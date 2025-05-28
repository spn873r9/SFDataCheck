/**------------------------------------------------------------------------------
 * クラス名：
 * 概要    ：
 *           
 *
 * 改版履歴：yyyy/MM/dd （作成者）：（修正概要）
**------------------------------------------------------------------------------*/
@IsTest 
public class Jpn_DateUtilsTest{
    @IsTest 
    public static void test1() {
        Test.StartTest();
        
        Jpn_DateUtils.getFormatText(1);
        
        Test.StopTest();
    }
    @IsTest 
    public static void test2() {
        Test.StartTest();
        
        Jpn_DateUtils.getFormatText(Datetime.now());
        
        Test.StopTest();
    }
    @IsTest 
    public static void test3() {
        Test.StartTest();
        
        Jpn_DateUtils.getFormatText(Date.today());
        
        Test.StopTest();
    }
    @IsTest 
    public static void test4() {
        Test.StartTest();
        
        Jpn_DateUtils.getHolidayText(Date.today());
        
        Test.StopTest();
    }
    @IsTest 
    public static void test5() {
        Test.StartTest();
        
        Jpn_DateUtils.getHolidayText(1);
        
        Test.StopTest();
    }
    @IsTest 
    public static void test6() {
        Test.StartTest();
        
        Jpn_DateUtils.isHoliday(Date.today());
        
        Test.StopTest();
    }
    @IsTest 
    public static void test7() {
        Test.StartTest();
        
        Jpn_DateUtils.getDayOfWeekString(Date.today());
        
        Test.StopTest();
    }
    @IsTest 
    public static void test8() {
        Test.StartTest();
        
        Jpn_DateUtils.checkHoliday(Date.today());
        
        Test.StopTest();
    }
    @IsTest 
    public static void test9() {
        Test.StartTest();
        
        Jpn_DateUtils.isTransferHoliday(Date.today());
        
        Test.StopTest();
    }
    @IsTest 
    public static void test10() {
        Test.StartTest();
        
        Jpn_DateUtils.isFixedHoliday(Date.today());
        
        Test.StopTest();
    }
    @IsTest 
    public static void test11() {
        Test.StartTest();
        
        Jpn_DateUtils.isHappyMonday(Date.today());
        
        Test.StopTest();
    }
}