trigger CaseTrigger on Case (after update) {


    Set<Id> newlyClosedCaseIds = new Set<Id>();
    for (Id caseId : Trigger.newMap.keySet()) {
        if (Trigger.newMap.get(caseId).IsClosed && 
            !Trigger.oldMap.get(caseId).IsClosed) {
            newlyClosedCaseIds.add(caseId);
        }
    }

   
    for (AggregateResult aggResult : [
            Select Count(Id), WhatId
            From Task
            Where WhatId In :newlyClosedCaseIds
                  And IsClosed = false
            Group by WhatId
            Having Count(Id) > 0
    ]) {
        Id caseId = (Id) aggResult.get('WhatId');
        Case errorCase = Trigger.newMap.get(caseId);

        // change error message as appropriate...
        errorCase.addError('Cannot close case since there are non closed tasks: ' +
                           errorCase.SuppliedName); 
    }
    List<Account> ListAcc=new List<Account>();
    for(id caseid:newlyClosedCaseIds)
    {
        Id id;
        case cas=[select id,AccountId  from case where id=:caseid];
       
            id=cas.AccountId ;
        try{    
        Account acc=new Account();
        acc=[select name,id,Type from account where id=:id ];
        acc.Type='Account';
        ListAcc.add(acc);
        }
        catch(exception e){
        system.debug('============'+e);
        }
        
        
    }
    update ListAcc;
}