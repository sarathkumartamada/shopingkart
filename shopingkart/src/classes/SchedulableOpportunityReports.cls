public class SchedulableOpportunityReports implements Schedulable{

 public void schudule(){
 
 
  
  Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          User u=[select id,EMAIL,name,ContactId from user where Username=:'balakrishna.info@amzur.com'];
          mail.setTargetObjectId(u.id);
          mail.setSenderDisplayName('Salesforce Opportunity Report');
          mail.setUseSignature(false);
          mail.setBccSender(false);
          
          EmailTemplate et=[Select id from EmailTemplate where name=:'OpportunityDashboards'];
          mail.setTemplateId(et.id);
          mail.setSaveAsActivity(false);
         

          Messaging.SendEmailResult [] r = 
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});   
     
   }
 
 
 
 

  public void execute(SchedulableContext sc)
    {
    schudule();
    }
}