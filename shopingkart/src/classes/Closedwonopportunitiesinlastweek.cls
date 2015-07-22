public class Closedwonopportunitiesinlastweek {
    
    public Integer Count{get;set;} 
    public List<Opportunity> getOpportunities()
    {
    
    List<Opportunity> opplist=[select Name,AccountId,CloseDate,StageName from Opportunity where StageName=:'Closed Won' AND CloseDate <: date.today() AND CloseDate >: date.today().addDays(-7)];
    Count=opplist.size();
    return opplist;
    }


        
}