public class createCaseFromTemplate {

  


    
     
      public Integer noOfRecords{get;set;}  
      public createCaseFromTemplate(ApexPages.StandardSetController controller) {
      
      
      }
      
       public Apexpages.standardsetController setcon{
        get
        {
            if(setCon == null){
                
                
                String queryString = 'select id,Type__c,Subject__c,CreatedById,name,Origin__c,Status__c,Description__c from CaseTemplate__c';
                setcon = new apexpages.standardsetController(Database.getquerylocator(queryString));
                
                
                system.debug('===================================================='+setcon);
                setcon.setpagesize(5);
                noOfRecords=setcon.getResultsize();            }
                
            return setcon;
        }
         set;
        }
      
      
      
      
      
     
      Public pageReference CreateNewTemplate()
      {
      
      
      r = CaseTemplate__c.sObjectType.getDescribe();
      String keyPrefix = r.getKeyPrefix();
      PageReference ref=new PageReference('/'+keyPrefix+'/e?retURL=apex/caseCreationTemplate&saveURL=apex/caseCreationTemplate');
      return ref;
      }
      public List<CaseTemplate__c> Templates{get{
      Templates=setcon.getrecords();
      return Templates;
      }
      set;}
      
      Schema.DescribeSObjectResult r;
      public String keyPrefix{get;set;}
      Public PageReference ref{get;set;}
      public pageReference create()
      {
      r = case.sObjectType.getDescribe();
      keyPrefix = r.getKeyPrefix();
      CaseTemplate__c CT=[select id,Type__c,Subject__c,name,Origin__c,Status__c,Description__c from CaseTemplate__c where id=:Myid];
      if(CT.Subject__c==null)
      CT.Subject__c='';
      if(CT.Description__c==null)
      CT.Description__c='';
      //CaseCreateTemplate__c CaseParameterId=CaseCreateTemplate__c.getValues('FieldId');

      //system.debug('======================================================inside CreateTemplate'+CaseParameterId);
     // PageReference ref=new PageReference('/'+keyPrefix+'/e?'+CaseParameterId.Status__c+'='+CT.Status__c+'&'+CaseParameterId.Origin__c+'='+CT.Origin__c+'&'+CaseParameterId.Description__c+'='+CT.Description__c+'&'+CaseParameterId.Type__c+'='+CT.Type__c+'&'+CaseParameterId.Subject__c+'='+CT.Subject__c+'&retURL=apex/caseCreationTemplate&saveURL=apex/caseCreationTemplate');
      PageReference ref=new PageReference('/'+keyPrefix+'/e?cas7='+CT.Status__c+'&cas11='+CT.Origin__c+'&cas15='+CT.Description__c+'&cas5='+CT.Type__c+'&cas14='+CT.Subject__c+'&retURL=apex/caseCreationTemplate&saveURL=apex/caseCreationTemplate');
      return ref;
      }
        
      public Id Myid{get;set;}   
      
      //=================================Search
      public string sortExpression{get;set;}
      public string Searchkey{get;set;}
      public string OrderString{get;set;}
      String PrevsortExpression{get;set;}
      Public pageReference Search()
      {
      string query;
      
      if(sortExpression==null)
      sortExpression='Name';
      if(PrevsortExpression==null)
      {
      PrevsortExpression=sortExpression;
      OrderString='ASC';
       system.debug('========================================OrderString'+OrderString+''+sortExpression+''+PrevsortExpression);
      
      }
      else
      {
          
              if(OrderString=='DESC'&&sortExpression==PrevsortExpression)
              {
              OrderString='ASC';
              system.debug('========================================OrderString==DESC&&sortExpression==PrevsortExpression'+OrderString+''+sortExpression+''+PrevsortExpression);
              }
              else
              if(sortExpression==PrevsortExpression)
              {
              OrderString='DESC';
              system.debug('========================================sortExpression==PrevsortExpression'+OrderString+''+sortExpression+''+PrevsortExpression);
              }else
              {
              OrderString='ASC';
              system.debug('========================================elseOrderString'+OrderString+''+sortExpression+''+PrevsortExpression);
              }
              
          system.debug('========================================OrderString'+OrderString+''+sortExpression+''+PrevsortExpression);
          PrevsortExpression=sortExpression;
      }    
          string filterstring;
      
       system.debug('========================================OrderString'+OrderString+''+sortExpression+''+PrevsortExpression);
    
       if(Status!=null&&Status!='--NONE--'&&Type!=null&&Type!='--NONE--')
       filterstring =' AND type__c =:Type And Status__c =:Status ';

      else
      if(Type!=null&&Type!='--NONE--')
      filterstring =' AND type__c =:Type ';

      else
      if(Status!=null&&Status!='--NONE--')
      filterstring =' AND Status__c =:Status ';
     if(filterstring==null)
     {
     filterstring=' ';
    
     //OrderString=' ';
     
     }
     string sortExp=' order by '+sortExpression;
      String searchStr =  Searchkey + '%';
      
      
      query='select id,Type__c,Subject__c,CreatedById,name,Origin__c,Status__c,Description__c from CaseTemplate__c where name like :searchStr '+filterstring+' '+sortExp+' '+OrderString;
      system.debug('======================================query'+query);
      system.debug('======================================query'+Database.getQueryLocator(query));
      setcon = new ApexPages.StandardSetController(Database.getQueryLocator(query));
      setcon.setpagesize(5);
    return null;
      
      }
      
      //===============================================Edit/Delete
    
      public pageReference editt()
      {
      PageReference ref=new PageReference('/'+Myid+'/e?retURL=apex/caseCreationTemplate&saveURL=apex/caseCreationTemplate');
      return ref;
      }
       public pageReference delet()
       {
       CaseTemplate__c del=[select id from CaseTemplate__c where id=:Myid];
       delete del;
       PageReference pageRef = new pageReference('/apex/caseCreationTemplate'); 
       pageRef.setRedirect(true);
       return pageRef;
       
       }
       
       //=========================================Filter
       public string Type{get;set;}
        public List<SelectOption> getTypes() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = CaseTemplate__c.Type__c.getDescribe();

        
         options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
}
 public string Status{get;set;}
        public List<SelectOption> getStatuses() {
            List<SelectOption> options = new List<SelectOption>();
             Schema.DescribeFieldResult statusFieldDescription = CaseTemplate__c.Status__c.getDescribe();
           options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
         
           
            return options;   
}
       
       
 
      }