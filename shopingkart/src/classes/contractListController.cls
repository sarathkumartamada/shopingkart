public class contractListController {
   


    public contractListController(ApexPages.StandardController controller) {

    }
    public shipment__c ship{get;set;}
    public string selected{get;set;}
    public list<contract> contractList{get;set;}
    
    public contractListController()
    {    
        
        
        contractList=[select id,Contractnumber,RecordTypeid,startdate,enddate from contract where id not in(select contract__c from shipment__c) And RecordType.Name = 'Hardware'];
        shipment__c sh1= new shipment__c();
        ship=sh1;
    
    }
    
   public List<SelectOption> getmyoptions() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('support Contract','support Contract'));
            options.add(new SelectOption('Miscellaneous','Miscellaneous'));
            options.add(new SelectOption('Return','Return'));
    
            return options;
    
    }
    public pageReference save()
    {
    try{
    insert ship;
    }
    catch(exception e){
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error:'+e);
    
    }
    pageReference ref=new pageReference('/'+ ship.id);
    return ref;
    }
    public pageReference NextForm(){
    
    ID id=ApexPages.CurrentPage().getParameters().get('schId');
    ship.project__c=ApexPages.CurrentPage().getParameters().get('Id');
    if(id!=null)
    ship.contract__c=id;
    ship.Type__c=selected;
    return page.shipment;
    }
    
}