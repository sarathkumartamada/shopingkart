public class Login_Con {

    public void saveAcc() {
        try{
            insert AccObj;
            init();
            isSuccess = true;
        }
        catch(Exception ex){
            Apexpages.addMessages(ex);
            isSuccess = false;
        }
        
    }


    public Boolean IsSuccess{get;set;}

    public Account AccObj{get;set;}

      private void init(){
        AccObj = new Account();
        isSuccess = false;
    }
    public void verify()
    {
        try{
        Account resulted=[select id,Industry from Account];
        if(AccObj.Industry==resulted.Industry)
        isSuccess = true;
        }
        catch(Exception ex){
            Apexpages.addMessages(ex);
            isSuccess = false;
        }
    }
}