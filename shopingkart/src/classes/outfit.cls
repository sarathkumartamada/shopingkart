public class outfit {
    public id accid{get;set;}
    public PageReference test() {
    system.debug('inside test'+prid);
        return null;
    }

    public id outfitid{get;set;}
    public PageReference updateoutfit() {

        outfit__c currentOutfitToUpdate=[select id from outfit__C where id=:outfitid];
        currentOutfitToUpdate.Result__c=result;
        system.debug('=========inside updateoutfit==result'+result);
        update currentOutfitToUpdate;
        return null;
    }
    list<outfit__c> Outfits;

    
    public list<outfit__c> getOutfits(){
            
            Outfits=[Select STYLE__c,Result__c,Name,  Opportunity__c,  Account__c, (Select Id, OpportunityId, SortOrder, PricebookEntryId, Product2Id, ProductCode, Name, Quantity, TotalPrice, UnitPrice, ListPrice, ServiceDate,  OutfitProduct__c From Opportunity_Product__r) From Outfit__c where account__c=:accid AND Result__c!=:'Send' ];
            Set<Id> resultIds = (new Map<Id,SObject>(Outfits)).keySet();
            system.debug('inside getmyoutfit============================================'+resultIds );
            system.debug('=========inside updateoutfit==result'+result);
            list<OpportunityLineItem> myOplI=[Select Product2Id,Balakrishna__OutfitProduct__c  From OpportunityLineItem where Balakrishna__OutfitProduct__c IN :resultIds ]; 
            system.debug('inside getmyoutfit  myOplI'+myOplI);  
    
    
    return outfits;
    }    
    
    
    
        public list<outfit__c> getOldOutfits(){
            
            Outfits=[Select STYLE__c,Result__c,Name,  Opportunity__c,  Account__c, (Select Id, OpportunityId, SortOrder, PricebookEntryId, Product2Id, ProductCode, Name, Quantity, TotalPrice, UnitPrice, ListPrice, ServiceDate,  OutfitProduct__c From Opportunity_Product__r) From Outfit__c where account__c=:accid AND Result__c=:'Send'];
            Set<Id> resultIds = (new Map<Id,SObject>(Outfits)).keySet();
            system.debug('inside getmyoutfit============================================'+resultIds );
       
            list<OpportunityLineItem> myOplI=[Select Product2Id,Balakrishna__OutfitProduct__c  From OpportunityLineItem where Balakrishna__OutfitProduct__c =: resultIds ]; 
            system.debug('inside getmyoutfit  myOplI'+myOplI);  
    
    
    return outfits;
    }   
        public outfit(){
        Outfits=new list<outfit__c>();
        }
        public string result{get;set;}
        public id prid{get;set;}
        private List<Id> photoIds;
        public List<Id> getphotos(){
        
            if(photoIds == null) {
                photoIds = new List<Id>();
                }
                photoIds.clear();

                system.debug('inside get photos'+prid);
                for(Attachment att : [select Id from Attachment where ParentId = :prid]) {
                    photoIds.Add(att.Id);
                }
            
                             
            return photoIds;
        }
    
}