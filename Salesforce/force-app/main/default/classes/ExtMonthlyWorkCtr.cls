/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-03-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class ExtMonthlyWorkCtr {
    public String               recId   { get; set; }
    public EmployeeInfo__c      empInfo { get; set; }
    public MonthlyAttendance__c maData  { get; set; }
    public List<DailyWork__c>   dwList  { get; set; }
    public List<SelectOption>   vacList { get; set; }
    public String               dataId  { get; set; }
    public Datetime             scDate  { get; set; }
    public String               hdStr   { get; set; } // 休日の日付文字列データ
    
    //------承認申請状態-------
    public Boolean monthlyApplovalFlag  { get; set; } // 【月次承認】申請中かどうか
    public Boolean monthlyApprovedFlag  { get; set; } // 【月次承認】承認済みかどうか
    
    public ExtMonthlyWorkCtr(ApexPages.StandardController controller) {
        this.recId = controller.getRecord().id;
        this.scDate = Datetime.now();
        try{
            init();
        }catch (Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'読み込み時エラーが発生しました。管理者にお問い合わせください。'));
        }
    }
    
    public void init(){
        //----初期化----
        vacList = new List<SelectOption>();
        this.dataId = '';
        this.monthlyApplovalFlag = false;
        this.monthlyApprovedFlag = false;
        this.dwList = new List<DailyWork__c>();
        
        // 開いた時は自動的に開いたユーザの当月の勤怠を参照する
        System.debug('★recId:' + recId);
        if(recId == null || recId == ''){
            // 現在の年月を取得する
            String searchNengetsu = this.scDate.year() + '年' + this.scDate.month() + '月';
            
            this.dwList = [
                Select
                     Id
                    ,Name
                    ,MonthAtt__c
                    ,VacationSetting__c
                    ,Date__c
                    ,ArriveAtWork__c
                    ,LeavingOffice__c
                    ,BreakTime__c
                    ,Remarks__c
                    ,FixWorkTime__c
                    ,BreakTimeStart1__c
                    ,BreakTimeStart2__c
                    ,BreakTimeStart3__c
                    ,BreakTimeStart4__c
                    ,BreakTimeEnd1__c
                    ,BreakTimeEnd2__c
                    ,BreakTimeEnd3__c
                    ,BreakTimeEnd4__c
                    ,DailyApplovalRequested__c
                    ,DailyApplovalCheck__c
                    ,VacationRequest__c
                    ,VacationApploval__c
                    ,DayOfWeek__c
                    ,PublicHoliday__c
                    ,WorkDay__c
                    ,VacationSetting__r.Applicability__c
                    ,VacationSetting__r.Type__c
                From
                     DailyWork__c
                Where
                    MonthAtt__r.EmpInfo__r.UseInfo__c = :UserInfo.getUserId()
                And
                    MonthAtt__r.Name = :searchNengetsu
                Order By
                    Date__c ASC
            ];
            System.debug('★dwList:' + dwList.size());
            
            if(this.dwList.size() != 0){
                this.recId = this.dwList.get(0).MonthAtt__c;
            }
            
        }else{
            this.dwList = [
                Select
                     Id
                    ,Name
                    ,MonthAtt__c
                    ,VacationSetting__c
                    ,Date__c
                    ,ArriveAtWork__c
                    ,LeavingOffice__c
                    ,BreakTime__c
                    ,Remarks__c
                    ,FixWorkTime__c
                    ,BreakTimeStart1__c
                    ,BreakTimeStart2__c
                    ,BreakTimeStart3__c
                    ,BreakTimeStart4__c
                    ,BreakTimeEnd1__c
                    ,BreakTimeEnd2__c
                    ,BreakTimeEnd3__c
                    ,BreakTimeEnd4__c
                    ,DailyApplovalRequested__c
                    ,DailyApplovalCheck__c
                    ,VacationRequest__c
                    ,VacationApploval__c
                    ,DayOfWeek__c
                    ,PublicHoliday__c
                    ,WorkDay__c
                    ,VacationSetting__r.Applicability__c
                    ,VacationSetting__r.Type__c
                From
                     DailyWork__c
                Where
                    MonthAtt__c = :this.recId
                Order By
                    Date__c ASC
            ];
            System.debug('★dwList:' + dwList.size());
        }
        
        List<MonthlyAttendance__c> monthList = [
            Select
                 Id
                ,IsDeleted
                ,Name
                ,CreatedDate
                ,CreatedById
                ,LastModifiedDate
                ,LastModifiedById
                ,SystemModstamp
                ,LastViewedDate
                ,LastReferencedDate
                ,EmpInfo__c
                ,Year__c
                ,JoinWorkDayCount__c
                ,Month__c
                ,SumWorkTime__c
                ,SumBreakTime__c
                ,PaidDayCount__c
                ,SpecialPaidLeave__c
                ,LateCount__c
                ,LeaveEarlyCount__c
                ,EmpInfo__r.Authorizer__r.Name
                ,EmpInfo__r.EmployeeType__r.StartWorkTime__c
                ,EmpInfo__r.EmployeeType__r.EndWorkTime__c
                ,EmpInfo__r.EmployeeType__r.StartBreakTime__c
                ,EmpInfo__r.EmployeeType__r.EndBreakTime__c
                ,EmpInfo__r.Name
                ,EmpInfo__r.EmployeeType__r.VacationCheck__c
                ,EmpInfo__r.EmployeeType__r.DailyCheck__c
                ,EmpInfo__r.EmployeeType__r.MonthlyCheck__c
            From
                 MonthlyAttendance__c
            Where
                id = :this.recId
        ];
        
        if(monthList.size() != 0){
            this.maData = monthList.get(0);
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'当月分の月次勤怠が作成されていません。管理者にお問い合わせください。'));
            return;
        }
        
        // 勤務者情報
        this.empInfo = [
            Select
                Id
                ,isWorking__c
                ,isActive__c
            From
                EmployeeInfo__c
            Where
                Id = :this.maData.EmpInfo__r.id
        ];
        
        // エラー処理
        if(this.dwList.size() == 0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'勤怠が登録されていません。'));
        }
        
        else if(this.dwList.size() > 31){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'日付が重複する勤怠データが存在しています。管理者にお問い合わせください。'));
        }
        
        // 休暇設定の選択リスト値を取得
        else{
            List<VacationMaster__c> vmList = [
                Select
                     Id
                    ,Name
                From
                     VacationMaster__c
            ];
            // 
            vacList.add(new SelectOption('',''));
            
            for(VacationMaster__c vm : vmList){
                vacList.add(new SelectOption(vm.Id,vm.Name));
                
            }
        }
        
        // 承認状況の取得
        // ----月次承認----
        List<ProcessInstanceWorkitem> piwMonthly = [
            Select
                 Id
            From
                 ProcessInstanceWorkitem
            Where
                ProcessInstance.TargetObjectId = :this.maData.id
            And
                ProcessInstance.ProcessDefinition.Name = '月次承認申請'
            And
                ProcessInstance.Status = 'Pending'
        ];
        
        List<ProcessInstance> piMonthly = [
            Select
                 Id
            From
                 ProcessInstance
            Where
                Status = 'Approved'
            And
                TargetObjectId = :this.maData.id
            And
                ProcessDefinition.Name = '月次承認申請'
        ];
        
        
        // 申請が存在している場合
        if(piwMonthly.size() != 0){
            this.monthlyApplovalFlag = true;
        }
        
        // 承認が存在している場合
        if(piMonthly.size() != 0){
            this.monthlyApprovedFlag = true;
        }
        
        this.hdStr = '';
        
        for(Holiday hd : [
            Select
                 Id
                ,Name
                ,IsAllDay
                ,ActivityDate
                ,IsRecurrence
                ,RecurrenceType
            From
                 Holiday
            Where
                (RecurrenceEndDateOnly >= TODAY OR RecurrenceEndDateOnly = null)
            And
                IsAllDay = true
        ]){
            // 繰り返しの場合繰り返し種別ごとに処理
            // 毎月
            if(hd.RecurrenceType == 'RecursMonthly' || hd.RecurrenceType == 'RecursMonthlyNth'){
                this.hdStr += Datetime.now().format('yyyy-MM-') + String.valueOf(hd.ActivityDate.day()).leftPad(2,'0');
            }
            // 毎年
            if(hd.RecurrenceType == 'RecursYearly' || hd.RecurrenceType == 'RecursYearlyNth'){
                this.hdStr += Datetime.now().format('yyyy-') + String.valueOf(hd.ActivityDate.month()).leftPad(2,'0') + '-' + String.valueOf(hd.ActivityDate.day()).leftPad(2,'0');
            }
        }
    }
    
    /*-----------------------------------------------------------------------------------------
     * 出勤
     *----------------------------------------------------------------------------------------*/
    public PageReference startWork(){
        PageReference pg = ApexPages.currentPage();
        Boolean errorFlag = false;
        
        for(DailyWork__c dw : dwList){
            if(dw.Date__c == Date.Today()){
                if(dw.VacationSetting__r.Type__c == '全休' || dw.VacationSetting__r.Type__c == '半休'){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'休暇が設定されているため出勤できません。'));
                    errorFlag = true;
                }else{
                    dw.ArriveAtWork__c = Datetime.now().format('HH:mm');
                    empInfo.isWorking__c = true;
                }
            }
        }
        
        if(dwList.size() != 0){
            if(errorFlag == false){
                try{
                    update dwList;
                    update empInfo;
                    
                    pg.setRedirect(true);
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'出勤しました。'));
                }catch (Exception e){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'更新時エラーが発生しました。' + e.getMessage()));
                }
            }
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'当月の勤怠ではないため出勤できません。'));
        }
        
        return pg;
    }
    /*-----------------------------------------------------------------------------------------
     * 退勤
     *----------------------------------------------------------------------------------------*/
    public PageReference endWork(){
        PageReference pg = ApexPages.currentPage();
        Boolean errorFlag = false;
        
        for(DailyWork__c dw : dwList){
            if(dw.Date__c == Date.Today()){
                if(dw.VacationSetting__r.Type__c == '全休' || dw.VacationSetting__r.Type__c == '半休'){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'休暇が設定されているため退勤できません。'));
                    errorFlag = true;
                    
                }else if(dw.ArriveAtWork__c == null){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'出勤されていません。'));
                    errorFlag = true;
                    
                }else{
                    dw.LeavingOffice__c = Datetime.now().format('HH:mm');
                    empInfo.isWorking__c = false;
                }
            }
        }
        
        if(dwList.size() != 0){
            if(errorFlag == false){
                try{
                    update dwList;
                    update empInfo;
                    
                    pg.setRedirect(true);
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'退勤しました。'));
                }catch (Exception e){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'更新時エラーが発生しました。' + e.getMessage()));
                }
            }
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'当月の勤怠ではないため退勤できません。'));
        }
        
        return pg;
    }
    /*-----------------------------------------------------------------------------------------
     * 保存
     *----------------------------------------------------------------------------------------*/
    public void saveAll(){
        if(dwList.size() != 0){
            try{
                update dwList;
                init();
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'保存しました。'));
            }catch (Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'更新時エラーが発生しました。' + e.getMessage()));
            }
            
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'保存するデータがありません。'));
            
        }
    }
    /*-----------------------------------------------------------------------------------------
     * 日次申請
     *----------------------------------------------------------------------------------------*/
    public PageReference dayApploval(){
        PageReference pg = ApexPages.currentPage();
        
        // プロセスの作成
        Approval.ProcessSubmitRequest psr = new Approval.ProcessSubmitRequest();
        
        // 申請するオブジェクトの設定
        psr.setObjectId(dataId);
        
        try{
            // プロセス実行
            Approval.ProcessResult submitResult = Approval.process(psr);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'日次申請を行いました。'));
            
        }catch (Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'申請プロセスが設定されていません。'));
        }

        pg.setRedirect(true);
        return pg;
    }
    
    /*-----------------------------------------------------------------------------------------
     * 日次申請承認
     *----------------------------------------------------------------------------------------*/
    public PageReference dayApplovalOK(){
        PageReference pg = ApexPages.currentPage();

        List<ProcessInstanceWorkitem> workItems = [
            SELECT 
                Id, 
                ProcessInstanceId 
            FROM 
                ProcessInstanceWorkitem 
            WHERE 
                ProcessInstance.TargetObjectId = :dataId 
        ];
        
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        for(ProcessInstanceWorkitem workItem : workItems){
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setWorkitemId(workItem.Id);
            req.setAction('Approve');
            requests.add(req);
        }

        if(requests.size() != 0){
            Approval.ProcessResult[] processResults = Approval.process(requests);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'日次申請を承認しました。'));
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'申請プロセスが設定されていません。'));
        }
        
        pg.setRedirect(true);
        return pg;
    }
    
    /*-----------------------------------------------------------------------------------------
     * 日次申請否認
     *----------------------------------------------------------------------------------------*/
    public PageReference dayApplovalNG(){
        PageReference pg = ApexPages.currentPage();
        
        List<ProcessInstanceWorkitem> workItems = [
            SELECT 
                Id, 
                ProcessInstanceId 
            FROM 
                ProcessInstanceWorkitem 
            WHERE 
                ProcessInstance.TargetObjectId = :dataId 
        ];
        
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        for(ProcessInstanceWorkitem workItem : workItems){
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setWorkitemId(workItem.Id);
            req.setAction('Reject');
            requests.add(req);
        }
        if(requests.size() != 0){
            Approval.ProcessResult[] processResults = Approval.process(requests);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'日次申請を否認しました。'));
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'申請プロセスが設定されていません。'));
        }
        
        pg.setRedirect(true);
        return pg;
    }
    
    /*-----------------------------------------------------------------------------------------
     * 休日申請
     *----------------------------------------------------------------------------------------*/
    public PageReference vacationApplovalRequest(){
        PageReference pg = ApexPages.currentPage();
        
        // プロセスの作成
        Approval.ProcessSubmitRequest psr = new Approval.ProcessSubmitRequest();
        
        // 申請するオブジェクトの設定
        psr.setObjectId(dataId);
        
        try{
            // プロセス実行
            Approval.ProcessResult submitResult = Approval.process(psr);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'休日申請を行いました。'));
            
        }catch (Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'申請プロセスが設定されていません。'));
        }
        
        pg.setRedirect(true);
        return pg;
    }
    /*-----------------------------------------------------------------------------------------
     * 休日申請承認
     *----------------------------------------------------------------------------------------*/
    public PageReference vacationApplovalRequestOK(){
        PageReference pg = ApexPages.currentPage();

        List<ProcessInstanceWorkitem> workItems = [
            SELECT 
                Id, 
                ProcessInstanceId 
            FROM 
                ProcessInstanceWorkitem 
            WHERE 
                ProcessInstance.TargetObjectId = :dataId 
        ];
        
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        for(ProcessInstanceWorkitem workItem : workItems){
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setWorkitemId(workItem.Id);
            req.setAction('Approve');
            requests.add(req);
        }
        if(requests.size() != 0){
            Approval.ProcessResult[] processResults = Approval.process(requests);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'休日申請を承認しました。'));
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'申請プロセスが設定されていません。'));
        }
        
        pg.setRedirect(true);
        return pg;
    }
    /*-----------------------------------------------------------------------------------------
     * 休日申請否認
     *----------------------------------------------------------------------------------------*/
    public PageReference vacationApplovalRequestNG(){
        PageReference pg = ApexPages.currentPage();
        
        List<ProcessInstanceWorkitem> workItems = [
            SELECT 
                Id, 
                ProcessInstanceId 
            FROM 
                ProcessInstanceWorkitem 
            WHERE 
                ProcessInstance.TargetObjectId = :dataId 
        ];
        
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        for(ProcessInstanceWorkitem workItem : workItems){
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setWorkitemId(workItem.Id);
            req.setAction('Reject');
            requests.add(req);
        }
        if(requests.size() != 0){
            Approval.ProcessResult[] processResults = Approval.process(requests);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'休日申請を否認しました。'));
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'申請プロセスが設定されていません。'));
        }
        pg.setRedirect(true);
        return pg;
    }
    /*-----------------------------------------------------------------------------------------
     * 月次申請
     *----------------------------------------------------------------------------------------*/
    public PageReference monthlyApplovalRequest(){
        // 1. 現在操作中のユーザのIDを元にユーザ情報を取得する
        // その際にManager項目をSelect文の中に加える
        // その情報はList<User>型で定義した変数に保存する
        List<User> getUser = [
            SELECT
                Id,
                ManagerId
            From
                User
            Where
                Id = :UserInfo.getUserId()
        ];
        
        
        // ２．１．で取得したユーザ情報のManager項目に値が設定されているかどうかを判定する
        // 判定した結果、Nullだった場合はエラメッセージを画面上に出力する
        // メッセージを出力した後にreturnにて強制終了を行う
        if(getUser.size() == 1){
            if(getUser.get(0).ManagerId == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'申請先が未設定です。'));
                return null;
            }
        
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'エラーが発生しました。管理者までお問い合わせください。ERROR-001'));
            return null;
        } 
        PageReference pg = ApexPages.currentPage();

        // プロセスの作成
        Approval.ProcessSubmitRequest psr = new Approval.ProcessSubmitRequest();
        // 申請するオブジェクトの設定
        psr.setObjectId(recId);
        
        try{
            // プロセス実行
            Approval.ProcessResult submitResult = Approval.process(psr);
        
        }catch (Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'申請可能なプロセスが見つかりません。ERROR-002'));
            return null;
        }
        
        pg.setRedirect(true);
        return pg;
    }
    /*-----------------------------------------------------------------------------------------
     * 休憩保存
     *----------------------------------------------------------------------------------------*/
    public PageReference saveBreakTime(){
        PageReference pg = ApexPages.currentPage();
        
        if(dataId != null){
            for(DailyWork__c dw : dwList){
                if(dw.Id == dataId){
                    
                    try{
                        update dw;
                    }catch (Exception e){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'更新時エラーが発生しました。' + e.getMessage()));
                    }
                    
                    break;
                }
            }
            pg.setRedirect(true);
        }else{
            pg.setRedirect(false);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'保存するデータが削除された可能性があります。'));
        }
        
        return pg;
    }
    
    /*-----------------------------------------------------------------------------------------
     * 次月
     *----------------------------------------------------------------------------------------*/
    public void nextMonth(){
        this.scDate = this.scDate.addMonths(1);
        this.recId = null;
        try{
            init();
        }catch (Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'読み込み時エラーが発生しました。管理者にお問い合わせください。'));
        }
    }
    
    /*-----------------------------------------------------------------------------------------
     * 前月
     *----------------------------------------------------------------------------------------*/
    public void beforeMonth(){
        this.scDate = this.scDate.addMonths(-1);
        this.recId = null;
        try{
            init();
        }catch (Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'読み込み時エラーが発生しました。管理者にお問い合わせください。'));
        }
    }
}