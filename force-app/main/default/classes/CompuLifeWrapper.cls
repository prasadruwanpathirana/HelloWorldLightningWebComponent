
public with sharing class CompuLifeWrapper {
    public CompuLifeWrapper() {
        
    }
    
    public class Request{
        @AuraEnabled Public String State {get; set;}
        @AuraEnabled Public String ZipCode {get; set;}
        @AuraEnabled Public String ActualAge {get; set;}
        @AuraEnabled Public String NearestAge {get; set;}
        @AuraEnabled Public String Sex {get; set;}
        @AuraEnabled Public String Smoker {get; set;}
        @AuraEnabled Public String Health {get; set;}
        @AuraEnabled Public String NewCategory {get; set;}
        @AuraEnabled Public String FaceAmount {get; set;}
        @AuraEnabled Public String ModeUsed {get; set;}
    }

    public class Response {
        @AuraEnabled Public String Compulife_company {get; set;}
        @AuraEnabled Public String Compulife_ambest {get; set;}
        @AuraEnabled Public String Compulife_amb {get; set;}
        @AuraEnabled Public String Compulife_ambnumber {get; set;}
        @AuraEnabled Public String Compulife_compprodcode {get; set;}
        @AuraEnabled Public String Compulife_premiumAnnual {get; set;}
        @AuraEnabled Public String Compulife_premiumM {get; set;}
        @AuraEnabled Public String Compulife_guar {get; set;}
        @AuraEnabled Public String Compulife_product {get; set;}                 
        @AuraEnabled Public String Compulife_rgpfpp {get; set;}
        @AuraEnabled Public String Compulife_healthcat {get; set;}         
        @AuraEnabled Public String Compulife_premiumQ {get; set;}
        @AuraEnabled Public String Compulife_premiumH {get; set;} 
        @AuraEnabled Public String Company_logo {get; set;} 
    }
}