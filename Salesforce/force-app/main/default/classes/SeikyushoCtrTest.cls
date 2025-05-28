@isTest
public class SeikyushoCtrTest {
    private Static Invoice__c iv = null;

    @isTest
    static void testMethod1() {
        createMaster();
    
        PageReference pageRef = Page.Seikyusho;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(iv);
        
        Test.startTest();
        SeikyushoCtr ctr = new SeikyushoCtr(sc);
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
        
        TaioAnken__c ta = new TaioAnken__c(
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