public with sharing class WorkTaskSearchCtr {
    private static final Integer PAGE_SIZE = 100;

    public List<WorkTask__c> objData { get; set; }
    
    // 検索条件
    public String searchName { get; set; }
    public String Status { get; set; }
    public String tanto { get; set; }
    public Datetime startDate { get; set; }
    public Datetime endDate { get; set; }
    public Boolean noViewClose { get; set; }
    
    // ソート
    public String sortSetClm { get; set; }
    public String sortType { get; set; }
    
    // 結果
    public Integer searchSize { get; set; }
    public Integer viewrecCount { get; set; }
    
    public List<SelectOption> monthList { get; set; }
    
    // 次ページ、前ページ用項目
    private integer totalRecs = 0;
    public integer OffsetSize = 0;
    private integer LimitSize= PAGE_SIZE;

    public Integer currentPage {get; private set;}    // 現在選択中のページ
    public Integer totalPage {get; private set;}      // ページ数
    
    public Integer firstNum { 
        get{
            if(currentPage != null){
                return PAGE_SIZE * (currentPage - 1) + 1;
            }
            
            return 0;
        }
        set;
    }
    
    public String pageParam { get; set; }
    
    
    //------------------------------------
    // コンストラクタ
    //------------------------------------
    public WorkTaskSearchCtr(){
        this.pageParam = System.currentPageReference().getParameters().get('Id');
        this.sortSetClm = 'CreatedDate';
        this.sortType = 'DESC';
        this.tanto = '';
        this.searchSize = 0;
        this.viewrecCount = 0;
        this.noViewClose = true;
    
        search();
    }
    //------------------------------------
    // 検索処理内容
    //------------------------------------
    public void searchWithoutScInstallDate(String strSearchMode,Boolean isPaging){
        this.searchSize = 0;
        this.viewrecCount = 0;
        
        String baseQuery = 
            'Select ' + 
                ' Id ' + 
                ',Name ' + 
                ',Status__c ' + 
                ',CreatedDate ' + 
                ',Tantosha__c ' +
            'From ' + 
                'WorkTask__c ';
                
        String whereQuery = 'Where IsDeleted = false ';
        
        if(pageParam != null){
            whereQuery += 'And ShinchokuKanri__c = \'' + pageParam + '\' ';
        }
        
        whereQuery += whereString(this.searchName,'Name');
        whereQuery += whereString(this.Status,'Status__c');
        whereQuery += whereString(this.tanto,'Tantosha__r.Name');

        if(noViewClose){
            whereQuery += 'AND Status__c Not in (\'完了\',\'中止\') ';
        }
        
        if(strSearchMode != null && strSearchMode == '0'){
            whereQuery += whereDatetime(startDate,endDate,'CreatedDate');
            
        }else if(strSearchMode != null && strSearchMode == '1'){
            whereQuery += 'AND CreatedDate = TODAY ';
            this.startDate = Datetime.newInstance(Date.Today().year(),Date.Today().month(),Date.Today().day());
            this.endDate = startDate.addDays(1);
            
        }else if(strSearchMode != null && strSearchMode == '2'){
            whereQuery += 'AND CreatedDate = THIS_MONTH ';
            this.startDate = Datetime.newInstance(Date.Today().year(),Date.Today().month(),1);
            this.endDate = this.startDate.addMonths(1);
            
        }
        
        String orderQuery = ' Order By ' + this.sortSetClm + ' ' + this.sortType;
        
        try{
            AggregateResult[] groupedResults = Database.query('Select COUNT(id) cnt from WorkTask__c ' + whereQuery);
            this.searchSize = Integer.valueOf(groupedResults.get(0).get('cnt'));

            if(isPaging == true){
                this.objData = Database.query(baseQuery + whereQuery + orderQuery + ' Limit ' + PAGE_SIZE + ' OFFSET :OffsetSize');
            }else{
                this.objData = Database.query(baseQuery + whereQuery + orderQuery + ' Limit ' + PAGE_SIZE);
                this.totalRecs = this.searchSize;
            }
            
            if(this.objData.size() >= PAGE_SIZE){
                this.viewrecCount = PAGE_SIZE;
            }else{
                this.viewrecCount = this.objData.size();
            }
            
        }catch (DmlException e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'エラーが発生しました。' + e.getMessage()));
        }
    }
    
    //------------------------------------
    // 検索処理
    //------------------------------------
    public void search(Boolean isPaging){
        searchWithoutScInstallDate('0',isPaging);
        
        if(isPaging == false){
            initPagingView();
        }
    }
    public void search(){
        searchWithoutScInstallDate('0',false);
        initPagingView();
    }
    public void searchToday(){
        searchWithoutScInstallDate('1',false);
        initPagingView();
    }
    public void searchMonth(){
        searchWithoutScInstallDate('2',false);
        initPagingView();
    }
    
    //------------------------------------
    // WhereString
    //------------------------------------
    public String whereString(String searchClm,String clmName){
        if(searchClm != null && searchClm != ''){
            return ' AND ' + clmName + ' Like \'%' + searchClm + '%\'';
        }
        return '';
    }
    //------------------------------------
    // WhereStringOr 多ワード　→ 1項目
    //------------------------------------
    public String whereStringOr(List<String> searchClms,String clmName){
        String orQuery = ' AND(';
        Boolean isExecute = false;
    
        for(String searchClm : searchClms){
            if(searchClm != null && searchClm != ''){
                orQuery += clmName + ' Like \'%' + searchClm + '%\' OR ';
                isExecute = true;
            }
        }
        if(isExecute){
            return orQuery.substring(0,orQuery.length() - 3) + ')';
            
        }else{
            return '';
        }
    }
    //------------------------------------
    // WhereStringOr 1ワード　→ 多項目
    //------------------------------------
    public String whereStringOr(String searchClm,List<String> clmNames){
        String orQuery = 'AND(';
        Boolean isExecute = false;
    
        for(String clmName : clmNames){
            if(searchClm != null && searchClm != ''){
                orQuery += clmName + ' Like \'%' + searchClm + '%\' OR ';
                isExecute = true;
            }
        }
        if(isExecute){
            return orQuery.substring(0,orQuery.length() - 3) + ')';
            
        }else{
            return '';
        }
    }
    //------------------------------------
    // WhereBoolean
    //------------------------------------
    public String whereBoolean(String searchClm,String clmName){
        if(searchClm != null && searchClm != ''){
           searchClm = searchClm.toLowerCase();
           if(searchClm == 'true' || searchClm == 'false'){
               return ' AND ' + clmName + ' = ' + searchClm;
           }
        }
        return '';
    }
    //------------------------------------
    // WhereDecimal
    //------------------------------------
    public String whereDecimal(String stSearchClm,String edSearchClm,String clmName){
        String retStr = '';
        
        if(stSearchClm != null && stSearchClm != ''){
            Decimal stSearchClmDc = Decimal.valueOf(stSearchClm);
            retStr += ' AND ' + clmName + ' >= ' + stSearchClmDc;
        }
        if(edSearchClm != null && edSearchClm != ''){
            Decimal edSearchClmDc = Decimal.valueOf(edSearchClm);
            retStr += ' AND ' + clmName + ' <= ' + edSearchClmDc;
        }
        
        return retStr;
    }
    //------------------------------------
    // WhereDate
    //------------------------------------
    public String whereDate(Date stSearchClm,Date edSearchClm,String clmName){
        String retStr = '';
        
        if(stSearchClm != null){
            String year = String.valueOf(stSearchClm.year()).leftPad(2,'0');
            String month = String.valueOf(stSearchClm.month()).leftPad(2,'0');
            String day = String.valueOf(stSearchClm.day()).leftPad(2,'0');
            retStr += ' AND ' + clmName + ' >= ' + year + '-' + month + '-' + day;
        }
        if(edSearchClm != null){
            String year = String.valueOf(edSearchClm.year()).leftPad(2,'0');
            String month = String.valueOf(edSearchClm.month()).leftPad(2,'0');
            String day = String.valueOf(edSearchClm.day()).leftPad(2,'0');
            retStr += ' AND ' + clmName + ' <= ' + year + '-' + month + '-' + day;
        }
        
        return retStr;
    }
    //------------------------------------
    // WhereDatetime
    //------------------------------------
    public String whereDatetime(Datetime stSearchClm,Datetime edSearchClm,String clmName){
        String retStr = '';
        
        if(stSearchClm != null){
            retStr += ' AND ' + clmName + ' >= ' + stSearchClm.formatGmt('yyyy-MM-dd\'T\'HH:mm') + ':00.000Z';
        }
        if(edSearchClm != null){
            retStr += ' AND ' + clmName + ' <= ' + edSearchClm.formatGmt('yyyy-MM-dd\'T\'HH:mm') + ':00.000Z';
        }
        
        return retStr;
    }
    
    //------------------------------------
    // ページング対応
    //------------------------------------
    public void initPagingView(){
        // ページの総数を計算
        // レコード数 / ページサイズで計算、小数部分は切り上げ
        totalPage = (Integer)Math.ceil((Decimal)this.searchSize / LimitSize);
        currentPage = 1;
        OffsetSize = 0;
    }
    
    public void FirstPage(){
        OffsetSize = 0;
        search(true);
    }
    
    public void previous(){
        OffsetSize = OffsetSize - LimitSize;
        search(true);
        currentPage--;
    }
    
    public void next(){
        OffsetSize = OffsetSize + LimitSize;
        search(true);
        currentPage++;
    }
    
    public void LastPage(){
        OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
        search(true);
    }
    
    // 前のページがあるかどうか
    public boolean getenablePrev(){
        if(OffsetSize == 0 || currentPage == 1){
            return false;
        }else{
            return true;
        }
    }
    
    // 次のページがあるかどうか
    public boolean getenableNext(){
        if((OffsetSize + LimitSize) > totalRecs){
            return false;
        }else{
            return true;    
        }
    }
}