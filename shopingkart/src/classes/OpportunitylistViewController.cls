public class OpportunitylistViewController {

    public OpportunitylistViewController() {

    }




    public PageReference listid() {
    system.debug('-------------------------------'+selectedList);
       return  null;
        
    }
    

        public string getSelectvalue()
    {
    if(selectedList=='All Opportunities'){
        string str='00B28000001khYE';
        return str;
        }
       return '00B28000000ZpZ9';
    
    }


    public OpportunitylistViewController(ApexPages.StandardController controller) {

    }


    public string selectedList{get;set;}
 
         public List<SelectOption> getstageList() {
     List<SelectOption> options = new List<SelectOption>();
       options.add(new SelectOption('00B28000001khYE','All Opportunities'));
        options.add(new SelectOption('00B28000000ZpZ9','subOpportunities'));
        
    return options;
    }
    }