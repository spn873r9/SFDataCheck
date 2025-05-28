trigger MonthlyAttendanceTrigger on MonthlyAttendance__c (after insert) {
    MonthlyAttendanceTriggerHdr hdr = new MonthlyAttendanceTriggerHdr();
    hdr.createDailyData(Trigger.new);
}