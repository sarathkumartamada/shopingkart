trigger SubitForApprovalOnClosedWonAnd   on Opportunity (after insert,before update) {
    
   
     Approval.ProcessSubmitRequest ListAppReq = new Approval.ProcessSubmitRequest();
    
      for(Opportunity opp:trigger.new)
      {
          if(opp.isWon&&opp.Approved__c== False)
          {
          
          ListAppReq.setObjectId(opp.id);
          //ListAppReq.setSkipEntryCriteria(false);
          Approval.ProcessResult result = Approval.process(ListAppReq);
          system.debug('=================================================================>'+result.isSuccess());
          }
          else
          {
          try{
           Account acc=[select id,type from account where id=:opp.Accountid];
           if(opp.Approved__c== True&&opp.isWon&&acc.type=='Prospect'){
                 system.debug('==========================================inside if trigger>'+acc);
                 Group gid=[select Id from Group where Name = 'Service Team' and Type = 'Queue' limit 1];
                 List<GroupMember> userID = [select UserOrGroupId from GroupMember where GroupId =:gid.id];
                 Case c = new Case ( 
                                       Opportunity__c=opp.id,  
                                       Accountid= acc.Id, 
                                       Status = 'New', 
                                       Origin = 'Web', 
                                       Type = 'Internal Case', 
                                       Reason = 'Campaign  Setup', 
                                       Subject = opp.name+'-New Business',
                                       Priority='Medium'
                                       //OwnerId = gid.id 
                                       );
                                       
                 AssignmentRule AR = new AssignmentRule();
                 AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];  
                 
                 Database.DMLOptions dmlOpts = new Database.DMLOptions();
                 dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;   
                 
                 c.setOptions(dmlOpts);                 
                 insert c;       
                 
                  List<Task> newListNewTask=new List<Task>();
                  Task newtask = new Task();
                    newtask.Type = 'Phone';
                    newtask.Priority='High';
                    newtask.subject='Call Prospect';
                    newtask.Description = ' Call Prospect'; //string
                    newtask.OwnerId = userID[0].UserOrGroupId; //user id
                    newtask.WhatId = c.id; //record id
                    newTask.Status='Not Started';
                    newTask.ActivityDate=Date.today().addDays(2);
                     newListNewTask.add(newtask);
                     
                     Task newtask2 = new Task();
                    newtask2.Type = 'Phone';
                    newtask2.Priority='High';
                    newtask2.subject='Send welcome package to prsoepct';
                    newtask2.Description = ' Call Prospect'; //string
                    newtask2.OwnerId = userID[1].UserOrGroupId; //user id
                    newtask2.WhatId = c.id; //record id
                    newTask2.Status='Not Started';
                    newTask2.ActivityDate=Date.today().addDays(2);
                     newListNewTask.add(newtask2);
                     
                     insert newListNewTask;
                     
                                     
                }
           
              }
              catch(exception e)
              {
              system.debug('No Account');
              }
          
          }
      
      }
      
      
}