trigger HealthInsuranceWelfarePensionMstTrigger on HealthInsuranceWelfarePensionMst__c (before insert, before update) {
    HealthInsuranceWelfarePensionMstTrgHdr hdr = new HealthInsuranceWelfarePensionMstTrgHdr();
    if(Trigger.new.size() != 0){
        hdr.mathRate(Trigger.new);
    }
}