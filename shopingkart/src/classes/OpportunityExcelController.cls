public class OpportunityExcelController {

    public OpportunityExcelController(ApexPages.StandardController controller) {

    }
 public OpportunityExcelController(ApexPages.StandardSetController contr) {
    if(contr.getSelected().isEmpty())
    OppList=contr.getRecords();
    else
    OppList=contr.getSelected();
    }

            public List<Id> OppListid{get;set;}
            public List<Opportunity> OppList{get;set;} 


            
            public void OpportunityExcelController()
            {
              
            }

}