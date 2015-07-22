public class NewProductController{

   public list<String> AlphaList {get; set;}
    public String AlphaFilter {get; set;}
    public String SearchName {get; set;}
    public String SearchBillingAddress {get; set;} 
    private String SaveSearchName;
    private String SaveSearchBillingAddress;
    private String QueryAccount;
     public String SortFieldSave;
        public void BuildQuery() {
        setcon = null;
        String QueryWhere = '';
        
        if (AlphaFilter == null || AlphaFilter.trim().length() == 0) {
            AlphaFilter = 'All';
        }
        
        QueryAccount = 'SELECT Id, Name, BillingStreet, BillingPostalCode, BillingCountry, BillingCity, BillingState ' +
            ' FROM Account'; 
        
        if (AlphaFilter == 'Other') {
            QueryWhere = BuildWhere(QueryWhere, '(' + String.escapeSingleQuotes(SortField) + ' < \'A\' OR ' + 
                                    String.escapeSingleQuotes(SortField) + ' > \'Z\') AND (NOT ' + 
                                    String.escapeSingleQuotes(SortField) + ' LIKE \'Z%\') ');
        } else if (AlphaFilter != 'All') {
            QueryWhere = BuildWhere(QueryWhere, '(' + String.escapeSingleQuotes(SortField) + ' LIKE \'' + String.escapeSingleQuotes(AlphaFilter) + '%\')' );
        }
        
        if (SaveSearchName != null) {
            QueryWhere = BuildWhere(QueryWhere, ' (Name LIKE \'%' + String.escapeSingleQuotes(SaveSearchName) + '%\')');
        }
        if (SaveSearchBillingAddress != null) {
            QueryWhere = BuildWhere(QueryWhere, '((BillingStreet LIKE \'%' + String.escapeSingleQuotes(SaveSearchBillingAddress) + '%\') or' +
                                    ' (BillingCity LIKE \'%' + String.escapeSingleQuotes(SaveSearchBillingAddress) + '%\') or' +
                                    ' (BillingState LIKE \'%' + String.escapeSingleQuotes(SaveSearchBillingAddress) + '%\') or' +
                                    ' (BillingPostalCode LIKE \'%' + String.escapeSingleQuotes(SaveSearchBillingAddress) + '%\') or' +
                                    ' (BillingCountry LIKE \'%' + String.escapeSingleQuotes(SaveSearchBillingAddress) + '%\'))');
        }
        
        QueryAccount += QueryWhere;
        QueryAccount += ' ORDER BY ' + String.escapeSingleQuotes(SortField) + ' ' + String.escapeSingleQuotes(SortDirection) + ' LIMIT 10000';
        
        system.debug('QueryAccount:' + QueryAccount);
    }
    
    /***
    * BuildWhere - build soql string for where criteria 
    ***/
    public String BuildWhere(String QW, String Cond) {
        if (QW == '') {
            return ' WHERE ' + Cond;
        } else {
            return QW + ' AND ' + Cond;
        }
    }
    
    /***
    * SortDirection - return sort direction. Default ascending(asc)
    ***/
    public String SortDirection {
        get { if (SortDirection == null) {  SortDirection = 'asc'; } return SortDirection;  }
        set;
    }
    
    /***
    * SortField - return sort by field. Default to Name
    ***/
    public String SortField {
        get { if (SortField == null) {SortField = 'Name'; } return SortField;  }
        set; 
    }
    
    /***
    * SortToggle - toggles the sorting of query from asc<-->desc
    ***/
    public void SortToggle() {
        SortDirection = SortDirection.equals('asc') ? 'desc NULLS LAST' : 'asc';
        // reset alpha filter and sort sequence when sorted field is changed
        if (SortFieldSave != SortField) {
            SortDirection = 'asc';
            AlphaFilter = 'All';
            SortFieldSave = SortField;
        }
        // run the query again
        BuildQuery();
    }



    public String getProducts() {
    
        return null;
    }


    public PageReference addRecord() {
        
        contract ac=[select name,id,AccountId,StartDate,EndDate,Status from contract where id=:ApexPages.CurrentPage().getParameters().get('schId')];
        integer A=0;
        boolean flag=false;
        A=selectedList.size();
        if(A>0)
        for (Integer i = A-1; i >= 0 ;i-- ) {
        if (selectedList.get(i) == ac || selectedList.get(i).get('id') == ac.get('id')) {
            selectedList.remove(i); 
            flag=true;
            }
        }
        if(flag==false)
        {
        selectedList.add(ac);
        MyContract con=new MyContract();
        con.contrac=ac;
        con.flag1=true;
        myContracts.add(con);
        }
        return null;
    }

    public List<contract> selectedList{get;set;}
    public NewProductController(){
    
    
    
    AlphaList = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'Other', 'All'};
            SortFieldSave = SortField;
        
        // alpha filter, use page parameter or set default to all
        if (apexpages.currentpage().getparameters().get('alpha') == null) {
            AlphaFilter = 'All';
        } else {
            AlphaFilter = apexpages.currentpage().getparameters().get('alpha');
            }
    myContracts=new List<MyContract>();
    selectedList=new List<contract>();
    }
    public String addRecord { get; set; }

    Public Integer noofRecords {get; set;}
    public integer size {get; set;}
   
    public Apexpages.standardsetController setcon{
        get{
            if(setCon == null){
                size = 5;
                String queryString = 'Select name,id,AccountId,StartDate,EndDate,Status from contract order by Name';
                setcon = new apexpages.standardsetController(Database.getquerylocator(queryString));
                setcon.setpagesize(size);
                noofRecords = setcon.getResultsize();
            }
            return setcon;
        }
         set;
    }
    Public list<MyContract> getContracts(){
        list<MyContract> conlist = new list<MyContract>();
         for(contract ac : (list<contract>)setcon.getrecords()){
         system.debug('================================================='+ac);
         MyContract con=new MyContract();
        con.contrac=ac;
        con.flag1=false;
        system.debug('================================================='+con);
        conlist.add(con);
         }
        return conList;
       
      
    }
   
    Public PageReference Refresh(){
        selectedList.clear();
        myContracts.clear();
        setcon=null;
        getcontracts();
        setcon.setpageNumber(1);
       
        return null;
    }
    
    public List<MyContract> myContracts{get;set;}
    
    
    class MyContract{
    public contract contrac{get;set;}
    public boolean flag1{get;set;}
    }
}