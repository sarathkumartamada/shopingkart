public class myNewSubOpportunity {

    public myNewSubOpportunity(ApexPages.StandardController controller) {

    }

    public Date Closedate{get;set;}
   
     public ID myid{get;set;}
    public string myNextStep{get;set;}
    
    public opportunity oldopp{get;set;}
    public opportunity opp{get;set;}
    public pagereference currentId() {
    myid=ApexPages.currentPage().getParameters().get('id');
    oldopp=[select name,Amount,CloseDate,ExpectedRevenue,ForecastCategoryName,Accountid,Parent_Opportunity__c,Customer_OpportunityType__c,LeadSource,NextStep,IsPrivate,Probability,TotalOpportunityQuantity,StageName  from opportunity where id=:myid];
    subType=oldopp.Customer_OpportunityType__c;
    system.debug('----------------------------------------------'+myid);
    return null;
    }
    
     
     public string myType{get;set;}
     public List<SelectOption> getTypeList() {
     List<SelectOption> options = new List<SelectOption>();
      options.add(new SelectOption('--none--','--none--'));
      system.debug('--------------------------------------mytype'+myType);
     if(subType=='Banking')
     {
         options.add(new SelectOption('Saving','Saving'));
          options.add(new SelectOption('Checking','Checking'));
          return options;
          }
     
     if(subType=='Credit Card')
     {
      options.add(new SelectOption('master','master'));
       options.add(new SelectOption('Visa','Visa'));
        options.add(new SelectOption('Amex','Amex'));
        return options;
        }
     if(subType=='Loan' && UserInfo.getProfileId()=='00528000000NAOL')
    
     {
     options.add(new SelectOption('personal','personal'));
     options.add(new SelectOption('auto','auto'))   ; 
     return options;
     }
     
     if(subType=='Loan'&&UserInfo.getProfileId()=='00528000000N9u1')
     {
     options.add(new SelectOption('personal ','personal '));
     options.add(new SelectOption('housing','housing'));
    return options;
    }
    if(subType=='Loan')
    {
    options.add(new SelectOption('personal ','personal '));
     options.add(new SelectOption('auto','auto')) ;
    options.add(new SelectOption('housing','housing'));
    return options;
    }
    return options;
    }
    public string StageNameopp{get;set;} 
     public List<SelectOption> getstageList() {
     List<SelectOption> options = new List<SelectOption>();
       options.add(new SelectOption('Prospecting','Prospecting'));
        options.add(new SelectOption('Qualification','Qualification'));
        options.add(new SelectOption('Needs Analysis','Needs Analysis'));
        options.add(new SelectOption('Value Proposition','Value Proposition'));
        options.add(new SelectOption('Id. Decision Maker','Id. Decision Maker'));
        options.add(new SelectOption('Perception Analysis','Perception Analysis'));
        options.add(new SelectOption('Proposal/PriceQuote','Proposal/PriceQuote'));
        options.add(new SelectOption('Negotiation/Review','Negotiation/Review'));
        options.add(new SelectOption('ClosedWon','ClosedWon'));
        options.add(new SelectOption('ClosedLost','ClosedLost'));
    return options;
    }
    
    public Integer Probability{get;set;}
    public string name{get;set;}
    public string ExpectedRevenueOpp{get;set;}
    public string subType{get;set;}
    public pageReference save()
    {
       
        opportunity newopp = new opportunity();
       
        
        system.debug('-------------------------------------'+subType);
        newopp=oldopp.clone(false);
        newopp.StageName=StageNameopp;
        newopp.Probability=Probability;
        newopp.CloseDate=oldopp.CloseDate;
        newopp.name=name;
        newopp.SubOpportunityType__c=myType;
        
        newopp.NextStep=myNextStep;
        newopp.CloseDate=Closedate;
        newopp.Parent_Opportunity__c=myid;
        try{
        insert newopp;
        }
        catch(Exception e){
         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error:sametype already exists.');
            ApexPages.addMessage(myMsg);
            return null;
        }
        
        pageReference page=new pageReference('/'+myid);
        return page;
    }
    

}