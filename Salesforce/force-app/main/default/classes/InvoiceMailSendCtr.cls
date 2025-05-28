/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-01-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class InvoiceMailSendCtr {
    public String bodyText { get; set; }
    public String title { get; set; }
    
    public Invoice__c ivData { get; set; }
    
    public Blob attData { get; set; }
    public String fileName { get; set; }
    public String templateName { get; set; }

    //---------------------------------------------
    // コンストラクタ
    //---------------------------------------------
    public InvoiceMailSendCtr(ApexPages.StandardController controller) {
        this.fileName = '';
        this.templateName = 'InvoiceMail';
        this.ivData = [
            Select
                 Id
                ,OwnerId
                ,IsDeleted
                ,Name
                ,CreatedDate
                ,CreatedById
                ,LastModifiedDate
                ,LastModifiedById
                ,SystemModstamp
                ,Atesaki1__c
                ,Atesaki2__c
                ,Atesaki3__c
                ,BikouRan__c
                ,F_Ginko__c
                ,F_KouzaBangou__c
                ,F_KouzaShubetsu__c
                ,F_Shitenmei__c
                ,SeikyouMoto__c
                ,SeikyoumonotApMName__c
                ,Seikyubi__c
                ,SeikyumotoAddress__c
                ,SeikyumotoDenwa__c
                ,SeikyumotoEmail__c
                ,SeikyumotoKaishaName__c
                ,SeikyumotoPostCode__c
                ,ShiharaiKigen__c
                ,Shiharaisaki__c
                ,TaiouAnken__c
                ,Goukei__c
                ,Shoukei__c
                ,Tax__c
                ,Atena1__c
                ,Atena2__c
                ,Atena3__c
            From
                 Invoice__c
            Where
                id = :controller.getRecord().id
        ];
        

        List<EmailTemplate> template = [
            Select
                 Id
                ,Subject
                ,Body
            From
                 EmailTemplate
            Where
                DeveloperName = :templateName
        ];
        
        this.title    = template.get(0).Subject
            .replace('[month]',String.valueOf(this.ivData.Seikyubi__c.month()))
        ;
        
        this.bodyText = template.get(0).Body
            .replace('[month]',String.valueOf(this.ivData.Seikyubi__c.month()))
            .replace('[Company]',String.valueOf(this.ivData.Shiharaisaki__c))
            .replace('[Tanto]',this.ivData.Atena1__c != null ? String.valueOf(this.ivData.Atena1__c): '')
        ;
    }
    
    //---------------------------------------------
    // ファイル添付
    //---------------------------------------------
    public void tempFile(){
        Attachment att = new Attachment(
            body = attData
            ,Name = fileName
            ,ParentId = this.ivData.Id
        );
        
        try{
            insert att;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'ファイルを添付しました'));
            
            att = new Attachment();
            
        }catch (Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ファイルを添付してください'));
        
        }
    }
    //---------------------------------------------
    // テンプレート変更
    //---------------------------------------------
    public void changeMapTechTemplate(){
        this.templateName = 'InvoiceMailMapTech';
        
        List<EmailTemplate> template = [
            Select
                 Id
                ,Subject
                ,Body
            From
                 EmailTemplate
            Where
                DeveloperName = :templateName
        ];
        
        this.title = template.get(0).Subject
            .replace('[month]',String.valueOf(this.ivData.Seikyubi__c.month()))
        ;
        
        this.bodyText = template.get(0).Body
            .replace('[month]',String.valueOf(this.ivData.Seikyubi__c.month()))
            .replace('[Company]',String.valueOf(this.ivData.Shiharaisaki__c))
            .replace('[Tanto]',this.ivData.Atena1__c != null ? String.valueOf(this.ivData.Atena1__c): '')
        ;
    }
        
    //---------------------------------------------
    // メール送信
    //---------------------------------------------
    public void sendMail(){
        sendMailFt(
            this.ivData.Id
            ,this.title
            ,this.bodyText
        );
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'メール送信をリクエストしました'));
    }
    
    @future(callout=true)
    public static void sendMailFt(String ivId,String title,String bodyText){
        Invoice__c ivData = [
            Select
                 Id
                ,OwnerId
                ,IsDeleted
                ,Name
                ,CreatedDate
                ,CreatedById
                ,LastModifiedDate
                ,LastModifiedById
                ,SystemModstamp
                ,Atesaki1__c
                ,Atesaki2__c
                ,Atesaki3__c
                ,BikouRan__c
                ,F_Ginko__c
                ,F_KouzaBangou__c
                ,F_KouzaShubetsu__c
                ,F_Shitenmei__c
                ,SeikyouMoto__c
                ,SeikyoumonotApMName__c
                ,Seikyubi__c
                ,SeikyumotoAddress__c
                ,SeikyumotoDenwa__c
                ,SeikyumotoEmail__c
                ,SeikyumotoKaishaName__c
                ,SeikyumotoPostCode__c
                ,ShiharaiKigen__c
                ,Shiharaisaki__c
                ,TaiouAnken__c
                ,Goukei__c
                ,Shoukei__c
                ,Tax__c
                ,Atena1__c
                ,Atena2__c
                ,Atena3__c
            From
                 Invoice__c
            Where
                id = :ivId
        ];
    
        List<Attachment> attList = [
            Select
                Id
                ,Body
            From
                Attachment
            Where
                ParentId = :ivId
        ];
    
    
        // 組織アドレスの取得
        List<OrgWideEmailAddress> orgMail = [
            Select
                 Id
                ,Address
                ,DisplayName
            From
                 OrgWideEmailAddress
            Where
                DisplayName = 'FuncTech株式会社 小林'
            Limit 1
        ];
    
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // 送信先設定
        List<String> mailList = new List<String>();
        mailList.add(ivData.Atesaki1__c);
        
        
        List<String> mailListCC = new List<String>();
        mailListCC.add(UserInfo.getUserEmail());
        
        if(ivData.Atesaki2__c != null){
            mailListCC .add(ivData.Atesaki2__c);
        }
        
        if(ivData.Atesaki3__c != null){
            mailListCC .add(ivData.Atesaki3__c);
        }
        
        mail.setToAddresses(mailList);                    // 送信先
        
        if(mailListCC.size() != 0){
            mail.setCcAddresses(mailListCC);                // CC送信先
        }
        
        mail.setSubject(title);                          // 件名(String)
        mail.setPlainTextBody(bodyText);                  // 本文(String)
        
        PageReference page = Page.Seikyusho;
        page.getParameters().put('Id',ivData.Id);

        List<Messaging.EmailFileAttachment> attaDataList = new List<Messaging.EmailFileAttachment>();

        Messaging.EmailFileAttachment temp = new Messaging.EmailFileAttachment();
        
        if(Test.IsRunningTest()){
            temp.setBody(Blob.valueof('test'));
        }else{
            temp.setBody(page.getContentAsPDF());
        }
        temp.setContentType('application/pdf');
        temp.setFileName(ivData.Shiharaisaki__c + '_ご請求書【' + String.valueOf(ivData.Seikyubi__c.month()) + '月】.pdf');
        
        attaDataList.add(temp);
        
        for(Attachment att : attList){
            Messaging.EmailFileAttachment attTemp = new Messaging.EmailFileAttachment();
            attTemp.setBody(att.Body);
            attTemp.setContentType('application/pdf');
            attTemp.setFileName(ivData.Shiharaisaki__c + '_勤怠情報【' + String.valueOf(ivData.Seikyubi__c.month()) + '月】.pdf');
            attaDataList.add(attTemp);
        }
        
        mail.setFileAttachments(attaDataList);
        
        mail.setOrgWideEmailAddressId(orgMail.get(0).Id); // 送信元に設定する組織のアドレスID(設定しない場合はApexの実行者が設定される)。
        mail.setUseSignature(false);                      // 著名の有無。デフォルトはtrue。
        mail.setBccSender(true);                          // 送信者をBCCに追加
        mail.setReplyTo(UserInfo.getUserEmail());         // 返信先メールアドレス(String)
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});

    }

}