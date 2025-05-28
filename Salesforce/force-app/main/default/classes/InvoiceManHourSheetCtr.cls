public class InvoiceManHourSheetCtr {
    public List<ManHours__c> mhList { get; set; }
    public Integer totalHours { get; set; }
    public Integer totalMinuts { get; set; }

    public InvoiceManHourSheetCtr(ApexPages.StandardController controller) {
        totalHours = 0;
        totalMinuts = 0;
        
        List<Invoice__c> ivList = [
            Select
                Id
                ,TaiouAnken__c
                ,Seikyubi__c
            From
                Invoice__c
            Where
                Id = :controller.getRecord().id
        ];
        
        Date gessho = getMonthOfStartDay(ivList.get(0).Seikyubi__c);
        Date getsumatsu = getMonthOfEndDay(ivList.get(0).Seikyubi__c);
        
        this.mhList = [
            Select
                 Id
                ,Name
                ,EndTime__c
                ,Hours__c
                ,Minute__c
                ,Remarks__c
                ,StartTime__c
                ,TaioAnken__c
                ,DateValue__c
                ,BreakTime__c
            From
                 ManHours__c
            Where
                TaioAnken__c = :ivList.get(0).TaiouAnken__c
            And
                DateValue__c >= :gessho 
            And
                DateValue__c <= :getsumatsu 
            Order by
                Name ASC,StartTime__c ASC
        ];
        
        for(ManHours__c mh : this.mhList){
            mh.Name = mh.Name.replace('-','/');
            totalHours += Integer.valueOf(mh.Hours__c);
            totalMinuts += Integer.valueOf(mh.Minute__c);
            
            System.debug('★mh.DateValue__c:' + mh.DateValue__c);
            System.debug('★mh.Hours__c:' + mh.Hours__c);
            System.debug('★mh.Minute__c:' + mh.Minute__c);
        }
        
        System.debug('★totalHours（計算前） :' + totalHours);
        System.debug('★totalMinuts（計算前） :' + totalMinuts);
        
        // 60分オーバーの場合
        if(60 <= totalMinuts){
            totalHours += Integer.valueOf(totalMinuts / 60);
            totalMinuts = Math.Mod(totalMinuts,60);
        }
        System.debug('★totalHours :' + totalHours);
        System.debug('★totalMinuts :' + totalMinuts);
    }
    
        
    //------------------------------------
    // 月初日付取得
    //------------------------------------
    public static Date getMonthOfStartDay(Date prmDate) {
        return prmDate != null ? Date.newInstance(prmDate.year(), prmDate.month(), 1) : null;
    }
    
    //------------------------------------
    // 月末日付取得
    //------------------------------------
    public static Date getMonthOfEndDay(Date prmDate) {
        return prmDate != null ? Date.newInstance(prmDate.year(), prmDate.month() + 1 ,0) : null;
    }
}