@isTest
global class GridMateApprovalHandlerTest {
    
    public static SObject getNewSobject(String typeName) {
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(typeName);
        Sobject sobj = objType.newSobject();        
        return sobj;
    }  
    
    
    @testSetup
    static void createTestData() {          
        Account acc = new Account(
            Name='Test Account',
            BillingCountry='US',
            AccountSource='Other'  
        );
        insert acc;        
        
        Sobject contact = getNewSobject('Contact');
        contact.put('AccountId', acc.get('Id'));
        contact.put('FirstName', 'Test');
        contact.put('LastName', 'Test'); 
        contact.put('Email', 'admin@happystamp.fr'); 
        insert contact;
        
        Sobject acc2 = getNewSobject('Account');
        acc2.put('Name', 'Test Account2');
        insert acc2;       
    }
    
    static testMethod void testSubmitForApproval(){
        Test.startTest();          
        Contact ct = [Select Id, Name From Contact Limit 1];
        
        Callable handler =  (Callable) Type.forName('GridMateApprovalHandler').newInstance();
        Boolean result = (Boolean) handler.call('submitForApproval', new Map<String, Object> { 
            'objectIdList' => new List<Id>{ct.Id},
            'comment' =>  'Please approve'
		});    
        
        Test.stopTest();  
        
        System.assert(result);  
    }
    
    static testMethod void testSetApproval(){
        Test.startTest();          
        Contact ct = [Select Id, Name From Contact Limit 1];
        Callable handler =  (Callable) Type.forName('GridMateApprovalHandler').newInstance();
        Boolean result = (Boolean) handler.call('submitForApproval', new Map<String, Object> { 
            'objectIdList' => new List<Id>{ct.Id},
            'comment' =>  'Please approve'
		}); 
        
        handler =  (Callable) Type.forName('GridMateApprovalHandler').newInstance();
        result = result && (Boolean) handler.call('setApproval', new Map<String, Object> { 
                'objectIdList' => new List<Id>{ct.Id},
                'approvalStatus' => 'Approve',                    
                'comment' => 'Approved'
        });  
        
        Test.stopTest();  
        
        System.assert(result);  
    }
}