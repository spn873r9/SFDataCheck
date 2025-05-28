@isTest
public class ManHoursTriggerHdrTest {
    private Static TaioAnken__c ta = null;
    private Static Invoice__c iv = null;

    @isTest
    static void testMethod1() {
        createMaster();
        
        Test.startTest();
        
        ManHours__c mh = new ManHours__c(
            Name          = Datetime.now().format('yyyy/MM/dd')
            ,StartTime__c = '00:00'
            ,EndTime__c   = '01:00'
            ,TaioAnken__c = ta.Id
        );
        
        insert mh;
        
        
        Test.stopTest();
        
    }
    
    @isTest
    static void testMethod2() {
        createMaster();
    
        ManHours__c mh = new ManHours__c(
            Name          = Datetime.now().format('yyyy/MM/dd')
            ,StartTime__c = '00:00'
            ,EndTime__c   = '01:00'
            ,TaioAnken__c = ta.Id
        );
        
        insert mh;
        
        Test.startTest();
        update mh;
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