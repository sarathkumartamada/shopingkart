public class OppAproveController {
    public Opportunity opp{get;set;}
    public OppAproveController(ApexPages.StandardController controller) {

    opp=(opportunity)controller.getrecord();

    }
    
    
    public PageReference Approve()
    {
        
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        req.setComments('Approving request using Trigger');
        req.setAction('Approve');
       // req.setNextApproverIds(new Id[] {opp.Next_Approver__c});
       // Id workItemId = getWorkItemId(opp.id); 

      
            req.setWorkitemId('04i280000000ED4');
            // Submit the request for approval
            Approval.ProcessResult result =  Approval.process(req);
       pageReference retPage=new pageReference('006/'+opp.id);
    return retPage;
    }

}