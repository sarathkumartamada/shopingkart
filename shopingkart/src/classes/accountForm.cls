public class accountForm{

    public String OutfitBox{get;set;}
    public String WorkStyle{get;set;}
    public String preferredShirtFit{get;set;}
    public String preferredTrouserfit{get;set;}
    public String Brand{get;set;}
    public String VFPassword{get;set;}
    public Account Myaccount{get;set;}
   
    public String Vfemail{get;set;}


   

       public id myid{get;set;}
     
       public Account account{get;set;}
       public string name{get;set;}
       public string email{get;set;}
       public string password{get;set;}
       public string phone{get;set;}
       
 
      public accountForm()
      {     
            product =new List<product2>();
            produstids='';

            account=new Account(); 
            mysize=new Size__c();
            mystyle=new style__c ();
      }
    
    
         public PageReference gsave() {
         
          list<account> acc=[select id,Email__c from Account where Email__c=:Email];
                if(acc.isEmpty())
                {
                account.Email__c=email;
                account.name=name;
                account.password__c=password;
                account.phone=phone;
                insert account;
                system.debug('=================isidesave'+account);
                myid=account.id;
                }
                else
                myid=acc[0].id;
                Myaccount=[select id,name from Account where id=:myid];
                system.debug('====================afterinsert'+myid);
                return page.himandlui;
         }
        public PageReference save() {
                system.debug('=================isidesave'+account);
                account.Email__c=email;
                account.name=name;
                account.password__c=password;
                account.phone=phone;
                insert account;
                system.debug('=================isidesave'+account);
                myid=account.id;
                Myaccount=[select id,name from Account where id=:myid];
                system.debug('====================afterinsert'+myid);
                return page.himandlui;
               
        }

  
  

    
        public PageReference  verifyAccount()
        {
        
        list<Account> vf=[select id,password__C from Account where Email__c=:VFEmail];
        if(!vf.isempty())
        if(vf[0].password__c==VFpassword)
        {
            myid=vf[0].id;
            Myaccount=[select id,name from Account where id=:myid];
            return page.himandlui;
            system.debug('===================================='+vf[0].password__C);
            
        }
        
        Apexpages.addMessage(new ApexPages.Message(Apexpages.Severity.ERROR,'Invalid Account OR Password'));
        return null;
        }
    
    
    
        public PageReference savestyle() {
        mystyle.Account__c=myid;
        
            
            return null;
        }


   
      
        
        public style__c mystyle{get;set;}
        public Size__c mysize{get;set;}
        
        public pageReference addstyle()
        {
        system.debug('============================inside add style '+myid);
        
        mystyle.Preferrence__c=OutfitBox;
        mystyle.Account__c=myid;
        mystyle.WorkStyle__c=WorkStyle;
        mystyle.Budjet__c=Budjet;
        mystyle.preferred_fit__c=preferredShirtFit;
        mystyle.WorkStyle__c=WorkStyle;
        mystyle.TrouserFit__c=preferredTrouserfit;
        mystyle.Brand__c=Brand;
        system.debug('============================inside add style '+mystyle);
        
        system.debug('============================inside add style '+mystyle);
        mysize.COLLAR_SIZE__c=COLLAR;
        mysize.HEIGHT__c=HEIGHT;
        mysize.JACKET_SIZE__c=JACKET;
        mysize.SHOES__c=SHOES;
        mysize.Top_Size__c=TopSize;
        mysize.WAIST__c=WAIST;

        mysize.Account__c=myid;

        
        system.debug('============================inside add style '+mysize);
        insert mysize;
        mystyle.Dimensions__c=mysize.id;
        insert mystyle;
        system.debug('============================inside add style '+mysize);
        system.debug('===========================================insideaddstyle'+mystyle+''+mysize);
        return page.login;
        }  
        //===========================size
        public string Type{get;set;}
        public string Budjet{get;set;}
        public List<SelectOption> getTypes() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = STYLE__c.Budjet__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
        }
        
        public string COLLAR{get;set;}
        public List<SelectOption> getCOLLARs() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = Size__c.COLLAR_SIZE__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
        }
        public string HEIGHT{get;set;}
        public List<SelectOption> getHEIGHTs() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = Size__c.HEIGHT__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
        }
        public string JACKET{get;set;}
        public List<SelectOption> getJACKETs() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = Size__c.JACKET_SIZE__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
        }
      
        public string SHOES{get;set;}
        public List<SelectOption> getSHOESs() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = Size__c.SHOES__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
        }
        public string TopSize{get;set;}
        public List<SelectOption> getTopSizes() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = Size__c.Top_Size__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
        }
        public string WAIST{get;set;}
        public List<SelectOption> getWAISTs() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = Size__c.WAIST__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           system.debug('hello=====================this is from getWaisats'+options);
            return options;   
        }
        
       /*
        //===================================================  outfit
        public List<Id> photoIdsold{get;set;}
        public List<Id> photoIdsnew{get;set;}
        public List<outfit__c> getmyOldoutfit()
        {
            List<outfit__c> myoutfit=[select id,name,STYLE__c, Result__c, Account__c From Outfit__c where Outfit__C.account__c=:myid AND Result__c=:'send'];
            system.debug('inside myOldoutfit'+myoutfit);
            Set<Id> resultIds = (new Map<Id,SObject>(myoutfit)).keySet();
            list<OpportunityLineItem> myOplI=[Select Product2Id,Balakrishna__OutfitProduct__c  From OpportunityLineItem  where Balakrishna__OutfitProduct__c =: resultIds ]; 
            system.debug('inside myOldoutfit myOplI'+myOplI);
            photoIdsold= new List<Id>();
                for(OpportunityLineItem opl:myOplI)
                for(Attachment att : [select Id from Attachment where ParentId = :opl.Product2Id]) {
                    photoIdsold.Add(att.Id);
                }
            return myoutfit;
            
        }     
        public List<outfit__c> getmyoutfit()
        {
            List<outfit__c> myoutfit=[select id,name,STYLE__c, Result__c,Account__c From Outfit__c where Outfit__C.account__c=:myid AND Result__c!=:'send'];
            system.debug('=========================myassigned outfits'+myid);
            system.debug('inside getmyoutfit'+myoutfit);
            
            Set<Id> resultIds = (new Map<Id,SObject>(myoutfit)).keySet();
            system.debug('inside getmyoutfit============================================'+resultIds );
         //   Select  Product2Id, Balakrishna__OutfitProduct__c From OpportunityLineItem  where Balakrishna__OutfitProduct__c  ='a0D280000001s46'
            list<OpportunityLineItem> myOplI=[Select Product2Id,Balakrishna__OutfitProduct__c  From OpportunityLineItem where Balakrishna__OutfitProduct__c =: resultIds ]; 
            system.debug('inside getmyoutfit  myOplI'+myOplI);    
  
                photoIdsnew= new List<Id>();
                for(OpportunityLineItem opl:myOplI)
                for(Attachment att : [select Id from Attachment where ParentId = :opl.Product2Id]) {
                    photoIdsnew.Add(att.Id);
                }
                                
            return myoutfit;
        }
        */
        //======================================conclusion
        public string result{get;set;}
        public pageReference updateoutfit()
        {
        system.debug('=========================updateoutfit'+myid);
        outfit__c oufitupdate=[select id,result__C from outfit__c where id=:ApexPages.CurrentPage().getParameters().get('outfitid')];
        oufitupdate.result__c=result;
        system.debug('=========================updateoutfit'+myid);
        upsert oufitupdate;
        
        return null;
        }
        //==========================================================image picker

       public List<SelectOption> getOutfitBoxs() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = STYLE__c.Preferrence__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
        }
       public List<SelectOption> getWorkStyles() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = STYLE__c.WorkStyle__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
        }
        public List<SelectOption> getpreferredShirtFits() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = STYLE__c.preferred_fit__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
        }
        public List<SelectOption> getpreferredTrouserfits() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = STYLE__c.TrouserFit__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
        }
        public List<SelectOption> getBrands() {
        
            List<SelectOption> options = new List<SelectOption>();
            
              Schema.DescribeFieldResult statusFieldDescription = STYLE__c.Brand__c.getDescribe();

        
        options.add(new SelectOption('--NONE--','--NONE--'));
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
           
         
           
            return options;   
        }
        
        //=========================================================================producrsAndAttachments
            public String mycartproductids { get; set; }

    public String findfamily { get; set; }

    public String searchtxt { get; set; }
public List<Product2> product;
public string searchkey{get;set;}

    /*  public ProductImagesAttachments(accountForm controller) {

    system.debug('================='+myaccount);
  id myprid=apexpages.currentpage().getparameters().get('id');
    system.debug('=============id       ============'+myprid);
    if(myprid!=null){
    product=[select id,name,family,  (select id From Attachments where ContentType=:'image/jpeg') from Product2 where id =:myprid];
    }
    }*/


    public String produstids { get; set; }
    





    public String myproducts { get; set; }


    public PageReference RemoveFromCart() {
        return null;
    }

 

   
    public id myaccountid{get;set;}
    public id productid{get;set;}
    public PageReference Buy() {
        opportunity oppor=new opportunity();
        myaccountid=myid;
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

        productinsertion='true';
        product.clear();
        return null;
    }
    public string productinsertion{get;set;}
    public PageReference mycartref()
    {
    system.debug('in==========mycartref start'+produstids+''+this.produstids);
    produstids=this.produstids;
    return null;
    
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
    system.debug('inside getMyCartProduct start produstids'+produstids);
    id myprid=apexpages.currentpage().getparameters().get('id');
    if(myprid!=null){
    product=[select id,name,family,ProductCode,Colour__c,Available__c  ,(select id From Attachments where ContentType=:'image/jpeg') from Product2 where id =:myprid];
    system.debug('inside getMyCartProduct in if productlist'+product);
    noofitems=product.size();
    return product;
    }
    if(produstids!=null&&produstids!='')
    {
    List<id> myid=produstids.split(',');
    system.debug('inside getMyCartProduct produstids'+produstids);
    system.debug('inside getMyCartProduct myid'+myid);
    product=[select id,name,family,Colour__c,Available__c,ProductCode,(select id From Attachments where ContentType=:'image/jpeg') from Product2 where id IN :myid];
    }
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
            public string Brandsidebar{get;set;}
            public List<SelectOption> getBrandssidebar() {
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
                                for(product2 p:[select id,name,family,(Select Id, Name, Pricebook2Id, Product2Id, UnitPrice, UseStandardPrice,  ProductCode From PricebookEntries),(select id From Attachments where ContentType=:'image/jpeg') from Product2 where family=:findfamily AND name LIKE :searchkey])
                                {
                                
                                if(!p.Attachments.isEmpty()&&!p.PricebookEntries.isEmpty())
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
                                for(product2 p:[select id,name,family,(Select Id, Name, Pricebook2Id, Product2Id, UnitPrice, UseStandardPrice,  ProductCode From PricebookEntries),(select id From Attachments where ContentType=:'image/jpeg') from Product2 where  name LIKE :searchkey])
                                {
                                
                                if(!p.Attachments.isEmpty())
                                product.add(p);
                                system.debug('inside if set searchtxt end'+searchkey+''+product);
                                }
                    }

            return null;
        }
}