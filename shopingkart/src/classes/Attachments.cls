public with sharing class Attachments{
 
    private ApexPages.standardController controller;
     
    private Product2 product;
 
    private List<Id> photoIds;
 
    public Attachments(ApexPages.StandardController controller) {
        this.controller = controller;
         
        this.product= (Product2)controller.getRecord();
    }
 
    public List<Id> photos {
        get {
            if(photoIds == null) {
                photoIds = new List<Id>();
                for(Attachment att : [select Id from Attachment where ParentId = :product.Id]) {
                    photoIds.Add(att.Id);
                }
            }
                             
            return photoIds;
        }
    }
     
    public Integer totalPhotos {
        get {
            return photos.size();
        }
    }
}