/***
* @author Hicham El Mansouri
* @date 02/2020
* @description Mass Convert Leads
*/
public with sharing class GridMateMassLeadConvertAction {    
    public class GmConvertException extends Exception {}
    
    static Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    
    /****
    * @description Convert leads
    * */
    @InvocableMethod(label='Mass Lead Convert' description='Mass Lead Convert Action')
    public static void leadConvert(List<MassLeadConvert> requests)
    {
        MassLeadConvert request = requests[0];

        Set<String> fieldSet = new Set<String>();
        fieldSet.add('Salutation');
        if(!String.isBlank(request.AccountNameField)){
            fieldSet.add(request.AccountNameField);            
        }
        if(!String.isBlank(request.ContactFirstNameField)){
            fieldSet.add(request.ContactFirstNameField);            
        }
        if(!String.isBlank(request.ContactLastNameField)){
            fieldSet.add(request.ContactLastNameField);            
        }
        if(!String.isBlank(request.OpportunityNameField)){
            fieldSet.add(request.OpportunityNameField);            
        }
        
        Boolean checkResult = isSafeObject('Lead');
        for(String field : fieldSet){
            checkResult = checkResult && isSafeField(field, 'Lead');
        }       
        
        if(checkResult){            
            List<Database.LeadConvert> convertList = new List<Database.LeadConvert>();
            String query = 'Select Id,' + String.join(new List<String>(fieldSet) , ',') + 
                           ' From Lead Where Id in (\'' + String.join(request.idList, '\',\'') +'\')';
            
            List<Lead> leadList = (List<Lead>)Database.query(query);
 			
            //Create Accounts
           	Map<Lead, Account> accountMap = new Map<Lead, Account>();            
            if(request.CreateAccount){
                for(Lead ld : LeadList){
                    Account acc = new Account(
                        Name = (String)ld.get(request.AccountNameField),
                        OwnerId = request.RecordOwnerId
                    );  
                    
                    if(request.AccountRecordTypeId != 'NONE'){
                        acc.put('RecordTypeId', request.AccountRecordTypeId);
                    }
                    accountMap.put(ld, acc);
                }
            }
            
            insert accountMap.values();
            
            //Create Contacts
            Map<Lead, Contact> contactMap = new Map<Lead, Contact>();
            if(request.CreateContact){
                for(Lead ld : LeadList){
                    Contact ctc = new Contact(
                        Salutation = ld.Salutation,
                        FirstName = (String)ld.get(request.ContactFirstNameField),
                        LastName = (String)ld.get(request.ContactLastNameField),
                        AccountId = (request.CreateAccount)?accountMap.get(ld).Id:request.AccountId,
                        OwnerId = request.RecordOwnerId
                    );       
                    
                    if(request.ContactRecordTypeId != 'NONE'){
                        ctc.put('RecordTypeId', request.ContactRecordTypeId);
                    }
                    contactMap.put(ld, ctc);
                }
            }
            insert contactMap.values();

            for(Lead ld : LeadList){           
                Database.LeadConvert convert = new Database.LeadConvert();
                convert.setLeadId(ld.Id);              
                
                convert.setDoNotCreateOpportunity(!request.CreateOpportunity); 
                convert.setOpportunityName(request.CreateOpportunity?(String)ld.get(request.OpportunityNameField):null);
                convert.setAccountId((request.CreateAccount)?accountMap.get(ld).Id:request.AccountId);
                convert.setContactId((request.CreateContact)?contactMap.get(ld).Id:request.ContactId);                
                convert.setConvertedStatus(request.ConvertedStatus);                
                convert.setOwnerID(request.RecordOwnerId);
                
                convertList.add(convert);
            }                                  
            
            Database.convertLead(convertList, true);                                          
        }
    }              
    
    /****
    * @description Check if the object is safe to use
    * */
	private static boolean isSafeObject(String objName)
    {
        SObjectType myObj = schemaMap.get(objName);	    
	    return (myObj != null && myObj.getDescribe().isAccessible()); 
	}               
    
    /****
    * @description Check if the field is safe to use
    * */
	private static boolean isSafeField(String fieldName, String objName)
    {
        SObjectType myObj = schemaMap.get(objName);        
        SObjectField myField = myObj.getDescribe().fields.getMap().get(fieldName);
        return (myField != null && myField.getDescribe().isAccessible());
	}        
    
    public class MassLeadConvert 
    {                
        @InvocableVariable
        public List<Id> idList;                     
        
        @InvocableVariable
        public Boolean CreateAccount;
        @InvocableVariable
        public String AccountNameField;
        @InvocableVariable
        public String AccountRecordTypeId;
        @InvocableVariable
        public String AccountId;
        
        @InvocableVariable
        public Boolean CreateContact;
        @InvocableVariable
        public String ContactFirstNameField;
        @InvocableVariable
        public String ContactLastNameField;
        @InvocableVariable
        public String ContactRecordTypeId;
        @InvocableVariable
        public String ContactId;
        
        @InvocableVariable
        public Boolean CreateOpportunity;
        @InvocableVariable
        public String OpportunityNameField;
        @InvocableVariable
        public String OpportunityRecordTypeId;
        
        @InvocableVariable
        public String RecordOwnerId;
        @InvocableVariable
        public String ConvertedStatus;
    }
}