@IsTest(SeeAllData=true)
public class HealthInsuranceWelfarePMstTrgHdrTest{
    @IsTest 
    public static void test1() {
        List<HealthInsuranceWelfarePensionMst__c> insData = [
            Select
                Id
            From
                HealthInsuranceWelfarePensionMst__c
        ];
    
        Test.StartTest();
        
        update insData;
        
        Test.StopTest();
    }
}