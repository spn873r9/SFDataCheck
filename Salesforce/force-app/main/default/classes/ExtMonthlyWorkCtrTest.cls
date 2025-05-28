/**------------------------------------------------------------------------------
 * クラス名：ExtMonthlyWorkCtrTest 
 * 概要    ：
 *           
 *
 * 改版履歴：2023/01/02 S.Kobayashi：新規
**------------------------------------------------------------------------------*/
@isTest
public class ExtMonthlyWorkCtrTest {
    @isTest
    static void testMethod1() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        
        Test.startTest();
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        Test.stopTest();
        
    }
    @isTest
    static void testMethod2() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        
        Test.startTest();
        ctr.startWork();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod3() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        ctr.startWork();
        
        Test.startTest();
        ctr.endWork();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod4() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        
        Test.startTest();
        ctr.saveAll();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod5() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        
        Test.startTest();
        ctr.dayApploval();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod6() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        ctr.dayApploval();
        
        Test.startTest();
        ctr.dayApplovalOK();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod7() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        ctr.dayApploval();
        
        Test.startTest();
        ctr.dayApplovalNG();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod8() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        
        Test.startTest();
        ctr.vacationApplovalRequest();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod9() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        ctr.vacationApplovalRequest();
        
        Test.startTest();
        ctr.vacationApplovalRequestOK();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod10() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        ctr.vacationApplovalRequest();
        
        Test.startTest();
        ctr.vacationApplovalRequestNG();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod11() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        
        Test.startTest();
        ctr.monthlyApplovalRequest();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod12() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        
        List<DailyWork__c> dwList = [
            Select
                Id
            From
                DailyWork__c
            Limit 1
        ];
        
        Test.startTest();
        ctr.dataId = dwList.get(0).Id;
        ctr.saveBreakTime();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod13() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        
        Test.startTest();
        ctr.nextMonth();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod14() {
        PageReference pageRef = Page.MonthlyWorkView;
        Test.setCurrentPage(pageRef);
        
        MonthlyAttendance__c stdData = createData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(stdData);
        ExtMonthlyWorkCtr ctr = new ExtMonthlyWorkCtr(sc);
        
        Test.startTest();
        ctr.beforeMonth();
        Test.stopTest();
        
    }
    
    //---------------------------------------
    // テストデータ
    //---------------------------------------
    public static MonthlyAttendance__c createData(){
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
        
        MonthlyAttendance__c stdData = new MonthlyAttendance__c(
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
        
        insert stdData;
        
        DailyWork__c dw = new DailyWork__c(
            Name                       = Datetime.now().year() + '年' + String.valueOf(Datetime.now().month()).leftPad(2,'0') + '月' + Datetime.now().day() + '日'
            ,MonthAtt__c               = stdData.Id
            ,ArriveAtWork__c           = '09:00'
            ,BreakTimeStart1__c        = '12:00'
            ,BreakTime__c              = '02:00'
            ,DailyApplovalCheck__c     = false
            ,DailyApplovalRequested__c = false
            ,Date__c                   = Date.Today()
            ,FixWorkTime__c            = '04:00'
            ,Late__c                   = false
            ,LeaveEarly__c             = false
            ,LeavingOffice__c          = '15:00'
            ,PublicHoliday__c          = false
            ,VacationApploval__c       = false
            ,VacationRequest__c        = false
        );
        
        insert dw;
        
        return stdData;
    }
}