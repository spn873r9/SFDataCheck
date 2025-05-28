/*-----------------------------------------------------------------------
 * 日時勤怠更新バッチ
/*----------------------------------------------------------------------*/
global class BC_MonthlyDataCreate implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 
            'Select id From EmployeeInfo__c Where IsActive__c = true';

        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<EmployeeInfo__c> rec){
        for(EmployeeInfo__c dw : rec){
            MonthlyAttendance__c ma = new MonthlyAttendance__c(
                Name = Datetime.now().format('yyyy年MM月dd日')
                ,Year__c = Datetime.now().format('yyyy')
                ,Month__c = Datetime.now().format('MM')
            );
        }
        
        update rec;
    }
    global void finish(Database.BatchableContext BC){
    }
}