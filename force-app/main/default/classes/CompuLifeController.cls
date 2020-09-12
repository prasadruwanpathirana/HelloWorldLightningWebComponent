public with sharing class  CompuLifeController {
    
  /*  @AuraEnabled(cacheable=true)  
    public static List<OptionWrapper> getContactList(){
       List<OptionWrapper> stateList = new List<OptionWrapper>();
       Schema.DescribeFieldResult fieldResult = Quote_Request__c.State__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry f : ple) {
          stateList.add(new OptionWrapper(f.getLabel(), f.getValue()));
       }

       System.debug(stateList);
       return stateList;
    } */
    
    @AuraEnabled(cacheable=true)  
    public static List<OptionWrapper> getHealthList(){
       List<OptionWrapper> healthList = new List<OptionWrapper>();
       Schema.DescribeFieldResult fieldResult = Quote_Request__c.Health__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry f : ple) {
          healthList.add(new OptionWrapper(f.getLabel(), f.getValue()));
       }

       System.debug(healthList);
       return healthList;
    }
    
    @AuraEnabled(cacheable=true)  
    public static List<OptionWrapper> getCategoryList(){
       List<OptionWrapper> categoryList = new List<OptionWrapper>();
       List<Quote_Category__c> catList = [SELECT Id, Name, Letter__c FROM Quote_Category__c];
       for(Quote_Category__c f : catList) {
          categoryList.add(new OptionWrapper(f.Name, f.Letter__c));
       }

       System.debug(categoryList);
       return categoryList;
    }
    
    @AuraEnabled(cacheable=true)  
    public static List<OptionWrapper> getProductList(){
       List<OptionWrapper> productList = new List<OptionWrapper>();
       List<Quote_Product__c> prdList = [SELECT Category_Letter__c,Comp_Code__c,Id,Letter__c,Name,Prod_Code__c FROM Quote_Product__c];
       for(Quote_Product__c f : prdList) {
          productList.add(new OptionWrapper(f.Name, f.Prod_Code__c));
       }
       return productList;
    }

    @AuraEnabled(cacheable=true)
    Public Static List<Quote_Result__c> getCachedQuotes(String State, String ZipCode, String ActualAge, String NearestAge, String Sex, String Smoker, String Health, String NewCategory, String FaceAmount, String ModeUsed){
         List<Quote_Category__c> quoteLst = [SELECT Id FROM Quote_Category__c WHERE Letter__c =:NewCategory];
         List<Quote_Request__c> quoteRequest = [SELECT Id FROM Quote_Request__c WHERE 
         ActualAge__c =:Decimal.valueOf(ActualAge) AND 
         FaceAmount__c =:Decimal.valueOf(FaceAmount)
         AND Health__c =:Health AND NearestAge__c =:Decimal.valueOf(NearestAge) 
         AND QuoteCategory__c =:quoteLst[0].Id
            AND Sex__c =:Sex AND Smoker__c =:Boolean.valueOf(Smoker) AND State__c =:State];

         List<Quote_Result__c> quoteResults = [Select Id, AMBRating__c,CompanyName__c,MonthlyPremium__c,PP_NonTobacco__c,ProductCode__c,Quote_Company__c,Quote_Product__c,QuoteRequest__c,Name FROM Quote_Result__c WHERE QuoteRequest__c IN :quoteRequest ];
         return quoteResults;         
    }

    @AuraEnabled(cacheable=true)
    Public Static Boolean cacheRequest(CompuLifeWrapper.Request req, List<CompuLifeWrapper.Response> resList){
      try {
         List<Quote_Category__c> quoteLst = [SELECT Id FROM Quote_Category__c WHERE Letter__c =:req.NewCategory];
         Quote_Request__c qReq = new Quote_Request__c();
         qReq.ActualAge__c = Decimal.valueOf(req.ActualAge);
         //qReq.Companies__c = req.
         qReq.FaceAmount__c = Decimal.valueOf(req.FaceAmount);
         qReq.Health__c = req.Health;
         qReq.NearestAge__c = Decimal.valueOf(req.NearestAge);
         //qReq.NewCategory__c = req.NewCategory;
         //qReq.Products__c 
         qReq.QuoteCategory__c = quoteLst[0].Id;
         qReq.Sex__c = req.Sex;
         qReq.Smoker__c = Boolean.valueOf(req.Smoker);
         qReq.State__c = req.State;
         insert qReq;
         List<String> proCodeList = new List<String>();
         for (CompuLifeWrapper.Response r : resList) {
            proCodeList.add(r.Compulife_compprodcode);
         }
         Map<String,Id> compMap = new Map<String,Id>();
         for(Quote_Company__c comp : [SELECT Id, Comp_Code__c  from Quote_Company__c WHERE Comp_Code__c IN : proCodeList])
         compMap.put(comp.Id, comp.Comp_Code__c);

         List<String> quotePrdList = new List<String>();
         for (CompuLifeWrapper.Response r : resList) {
            quotePrdList.add(r.Compulife_rgpfpp);
         }
         Map<String,Id> qPrdMap = new Map<String,Id>();
         for(Quote_Product__c qPrd : [SELECT Id, Prod_Code__c  from Quote_Product__c WHERE Prod_Code__c IN : quotePrdList])
         qPrdMap.put(qPrd.Id, qPrd.Prod_Code__c);

         List<Quote_Result__c> qResultList = new List<Quote_Result__c>();
         for (CompuLifeWrapper.Response qRes: resList) {
            Quote_Result__c qResult = new Quote_Result__c();
            qResult.AMBRating__c = qRes.Compulife_ambest;
            qResult.CompanyName__c = qRes.Compulife_company;
            qResult.MonthlyPremium__c = Decimal.valueOf(qRes.Compulife_premiumM);
            qResult.PP_NonTobacco__c = qRes.Compulife_healthcat;
            qResult.ProductCode__c = qRes.Compulife_product;           
            qResult.Quote_Company__c = compMap.get(qRes.Compulife_compprodcode);
            qResult.Quote_Product__c = compMap.get(qRes.Compulife_rgpfpp);
            qResult.QuoteRequest__c = qReq.Id;
            qResultList.add(qResult);
         }

         insert qResultList;
         return true;

      } catch (Exception ex) {
         System.debug('CompLife caching error ' + ex.getMessage());
         return false;
      }
    }
}