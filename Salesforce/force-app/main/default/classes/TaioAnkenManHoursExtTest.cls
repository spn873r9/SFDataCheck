@isTest
public class TaioAnkenManHoursExtTest {
    private Static TaioAnken__c ta = null;
    private Static Invoice__c iv = null;

    @isTest
    static void testMethod1() {
        createMaster();
    
        PageReference pageRef = Page.ManHoursInput;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ta);
        
        Test.startTest();
        TaioAnkenManHoursExt ctr = new TaioAnkenManHoursExt(sc);
        Test.stopTest();
        
    }
    
    @isTest
    static void testMethod2() {
        createMaster();
    
        PageReference pageRef = Page.ManHoursInput;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ta);
        TaioAnkenManHoursExt ctr = new TaioAnkenManHoursExt(sc);
        
        Test.startTest();
        ctr.addData();
        Test.stopTest();
        
    }
    
    @isTest
    static void testMethod3() {
        createMaster();
    
        PageReference pageRef = Page.ManHoursInput;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ta);
        TaioAnkenManHoursExt ctr = new TaioAnkenManHoursExt(sc);
        
        Test.startTest();
        ctr.saveData();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod4() {
        createMaster();
    
        PageReference pageRef = Page.ManHoursInput;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ta);
        TaioAnkenManHoursExt ctr = new TaioAnkenManHoursExt(sc);
        
        Test.startTest();
        ctr.beforeMonth();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod5() {
        createMaster();
    
        PageReference pageRef = Page.ManHoursInput;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ta);
        TaioAnkenManHoursExt ctr = new TaioAnkenManHoursExt(sc);
        
        Test.startTest();
        ctr.nextMonth();
        Test.stopTest();
        
    }
    
    private static void createMaster(){
        Account acc = new Account(
            Name = 'test'
        );
        
        insert acc;
        
        Opportunity opp = new Opportunity(
            Name = 'Test'
            ,CloseDate = Date.today()
            ,StageName = '新規'
        );
        
        insert opp;
        
        ta = new TaioAnken__c(
            Name = 'test'
            ,Opportunity__c = opp.id
            ,Okyakusama__c = acc.id
        );
        
        insert ta;
        
        iv = new Invoice__c(
            Seikyubi__c = Date.Today()
            ,TaiouAnken__c = ta.id
        );
        
        insert iv;
    }
}