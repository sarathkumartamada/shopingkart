public class OpenOpportunitiesHasopenactivities {
public Integer Count{get;set;} 
    public List<Opportunity> getOpportunities()
    {
                 set<id> AccountIDset=new set<id>();
                 
               //  for(Task t:[Select AccountId From Task where IsClosed=:false AND AccountId !=:null])
                // AccountIDset.add(t.AccountId);
                 //for(Event e:[Select AccountId From Event where id!=null ])
                 //AccountIDset.add(e.AccountId);
                 
                 
                 List<Opportunity> opplist=new List<Opportunity>();
                 for(Opportunity o:[Select Name, Id,closedate,StageName,AccountId,(SELECT ActivityDate,
                                  Description,
                                  Subject
                           FROM OpenActivities) From opportunity where   isclosed=:false ])
                           if(o.OpenActivities.size()>0)
                           opplist.add(o);
                           
                           
                 system.debug(opplist);
                 Count=opplist.size();
   
    return opplist;
    }


}