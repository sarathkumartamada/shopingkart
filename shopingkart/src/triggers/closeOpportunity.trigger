trigger closeOpportunity on Outfit__c (before insert,before update) {

List<opportunity> opplist=new List<opportunity>();
opportunity opp;
Map<id,opportunity> opids=new Map<id,opportunity>([select id,name,StageName from opportunity]);
for(outfit__c oft:trigger.new)
{

    opp=new opportunity();
    opp=opids.get(oft.opportunity__c);
    if(oft.Result__c=='Send')
    opp.StageName='Closed Won';
    else 
    if(oft.Result__c=='Like')
    opp.StageName='Prospective';
    else
    opp.StageName='Closed Lost';
    opplist.add(opp);
}

upsert opplist;
}