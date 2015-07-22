@isTest(SeeAllData=true)
private class TestForTriggerOpportunity
{
private static testmethod void TestForTriggerOpportunityTestmethod()
{
opportunity opp=new opportunity(Name='oppname',StageName='Closed Won',CloseDate=date.today());
insert opp;
    
    opportunity opp1=new opportunity(Name='oppname',StageName='Closed Won',CloseDate=date.today(),Approved__c=true,accountid='00128000002u3I7');
insert opp1;
    
    opportunity opp2=new opportunity(Name='oppname',StageName='Closed Won',CloseDate=date.today(),Approved__c=false,accountid='00128000002u3I7');
insert opp2;
    
    
}



}