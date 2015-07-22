public class ProductImagesAttachments{

    public String mycartproductids { get; set; }

    public String findfamily { get; set; }

    public String searchtxt { get; set; }
public List<Product2> product;
public string searchkey{get;set;}

    public ProductImagesAttachments(accountForm controller) {

    system.debug('================='+myaccount);
  /*  id myprid=apexpages.currentpage().getparameters().get('id');
    system.debug('=============id       ============'+myprid);
    if(myprid!=null){
    product=[select id,name,family,  (select id From Attachments where ContentType=:'image/jpeg') from Product2 where id =:myprid];
    }*/
    }


    public String produstids { get; set; }
    





    public String myproducts { get; set; }


    public PageReference RemoveFromCart() {
        return null;
    }

 

    public Account myaccount{get;set;}
    public id myaccountid{get;set;}
    public id productid{get;set;}
    public PageReference Buy() {
        opportunity oppor=new opportunity();
        myaccountid='00128000003edLn';
        system.debug('============myaccount====='+myaccount);
        myaccount=[select id,name from Account where id= :myaccountid];
        system.debug('==============oppor==='+myaccountid);
        oppor.name=myaccount.name+date.today();
        oppor.Accountid=myaccount.id;
        oppor.CloseDate=Date.today().addDays(7);
        oppor.StageName='Close Won'; 
        
        
        insert oppor;
       List<OpportunityLineItem> OpLnIt= new List<OpportunityLineItem>();
       
       map<Id,PriceBookEntry > mapPBList=new map<Id,PriceBookEntry >();
       
       for(PriceBookEntry PBE: [SELECT Id, Product2Id,UnitPrice, Product2.Id, Product2.Name FROM PriceBookEntry WHERE  PriceBook2.isStandard=true ])
       {
       mapPBList.put(PBE.Product2.Id,PBE);
       system.debug('====================================PBE'+PBE.Product2.Id);
       }
       
       
       OpportunityLineItem opp;
       
       system.debug('====================================================insertRecordsCurrentpageId'+oppor.id);
           for(Product2 p:product)
           {
           opp=new OpportunityLineItem();
           opp.Quantity=quantity; 
           system.debug('================================================ProPBID'+mapPBList.get(p.Id));
           opp.PricebookEntryId=(mapPBList.get(p.Id)).id;
           opp.TotalPrice=quantity*(mapPBList.get(p.Id)).UnitPrice;
           opp.Opportunityid=oppor.id;
           
           OpLnIt.add(opp);
           }
        insert OpLnIt;

        
        return page.himandlui;
    }

    public PageReference mycartref()
    {
    
    return page.mycart;
    
    }
    
    
    public PageReference addtoCart() {

        return null;
    }
    

    public List<Product2> getproduct()
    {
    if(product.isEmpty())
        for(product2 p:[select id,name,family,Available__c,(Select Id, Name, Pricebook2Id, Product2Id, UnitPrice, UseStandardPrice,  ProductCode From PricebookEntries),(select id From Attachments where ContentType=:'image/jpeg') from Product2])
    {
    
    if(!p.Attachments.isEmpty()&&!p.PricebookEntries.isEmpty())
    product.add(p);

    }

    return product;
    
    }
    public ProductImagesAttachments(){
    product =new List<product2>();
    produstids ='';
    
    
    }
    private List<Id> photoIds;

     
    public Integer totalPhotos {
        get {
            return product.size();
        }
    }
    //========================================mycart
    public integer quantity{get;set;}
    public PageReference mycart() {
        return page.mycart;
    }
    public integer noofitems{get;set;}

    
    public List<Product2> getMyCartProduct(){
    system.debug('inside getMyCartProduct start');
    id myprid=apexpages.currentpage().getparameters().get('id');
    if(myprid!=null){
    product=[select id,name,family,ProductCode,Colour__c,Available__c  ,(select id From Attachments where ContentType=:'image/jpeg') from Product2 where id =:myprid];
    system.debug('inside getMyCartProduct in if productlist'+product);
    noofitems=product.size();
    return product;
    }
    List<id> myid=produstids.split(',');
    system.debug('inside getMyCartProduct myid'+myid);
    product=[select id,name,family,Colour__c,Available__c,ProductCode,(select id From Attachments where ContentType=:'image/jpeg') from Product2 where id IN :myid];
    system.debug('inside getMyCartProduct productlist'+product);
    noofitems=product.size();
    return product;
    }
    
            public string Family{get;set;}
            public List<SelectOption> getFamilies() {
            List<SelectOption> options = new List<SelectOption>();
             Schema.DescribeFieldResult statusFieldDescription = Product2.Family.getDescribe();
             options.add(new SelectOption('ALL','ALL'));
                    for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
                    {
                        options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
                    }
                     
                       
                        return options;   
            }
            public string Brand{get;set;}
            public List<SelectOption> getBrands() {
            List<SelectOption> options = new List<SelectOption>();
             Schema.DescribeFieldResult statusFieldDescription = Product2.Brand__c.getDescribe();
             options.add(new SelectOption('ALL','ALL'));
                    for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
                    {
                        options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
                    }
                     
                       
                        return options;   
            }
            public string Colour{get;set;}
            public List<SelectOption> getColours() {
            List<SelectOption> options = new List<SelectOption>();
             Schema.DescribeFieldResult statusFieldDescription = Product2.colour__c.getDescribe();
             options.add(new SelectOption('ALL','ALL'));
                    for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
                    {
                        options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
                    }
                     
                       
                        return options;   
            }      
            
          //  =========================================================================================================search                  
        public pagereference search(){
            system.debug('inside search searchkey'+searchkey+'family'+findfamily);
                    if((searchtxt!=''||searchtxt!=null)&&(findfamily!=''&&findfamily!=null))
                    {
                    system.debug('inside if set searchkey'+searchkey+'family'+'-'+findfamily+'-');
                    product.clear();
                    searchkey=searchtxt+'%';
                                for(product2 p:[select id,name,family,(select id From Attachments where ContentType=:'image/jpeg'),(Select Id, Name, Pricebook2Id, Product2Id, UnitPrice, UseStandardPrice,  ProductCode From PricebookEntries) from Product2 where family=:findfamily AND name LIKE :searchkey])
                                {
                                
                                if(!p.Attachments.isEmpty())
                                product.add(p);
                                system.debug('inside if set searchtxt and family'+searchkey+''+product);
                                }
                    }
                    else
                    if((searchtxt!=''||searchtxt!=null))
                    {
                    
                    product.clear();
                    system.debug('inside if set searchtxt start'+searchkey+''+product);
                    searchkey=searchtxt+'%';
                                for(product2 p:[select id,name,family,(select id From Attachments where ContentType=:'image/jpeg') from Product2 where  name LIKE :searchkey])
                                {
                                
                                if(!p.Attachments.isEmpty())
                                product.add(p);
                                system.debug('inside if set searchtxt end'+searchkey+''+product);
                                }
                    }

            return null;
        }
    
}