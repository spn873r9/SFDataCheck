public class CommonUtil{
    /*----------------------------------------------------
     * テキスト労働時間計算
     * マイナス値は00:00で返却
     *---------------------------------------------------*/
    public static String mathTextTime(String startTime , String endTime ,String breakTime){
        String retTime = '';
        
        Integer startHourInt = Integer.valueOf(startTime.substring(0,2));
        Integer endHourInt = Integer.valueOf(endTime.substring(0,2));
        Integer breakHourInt = 0;
        
        Integer startMinInt = Integer.valueOf(startTime.substring(3,5));
        Integer endMinInt = Integer.valueOf(endTime.substring(3,5));
        Integer breakMinInt = 0;

        if(breakTime != null){
            breakHourInt = Integer.valueOf(breakTime.substring(0,2));
            breakMinInt = Integer.valueOf(breakTime.substring(3,5));
        }
        
        Integer workHour = 0;
        Integer workMin = 0;
        
        // 始業時間（時）< 退社時間（時）
        if(startHourInt < endHourInt){
            workHour = endHourInt - startHourInt;
            
            // 始業時間（分）< 退社時間（分）
            if(startMinInt <= endMinInt){
                workMin = endMinInt - startMinInt;
            
            }else{
                workHour = workHour - 1;
                workMin = 60 - (startMinInt - endMinInt);
            
            }
        
        }else if(startHourInt == endHourInt){
            if(startMinInt <= endMinInt){
                workMin = endMinInt - startMinInt;
            
            }else{
                retTime = '00:00';
                return retTime;
            
            }
        
        }else{
            retTime = '00:00';
            return retTime;
        
        }
        
        if(breakTime != null){
            if(breakHourInt <= workHour){
                workHour = workHour - breakHourInt;
                
            }else{
                retTime = '00:00';
                return retTime;
            
            }
            
            if(breakMinInt <= workMin){
                workMin = workMin - breakMinInt;
            
            }else if((workHour - 1) <= 0){
                retTime = '00:00';
                return retTime;
                
            }else{
                workMin = 60 + (workMin - breakMinInt);
                workHour = workHour - 1;
            }
        }
        
        retTime = String.valueOf(workHour).leftPad(2,'0') + ':' + String.valueOf(workMin).leftPad(2,'0');
        
        
        return retTime;
    }
    /*----------------------------------------------------
     * テキスト時間差分計算
     * マイナス値は0で返却
     *---------------------------------------------------*/
    public static double mathIntTime(String startTime , String endTime){
        double retTime = 0;
        
        Integer startHourInt = Integer.valueOf(startTime.substring(0,2));
        Integer endHourInt = Integer.valueOf(endTime.substring(0,2));
        Integer breakHourInt = 0;
        
        Integer startMinInt = Integer.valueOf(startTime.substring(3,5));
        Integer endMinInt = Integer.valueOf(endTime.substring(3,5));
        Integer breakMinInt = 0;
        
        double workHour = 0;
        double workMin = 0;
        
        if(startHourInt < endHourInt){
            workHour = endHourInt - startHourInt;
            
            if(startMinInt <= endMinInt){
                workMin = endMinInt - startMinInt;
            
            }else{
                workHour = workHour - 1;
                workMin = 60 + (endMinInt - startMinInt);
            
            }
        
        }else if(startHourInt == endHourInt){
            if(startMinInt <= endMinInt){
                workMin = endMinInt - startMinInt;
            
            }else{
                retTime = 0;
                return retTime;
            
            }
        
        }else{
            retTime = 0;
            return retTime;
        
        }
        System.debug('workHour★:' + workHour);
        System.debug('workMin★:' + workMin);
        
        if(workMin != 0){
            retTime = workHour + (workMin / 60);
        }else{
            retTime = workHour;
        }
        
        
        return retTime;
    }
    
    /*----------------------------------------------------
     * 数値時間をテキスト時間に変換
     *---------------------------------------------------*/
    public static String mathParseIntTime(double intTime){
        String retTime = '';
        Integer hour = Integer.valueOf(intTime);
        Integer min = Integer.valueOf((intTime - hour) * 60);
        
        retTime = String.valueOf(hour).leftPad(2,'0') + ':' + String.valueOf(min).leftPad(2,'0');
        
        return retTime;
    }
    /*----------------------------------------------------
     * テキスト時間を数値時間に変換
     *---------------------------------------------------*/
    public static double mathParseStringTime(String strTime){
        double retTime = 0;
        double hourInt = Integer.valueOf(strTime.substring(0,2));
        double minInt = Integer.valueOf(strTime.substring(3,5));
        
        if(minInt != 0){
            retTime = hourInt + Decimal.valueOf(minInt / 60).setScale(2,System.RoundingMode.HALF_DOWN);
            
            System.debug('★min / 60:' + Decimal.valueOf(minInt / 60).setScale(2,System.RoundingMode.HALF_DOWN));
        }else{
            retTime = hourInt;
        }
        return retTime;
    }
    /*----------------------------------------------------
     * 勤務開始・終了時間が休憩時間範囲かどうかを返す
     *---------------------------------------------------*/
    public static Boolean checkWorkTime(String startTime , String endTime, String startBreakTime, String endBreakTime){
        Boolean chkResult = false;
        
        Double dStartTime = CommonUtil.mathParseStringTime(startTime);
        Double dEndTime = CommonUtil.mathParseStringTime(endTime);
        Double dStartBreakTime = CommonUtil.mathParseStringTime(startBreakTime);
        Double dEndBreakTime = CommonUtil.mathParseStringTime(endBreakTime);
        
        if(dStartTime <= dStartBreakTime && dEndBreakTime <= dEndTime){
            return true;
        
        }
        
        
        return chkResult;
    }
}