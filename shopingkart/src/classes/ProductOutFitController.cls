public class ProductOutFitController {


    

    public String AlphaFilter { get; set; }
    
    public Integer ListSize{get;set;}
    public PageReference BuildQuery() {
    
    AlphaFilter = (string)ApexPages.CurrentPage().getParameters().get('AlphaFilter');
    
    if (AlphaFilter == null || AlphaFilter.trim().length() == 0) {
            AlphaFilter = 'All';
        }
        
       
        
        if (AlphaFilter == 'Other') {
            Searchkey ='-%' ;
        } else if (AlphaFilter != 'All') {
            Searchkey = AlphaFilter ;
            
        }
        
        
        Find();
        return null;
        

    }
    
    // ==========AlphaList 
    
   public list<String> AlphaList {get; set;}
   
  
  





    //================================
    public set<id> ProductSetId;
    public String Searchkey { get; set; }
    public List<Product2> selectedList {get;set;}
    public List<ProductList> proList{get;set;}
  
    Public Integer noofRecords {get; set;}
    public integer size {get; set;}
   
   

    public Apexpages.standardsetController setcon{
        get{
            if(setCon == null){
                size = 5;
                
                String queryString = 'Select SystemModstamp,ProductCode, Name,Id, Family, Description From Product2  where Family IN: someValues';
                setcon = new apexpages.standardsetController(Database.getquerylocator(queryString));
                
                
                system.debug('===================================================='+setcon);
                setcon.setpagesize(size);
                noofRecords = setcon.getResultsize();
            }
            return setcon;
        }
         set;
        }
        
        //===================================================setconselected
         public integer sizesetcon{get;set;}
         public Apexpages.standardsetController selectedsetcon{
        get{
                
                
                
                
                selectedsetcon= new apexpages.standardsetController(selectedList);
                system.debug('====================================================..................selctedsetcon'+selectedsetcon);
                selectedsetcon.setpagesize(sizesetcon);
                ListSize= selectedsetcon.getResultsize();
            
            return selectedsetcon;
        }
         set;
        }
        
        Public List<Product2> getSelctedSetconList()
        {
        
        system.debug('====================================================..................selctedsetconRecords'+selectedsetcon.getrecords());
        return  (list<Product2>)selectedsetcon.getrecords();
        }
    
    // =======================================ProductList
    
    Public list<ProductList> getProducts(){
         proList.clear();
         for(Product2 ol : (list<Product2>)setcon.getrecords()){
         proList.add(new ProductList(ol,ProductSetId.contains(ol.id)));
         }
         
         return proList;
         }
    
    public PageReference addRecord() {
        system.debug('=============================================================>'+ApexPages.CurrentPage().getParameters().get('schId'));
        //system.assert(ApexPages.CurrentPage().getParameters().get('schId')=='00k28000002cK5k');
        Product2 ac=new Product2();
        ac=[select SystemModstamp,ProductCode, Name,Id, Family, Description from Product2 where id=:ApexPages.CurrentPage().getParameters().get('schId')];
        
        system.debug('=============================================================>'+ApexPages.CurrentPage().getParameters().get('schId')+'-'+ac);
        integer A=0;
        boolean flag=false;
        A=selectedList.size();
                
                if(A>0&&ProductSetId.contains(ac.id))
                    for (Integer i = A-1; i >= 0 ;i-- ) 
                    if (selectedList.get(i) == ac || selectedList.get(i).get('id') == ac.get('id')) {
                        selectedList.remove(i); 
                        ProductSetId.remove((ID)ac.get('id'));
                        flag=true;
                        
                        }
                    
                if(flag==false)
                {
                
                selectedList.add(ac);
                ProductSetId.add(ac.id);
                
                }
        return null;
    }    
    
    //================================constructer
    public Id id{get;set;}
    List<String> someValues; 
    public ProductOutFitController(){
    id=ApexPages.CurrentPage().getParameters().get('Id');
        system.debug('=========================================================id'+id);
    sortExpression='Name';
    searchkey='';
    ProductSetId=new set<ID>();
    sizesetcon= 50;
    proList=new List<ProductList>();
    AlphaList = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'Other', 'All'};
    selectedList=new list<Product2>();

    
    someValues = new List<String>();
        Schema.DescribeFieldResult statusFieldDescription = Product2.Family.getDescribe();
        
        for (Schema.Picklistentry picklistEntry : statusFieldDescription.getPicklistValues())
        {
            someValues.add(pickListEntry.getValue());
        }
   
   
    }
    //=================================sort
   
  
     public String sortExpression{get;set;}
  
   
    
    //===============================finder
    
    public PageReference Find(){
    
    String searchStr =  Searchkey + '%';
    string query='select Name,ProductCode,SystemModstamp,Description,Family from Product2 where Family IN: someValues AND name like :searchStr order by '+sortExpression;
    system.debug('======================================query'+Database.getQueryLocator(query));
       setcon = new ApexPages.StandardSetController(Database.getQueryLocator(query));
       noOfRecords=setcon.getrecords().size();
       setcon.setpagesize(size);
       
    return null;
    }
    // ======================================save
    
     public PageReference insertRecords() {
       List<OpportunityLineItem> OpLnIt= new List<OpportunityLineItem>();
       
       map<Id,Id> mapPBList=new map<Id,Id>();
       
       for(PriceBookEntry PBE: [SELECT Id, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry WHERE  PriceBook2.isStandard=true ])
       {
       mapPBList.put(PBE.Product2.Id,PBE.Id);
       system.debug('====================================PBE'+PBE.Product2.Id);
       }
       
       
       OpportunityLineItem opp;
       
       system.debug('====================================================insertRecordsCurrentpageId'+id);
           for(Product2 p:selectedList )
           {
           opp=new OpportunityLineItem();
           opp.Quantity=1; 
           system.debug('================================================ProPBID'+(Id)mapPBList.get(p.Id));
           opp.PricebookEntryId=(Id)mapPBList.get(p.Id);
           opp.OutfitProduct__c=id;
           opp.Opportunityid=ApexPages.CurrentPage().getParameters().get('oppid');
           opp.TotalPrice=200;
           OpLnIt.add(opp);
           }
        insert OpLnIt;
        return null;
    }
    
    
    public class ProductList
    {
        public Product2 pr{get;set;}
        public Boolean flag{get;set;}
         
         public ProductList(Product2 a, Boolean chk)
         {
                pr = a;
                flag = chk;
         }
        
     }
    


}