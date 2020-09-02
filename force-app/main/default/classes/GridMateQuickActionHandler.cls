/***
* @author Hicham El Mansouri
* @date 05/2019
* @description helper class to perform quick actions.
*/
global class GridMateQuickActionHandler implements Callable {
    global Object call(String action, Map<String, Object> args) {
        if(action=='performQuickAction'){
            String actionName = (String)args.get('actionName');
            String jsonData = (String)args.get('jsonData');
            List<Id> objectIdList = (List<Id>)args.get('objectIdList');
            
            List<QuickAction.QuickActionRequest> reqList = new List<QuickAction.QuickActionRequest>();        
            for(Id objectId : objectIdList){
                QuickAction.QuickActionRequest req = new QuickAction.QuickActionRequest();
                
                req.quickActionName = actionName;              
                req.record = (SObject)JSON.deserialize(jsonData, SObject.class);
                req.contextid = objectId; 
                
                reqList.add(req);
            }
            
            QuickAction.performQuickActions(reqList, true);        
            return true;            
        }
        else {
            throw new ExtensionMalformedCallException('Action not implemented');
        }
    }
    
    global class ExtensionMalformedCallException extends Exception {}
}