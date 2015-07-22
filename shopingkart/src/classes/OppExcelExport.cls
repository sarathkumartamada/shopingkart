public class OppExcelExport {

public string ObjectName{get;set;}
public Id listid{get;set;}
public List<Sobject> recordList {get;set;}
public List<List<Sobject>> allRecords{get;set;}
public OppExcelExport(){

ObjectName=ApexPages.currentPage().getParameters().get('type');
listid=ApexPages.currentPage().getParameters().get('listid');
system.debug(ObjectName);
ObjectName='Opportunity';


//HTTP callouts
HttpRequest req = new HttpRequest();
req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
req.setHeader('Content-Type', 'application/json');
String domainUrl=URL.getSalesforceBaseUrl().toExternalForm();
String endpointUrl=domainUrl+'/services/data/v32.0/sobjects/'+ObjectName+'/listviews/'+listid+'/describe';
req.setEndpoint(endpointUrl);
req.setMethod('GET');      
Http h = new Http();
HttpResponse res = h.send(req);
system.debug('===============================================response'+res.getBody());
/*
Map<string,Opportunity> root  = (Map<string, Opportunity>)JSON.deserializeUntyped(res.getBody());     

//this logic to over come the 10k collection limit    
for(Sobject sobj : Database.query((string)root.get('query'))){
  recordList.add(sobj);
  if(recordList.size() == 10000){
     allRecords.add(recordList);
     recordList = new List<sobject>();
  }
}
     */
if(recordList != null && !recordList.isEmpty())
  allRecords.add(recordList);  
  system.debug(allRecords);
/*
//Parsing to get the column details        
JSONParser parser = JSON.createParser(res.getBody());
while (parser.nextToken() != null){ 
   if(parser.getCurrentToken() == JSONToken.START_ARRAY) {       
     while (parser.nextToken() != null) {
        if(parser.getCurrentToken() == JSONToken.START_OBJECT) {
           listviewAPI.Columns le = (listviewAPI.Columns)parser.readValueAs(listviewAPI.Columns.class);
           parserCol.add(le);        
         }
     }
   }
}
*/

}

}