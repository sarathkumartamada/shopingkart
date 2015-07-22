global class BootsrapPageController{

    public BootsrapPageController(ApexPages.StandardController controller) {

    }

        public integer TotalAcc{get;set;}
        public List<SelectOption> getParentAccount() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('','--none--'));
            for(Account acc:[select id,name from Account order by name ])
            options.add(new SelectOption(acc.id,acc.name));
            TotalAcc=options.size();
            return options;
        }

@RemoteAction     
 global static List<Account> getAccountList(){     
      List<Account> accList=[select id,Name from account];   
      return accList;    
} 

}