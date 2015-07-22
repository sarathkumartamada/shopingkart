public class OutfiTCustomController {

    public OutfiTCustomController(ApexPages.StandardController controller) {

    }

    
    public id Myid{get;set;}
    public Size__c mysize{get;set;}
    public STYLE__c mystyle1{get;set;}
    public void OutfiTCustomController()
    {    
        Myid=ApexPages.currentPage().getParameters().get('id') ;
        
        mystyle1=[Select  Name,    Id,     regularstyle__c,    preferred_fit__c,    WorkStyle__c,    TrouserFit__c, colour__c,   Preferrence__c,    FavShirt__c,    Dimensions__c,    Budjet__c,    Brand__c,    Account__c From   STYLE__c where id=:myid ];
        mysize=[Select   Name,  LastModifiedDate, Id,    WAIST__c,    Top_Size__c,    SHOES__c,    JACKET_SIZE__c,    HEIGHT__c,    COLLAR_SIZE__c,    Account__c From   Size__c where id=:mystyle1.Dimensions__c];
        Brand=mystyle1.Brand__c;
        searchStr='';
    }
    


    //=============================standardsetcontroller
    public List<Product2> getMyProductList()
    {
    
    List<Product2> MyProductList=setcon.getrecords();
    return MyProductList;
    }
    Public Integer noOfRecords{get;set;}
     public Apexpages.standardsetController setcon{
        get
        {
            if(setCon == null){
                
                
                String queryString = 'select id,Brand__c,Family,CreatedById,name,Colour__c,Demo__c from Product2';
                setcon = new apexpages.standardsetController(Database.getquerylocator(queryString));
                
                
                system.debug('===================================================='+setcon);
                setcon.setpagesize(5);
                noOfRecords=setcon.getResultsize();            }
                
            return setcon;
        }
         set;
        }
    
    
    
    
    
    //========================search
      public string Brand{get;set;}
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
      public string Colour{get;set;}
      public List<SelectOption> getColours() {
             List<SelectOption> options = new List<SelectOption>();
             Schema.DescribeFieldResult statusFieldDescription = STYLE__c.Colour__c.getDescribe();
             options.add(new SelectOption('--NONE--','--NONE--'));
                for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
                {
                    options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
                }
         
           
            return options;   
       } 
       public string family{get;set;}
      public List<SelectOption> getfamilys() {
             List<SelectOption> options = new List<SelectOption>();
             Schema.DescribeFieldResult statusFieldDescription = Product2.family.getDescribe();
             options.add(new SelectOption('--NONE--','--NONE--'));
                for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
                {
                    options.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
                }
         
           
            return options;   
       } 
      public string searchStr{get;set;} 
      public string Status{get;set;}  
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
    
       if(Status!=null&&Status!='--NONE--'&&Brand!=null&&Brand!='--NONE--')
       filterstring =' AND Brand__c =:Brand And Colour__c =:Status ';

      else
      if(Brand!=null&&Brand!='--NONE--')
      filterstring =' AND Brand__c =:Brand ';

      else
      if(Status!=null&&Status!='--NONE--')
      filterstring =' AND Colour__c =:Status ';
     if(filterstring==null)
     {
     filterstring=' ';
    
     //OrderString=' ';
     
     }
     string sortExp=' order by '+sortExpression;
      String searchStr =  Searchkey + '%';
      
      
      query='select id,Brand__c,Family ,CreatedById,name,Colour__c,Demo__c from Product2 where name like :searchStr '+filterstring+' '+sortExp+' '+OrderString;
      system.debug('======================================query'+query);
      system.debug('======================================query'+Database.getQueryLocator(query));
      setcon = new ApexPages.StandardSetController(Database.getQueryLocator(query));
      setcon.setpagesize(5);
    return null;
      
      }
      
      //=============================================
      Public Integer Count{get;set;}
      Public id Myproductid{get;set;}
      public pageReference Assign()
      {
      Outfit__c myOutfit=new Outfit__c();
      
      
      
      
      return null;
      }
      
}