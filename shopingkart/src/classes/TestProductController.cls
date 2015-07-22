@isTest(SeeAllData=true)
private class TestProductController{

private static testmethod void TestProductControllerTestmethod()
{


PageReference testPage = Page.new;
Test.setCurrentPage(testPage);ApexPages.currentPage().getParameters().put('Id', '00628000002Xbm1');
    ProductController PC=new ProductController();

    system.assert(PC.setCon!=null);
ApexPages.currentPage().getParameters().put('Id', '00628000002Xbm1');
PageReference next= PC.BuildQuery();
ApexPages.currentPage().getParameters().put('AlphaFilter', 'A');
next = PC.BuildQuery();
ApexPages.currentPage().getParameters().put('AlphaFilter', 'Other');
next = PC.BuildQuery();

PC.Searchkey='SLA';
PC.find(); 
    system.assert(PC.ListSize==null);
	system.assert(PC.noofRecords!=null);
     List<Product2> testProduct2 = [select SystemModstamp,ProductCode,Name, Family, Description from Product2];
     upsert testProduct2;
    ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(testProduct2);
    
    ApexPages.currentPage().getParameters().put('schId', testProduct2[3].id);
   // system.assertEquals('00k28000002cK5k',ApexPages.currentPage().getParameters().get('schId'));
   
    system.debug(ApexPages.currentPage().getParameters().get('schId'));
    system.assert(PC.getProducts()!=null);
    system.assert(PC.getSelctedSetconList()!=null);
    system.assertEquals(null, PC.addRecord());
    ApexPages.currentPage().getParameters().put('schId', testProduct2[3].id);
    system.assertEquals(null, PC.addRecord());
    ApexPages.currentPage().getParameters().put('schId', testProduct2[4].id);
    system.assertEquals(null, PC.addRecord());
    ApexPages.currentPage().getParameters().put('schId', testProduct2[5].id);
    system.assertEquals(null, PC.addRecord());
    ApexPages.currentPage().getParameters().put('schId', testProduct2[6].id);
    system.assertEquals(null, PC.addRecord());
   
    system.assertEquals(null, PC.insertRecords());
	//string str = PC.addRecord().getUrl();

}




}