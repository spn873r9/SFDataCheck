/*-------------------------------------------------------------------
 * クラス名  ：請求書作成コントローラクラス
 * 概要      ：
 * 役割　　　：
 *             
 * 作成者　　　　作成日　　　作成/更新    理由 
 * ==================================================================
 * S.kobayashi   2019/06/28  Create       Insert
 *-----------------------------------------------------------------*/
public class SeikyushoCtr {
    public static final Decimal maxIndex = 20; // 最大行数

    // 請求明細
    public List<InvoiceList__c> ivMsList { get; set; }
    
    // 空の請求明細
    public List<InvoiceList__c> ivMsNullList { get; set; }
    
    // 追加印字数
    public Decimal addIndex { get; set; }
    
    // 行数
    public Decimal index{ get; set; }
    
    // コンストラクタ
    public SeikyushoCtr (ApexPages.StandardController controller) {
        this.ivMsNullList = new List<InvoiceList__c>();
        this.ivMsList = [
            Select
                 Id
                ,IsDeleted
                ,Name
                ,CreatedDate
                ,CreatedById
                ,LastModifiedDate
                ,LastModifiedById
                ,SystemModstamp
                ,Invoice__c
                ,Suuryou__c
                ,Tanka__c
                ,Kingaku__c
                ,Bikou__c
                ,Jikan__c
                ,Min__c
                ,TaxRate__c
                ,Tax__c
                ,KingakuNoTax__c
            From
                 InvoiceList__c
            Where
                Invoice__c = :controller.getRecord().id
            Order By 
                CreatedDate Asc
        ];
        this.index = ivMsList.size();
        this.addIndex = maxIndex - this.index;
        
        for(Decimal i = 0; i < this.addIndex; i++){
            ivMsNullList.add(new InvoiceList__c(Suuryou__c = i));
        }
    }

}