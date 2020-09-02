@isTest
global class GridMateQuickActionHandlerTest {
    public static SObject getNewSobject(String typeName) {
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(typeName);
        Sobject sobj = objType.newSobject();        
        return sobj;
    }
    
    @testSetup
    static void createTestData() {
        Sobject acc = getNewSobject('Account');
        acc.put('Name', 'Test Account');
        insert acc;
                
        Sobject opp = getNewSobject('Opportunity');
        opp.put('Name', 'Test Opportunity');
        opp.put('StageName', 'Sourcing Demand');
        opp.put('CloseDate', System.today());
        opp.put('AccountId', acc.Id);
        insert opp;                  
    }
    
    static testMethod void testPerformQuickAction(){
        Test.startTest();
        Opportunity opp = [Select Id, Name From Opportunity Limit 1];
        String jsonData = '{"attributes":{"type":"Account"},"Name":"account 1","Type":"Prospect","Phone":"664008263","Website":null,"Industry":"Consulting"}';        
        
        
        Callable handler =  (Callable) Type.forName('GridMateQuickActionHandler').newInstance();
        Boolean result = (Boolean) handler.call('performQuickAction', new Map<String, Object> { 
                'actionName' => 'gmpkg__NewAccount',
                'jsonData' => jsonData,
                'objectIdList' => new List<Id>{opp.Id}
        });
        Test.stopTest();  
        
        System.assertEquals(true, result); 
    }    
}