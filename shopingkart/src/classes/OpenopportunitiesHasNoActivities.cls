public class OpenopportunitiesHasNoActivities {

   

public Integer Count{get;set;} 
    public List<Opportunity> getOpportunities()
    {
             /*    set<id> AccountIDset=new set<id>();
                 
                 for(Task t:[Select AccountId From Task])
                 AccountIDset.add(t.AccountId);
                 for(Event e:[Select AccountId From Event])
                 AccountIDset.add(e.AccountId);
                 
                 
                 List<Opportunity>   opplist=[Select Name,CloseDate,Id,StageName,AccountId From opportunity where   isClosed=:false And AccountId NOT IN: AccountIDset];    */
                  
                 List<Opportunity>   opplist=new List<Opportunity>();
                 for(Opportunity a : [Select Name, Id,CloseDate,StageName,AccountId,( SELECT  ActivityDate ,id FROM ActivityHistories  ),(SELECT ActivityDate,  Description, Subject   FROM OpenActivities) From opportunity where   isclosed=:false ])
    if(a.ActivityHistories.isEmpty()&&a.OpenActivities.isEmpty())
        opplist.add(a);
                 
                 system.debug(opplist);
                 Count=opplist.size();
   
    return opplist;
    }



}