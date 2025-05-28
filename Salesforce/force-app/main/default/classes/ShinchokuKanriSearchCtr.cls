public with sharing class ShinchokuKanriSearchCtr {
    public List<ShinchokuKanri__c> objData { get; set; }
    
    // 検索条件
    public String searchName { get; set; }
    public String statusName { get; set; }
    public String categoryName { get; set; }
    public Date startDate { get; set; }
    public Date endDate { get; set; }   
    
    
    //------------------------------------
    // コンストラクタ
    //------------------------------------
    public ShinchokuKanriSearchCtr(){
        search();
    }
    //------------------------------------
    // 検索処理内容
    //------------------------------------
    public void searchWithoutScInstallDate(String strSearchMode){
        String baseQuery = 
            'Select                ' +  
            '    Id                ' + 
            '   ,Name              ' + 
            '   ,Category__c       ' + 
            '   ,EndDate__c        ' + 
            '   ,Naiyo__c          ' + 
            '   ,StartDate__c      ' + 
            '   ,Status__c         ' + 
            '   ,SyncList__c       ' + 
            '   ,KakuninTanto__c   ' + 
            '   ,RequestDate__c    ' + 
            '   ,DueDate__c        ' + 
            'From                  ' + 
            '    ShinchokuKanri__c ' +
            'Where                 ' +
            '    IsDeleted = false ';
        
        if(this.searchName != null && this.searchName != ''){
            String likeSet1 = '%' + this.searchName + '%';
            baseQuery += 'AND Name Like :likeSet1 ';
        }
        
        if(this.statusName != null && this.statusName != ''){
            String likeSet2 = '%' + this.statusName + '%';
            baseQuery += 'AND Status__c Like :likeSet2 ';
        }
        
        if(this.categoryName != null && this.categoryName != ''){
            String likeSet3 = '%' + this.categoryName + '%';
            baseQuery += 'AND Category__c Like :likeSet3 ';
        }
        
        if(strSearchMode != null && strSearchMode == '0'){
            baseQuery += 'AND RequestDate__c >= :startDate ';
            baseQuery += 'AND RequestDate__c <= :endDate ';
            
        }else if(strSearchMode != null && strSearchMode == '1'){
            baseQuery += 'AND RequestDate__c = TODAY ';
            this.startDate = Date.today();
            this.endDate = Date.today();
            
        }else if(strSearchMode != null && strSearchMode == '2'){
            baseQuery += 'AND RequestDate__c = THIS_MONTH ';
            this.startDate = Date.newInstance(Date.Today().year(),Date.Today().month(),1);
            this.endDate = this.startDate.addMonths(1).addDays(-1);
            
        }
        
        try{
            this.objData = Database.query(baseQuery + ' Order By CreatedDate DESC Limit 2000');
            
        }catch (DmlException e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'エラーが発生しました。' + e.getMessage()));
        }
    }
    
    //------------------------------------
    // 検索処理
    //------------------------------------
    public void search(){
        searchWithoutScInstallDate('0');
    }
    public void searchToday(){
        searchWithoutScInstallDate('1');
    }
    public void searchMonth(){
        searchWithoutScInstallDate('2');
    }
}