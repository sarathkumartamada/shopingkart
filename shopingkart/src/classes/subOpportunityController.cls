public class subOpportunityController {

   

    public ID myid{get;set;}
    public subOpportunityController(ApexPages.StandardController controller) {
    myid=ApexPages.currentPage().getParameters().get('id');
    system.debug('---------------------------------------id'+myid);
    }

    public subOpportunityController(){
       
            
    }
    public list<Opportunity> getOpportunities()
    {
    list<Opportunity> opps=new list<Opportunity>([select name,Amount,CloseDate,id,Parent_Opportunity__c,SubOpportunityType__c,ExpectedRevenue,ForecastCategoryName,LeadSource,NextStep,IsPrivate,Probability,TotalOpportunityQuantity,StageName from opportunity where Parent_Opportunity__c=:myid]);
    return opps;
        
    }
    public ID currentid{get;set;}
    public pageReference OppEdit()
    {
    currentid=ApexPages.currentPage().getParameters().get('Oppid');
    system.debug('-----------------------------------------------------linkid'+currentid+ApexPages.currentPage().getParameters().get('myid'));
    if(currentid!=null)
    {
    pageReference page=new pagereference('/apex/EditSubOpportunity?id='+ApexPages.currentPage().getParameters().get('Oppid'));
    return page;
    }
    return null;
    }
    public pageReference oppdelete()
    {
    
        currentid=ApexPages.currentPage().getParameters().get('oppid');
    system.debug('-----------------------------------------------------linkid'+currentid);
    if(currentid!=null)
    {
    opportunity opp=[select id from opportunity where id=:currentid];
    delete opp;
    }
    return null;
    }
    
    
}