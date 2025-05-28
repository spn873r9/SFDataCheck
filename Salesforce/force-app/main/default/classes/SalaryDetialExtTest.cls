@isTest
public class SalaryDetialExtTest {
    private Static Salary__c sly = null;

    @isTest
    static void testMethod1() {
        createMaster();
    
        PageReference pageRef = Page.SalaryDetial;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(sly);
        
        Test.startTest();
        SalaryDetialExt ctr = new SalaryDetialExt(sc);
        Test.stopTest();
        
    }
    
    private static void createMaster(){
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
        
        insert ma;
        
        DailyWork__c dw = new DailyWork__c(
            Name                       = Datetime.now().year() + '年' + String.valueOf(Datetime.now().month()).leftPad(2,'0') + '月' + Datetime.now().day() + '日'
            ,MonthAtt__c               = ma.Id
            ,ArriveAtWork__c           = '09:00'
            ,BreakTimeStart1__c        = '12:00'
            ,BreakTimeEnd1__c          = '13:00'
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
        
        sly = new Salary__c(
            MonthlyAttendance__c = ma.Id
        );
        
        insert sly;
    }
}