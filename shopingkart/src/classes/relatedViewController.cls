public class relatedViewController {

    public ID myid{get;set;}
    public relatedViewController(ApexPages.StandardController controller) {
    myid=ApexPages.currentPage().getParameters().get('id');
    system.debug('---------------------------------------id'+myid);
    }

    public relatedViewController(){
       
            
    }
    public list<Opportunity> getOpportunities()
    {
    list<Opportunity> opps=new list<Opportunity>([select name,Amount,CloseDate,id,Parent_Opportunity__c,SubOpportunityType__c,ExpectedRevenue,ForecastCategoryName,LeadSource,NextStep,IsPrivate,Probability,TotalOpportunityQuantity,StageName from opportunity where Parent_Opportunity__c=:myid]);
    return opps;
        
    }
    public ID currentid{get;set;}

}