public class EmployeeInfoTriggerHdr{
    public static Boolean createMonthDataFlag = false;
    
    //--------------------------
    // 当月の月次勤怠を作成する
    //--------------------------
    public void createMonthlyData(List<EmployeeInfo__c> newList){
        List<MonthlyAttendance__c> insMonthDataList = new List<MonthlyAttendance__c>();
        
        Set<Id> eiIds = new Set<Id>();
        
        for(EmployeeInfo__c ei : newList){
            System.debug('★勤務者:' + ei);
            if(ei.UseInfo__c != null && ei.IsActive__c == true){
                eiIds.add(ei.id);
            }
        }
        
        System.debug('★年:' + String.valueOf(Date.Today().year()));
        System.debug('★月:' + String.valueOf(Date.Today().month()));
        
        // 該当勤務者の今月の月次勤怠があるかを確認する
        List<MonthlyAttendance__c> maList = [
            Select
                id
                ,Name
                ,Year__c
                ,Month__c
                ,EmpInfo__c
            From
                MonthlyAttendance__c
            Where
                EmpInfo__c in :eiIds
            And
                Year__c = :String.valueOf(Date.Today().year())
            And
                Month__c = :String.valueOf(Date.Today().month())
        ];
        
        // 全員勤怠が無い場合全員分を作成
        if(maList.size() == 0){
            System.debug('★月次勤怠なし');
            for(EmployeeInfo__c ei : newList){
                MonthlyAttendance__c ma = new MonthlyAttendance__c(
                    Name = String.valueOf(Date.Today().year()) + '年' + String.valueOf(Date.Today().month()) + '月'
                    ,Year__c = String.valueOf(Date.Today().year())
                    ,Month__c = String.valueOf(Date.Today().month())
                    ,EmpInfo__c = ei.id
                );
                
                insMonthDataList.add(ma);
            }
            
        // データが存在しているものがある場合、ないものだけ作成処理を行う
        }else{
            System.debug('★月次勤怠あり');
            for(EmployeeInfo__c ei : newList){
                Boolean nodataFlag = true;
                
                for(MonthlyAttendance__c ma : maList){
                    if(ma.EmpInfo__c == ei.id){
                        nodataFlag = false;
                    }
                }
                
                if(nodataFlag == true){
                    MonthlyAttendance__c ma = new MonthlyAttendance__c(
                        Name = String.valueOf(Date.Today().year()) + '年' + String.valueOf(Date.Today().month()) + '月'
                        ,Year__c = String.valueOf(Date.Today().year())
                        ,Month__c = String.valueOf(Date.Today().month())
                        ,EmpInfo__c = ei.id
                    );
                    
                    insMonthDataList.add(ma);
                }
            }
        }
        
        if(insMonthDataList.size() != 0){
            insert insMonthDataList;
            
            createMonthDataFlag = true;
        }
    }
}