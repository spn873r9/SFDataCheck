/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-01-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class WorkTaskSearchCtrTest {
    private static void createMaster(){
        WorkTask__c obj = new WorkTask__c();
        
        insert obj;
    }
    
    private static void createMaster100(){
        List<WorkTask__c> dataList = new List<WorkTask__c>();
        for(Integer i = 0; i < 100; i++){
            dataList.add(new WorkTask__c());
        }
        
        insert dataList;
    }
    
    @isTest
    static void testMethod1() {
        createMaster();
        Test.startTest();
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod2_1() {
        createMaster();
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.searchWithoutScInstallDate('0',false);
        Test.stopTest();
        
    }
    @isTest
    static void testMethod2_2() {
        createMaster();
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.searchWithoutScInstallDate('1',false);
        Test.stopTest();
        
    }
    @isTest
    static void testMethod2_3() {
        createMaster();
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.searchWithoutScInstallDate('2',false);
        Test.stopTest();
        
    }
    @isTest
    static void testMethod2_4() {
        createMaster();
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.searchWithoutScInstallDate('0',true);
        Test.stopTest();
        
    }
    @isTest
    static void testMethod3() {
        createMaster();
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.search();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod4() {
        createMaster();
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.searchToday();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod5() {
        createMaster();
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.searchMonth();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod6_1() {
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.search(false);
        Test.stopTest();
        
    }
    @isTest
    static void testMethod6_2() {
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.search(true);
        Test.stopTest();
        
    }
    @isTest
    static void testMethod7() {
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.whereString('Name','Name');
        Test.stopTest();
        
    }
    @isTest
    static void testMethod8() {
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.whereStringOr(new List<String>{'Name','Name'},'Name');
        Test.stopTest();
        
    }
    @isTest
    static void testMethod9() {
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.whereStringOr('Name',new List<String>{'Name','Name'});
        Test.stopTest();
        
    }
    @isTest
    static void testMethod10() {
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.whereBoolean('Name','Name');
        Test.stopTest();
        
    }
    @isTest
    static void testMethod11() {
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.whereDecimal('0','1','Name');
        Test.stopTest();
        
    }
    @isTest
    static void testMethod12() {
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.whereDate(Date.Today(),Date.Today(),'Name');
        Test.stopTest();
        
    }
    @isTest
    static void testMethod13() {
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.whereDatetime(Datetime.now(),Datetime.now(),'CreatedDate');
        Test.stopTest();
        
    }
    @isTest
    static void testMethod14() {
        createMaster100();
        WorkTaskSearchCtr ctr = new WorkTaskSearchCtr();
        Test.startTest();
        ctr.next();
        ctr.previous();
        ctr.LastPage();
        ctr.FirstPage();
        ctr.getenablePrev();
        ctr.getenableNext();
        Test.stopTest();
    }
}