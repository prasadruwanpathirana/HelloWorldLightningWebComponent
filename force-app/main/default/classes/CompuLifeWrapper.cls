public with sharing class CompuLifeWrapper {
    public CompuLifeWrapper() {
        
    }
    public class Request{
        Public String State {get; set;}
        Public String ZipCode {get; set;}
        Public String ActualAge {get; set;}
        Public String NearestAge {get; set;}
        Public String Sex {get; set;}
        Public String Smoker {get; set;}
        Public String Health {get; set;}
        Public String NewCategory {get; set;}
        Public String FaceAmount {get; set;}
        Public String ModeUsed {get; set;}
    }

    public class Response {
        Public String Compulife_company {get; set;}
        Public String Compulife_ambest {get; set;}
        Public String Compulife_amb {get; set;}
        Public String Compulife_ambnumber {get; set;}
        Public String Compulife_compprodcode {get; set;}
        Public String Compulife_premiumAnnual {get; set;}
        Public String Compulife_premiumM {get; set;}
        Public String Compulife_guar {get; set;}
        Public String Compulife_product {get; set;}                 
        Public String Compulife_rgpfpp {get; set;}
        Public String Compulife_healthcat {get; set;}         
        Public String Compulife_premiumQ {get; set;}
        Public String Compulife_premiumH {get; set;}
    }
}