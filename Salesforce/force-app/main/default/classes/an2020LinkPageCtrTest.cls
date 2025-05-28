@isTest
public class an2020LinkPageCtrTest {
    @isTest
    static void testMethod1() {
        createData();
        PageReference pageRef = Page.an2020LinkPage;
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        an2020LinkPageCtr ctr = new an2020LinkPageCtr();
        ctr.viewPage();
        
        Test.stopTest();
        
    }
    @isTest
    static void testMethod2() {
        createData();
        PageReference pageRef = Page.an2020LinkPage;
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        an2020LinkPageCtr ctr = new an2020LinkPageCtr();
        ctr.linkLips();
        
        Test.stopTest();
        
    }
    @isTest
    static void testMethod3() {
        createData();
        PageReference pageRef = Page.an2020LinkPage;
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        an2020LinkPageCtr ctr = new an2020LinkPageCtr();
        ctr.linkInsta();
        
        Test.stopTest();
        
    }
    @isTest
    static void testMethod4() {
        createData();
        PageReference pageRef = Page.an2020LinkPage;
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        an2020LinkPageCtr ctr = new an2020LinkPageCtr();
        ctr.linkTwitter();
        
        Test.stopTest();
        
    }
    @isTest
    static void testMethod5() {
        createData();
        PageReference pageRef = Page.an2020LinkPage;
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        an2020LinkPageCtr ctr = new an2020LinkPageCtr();
        ctr.linkRRoom();
        
        Test.stopTest();
        
    }
    
    public static void createData(){
        SiteTuisekiRireki__c sr = new SiteTuisekiRireki__c(
            Name = 'an2020'
            ,SiteViewCount__c = 0
            ,ClickCountLips__c = 0
            ,ClickCountInsta__c = 0
            ,ClickCountTwitter__c = 0
            ,ClickCountRRoom__c = 0
        );
        
        insert sr;
    }
}