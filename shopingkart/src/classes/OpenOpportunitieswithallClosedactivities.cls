public class OpenOpportunitieswithallClosedactivities {

public Integer Count{get;set;} 
    public List<Opportunity> getOpportunities()
    {
                 //set<id> AccountIDset=new set<id>();
                 
                 //for(Task t:[Select AccountId From Task where IsClosed=:true ])
                 //AccountIDset.add(t.AccountId);
                 //for(Event e:[Select AccountId From Event where id!=:null])
                 //AccountIDset.add(e.AccountId);
                 
                 
                 List<Opportunity>   opplist=new List<Opportunity>();
                 for(Opportunity a : [Select Name, Id,CloseDate,StageName,AccountId,( SELECT  ActivityDate ,id FROM ActivityHistories  ),(SELECT ActivityDate,  Description, Subject   FROM OpenActivities) From opportunity where   isclosed=:false ])
    if(!a.ActivityHistories.isEmpty()&&a.OpenActivities.isEmpty())
        opplist.add(a);
                 system.debug(opplist);
                 Count=opplist.size();
   
    return opplist;
    }
}