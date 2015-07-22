public class VSModals_Con {
 
    public Boolean isSuccess{get;set;}
    public Case caseObj{get;set;}
    
    public VSModals_Con() {
        init();
    }
    
    //method to save the records
    public void saveCase(){
        try{
            insert caseObj;
            init();
            isSuccess = true;
        }
        catch(Exception ex){
            Apexpages.addMessages(ex);
            isSuccess = false;
        }
    }
    
    //fetch the cases
    public List<Case> getCases(){
        return [SELECT Id,CaseNumber,Status,Priority,Type,Subject,isClosed FROM Case ORDER BY CreatedDate DESC];
    }
    
    
    private void init(){
        caseObj = new Case();
        isSuccess = false;
    }
 
}