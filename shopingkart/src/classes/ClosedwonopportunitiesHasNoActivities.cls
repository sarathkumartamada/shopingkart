public class ClosedwonopportunitiesHasNoActivities {

   

public Integer Count{get;set;} 
    public List<Opportunity> getOpportunities()
    {
                 set<id> AccountIDset=new set<id>();
                 
               /*  for(Task t:[Select AccountId From Task])
                 AccountIDset.add(t.AccountId);
                 for(Event e:[Select AccountId From Event])
                 AccountIDset.add(e.AccountId);*/
                 
                 
                 //List<Opportunity>   opplist=[Select Name,CloseDate,Id,StageName,AccountId From opportunity where   isClosed=:false And AccountId NOT IN: AccountIDset];
                 List<Opportunity> opplist=new List<Opportunity>();
                 for(Opportunity o:[Select Name, Id,closedate,StageName,AccountId,(SELECT ActivityDate, Description, Subject FROM OpenActivities),( SELECT  ActivityDate ,id FROM ActivityHistories  ) From opportunity where   isclosed=:false ])
                           if(o.OpenActivities.isEmpty()&&o.ActivityHistories.isEmpty())
                           opplist.add(o);
                 system.debug(opplist);
                 Count=opplist.size();
   
    return opplist;
    }



}