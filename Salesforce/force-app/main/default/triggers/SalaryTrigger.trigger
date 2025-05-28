trigger SalaryTrigger on Salary__c (before insert ,before update) {
    SalaryTriggerHdr hdr = new SalaryTriggerHdr();
    if(Trigger.new.size() != 0){
        hdr.mathsalary(Trigger.new);
    }
}