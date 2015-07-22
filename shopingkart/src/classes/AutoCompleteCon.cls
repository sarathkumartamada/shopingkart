public class AutoCompleteCon{

    public String labelFieldVar{ get; set; }
    public String valueFieldVar{ get; set; }
    public String sObjVal{get;set;}
    public Integer randomJsIden{get;set;}
    public Object cacheField{get;private set;} 
    
    private String targetFieldVar;
    
    public AutoCompleteCon(){
        randomJsIden = getRandomNumber(1000000);
        sObjVal='Account';
        labelFieldVar='Name';
        valueFieldVar='Id';
    }
    
    /*Dummy setter Method*/
    public void setCacheField(Object cacheField){}
    
    public void setTargetFieldVar(String targetFieldVar){
        
        if(targetFieldVar != this.targetFieldVar){
            cacheField = getCacheFieldValue(targetFieldVar);
            this.targetFieldVar = targetFieldVar;
           
        }
        
    }
    
    public String getTargetFieldVar(){
        return targetFieldVar;
    }
    
   private Object getCacheFieldValue(Object targetFieldVar){
        Object retVal = targetFieldVar;
        if(targetFieldVar!=null){
            for(sObject sObj : Database.query('SELECT '+valueFieldVar+','+labelFieldVar+' FROM '+sObjVal+' WHERE '+valueFieldVar+' =:targetFieldVar')){
                retVal = sObj.get(labelFieldVar);
                break;
            }
        }
        
        return retVal;
    }

    
    /*
    *Random number generator to change the js function name if multiple components us
    ***/
    private Integer getRandomNumber(Integer size){
        Double d = Math.random() * size;
        return d.intValue();
    }
    
    /*
    *This method queries data according to the passed parameters
    ***/
    @RemoteAction
    public static List<AutoCompleteData> getData(String sObjVal,String labelFieldVar,String valueFieldVar,String param){
       
        List<AutoCompleteData> AutoCompleteDatas = new List<AutoCompleteData>();
        param = String.escapeSingleQuotes(param);
        
        
       
            for( Sobject sObj : Database.query('SELECT '+valueFieldVar+','+labelFieldVar+' FROM '+sObjVal+' WHERE '+labelFieldVar+' LIKE \'%'+param+'%\'')){
            system.debug(sObj+'==='+sObj.get(valueFieldVar)+' =='+sObj.get(labelFieldVar));
                AutoCompleteDatas.add(new AutoCompleteData(sObj.get(valueFieldVar),sObj.get(labelFieldVar)));
            }
        
        return AutoCompleteDatas;
        
    }
    
    public class AutoCompleteData{
        public String id;
        public String text;
        
        public AutoCompleteData(Object id, Object text){
            this.id = String.valueOf(id);
            this.text = String.valueOf(text);
        }
    }

    
}