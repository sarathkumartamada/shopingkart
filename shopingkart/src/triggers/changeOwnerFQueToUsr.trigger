trigger changeOwnerFQueToUsr on Case (before update) {
    

    for(case cas:trigger.new)
    {
     
        
        Group gid=[select Id from Group where Name = 'Service Team' and Type = 'Queue' limit 1];
        if(cas.OwnerId==gid.id)
        {
        
        List<GroupMember> userID = [select UserOrGroupId from GroupMember where GroupId =:gid.id];
        for(GroupMember Gm:userID )
        {
                        try{
                        if(Gm.UserOrGroupId==UserInfo.getUserId())
                        {
                                    cas.OwnerId=UserInfo.getUserId();
                                    cas.Status='Working';
                                    
                                    Opportunity opp=[select OwnerId from Opportunity where id=:cas.Opportunity__c];
                                    user u=[select Email,FirstName from user where id =: opp.OwnerId];
                                    cas.OpportunityQwner_Email__c=u.Email;
                                    
                              
                        }
                        }
                        catch(exception e)
                        {
                        
                        }
                        
        }
        }
    }
}