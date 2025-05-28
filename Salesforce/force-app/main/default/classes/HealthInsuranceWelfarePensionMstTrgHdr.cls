public class HealthInsuranceWelfarePensionMstTrgHdr{
    public void mathRate(List<HealthInsuranceWelfarePensionMst__c> newList){
        RateData__c rd = RateData__c.getOrgDefaults();
        
        Decimal maxKouseiNenkin = 0;
        for(HealthInsuranceWelfarePensionMst__c mst : newList){
            if(mst.Name == '35（32）'){
                maxKouseiNenkin = mst.Monthly__c * (rd.KouseiNenkinRate__c * 0.01);
            }
        }
        
        for(HealthInsuranceWelfarePensionMst__c mst : newList){
            mst.KaigoHokenNon2GouHokenryo__c = mst.Monthly__c * (rd.KaigoHokenNon2GouHokenryo__c * 0.01);
            mst.KaigoHoken2GouHokenryo__c = mst.Monthly__c * (rd.Kaigohoken2GouRate__c * 0.01);
            
            if(mst.Name != '1' && mst.Name != '2' && mst.Name != '3'){
                mst.KouseiNenkinHokenryo__c = mst.Monthly__c * (rd.KouseiNenkinRate__c * 0.01);
            }else{
                mst.KouseiNenkinHokenryo__c = 0;
            }
            
            if(maxKouseiNenkin < mst.KouseiNenkinHokenryo__c){
                mst.KouseiNenkinHokenryo__c = maxKouseiNenkin;
            }
        }
    }
}