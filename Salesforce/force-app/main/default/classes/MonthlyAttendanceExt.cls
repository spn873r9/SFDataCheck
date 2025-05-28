public class MonthlyAttendanceExt {
    public List<DailyWork__c> dw { get;set; }
            
    public MonthlyAttendanceExt(ApexPages.StandardController controller) {
        this.dw = [
            Select
                Id
                ,Name
                ,BreakTime__c
                ,Date__c
                ,ArriveAtWork__c
                ,LeavingOffice__c
                ,FixWorkTime__c
                ,VacationSetting__c
                ,Remarks__c
                ,MonthAtt__c
                ,DayOfWeek__c
            From
                DailyWork__c
            Where
                MonthAtt__c = : controller.getRecord().Id

        ];    
    }
}