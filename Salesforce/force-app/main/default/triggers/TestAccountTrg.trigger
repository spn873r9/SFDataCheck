trigger TestAccountTrg on Account (before update) {
    for(account acc : Trigger.new){
        System.debug('★Datetimenow:' + System.now());
        acc.DatetimeTest__c = System.now();
        System.debug('★DatetimenowMill:' + System.now().millisecond());
        System.debug('★Data:' + acc.DatetimeTest__c.millisecond());
        
        
    }
}