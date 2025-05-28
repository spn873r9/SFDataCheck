/*-----------------------------------------------------------------------
 * 日時勤怠更新バッチ
/*----------------------------------------------------------------------*/
global class BC_DailyWork implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 
            'Select                            '+
            '     Id                           '+
            '    ,Name                         '+
            '    ,MonthAtt__c                  '+
            '    ,VacationSetting__c           '+
            '    ,Date__c                      '+
            '    ,ArriveAtWork__c              '+
            '    ,LeavingOffice__c             '+
            '    ,BreakTime__c                 '+
            '    ,Remarks__c                   '+
            '    ,BreakTimeStart1__c           '+
            '    ,FixWorkTime__c               '+
            '    ,BreakTimeEnd1__c             '+
            '    ,BreakTimeStart2__c           '+
            '    ,BreakTimeStart3__c           '+
            '    ,BreakTimeStart4__c           '+
            '    ,BreakTimeEnd2__c             '+
            '    ,BreakTimeEnd3__c             '+
            '    ,BreakTimeEnd4__c             '+
            '    ,RegulationsBreakTime__c      '+
            '    ,RegulationsStartBreakTime__c '+
            '    ,RegulationsEndBreakTime__c   '+
            '    ,MonthAtt__r.EmpInfo__r.isWorking__c '+
            'From                              '+
            '     DailyWork__c                 '+
            'Where                             '+
            '    (Date__c = '+ Datetime.now().addDays(-1).format('yyyy-MM-dd') + ' OR Date__c = '+ Datetime.now().format('yyyy-MM-dd') + ') ' +
            'And                               '+
            '    MonthAtt__r.EmpInfo__r.isWorking__c = true';

        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<DailyWork__c> rec){
        WorkSetting__c cs_ws = WorkSetting__c.getOrgDefaults();
    
        for(DailyWork__c dw : rec){
            // 出勤されていて退勤ができていないデータをカスタム設定指定時刻で強制退勤する
            if(dw.ArriveAtWork__c != null && dw.LeavingOffice__c == null && dw.Date__c == Date.today().addDays(-1)){
                dw.LeavingOffice__c = cs_ws.ForcedLeaveWorkTime__c;
            }
            
            // 出勤されていて強制退勤が発生したデータの翌日を0時で自動出勤にする
            if(dw.ArriveAtWork__c == null && dw.LeavingOffice__c == null && dw.Date__c == Date.today()){
                dw.ArriveAtWork__c = '00:00';
            }
        }
        
        update rec;
    }
    global void finish(Database.BatchableContext BC){
    }
}