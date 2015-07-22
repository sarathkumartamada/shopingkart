public class myOpportunityController {
    public list<opportunity> opps=new list<opportunity>(); 
    public myOpportunityController(ApexPages.StandardController controller) {
    value=false;
    }
    public boolean value{get;set;}
    public pageReference change()
    {
    opps=[select id from opportunity where Parent_Opportunity__c=:ApexPages.currentPage().getParameters().get('id')];
    if(opps.isEmpty())
    mysubopp='null';
    else
    mysubopp='notnull';
    
    
    
    
    if(value==false)
    {
    value=true;
    system.debug('----------------------------------------myvalue'+value);
    return null;
    }
    else
    value=false;
    return null;
    }
    public string mysubopp{get;set;}
}