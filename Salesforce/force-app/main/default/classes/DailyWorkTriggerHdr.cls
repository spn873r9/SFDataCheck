public class DailyWorkTriggerHdr{
    //------------------------
    // 保存時自動更新処理
    //------------------------
    public void saveAutoUpdate(List<DailyWork__c> newList){
        for(DailyWork__c dw : newList){
            //------------------------
            // 規定休憩時間入力
            //------------------------
            if(dw.BreakTimeStart1__c == null && dw.BreakTimeEnd1__c == null 
            && dw.ArriveAtWork__c != null && dw.LeavingOffice__c != null
            && dw.RegulationsStartBreakTime__c != null && dw.RegulationsEndBreakTime__c != null){
                dw.BreakTimeStart1__c = dw.RegulationsStartBreakTime__c;
                dw.BreakTimeEnd1__c = dw.RegulationsEndBreakTime__c;
            }
            //------------------------
            // 休憩時間を計算
            //------------------------
            double sumBreakTime = 0;
            boolean writeBreakTimeFlag = false;
            
            if(dw.ArriveAtWork__c != null && dw.LeavingOffice__c != null && dw.BreakTimeStart1__c != null && dw.BreakTimeEnd1__c != null){
                writeBreakTimeFlag = true;
                if(CommonUtil.checkWorkTime(dw.ArriveAtWork__c, dw.LeavingOffice__c, dw.BreakTimeStart1__c, dw.BreakTimeEnd1__c)){
                    sumBreakTime += CommonUtil.mathIntTime(dw.BreakTimeStart1__c , dw.BreakTimeEnd1__c);
                
                }
            }
            if(dw.ArriveAtWork__c != null && dw.LeavingOffice__c != null && dw.BreakTimeStart2__c != null && dw.BreakTimeEnd2__c != null){
                writeBreakTimeFlag = true;
                if(CommonUtil.checkWorkTime(dw.ArriveAtWork__c, dw.LeavingOffice__c, dw.BreakTimeStart2__c, dw.BreakTimeEnd2__c)){
                    sumBreakTime += CommonUtil.mathIntTime(dw.BreakTimeStart2__c , dw.BreakTimeEnd2__c);
                
                }
            }
            if(dw.ArriveAtWork__c != null && dw.LeavingOffice__c != null && dw.BreakTimeStart3__c != null && dw.BreakTimeEnd3__c != null){
                writeBreakTimeFlag = true;
                if(CommonUtil.checkWorkTime(dw.ArriveAtWork__c, dw.LeavingOffice__c, dw.BreakTimeStart3__c, dw.BreakTimeEnd3__c)){
                    sumBreakTime += CommonUtil.mathIntTime(dw.BreakTimeStart3__c , dw.BreakTimeEnd3__c);
                
                }
            }
            if(dw.ArriveAtWork__c != null && dw.LeavingOffice__c != null && dw.BreakTimeStart4__c != null && dw.BreakTimeEnd4__c != null){
                writeBreakTimeFlag = true;
                if(CommonUtil.checkWorkTime(dw.ArriveAtWork__c, dw.LeavingOffice__c, dw.BreakTimeStart4__c, dw.BreakTimeEnd4__c)){
                    sumBreakTime += CommonUtil.mathIntTime(dw.BreakTimeStart4__c , dw.BreakTimeEnd4__c);
                
                }
            }
            
            System.debug('sumBreakTime★:' + sumBreakTime);
            
            if(writeBreakTimeFlag ){
                dw.BreakTime__c = CommonUtil.mathParseIntTime(sumBreakTime);
                
                
            }else if(dw.BreakTime__c == null && dw.RegulationsBreakTime__c != null && dw.ArriveAtWork__c != null && dw.LeavingOffice__c != null){
                dw.BreakTime__c = dw.RegulationsBreakTime__c;
            }
            //------------------------
            // 労働時間を計算
            //------------------------
            if(dw.ArriveAtWork__c != null && dw.LeavingOffice__c != null && dw.BreakTime__c == null){
                // 労働時間を計算（休憩なし）
                dw.FixWorkTime__c = CommonUtil.mathTextTime(dw.ArriveAtWork__c,dw.LeavingOffice__c ,null);
                
            }else if(dw.ArriveAtWork__c != null && dw.LeavingOffice__c != null && dw.BreakTime__c != null){
                // 労働時間を計算（休憩あり）
                dw.FixWorkTime__c = CommonUtil.mathTextTime(dw.ArriveAtWork__c,dw.LeavingOffice__c ,dw.BreakTime__c);
            
            // 労働時間の計算が不可能なデータの場合は休憩時間と労働時間をクリアする
            }else{
                dw.BreakTime__c = null;
                dw.FixWorkTime__c = null;
            }
            
            //------------------------
            // 祝日情報を保存
            //------------------------
            dw.PublicHoliday__c = Jpn_DateUtils.isHoliday(dw.Date__c);
        }
    }
    
    //------------------------
    // 保存時自動更新処理
    //------------------------
    public void updateHoliday(List<DailyWork__c> newList){
        for(DailyWork__c dw : newList){
            //------------------------
            // 祝日情報を保存
            //------------------------
            dw.PublicHoliday__c = Jpn_DateUtils.isHoliday(dw.Date__c);
        }
    }
    
    //------------------------
    // 月次勤怠集計計算
    //------------------------
    public void summaryMonthlyData(List<DailyWork__c> newList){
        Set<Id> updSumMonthObjId = new Set<Id>();
        List<MonthlyAttendance__c> maList = new List<MonthlyAttendance__c>();
        
        for(DailyWork__c dw : newList){
            updSumMonthObjId.add(dw.MonthAtt__c);
            
        }
        
        // 再集計する月次勤怠のIDを持つ勤怠を取得する
        List<DailyWork__c> reSumDailyWorks = [
            Select
                Id
                ,FixWorkTime__c
                ,BreakTime__c
                ,VacationSetting__r.Type__c
                ,VacationSetting__r.Vacation__c
                ,VacationSetting__r.SpecialPaidLeave__c
                ,MonthAtt__c
            From
                DailyWork__c
            Where
                MonthAtt__c in : updSumMonthObjId
        ];
        
        for(Id monthId : updSumMonthObjId){
            double workTime = 0;
            double breakTime = 0;
            double vacTime = 0;
            double spVacTime = 0;
            
            for(DailyWork__c dw : reSumDailyWorks){
                if(monthId == dw.MonthAtt__c){
                    workTime += dw.FixWorkTime__c != null ? CommonUtil.mathParseStringTime(dw.FixWorkTime__c) : 0;
                    breakTime += dw.BreakTime__c != null ? CommonUtil.mathParseStringTime(dw.BreakTime__c) : 0;
                    if(dw.VacationSetting__r.Type__c == '半休' && dw.VacationSetting__r.Vacation__c == true){
                        vacTime += 0.5;
                        
                    }
                    if(dw.VacationSetting__r.Type__c == '全休' && dw.VacationSetting__r.Vacation__c == true){
                        vacTime += 1;
                        
                    }
                    if(dw.VacationSetting__r.Type__c == '半休' && dw.VacationSetting__r.SpecialPaidLeave__c == true){
                        spVacTime += 0.5;
                        
                    }
                    if(dw.VacationSetting__r.Type__c == '全休' && dw.VacationSetting__r.SpecialPaidLeave__c == true){
                        spVacTime += 1;
                        
                    }
                }
            }
            MonthlyAttendance__c updMa = new MonthlyAttendance__c(
                Id = monthId
                ,PaidDayCount__c = vacTime
                ,SumWorkTime__c = workTime
                ,SumBreakTime__c = breakTime
                ,SpecialPaidLeave__c = spVacTime
            );
            
            maList.add(updMa);
        }
        
        if(maList.size() != 0){
            update maList;
        }
    }
}