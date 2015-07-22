trigger createopportunity on Outfit__c(before insert) {
    map<id,id> mymap=new Map<id,id>();
    for(style__c s:[select id,account__c from style__c])
    mymap.put(s.id,s.account__c);
    
    opportunity oppor;
    for(Outfit__c otf:trigger.new)
    {
    oppor=new opportunity();
    oppor.name=otf.name;
    oppor.Accountid=mymap.get(otf.style__c);
    oppor.CloseDate=Date.today().addDays(7);
    oppor.StageName='Prospecting'; 
    otf.account__c=mymap.get(otf.style__c);
    system.debug('==============================accountid'+mymap.get((id)otf.style__c));
    insert oppor;
    otf.Opportunity__c=oppor.id;
    
    }
    
}