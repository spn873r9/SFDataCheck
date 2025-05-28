/**------------------------------------------------------------------------------
 * クラス名：
 * 概要    ：
 *           
 *
 * 改版履歴：yyyy/MM/dd （作成者）：（修正概要）
**------------------------------------------------------------------------------*/
@IsTest 
public class CommonUtilTest{
    @IsTest 
    public static void test1() {
        Test.StartTest();
        
        CommonUtil.mathTextTime('09:00' , '19:00' ,'01:00');
        CommonUtil.mathTextTime('09:00' , '19:30' ,'01:00');
        CommonUtil.mathTextTime('09:30' , '19:00' ,'01:00');
        CommonUtil.mathTextTime('20:30' , '09:00' ,'01:00');
        CommonUtil.mathTextTime('09:00' , '09:00' ,'00:00');
        
        Test.StopTest();
    }
    @IsTest 
    public static void test2() {
        Test.StartTest();
        
        CommonUtil.mathIntTime('09:00' , '19:00');
        CommonUtil.mathIntTime('09:00' , '19:30');
        CommonUtil.mathIntTime('09:30' , '19:00');
        CommonUtil.mathIntTime('20:00' , '09:00');
        CommonUtil.mathIntTime('09:00' , '09:00');
        
        Test.StopTest();
    }
    @IsTest 
    public static void test3() {
        Test.StartTest();
        
        CommonUtil.mathParseIntTime((double)2.5);
        
        Test.StopTest();
    }
    @IsTest 
    public static void test4() {
        Test.StartTest();
        
        CommonUtil.mathParseStringTime('10:30');
        
        Test.StopTest();
    }
    @IsTest 
    public static void test5() {
        Test.StartTest();
        
        CommonUtil.checkWorkTime('09:00' , '19:00', '12:00' , '13:00');
        
        Test.StopTest();
    }
}