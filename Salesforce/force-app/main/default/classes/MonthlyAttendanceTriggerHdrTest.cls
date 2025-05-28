/**------------------------------------------------------------------------------
 * クラス名：MonthlyAttendanceTriggerHdrTest 
 * 概要    ：
 *           
 *
 * 改版履歴：2023/01/02 S.Kobayashi：新規
**------------------------------------------------------------------------------*/
@isTest
public class MonthlyAttendanceTriggerHdrTest {
    /**------------------------------------------------------------------------------
     * 標準コントローラクラスのテスト
    **------------------------------------------------------------------------------*/
    @isTest
    static void testMethod1() {
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
        
        MonthlyAttendance__c ma = new MonthlyAttendance__c(
            Name                     = Datetime.now().year() + '年' + String.valueOf(Datetime.now().month()).leftPad(2,'0') + '月'
            ,EmpInfo__c              = emp.Id
            ,Month__c                = String.valueOf(Datetime.now().month()).leftPad(2,'0')
            ,MonthlyApplovalCheck__c = false
            ,PaidDayCount__c         = 0.0
            ,SpecialPaidLeave__c     = 0.0
            ,SumBreakTime__c         = 3.0
            ,SumWorkTime__c          = 20.0
            ,Year__c                 = String.valueOf(Datetime.now().year())
        );
        
        Test.startTest();
        
        insert ma;
        
        Test.stopTest();
        
    }
}