public class ManHoursTriggerHdr{
    public void insManHours(List<ManHours__c> newList){
        List<Event> evList = new List<Event>();
    
        for(ManHours__c mh : newList){
            String dateStr = 
                mh.DateValue__c.year() + '-' + 
                String.valueOf(mh.DateValue__c.month()).leftPad(2, '0') + '-' + 
                String.valueOf(mh.DateValue__c.day()).leftPad(2, '0');
        
            Event ev = new Event(
                Subject= mh.AccountName__c
                ,WhatId = mh.AccountId__c
                ,StartDateTime = Datetime.valueOf(dateStr + ' ' + mh.StartTime__c + ':000')
                ,EndDateTime = Datetime.valueOf(dateStr + ' ' + mh.EndTime__c + ':000')
                ,Description = mh.Remarks__c
            );
            
            evList.add(ev);
        
        }
        
        insert evList;
        
    }
    public void updManHours(Map<Id,ManHours__c> newMap){
        List<Event> evList = [
            Select
                Id
                ,WhatId
                ,StartDateTime 
                ,EndDateTime 
                ,Description 
            From
                Event
            Where
                WhatId in : newMap.keySet()
        ];
        
        for(Event ev : evList){
            String dateStr = 
                newMap.get(ev.WhatId).DateValue__c.year() + '-' + 
                String.valueOf(newMap.get(ev.WhatId).DateValue__c.month()).leftPad(2, '0') + '-' + 
                String.valueOf(newMap.get(ev.WhatId).DateValue__c.day()).leftPad(2, '0');
                
            ev.StartDateTime = Datetime.valueOf(dateStr + ' ' + newMap.get(ev.WhatId).StartTime__c + ':000');
            ev.EndDateTime   = Datetime.valueOf(dateStr + ' ' + newMap.get(ev.WhatId).EndTime__c + ':000');
            ev.Description   = newMap.get(ev.WhatId).Remarks__c;
        }
        
        update evList;
    }
}