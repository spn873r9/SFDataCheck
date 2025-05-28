public class SalaryTriggerHdr{
    public void mathsalary(List<Salary__c> newList){
        // 報酬月額を取得
        List<HealthInsuranceWelfarePensionMst__c> lstData = [
            Select
                 Id
                ,OwnerId
                ,Name
                ,Monthly__c
                ,MonthlyRemunerationFrom__c
                ,MonthlyRemunerationTo__c
                ,KaigoHoken2GouHokenryo__c
                ,KaigoHokenNon2GouHokenryo__c
                ,KouseiNenkinHokenryo__c
            From
                 HealthInsuranceWelfarePensionMst__c
        ];
        
        for(Salary__c sly : newList){
            if(sly.BaseSalary__c != null){
                // 社会保険料設定
                for(HealthInsuranceWelfarePensionMst__c data : lstData){
                    // 対象となる標準報酬範囲が見つかったら
                    if(data.MonthlyRemunerationFrom__c <= sly.BaseSalary__c &&
                       sly.BaseSalary__c < data.MonthlyRemunerationTo__c
                    ){
                        sly.KenkoHoken__c   = (data.KaigoHokenNon2GouHokenryo__c / 2).round(System.RoundingMode.FLOOR);
                        sly.KouseiNenkin__c = (data.KouseiNenkinHokenryo__c / 2).round(System.RoundingMode.FLOOR);
                        sly.KoyoHoken__c    = (sly.BaseSalary__c * 5 / 1000).round(System.RoundingMode.FLOOR);
                        
                        if(sly.Kaigo2GouFlag__c == true){
                            sly.KaigoHoken__c = 
                                (data.KaigoHoken2GouHokenryo__c / 2).round(System.RoundingMode.FLOOR) -
                                (data.KaigoHokenNon2GouHokenryo__c / 2).round(System.RoundingMode.FLOOR);
                        
                        }else{
                            sly.KaigoHoken__c = 0;
                        }
                    }
                }
            }
        }
    }
}