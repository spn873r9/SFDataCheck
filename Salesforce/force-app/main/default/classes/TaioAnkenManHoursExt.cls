public class TaioAnkenManHoursExt {
    public String recId { get; set; }
    public List<ManHoursData> mhList { get; set; }
    public String actionId { get; set; }
    public Date currentMonth { get; set; }
    public String monthView { get; set; }
    public String StartTime { get; set; }
    public String EndTime { get; set; }
    public String BreakTime { get; set; }
    public List<SelectOption> dataList { get; set; }
    public Integer setDeleteNumber{ get; set; }
    
    //------------------------------------
    // コンストラクタ
    //------------------------------------
    public TaioAnkenManHoursExt(ApexPages.StandardController controller) {
        this.recId = controller.getRecord().Id;
        this.currentMonth = Date.today();
        init();
        dataList = new List<SelectOption>();        
        dataList.add(new SelectOption('--なし--', '--なし--'));
        dataList.add(new SelectOption('00:00', '00:00'));
        dataList.add(new SelectOption('00:15', '00:15'));
        dataList.add(new SelectOption('00:30', '00:30'));
        dataList.add(new SelectOption('00:45', '00:45'));
        dataList.add(new SelectOption('01:00', '01:00'));
        dataList.add(new SelectOption('01:15', '01:15'));
        dataList.add(new SelectOption('01:30', '01:30'));
        dataList.add(new SelectOption('01:45', '01:45'));
        dataList.add(new SelectOption('02:00', '02:00'));
        dataList.add(new SelectOption('02:15', '02:15'));
        dataList.add(new SelectOption('02:30', '02:30'));
        dataList.add(new SelectOption('02:45', '02:45'));
        dataList.add(new SelectOption('03:00', '03:00'));
        dataList.add(new SelectOption('03:15', '03:15'));
        dataList.add(new SelectOption('03:30', '03:30'));
        dataList.add(new SelectOption('03:45', '03:45'));
        dataList.add(new SelectOption('04:00', '04:00'));
        dataList.add(new SelectOption('04:15', '04:15'));
        dataList.add(new SelectOption('04:30', '04:30'));
        dataList.add(new SelectOption('04:45', '04:45'));
        dataList.add(new SelectOption('05:00', '05:00'));
        dataList.add(new SelectOption('05:15', '05:15'));
        dataList.add(new SelectOption('05:30', '05:30'));
        dataList.add(new SelectOption('05:45', '05:45'));
        dataList.add(new SelectOption('06:00', '06:00'));
        dataList.add(new SelectOption('06:15', '06:15'));
        dataList.add(new SelectOption('06:30', '06:30'));
        dataList.add(new SelectOption('06:45', '06:45'));
        dataList.add(new SelectOption('07:00', '07:00'));
        dataList.add(new SelectOption('07:15', '07:15'));
        dataList.add(new SelectOption('07:30', '07:30'));
        dataList.add(new SelectOption('07:45', '07:45'));
        dataList.add(new SelectOption('08:00', '08:00'));
        dataList.add(new SelectOption('08:15', '08:15'));
        dataList.add(new SelectOption('08:30', '08:30'));
        dataList.add(new SelectOption('08:45', '08:45'));
        dataList.add(new SelectOption('09:00', '09:00'));
        dataList.add(new SelectOption('09:15', '09:15'));
        dataList.add(new SelectOption('09:30', '09:30'));
        dataList.add(new SelectOption('09:45', '09:45'));
        dataList.add(new SelectOption('10:00', '10:00'));
        dataList.add(new SelectOption('10:15', '10:15'));
        dataList.add(new SelectOption('10:30', '10:30'));
        dataList.add(new SelectOption('10:45', '10:45'));
        dataList.add(new SelectOption('11:00', '11:00'));
        dataList.add(new SelectOption('11:15', '11:15'));
        dataList.add(new SelectOption('11:30', '11:30'));
        dataList.add(new SelectOption('11:45', '11:45'));
        dataList.add(new SelectOption('12:00', '12:00'));
        dataList.add(new SelectOption('12:15', '12:15'));
        dataList.add(new SelectOption('12:30', '12:30'));
        dataList.add(new SelectOption('12:45', '12:45'));
        dataList.add(new SelectOption('13:00', '13:00'));
        dataList.add(new SelectOption('13:15', '13:15'));
        dataList.add(new SelectOption('13:30', '13:30'));
        dataList.add(new SelectOption('13:45', '13:45'));
        dataList.add(new SelectOption('14:00', '14:00'));
        dataList.add(new SelectOption('14:15', '14:15'));
        dataList.add(new SelectOption('14:30', '14:30'));
        dataList.add(new SelectOption('14:45', '14:45'));
        dataList.add(new SelectOption('15:00', '15:00'));
        dataList.add(new SelectOption('15:15', '15:15'));
        dataList.add(new SelectOption('15:30', '15:30'));
        dataList.add(new SelectOption('15:45', '15:45'));
        dataList.add(new SelectOption('16:00', '16:00'));
        dataList.add(new SelectOption('16:15', '16:15'));
        dataList.add(new SelectOption('16:30', '16:30'));
        dataList.add(new SelectOption('16:45', '16:45'));
        dataList.add(new SelectOption('17:00', '17:00'));
        dataList.add(new SelectOption('17:15', '17:15'));
        dataList.add(new SelectOption('17:30', '17:30'));
        dataList.add(new SelectOption('17:45', '17:45'));
        dataList.add(new SelectOption('18:00', '18:00'));
        dataList.add(new SelectOption('18:15', '18:15'));
        dataList.add(new SelectOption('18:30', '18:30'));
        dataList.add(new SelectOption('18:45', '18:45'));
        dataList.add(new SelectOption('19:00', '19:00'));
        dataList.add(new SelectOption('19:15', '19:15'));
        dataList.add(new SelectOption('19:30', '19:30'));
        dataList.add(new SelectOption('19:45', '19:45'));
        dataList.add(new SelectOption('20:00', '20:00'));
        dataList.add(new SelectOption('20:15', '20:15'));
        dataList.add(new SelectOption('20:30', '20:30'));
        dataList.add(new SelectOption('20:45', '20:45'));
        dataList.add(new SelectOption('21:00', '21:00'));
        dataList.add(new SelectOption('21:15', '21:15'));
        dataList.add(new SelectOption('21:30', '21:30'));
        dataList.add(new SelectOption('21:45', '21:45'));
        dataList.add(new SelectOption('22:00', '22:00'));
        dataList.add(new SelectOption('22:15', '22:15'));
        dataList.add(new SelectOption('22:30', '22:30'));
        dataList.add(new SelectOption('22:45', '22:45'));
        dataList.add(new SelectOption('23:00', '23:00'));
        dataList.add(new SelectOption('23:15', '23:15'));
        dataList.add(new SelectOption('23:30', '23:30'));
        dataList.add(new SelectOption('23:45', '23:45'));

    }
    
    //------------------------------------
    // 初期化
    //------------------------------------
    public void init(){
        this.mhList = new List<ManHoursData>();
        Date gessho = getMonthOfStartDay(currentMonth);
        Date getsumatsu = getMonthOfEndDay(currentMonth);
        this.monthView = String.valueOf(currentMonth.Month());
        
        
        List<ManHours__c> objmhList = [
            Select
                 Id
                ,OwnerId
                ,Name
                ,EndTime__c
                ,Remarks__c
                ,StartTime__c
                ,TaioAnken__c
                ,DateValue__c
                ,BreakTime__c
            From
                 ManHours__c
            Where
                TaioAnken__c = :recId 
            And
                DateValue__c >= :gessho 
            And
                DateValue__c <= :getsumatsu 
            //Nameの昇順
            Order by
                Name ASC 
               ,StartTime__c ASC
        ];
        Integer currentIndex = 0;
        //ManHours__cオブジェクトの変数mhにobjmhListを繰り返しコピーして入れろよ。
        for(ManHours__c mh : objmhList){
        //ManHoursDataクラスの変数mhdをインスタンス化（コピーを生成）
            ManHoursData mhd = new ManHoursData();
            //ManHoursDataオブジェクトのデータをManHours__cオブジェクトの変数mhに入れろよ。
            mhd.mh = mh;
            //ManHoursDataオブジェクトの変数dateDataにDateクラスのvalueOfメソッドを入れろよ。(mhdはstringクラスなのでstringクラスのreplaeAllメソッドが使える)
            mhd.dateData = Date.valueOf(mh.Name.replaceAll('/','-'));
            system.debug(mhd.dateData);
            mhd.currentNumber = currentIndex;
            currentIndex++;
            //変数mhListに変数mhdを追加する。
            mhList.add(mhd);
        }
    }
    //------------------------------------
    // 削除
    //------------------------------------
    //deleteItemが呼ばれたときに実行する（活性化）
    public void deleteItem(){
    //例外が起こる可能性がある処理を中に書く(エラーが出そうな処理)
    System.debug('DeleteNumber☆ ' + setDeleteNumber);
        try {
        system.debug(actionId );
            if (actionId != null && actionId != '') {
                //SOQLクエリでid取得
                List<ManHours__c> mhIdList = [
                    SELECT 
                        Id
                    FROM 
                        ManHours__c
                    WHERE 
                        Id = :this.actionId
                ];
                system.debug(actionId );
                system.debug(mhIdList.size() );
                System.debug('DeleteNumber☆☆ ' + setDeleteNumber);
                delete mhIdList;
            }
            System.debug('DeleteNumber☆☆☆ ' + setDeleteNumber);
            //Idが無い場合mhListリストのアイテムを削除
            for (Integer i = mhList.size() -1; i >= 0; i--) {
                System.debug('DeleteNumber☆☆☆☆ ' + setDeleteNumber);
                if(mhList.get(i).currentNumber == setDeleteNumber){
                    System.debug('DeleteNumber☆☆☆☆☆ ' + setDeleteNumber);
                    mhList.remove(i);
                    System.debug('DeleteNumber☆☆☆☆☆☆ ' + setDeleteNumber);
                     // 一度削除したらループを終了
                    setDeleteNumber = null;
                    break;
               }
            }
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, '削除しました。'));
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '削除中にエラーが発生しました。' + e.getMessage()));
        }
    }

    //------------------------------------
    // 行追加
    //------------------------------------
    //addDataが呼ばれたときに実行する（活性化）
    public void addData(){
    //ManHoursDataクラスの変数mhdにインスタンス化（コピー生成する）
        ManHoursData mhd = new ManHoursData();
        //変数mhd.mhにインスタンス化(コピーを生成する)
        mhd.mh = new ManHours__c(
        //TaioAnken__c項目にrecId（文字列）を寄こせよ。
            TaioAnken__c = this.recId
            //Name項目にDatetime.now()メソッドを使用してformat('yyyy-MM-dd')したデータを寄こせよ。
            ,Name = Datetime.now().format('yyyy-MM-dd')
        );
        //変数dateDataにDate.Today()を寄こせよ。
        mhd.dateData = Date.Today();
        mhd.currentNumber = this.mhList.size();
        system.debug(mhd.currentNumber + '☆追加☆');
        //変数mhListにmhdを追加しろよ。
        this.mhList.add(mhd);
        system.debug(mhd + '☆追加');
        // リストの番号を 0 から再割り当て
        for (Integer i = 0; i < this.mhList.size(); i++) {
            this.mhList.get(i).currentNumber = i;
        }
    }
    //------------------------------------
    // 保存
    //------------------------------------
    public void saveData() {
        List<ManHours__c> saveDatas = new List<ManHours__c>();
        //行番号の変数
        Integer Index = -1;
        for(ManHoursData mhd : this.mhList){
            Index ++;
        if (mhd.mh.StartTime__c == null || mhd.mh.EndTime__c == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Index +'行目が'+'開始時間または終了時間が設定されていません'));
            return;
        }
            mhd.mh.Name = String.valueOf(mhd.dateData);
            saveDatas.add(mhd.mh);
            
        
        }
        try {
            upsert saveDatas;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, '保存しました'));
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'データ保存中にエラーが発生しました: ' + e.getstackTraceString()));
        }
      }
    //------------------------------------
    // 一括保存
    //------------------------------------
    public void BulksaveData(){
        List<ManHours__c> saveDatas = new List<ManHours__c>();
        if(StartTime == '--なし--' || EndTime == '--なし--'|| BreakTime == '--なし--'){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '開始時間、終了時間、休憩時間のいずれかが設定されていません'));
            return;
           
        }    
        for(ManHoursData mhd : this.mhList){
            if(mhd.mh.StartTime__c == null || mhd.mh.EndTime__c == null || mhd.mh.BreakTime__c == null){
                mhd.mh.StartTime__c = string.valueOf(StartTime);
                mhd.mh.EndTime__c = string.valueOf(EndTime);
                mhd.mh.BreakTime__c = string.valueOf(BreakTime);
                mhd.mh.Name = String.valueOf(mhd.dateData);
                saveDatas.add(mhd.mh);
            }
        }
        
        try {
            upsert saveDatas;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, '保存しました'));
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'データ保存中にエラーが発生しました: ' + e.getstackTraceString()));
        }
    }
    //------------------------------------
    // 一括行追加
    //------------------------------------
    public void addBulkData(){    
        Date today = currentMonth;
        // 月初と月末の日付を取得
        Date startDate = today.toStartOfMonth();
        Date endDate = getEndOfMonth(today);
        // 月初から月末までの全ての日付をリストに追加
        for (Date currentDate = startDate; currentDate <= endDate; currentDate = currentDate.addDays(1)) {
            Datetime datet = Datetime.newInstance(currentDate,Time.newInstance(0, 0, 0, 0));
            String weekofdate = datet.format('E');
            if ( weekofdate == 'Mon' || weekofdate  == 'Tue' || weekofdate  == 'Wed' || weekofdate  == 'Thu' || weekofdate  == 'Fri') {
                ManHoursData mhd = new ManHoursData();
                mhd.mh = new ManHours__c(
                    TaioAnken__c = this.recId,
                    Name = Datetime.now().format('yyyy-MM-dd')
                );
                mhd.dateData = currentDate;
                mhd.currentNumber = this.mhList.size();
                this.mhList.add(mhd);
            }
        }
        // リストの番号を 0 から再割り当て
        for (Integer i = 0; i < this.mhList.size(); i++) {
            this.mhList.get(i).currentNumber = i;
        }
    }
    //------------------------------------
    // 前月
    //------------------------------------
    public void beforeMonth(){
        this.currentMonth = currentMonth.addMonths(-1);
        init();
    }
    
    //------------------------------------
    // 次月
    //------------------------------------
    public void nextMonth(){
        this.currentMonth = currentMonth.addMonths(1);
        init();
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
    
    public class ManHoursData { 
        public Date dateData { get; set; }
        public ManHours__c mh { get; set; }
        public Integer currentNumber { get; set; }
    }
    //------------------------------------
    // 一括行追加用月末日付取得
    //------------------------------------
    public static date getEndOfMonth(Date targetDate) {
        Date NewTargetDate = targetDate.addMonths(1).toStartOfMonth();
        Date result = NewTargetDate - 1;   
        return result;
    }
    //------------------------------------
    // 最初は時間文字列を分に変換
    //------------------------------------
    public Integer timeStringToMinutes(String timeStr) {
        if (timeStr == null || timeStr == '--なし--') {
            return 0;
        }
        String[] parts = timeStr.split(':');
        Integer hours = Integer.valueOf(parts[0]);
        Integer minutes = Integer.valueOf(parts[1]);
        return (hours * 60) + minutes;
    }
    //------------------------------------
    // 最後に分を時間文字列に変換
    //------------------------------------
    public String minutesToTimeString(Integer minutes) {
        Integer hours = minutes / 60;
        minutes = Math.mod(minutes, 60);
        String hoursStr;
        if (hours < 10) {
            hoursStr = '0' + String.valueOf(hours);
        } else {
            hoursStr = String.valueOf(hours);
        }
        
        String minutesStr;
        if (minutes < 10) {
            minutesStr = '0' + String.valueOf(minutes);
        } else {
            minutesStr = String.valueOf(minutes);
        }
        return hoursStr + ':' + minutesStr;
    }

    //------------------------------------
    // 実働合計時間を計算
    //------------------------------------
    public String getTotalWorkHours() {
        Integer totalMinutes = 0;
        for (ManHoursData mhd : mhList) {
            Integer startTime = timeStringToMinutes(mhd.mh.StartTime__c);
            Integer endTime = timeStringToMinutes(mhd.mh.EndTime__c);
            Integer breakTime = timeStringToMinutes(mhd.mh.BreakTime__c);
            
            if (startTime != null && endTime != null) {
                totalMinutes += (endTime - startTime - breakTime);
            }
        }
        return minutesToTimeString(totalMinutes);
    }

    //------------------------------------
    // 総労働時間を計算
    //------------------------------------
    public String getTotalActualWorkHours() {
        Integer totalMinutes = 0;
        for (ManHoursData mhd : mhList) {
            Integer startTime = timeStringToMinutes(mhd.mh.StartTime__c);
            Integer endTime = timeStringToMinutes(mhd.mh.EndTime__c);
            if (startTime != null && endTime != null) {
                totalMinutes += (endTime - startTime);
            }
        }
        return minutesToTimeString(totalMinutes);
    }

    //------------------------------------
    // 総休憩時間を計算
    //------------------------------------
    public String getTotalBreakTime() {
        Integer totalMinutes = 0;
        for (ManHoursData mhd : mhList) {
            Integer breakTime = timeStringToMinutes(mhd.mh.BreakTime__c);
            if (breakTime != null) {
                totalMinutes += breakTime;
            }
        }
        return minutesToTimeString(totalMinutes);
    }
}