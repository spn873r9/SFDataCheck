/**------------------------------------------------------------------------------
 * クラス名：EmployeeInfoTriggerHdrTest
 * 概要    ：
 *           
 *
 * 改版履歴：2023/01/02 S.Kobayashi：新規
**------------------------------------------------------------------------------*/
@IsTest 
public class EmployeeInfoTriggerHdrTest{
    @IsTest 
    public static void test1() {
        Test.StartTest();
        
        EmployeeInfoTriggerHdr hdr = new EmployeeInfoTriggerHdr();
        WorkingConditionsMaster__c wm = new WorkingConditionsMaster__c(
            Name              = '裁量労働制'
            ,BreakTime__c      = '01:00'
            ,DailyCheck__c     = false
            ,EndBreakTime__c   = '13:00'
            ,EndWorkTime__c    = '19:00'
            ,MonthlyCheck__c   = true
            ,ScheduledLabor__c = '08:00'
            ,StartBreakTime__c = '12:00'
            ,StartWorkTime__c  = '10:00'
            ,VacationCheck__c  = true
            ,WorkActiveFri__c  = true
            ,WorkActiveMon__c  = true
            ,WorkActiveSat__c  = false
            ,WorkActiveSun__c  = false
            ,WorkActiveThu__c  = true
            ,WorkActiveTue__c  = true
            ,WorkActiveWed__c  = true
        );
        
        insert wm;
        
        EmployeeInfo__c emp = new EmployeeInfo__c(
            Name                 = 'テスト タロウ'
            ,EmployeeType__c     = wm.Id
            ,IsActive__c         = true
            ,JoinCompanyDate__c  = Date.Today()
            ,UseInfo__c          = UserInfo.getUserId()
        );
        
        insert emp;
        
        Test.StopTest();
    }
}