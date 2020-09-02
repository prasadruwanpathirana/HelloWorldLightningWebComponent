/***
* @author Hicham El Mansouri
* @date 12/2019
* @description helper class to perform approval actions.
*/
global class GridMateApprovalHandler implements Callable {
    global Object call(String action, Map<String, Object> args) {
        if(action=='submitForApproval'){
            List<Id> objectIdList = (List<Id>)args.get('objectIdList');
            String comment = (String)args.get('comment');
            
            return submitForApproval(objectIdList, comment);
        }
        else if(action=='setApproval'){
            List<Id> objectIdList = (List<Id>)args.get('objectIdList');
            String approvalStatus = (String)args.get('approvalStatus');
            String comment = (String)args.get('comment');
            
            return setApproval(objectIdList, approvalStatus, comment);
        }
        else {
            throw new ExtensionMalformedCallException('Action not implemented');
        }
    }
    
    /****
    * @description submit a list of records for approval 
    * @param objectIdList the list of ID(s)            
    * @param comment submitter comment            
    * @return Boolean the result of the processing
    **/	
    global static Boolean submitForApproval(List<Id> objectIdList, String comment){             
        List<Approval.ProcessSubmitRequest> requests = new List<Approval.ProcessSubmitRequest>();
        
        for(Id objectId : objectIdList){
            Approval.ProcessSubmitRequest request = new Approval.ProcessSubmitRequest();
            request.setObjectId(objectId);          
            request.setComments(comment);
            requests.add(request);
        }
        
        Approval.ProcessResult[] processResults = Approval.process(requests);
        
        Boolean result = true;
        for(Approval.ProcessResult pr : processResults){
            result = result && pr.getErrors() == null; 
        }
        
        return result;
    }
    
    /****
    * @description approve or decline a list of records 
    * @param objectIdList the list of ID(s)            
    * @param comment approver comment            
    * @return Boolean the result of the processing
    **/	    
    global static Boolean setApproval(List<Id> objectIdList, String approvalStatus, String comment){                     
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        
        List<ProcessInstanceWorkitem> workItems = [Select Id, 
                                                   ProcessInstanceId 
                                                   From ProcessInstanceWorkitem 
                                                   Where ProcessInstance.TargetObjectId IN :objectIdList];
        
        for(ProcessInstanceWorkitem workItem : workItems){
            Approval.ProcessWorkitemRequest request = new Approval.ProcessWorkitemRequest();
            request.setWorkitemId(workItem.Id);
            request.setAction(approvalStatus);
            request.setComments(comment);
            requests.add(request);
        }
        
        Approval.ProcessResult[] processResults = Approval.process(requests);
        
        Boolean result = true;
        for(Approval.ProcessResult pr : processResults){
            result = result && pr.getErrors() == null; 
        }
        
        return result;
    }
    
    global class ExtensionMalformedCallException extends Exception {}
}