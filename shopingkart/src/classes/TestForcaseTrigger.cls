@isTest(SeeAllData=true)
private class TestForcaseTrigger
{

private static testmethod void TestForcaseTriggerTestmethod()
{

case c=[select id,Status,OwnerId,Opportunity__c from case where id='50028000001x4WD'];
c.Status='Closed';

    
      try {
            update c;
        } catch (DmlException e) {
            
            System.assert( e.getMessage().contains('Cannot close case since there are non closed tasks:'), 
                e.getMessage() );
                  
            Opportunity opp=[select OwnerId from Opportunity where id=:c.Opportunity__c];
            upsert opp;
			case c1=[select id,Status from case where id='50028000001x95d'];
			c1.Status='Closed';
            Group gid=[select Id from Group where Name = 'Service Team' and Type = 'Queue' limit 1];
            c1.OwnerId=gid.id;
            
            try{
			update c1;
            }
            catch(Exception ex)
            {
                
            }
            
            }
   }
   }