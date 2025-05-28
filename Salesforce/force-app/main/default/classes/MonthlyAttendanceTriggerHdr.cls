public class MonthlyAttendanceTriggerHdr{
    public void createDailyData(List<MonthlyAttendance__c> newList){
        List<DailyWork__c> insList = new List<DailyWork__c>();
        
        for(MonthlyAttendance__c ma : newList){
            Date createDate = Date.newInstance(Integer.valueOf(ma.Year__c),Integer.valueOf(ma.Month__c),1);
            Date monthLast = getMonthOfEndDay(createDate);
            
            for(Integer i = 1; i <= monthLast.day(); i++){
                DailyWork__c dw = new DailyWork__c(
                    MonthAtt__c = ma.id,
                    Date__c = Date.newInstance(createDate.year(),createDate.month(),i),
                    Name = createDate.year() + '年' + createDate.month() + '月' + i + '日'
                );
                
                insList.add(dw);
            }
        }
        
        if(insList.size() != 0){
            insert insList;
        
        }
    }
    /**
     * 月末日付取得
     */
    public static Date getMonthOfEndDay(Date prmDate) {
        return prmDate != null ? Date.newInstance(prmDate.year(), prmDate.month() + 1 ,0) : null;
    }
}