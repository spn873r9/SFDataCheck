trigger DailyWorkTrigger on DailyWork__c (before insert,before update,after update) {
    DailyWorkTriggerHdr hdr = new DailyWorkTriggerHdr();
    
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            hdr.saveAutoUpdate(Trigger.new);
        }
        hdr.updateHoliday(Trigger.new);
    }
    if(Trigger.isAfter){
        hdr.summaryMonthlyData(Trigger.new);
    }
}