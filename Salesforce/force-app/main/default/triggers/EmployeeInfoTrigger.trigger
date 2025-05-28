trigger EmployeeInfoTrigger on EmployeeInfo__c (After insert,After update) {
    EmployeeInfoTriggerHdr hdr = new EmployeeInfoTriggerHdr();
    
    if(EmployeeInfoTriggerHdr.createMonthDataFlag == false){
        hdr.createMonthlyData(Trigger.new);
    }
}