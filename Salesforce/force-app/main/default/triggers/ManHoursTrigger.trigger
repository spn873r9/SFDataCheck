trigger ManHoursTrigger on ManHours__c (after insert,after update) {
    ManHoursTriggerHdr hdr = new ManHoursTriggerHdr();
    
    if(Trigger.isInsert){
        hdr.insManHours(Trigger.new);
    
    }
    if(Trigger.isUpdate){
        hdr.updManHours(Trigger.newMap);
    
    }
}