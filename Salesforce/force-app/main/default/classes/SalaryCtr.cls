public class SalaryCtr {
    public Salary__c slData { get; set; }
    
    public Blob pdfData { get; set; }

    //---------------------------------------------
    // コンストラクタ
    //---------------------------------------------
    public SalaryCtr(ApexPages.StandardController controller) {
        this.slData = [
            Select
                 Id
                ,Name
                ,MonthlyAttendance__c
                ,JoinWorkDayCount__c
                ,KekkinNissu__c
                ,YukyuZan__c
                ,TotalActiveWork__c
                ,NomalZangyo__c
                ,HolidayWorkTime__c
                ,MidnightWorkTime__c
                ,MidnightZangyoTime__c
                ,HolidayMidonightWorkTime__c
                ,ThikokuSoutaiTime__c
                ,Over45Zangyo__c
                ,Over60Zangyo__c
                ,BaseSalary__c
                ,YakushokuTeate__c
                ,FamilyTeate__c
                ,HomeTeate__c
                ,NoTaxTuukinhi__c
                ,TaxTuukinhi__c
                ,NomalZangyoTeate__c
                ,MidnightWorkTeate__c
                ,HolidayWorkTeate__c
                ,KekkinKoujyo__c
                ,ChikokuSoutaiKouzyo__c
                ,KazeiGoukei__c
                ,HikazeiTotal__c
                ,ShikyuTotal__c
                ,KaigoHoken__c
                ,KouseiNenkin__c
                ,KoyoHoken__c
                ,ShakaiHokenChosei__c
                ,ShotokuTax__c
                ,ZyuminTax__c
                ,ChoseiKoujyo__c
                ,Nenmatsuchoseikanpu__c
                ,Nenmatsuchoseichosyu__c
                ,KanendoChosei__c
                ,SonotaTotal__c
                ,Shikyugaku__c
                ,GenkinShikyugaku__c
                ,GenbutsuSikyugaku__c
                ,KenkoHoken__c
                ,Yukyu__c
                ,Kinmusha__c
                ,Kaigo2GouFlag__c
                ,ShakaihokenTotal__c
                ,KoujyoTotal__c
                ,SashihikiShikyugaku__c
                ,HurikomiShikyu1__c
                ,HurikomiShikyu2__c
                ,HurikomiShikyu3__c
                ,HurikomiTotal__c
                ,Nengetsu__c
                ,MonthlyAttendance__r.Name
                ,MonthlyAttendance__r.EmpInfo__r.UseInfo__r.Email
            From
                 Salary__c
            Where
                id = :controller.getRecord().Id
        ];
    }
    //---------------------------------------------
    // メール送信
    //---------------------------------------------
    public void sendMail(){
        sendMailCallOut(this.slData.Id);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'メール送信を行いました'));
    }
    @future(callout=true)
    public static void sendMailCallOut(String dataId){
        Salary__c slData = [
            Select
                 Id
                ,Name
                ,MonthlyAttendance__c
                ,JoinWorkDayCount__c
                ,KekkinNissu__c
                ,YukyuZan__c
                ,TotalActiveWork__c
                ,NomalZangyo__c
                ,HolidayWorkTime__c
                ,MidnightWorkTime__c
                ,MidnightZangyoTime__c
                ,HolidayMidonightWorkTime__c
                ,ThikokuSoutaiTime__c
                ,Over45Zangyo__c
                ,Over60Zangyo__c
                ,BaseSalary__c
                ,YakushokuTeate__c
                ,FamilyTeate__c
                ,HomeTeate__c
                ,NoTaxTuukinhi__c
                ,TaxTuukinhi__c
                ,NomalZangyoTeate__c
                ,MidnightWorkTeate__c
                ,HolidayWorkTeate__c
                ,KekkinKoujyo__c
                ,ChikokuSoutaiKouzyo__c
                ,KazeiGoukei__c
                ,HikazeiTotal__c
                ,ShikyuTotal__c
                ,KaigoHoken__c
                ,KouseiNenkin__c
                ,KoyoHoken__c
                ,ShakaiHokenChosei__c
                ,ShotokuTax__c
                ,ZyuminTax__c
                ,ChoseiKoujyo__c
                ,Nenmatsuchoseikanpu__c
                ,Nenmatsuchoseichosyu__c
                ,KanendoChosei__c
                ,SonotaTotal__c
                ,Shikyugaku__c
                ,GenkinShikyugaku__c
                ,GenbutsuSikyugaku__c
                ,KenkoHoken__c
                ,Yukyu__c
                ,Kinmusha__c
                ,Kaigo2GouFlag__c
                ,ShakaihokenTotal__c
                ,KoujyoTotal__c
                ,SashihikiShikyugaku__c
                ,HurikomiShikyu1__c
                ,HurikomiShikyu2__c
                ,HurikomiShikyu3__c
                ,HurikomiTotal__c
                ,Nengetsu__c
                ,MonthlyAttendance__r.Name
                ,MonthlyAttendance__r.EmpInfo__r.UseInfo__r.Email
            From
                 Salary__c
            Where
                id = :dataId
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
        mailList.add(slData.MonthlyAttendance__r.EmpInfo__r.UseInfo__r.Email);
        
        List<String> mailListCC = new List<String>();
        mailListCC.add(UserInfo.getUserEmail());
        
        mail.setToAddresses(mailList);                    // 送信先
        mail.setBccAddresses(new List<String>{System.label.KeiriAddress});
        
        if(mailListCC.size() != 0){
            mail.setCcAddresses(mailListCC);              // CC送信先
        }
        
        mail.setSubject('【給与明細】' + slData.MonthlyAttendance__r.Name); 
        mail.setPlainTextBody(slData.MonthlyAttendance__r.Name + '分の給与明細です。\nご確認のほどよろしくお願いいたします。'); 

        List<Messaging.EmailFileAttachment> attaDataList = new List<Messaging.EmailFileAttachment>();

        Messaging.EmailFileAttachment temp = new Messaging.EmailFileAttachment();
        
        
        PageReference page = Page.SalaryDetial;
        page.getParameters().put('Id',slData.Id);
        
        if(Test.IsRunningTest()){
            temp.setBody(Blob.valueof('test'));
        }else{
            temp.setBody(page.getContentAsPDF());
        }
        
        temp.setContentType('application/pdf');
        temp.setFileName('給与明細_' + slData.MonthlyAttendance__r.Name + '.pdf');
            
            attaDataList.add(temp);

        mail.setFileAttachments(attaDataList);
        mail.setOrgWideEmailAddressId(orgMail.get(0).Id); // 送信元に設定する組織のアドレスID(設定しない場合はApexの実行者が設定される)。
        mail.setUseSignature(false);                      // 著名の有無。デフォルトはtrue。
        mail.setBccSender(true);                          // 送信者をBCCに追加
        mail.setReplyTo(UserInfo.getUserEmail());         // 返信先メールアドレス(String)
        
        try{
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
            
        } catch (Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'送信中にエラーが発生しました。' + e.getMessage()));
        }
    }
}