@isTest
public class GridMateMassLeadConvertActionTest {
    @testSetup
    static void createTestData() {          
        Lead ld = new Lead(
            FirstName='Hicham',
            LastName='El Mansouri',
            Company='GridPal LLC'            
        );
        insert ld;
        
        ld = new Lead(
            FirstName='Rey',
            LastName='Perera',
            Company='GridMate'            
        );
        insert ld;
    }
    
    static testMethod void testLeadConvert(){
        Test.startTest();
        List<Lead> leadList = [Select Id, Name From Lead];
        GridMateMassLeadConvertAction.MassLeadConvert request = new GridMateMassLeadConvertAction.MassLeadConvert();
        
        request.CreateAccount = true;
        request.AccountNameField = 'Company';
        request.AccountRecordTypeId = 'NONE';
        request.AccountId = null;
        
        request.CreateContact = true;
        request.ContactFirstNameField = 'FirstName';
        request.ContactLastNameField = 'LastName';
        request.ContactRecordTypeId = 'NONE';
        request.ContactId= null;
        
        request.CreateOpportunity = true;
        request.OpportunityNameField = 'Company';
        request.OpportunityRecordTypeId = 'NONE';
        
        request.RecordOwnerId = UserInfo.getUserId();
        request.ConvertedStatus = 'Closed - Converted';
        request.idList = new List<Id>();
            
        for(Lead ld : leadList){
            request.idList.add(ld.Id);
        }
        
        GridMateMassLeadConvertAction.leadConvert(new List<GridMateMassLeadConvertAction.MassLeadConvert>{request});
        Test.stopTest();
        
        Integer accountNb  =[Select count() from Account];
        Integer contactNb  =[Select count() from Contact];
        Integer opportunityNb  =[Select count() from Opportunity];
		
        System.assert(accountNb == 2 && contactNb == 2 && opportunityNb == 2);
    }
}