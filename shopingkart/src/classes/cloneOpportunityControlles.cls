public class cloneOpportunityControlles {

    List<Team__c> Lt{get;set;}
    Opportunity opp{get;set;}
    Opportunity cloneOpp{get;set;}
    public cloneOpportunityControlles(Apexpages.Standardcontroller con)
    {
    
    
    }
    
    
    public void clonee()
    {
    string clone=ApexPages.currentPage().getParameters().get('clone');
    id Myid=ApexPages.currentPage().getParameters().get('id');
    try{
    opp=new opportunity();
    opp=[select id,name,StageName,CloseDate from opportunity where id=:Myid limit 1];
    
    
    cloneopp=new Opportunity();
    cloneOpp=opp.clone(false);
    cloneOpp.StageName=opp.StageName;
    cloneOpp.CloseDate=opp.CloseDate;
    cloneOpp.name=opp.name+'clone';
    insert cloneOpp;
    system.debug('===================================clonedopp'+cloneOpp.id);
    if(clone=='true')
    {
     List<OpportunityLineItem> lineItems=[SELECT Id,PricebookEntryId,OpportunityId,UnitPrice FROM OpportunityLineItem WHERE OpportunityId=:Myid];
     List<OpportunityLineItem> clonedLineItems=new  List<OpportunityLineItem>();
                OpportunityLineItem clonedLineItem=null;
                for(OpportunityLineItem lineItem : lineItems){
                    clonedLineItem=lineItem.clone(false,true);
                    clonedLineItem.PricebookEntryId=lineItem.PricebookEntryId;
                    clonedLineItem.OpportunityId=cloneOpp.Id;
                    clonedLineItem.UnitPrice=lineItem.UnitPrice;
                    clonedLineItem.Quantity=1;   
                    clonedLineItems.add(clonedLineItem);
    Lt=new List<Team__c>();
    Team__c t;
    
    for(Team__c Ot:[select name,id from Team__c where Opportunity__c =: Myid])
    {
    t=new Team__c();
    t=Ot.clone(false);
    t.name=Ot.name+'clone';
    t.Opportunity__c=cloneOpp.id;
    Lt.add(t);
    }
    
    }
    if(!Lt.isEmpty()){
      insert Lt;
     }
    
    if(!clonedLineItems.isEmpty()){
      insert clonedLineItems;
     }
    }
    
    
    }
    catch(Exception e){
    

    }
   //SendMail();

    }
    

    
    public pageReference SendMail(){
    List<Messaging.SingleEmailMessage> mails =new List<Messaging.SingleEmailMessage>();
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
     User u= [SELECT Email,Firstname FROM User WHERE Id=:UserInfo.getUserId()];
     system.debug('=========================================================================='+U);
     List<String> sendTo = new List<String>();
     sendTo.add(u.Email);
     mail.setToAddresses(sendTo);  
     mail.setSubject(opp.name);
     String body = 'Dear ' + u.FirstName + ', ';
     body += 'This is your opportunity ';
     body +='<a href="https://ap2.salesforce.com/'+cloneOpp.id+'">view in salesforce</a>';
     
     mail.setHtmlBody(body);
     mails.add(mail);
     Messaging.sendEmail(mails);
     return null;
    }
    
    
}