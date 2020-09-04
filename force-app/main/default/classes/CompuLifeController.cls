public with sharing class  CompuLifeController {
    
    @AuraEnabled(cacheable=true)  
    public static List<OptionWrapper> getContactList(){
       List<OptionWrapper> stateList = new List<OptionWrapper>();
       Schema.DescribeFieldResult fieldResult = Quote_Request__c.State__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry f : ple) {
          stateList.add(new OptionWrapper(f.getLabel(), f.getValue()));
       }

       System.debug(stateList);
       return stateList;
    }
    
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

       //System.debug(productList);
       return productList;
    }
}