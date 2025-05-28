/**------------------------------------------------------------------------------
 * クラス名：ShinchokuKanriSearchCtrTest 
 * 概要    ：
 *           
 *
 * 改版履歴：2023/01/03 S.Kobayashi：新規
**------------------------------------------------------------------------------*/
@isTest
public class ShinchokuKanriSearchCtrTest {
    @isTest
    static void testMethod1() {
        PageReference pageRef = Page.ShinchokuKanriSearch;
        Test.setCurrentPage(pageRef);
        
        ShinchokuKanri__c sk = new ShinchokuKanri__c(
            Name            = 'テスト'
            ,Category__c    = '調査'
            ,Naiyo__c       = 'テスト'
            ,StartDate__c   = Date.today()
            ,Status__c      = 'プロジェクト開始前'
            ,KakuninTanto__c= 'テスト タロウ'
            ,RequestDate__c = Date.today()
            ,DueDate__c     = Date.today()
        );
        
        insert sk;
        
        Test.startTest();
        ShinchokuKanriSearchCtr ctr = new ShinchokuKanriSearchCtr();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod2() {
        PageReference pageRef = Page.ShinchokuKanriSearch;
        Test.setCurrentPage(pageRef);
        
        ShinchokuKanri__c sk = new ShinchokuKanri__c(
            Name            = 'テスト'
            ,Category__c    = '調査'
            ,Naiyo__c       = 'テスト'
            ,StartDate__c   = Date.today()
            ,Status__c      = 'プロジェクト開始前'
            ,KakuninTanto__c= 'テスト タロウ'
            ,RequestDate__c = Date.today()
            ,DueDate__c     = Date.today()
        );
        
        insert sk;
        ShinchokuKanriSearchCtr ctr = new ShinchokuKanriSearchCtr();
        
        Test.startTest();
        ctr.searchToday();
        Test.stopTest();
        
    }
    @isTest
    static void testMethod3() {
        PageReference pageRef = Page.ShinchokuKanriSearch;
        Test.setCurrentPage(pageRef);
        
        ShinchokuKanri__c sk = new ShinchokuKanri__c(
            Name            = 'テスト'
            ,Category__c    = '調査'
            ,Naiyo__c       = 'テスト'
            ,StartDate__c   = Date.today()
            ,Status__c      = 'プロジェクト開始前'
            ,KakuninTanto__c= 'テスト タロウ'
            ,RequestDate__c = Date.today()
            ,DueDate__c     = Date.today()
        );
        
        insert sk;
        ShinchokuKanriSearchCtr ctr = new ShinchokuKanriSearchCtr();
        
        Test.startTest();
        ctr.searchMonth();
        Test.stopTest();
        
    }
}