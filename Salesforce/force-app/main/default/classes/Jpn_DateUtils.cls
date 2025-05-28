/**
 * Dateクラスに祝日判定を入れたUtilsクラス
 **/
public with sharing class Jpn_DateUtils {

    /**
     * 「YYYY年MM月dd日（）」のフォーマットに沿った文字列を返す
     *
     * @params Log val エポック秒
     * @return String 文字列
     **/
    public static String getFormatText(Long val) {
        return getFormatText(Datetime.newInstance(val));
    }

    /**
     * 「YYYY年MM月dd日（）」のフォーマットに沿った文字列を返す
     *
     * @params Datetime dt 日付
     * @return String 文字列
     **/
    public static String getFormatText(Datetime dt) {
        return dt.format('yyyy年MM月dd日(' + getDayOfWeekString(dt.date()) + ') ', 'Asia/Tokyo');
    }

    /**
     * 「YYYY年MM月dd日（）」のフォーマットに沿った文字列を返す
     *
     * @params Date d 日付
     * @return String 文字列
     **/
    public static String getFormatText(Date d) {
        return Datetime.newInstance(d.year(), d.month(), d.day()).format('yyyy年MM月dd日(' + getDayOfWeekString(d) + ')', 'Asia/Tokyo');
    }

    /**
     * 祝日の名称を返す
     *
     * @params Date d 日付
     * @return String 祝日名
     */
    public static String getHolidayText(Date d) {
        String text = getFixedHolidayText(d);
        text = text == null ? getHappyMondayText(d) : text;
        text = isSpringHoliday(d) ? '春分の日' : text;
        text = isAutumnHoliday(d) ? '秋分の日' : text;
        text = (text == null && isNationalHoliday(d)) ? '国民の祝日' : text;
        text = isTransferHoliday(d) ? '振替休日' : text;

        return text;
    }

    /**
     * 祝日の名称を返す
     *
     * @params Log val エポック秒
     * @return String 祝日名
     */
    public static String getHolidayText(Long val) {
        Date d = Datetime.newInstance(val).date();
        return getHolidayText(d);
    }

    /**
     * （振替休日と国民の休日を含んだ）祝日かどうか
     *
     * @params Date d 調べたい日付
     * @return boolean true:祝日 / false:祝日ではない
     **/
    public static boolean isHoliday(Date d) {
        return checkHoliday(d) || isTransferHoliday(d) || isNationalHoliday(d);
    }

    /**
     * 指定された日付の曜日を文字列（短縮１文字）で返す
     *
     * @params Date d 調べたい日付
     * @return boolean 日曜日:日 / 月曜日:月 / ... / 土曜日:土
     **/
    public static String getDayOfWeekString(Date d) {
        switch on getDayOfWeek(d) {
            when 1 {
                return '月';
            }
            when 2 {
                return '火';
            }
            when 3 {
                return '水';
            }
            when 4 {
                return '木';
            }
            when 5 {
                return '金';
            }
            when 6 {
                return '土';
            }
            when else {
                return '日';
            }
        }

    }

    /**
     * （振替休日と国民の休日を含んでいない）祝日かどうか
     *
     * @params Date d 調べたい日付
     * @return boolean true:祝日 / false:祝日ではない
     **/
    @TestVisible
    private static boolean checkHoliday(Date d) {
        return isFixedHoliday(d) || isSpringHoliday(d) || isAutumnHoliday(d) || isHappyMonday(d);
    }

    /**
     * 国民の休日かどうか
     *
     * @see https://www8.cao.go.jp/chosei/shukujitsu/gaiyou.html
     * @params Date d 調べたい日付
     * @return boolean true:国民の休日 / false:国民の休日ではない
     **/
    @TestVisible
    private static boolean isNationalHoliday(Date d) {
        Date yesterday = d - 1;
        Date tomorrow = d + 1;

        return checkHoliday(yesterday) && checkHoliday(tomorrow) && !new List<Integer> {0, 6}.contains(getDayOfWeek(d));
    }

    /**
     * 振替休日かどうか
     *
     * @params Date d 調べたい日付
     * @return boolean true:振替休日 / false:振替休日ではない
     **/
    @TestVisible
    private static boolean isTransferHoliday(Date d) {
        // 当日が祝日または日曜日ならfalse
        if (checkHoliday(d) || getDayOfWeek(d) == 0) {
            return false;
        }

        Date yesterday = d - 1;
        for (Integer i = getDayOfWeek(d); i >= 0; i--) {
            if (!checkHoliday(yesterday)) {
                return false;
            } else if (getDayOfWeek(yesterday) == 0) {
                return true;
            }
            yesterday = yesterday - 1;
        }

        return false;
    }

    /**
     * 固定祝日を取得する
     *
     * @params Date d 調べたい日付
     * @return boolean 固定休日
     **/
    private static String getFixedHolidayText(Date d) {
        Integer year  = d.year();
        Integer month = d.month();
        Integer day   = d.day();
        List<List<String> > holiday  = new List<List<String> > {
            //                             月 日 開始年 終了年
            new List<String> {'1', '1',  '1949', '9999', '元旦'},
            new List<String> {'2', '11', '1967', '9999', '建国記念の日'},
            new List<String> {'2', '23', '2020', '9999', '天皇誕生日'},
            new List<String> {'4', '29', '2007', '9999', '昭和の日'},
            new List<String> {'5', '3',  '1949', '9999', '憲法記念日'},
            new List<String> {'5', '4',  '2007', '9999', 'みどりの日'},
            new List<String> {'5', '5', '1949', '9999', 'こどもの日'},
            new List<String> {'8', '11', '2021', '9999', '山の日'},
            new List<String> {'11','3',  '1948', '9999', '文化の日'},
            new List<String> {'11','23', '1948', '9999', '勤労感謝の日'},
            // 以下、指定した年月日のみの祝日
            new List<String> {'5', '1', '2019', '2019', '新天皇即位日'},
            new List<String> {'10', '22', '2019', '2019', '即位礼正殿の儀'},
            new List<String> {'7', '24', '2020', '2020', 'スポーツの日'},
            new List<String> {'8', '11', '2016', '2019', '山の日'},
            new List<String> {'8', '10', '2020', '2020', '山の日'}
        };

        for (List<String> variable : holiday) {
            if (month == Integer.valueOf(variable[0]) && day == Integer.valueOf(variable[1]) && year >= Integer.valueOf(variable[2]) && year <= Integer.valueOf(variable[3])) {
                return variable[4];
            }
        }

        return null;
    }

    /**
     * 固定祝日かどうか
     *
     * @params Date d 調べたい日付
     * @return boolean true:固定休日 / false:固定休日ではない
     **/
    @TestVisible
    private static boolean isFixedHoliday(Date d) {
        Integer year = d.year();
        Integer month = d.month();
        Integer day = d.day();
        List<List<Integer> > holiday  = new List<List<Integer> > {
            //                             月 日 開始年 終了年
            new List<Integer> {1, 1, 1949, 9999},    // 元旦
            new List<Integer> {2, 11, 1967, 9999},   // 建国記念の日
            new List<Integer> {2, 23, 2020, 9999},   // 天皇誕生日
            new List<Integer> {4, 29, 2007, 9999},   // 昭和の日
            new List<Integer> {5, 3, 1949, 9999},    // 憲法記念日
            new List<Integer> {5, 4, 2007, 9999},    // みどりの日
            new List<Integer> {5, 5, 1949, 9999},    // こどもの日
            new List<Integer> {8, 11, 2021, 9999},   // 山の日
            new List<Integer> {11, 3, 1948, 9999},   // 文化の日
            new List<Integer> {11, 23, 1948, 9999},  // 勤労感謝の日
            // 以下、指定した年月日のみの祝日
            new List<Integer> {5, 1, 2019, 2019},    // 新天皇即位日
            new List<Integer> {10, 22, 2019, 2019},  // 即位礼正殿の儀
            new List<Integer> {7, 24, 2020, 2020},   // スポーツの日
            new List<Integer> {8, 11, 2016, 2019},   // 山の日
            new List<Integer> {8, 10, 2020, 2020}    // 山の日
        };

        for (List<Integer> variable : holiday) {
            if (month == variable[0] && day == variable[1] && year >= variable[2] && year <= variable[3]) {
                return true;
            }
        }

        return false;
    }

    /**
     * ハッピーマンデーを取得する
     *
     * @params Date d 調べたい日付
     * @return boolean ハッピーマンデー
     **/
    private static String getHappyMondayText(Date d) {
        Integer year = d.year();
        Integer month = d.month();
        Integer day = d.day();
        List<List<String> > holiday  = new List<List<String> > {
            //                             月 第N曜日 開始年 終了年
            new List<String> {'1', '2', '2000', '9999', '成人の日'},
            new List<String> {'7', '3', '2003', '2019', '海の日'},
            new List<String> {'7', '3', '2021', '9999', '海の日'},
            new List<String> {'9', '3', '2003', '9999', '敬老の日'},
            new List<String> {'10', '2', '2000', '2019', '体育の日'},
            new List<String> {'10', '2', '2021', '9999', 'スポーツの日'}
        };

        Integer dow = getDayOfWeek(Date.newInstance(year, month, 1));
        Integer mondayOfWeek = 1;
        Integer happyDay = mondayOfWeek - dow < 0 ? 7 + mondayOfWeek - dow : mondayOfWeek - dow;
        happyDay++;

        for (List<String> variable : holiday) {
            if (month == Integer.valueOf(variable[0])  && year >= Integer.valueOf(variable[2]) && year <= Integer.valueOf(variable[3])) {
                happyDay = happyDay + 7 * (Integer.valueOf(variable[1]) - 1);
                if (happyDay == day) {
                    return variable[4];
                }
            }
        }

        return null;
    }

    /**
     * ハッピーマンデーかどうか
     *
     * @params Date d 調べたい日付
     * @return boolean true:ハッピーマンデー / false:ハッピーマンデーではない
     **/
    @TestVisible
    private static boolean isHappyMonday(Date d) {
        Integer year = d.year();
        Integer month = d.month();
        Integer day = d.day();
        List<List<Integer> > holiday  = new List<List<Integer> > {
            //                             月 第N曜日 開始年 終了年
            new List<Integer> {1, 2, 2000, 9999}, // 成人の日
            new List<Integer> {7, 3, 2003, 2019}, // 海の日
            new List<Integer> {7, 3, 2021, 9999}, // 海の日
            new List<Integer> {9, 3, 2003, 9999}, // 敬老の日
            new List<Integer> {10, 2, 2000, 2019}, // 体育の日
            new List<Integer> {10, 2, 2021, 9999} // スポーツの日
        };

        Integer dow = getDayOfWeek(Date.newInstance(year, month, 1));
        Integer mondayOfWeek = 1;
        Integer happyDay = mondayOfWeek - dow < 0 ? 7 + mondayOfWeek - dow : mondayOfWeek - dow;
        happyDay++;

        for (List<Integer> variable : holiday) {
            if (month == variable[0]  && year >= variable[2] && year <= variable[3]) {
                happyDay = happyDay + 7 * (variable[1] - 1);
                if (happyDay == day) {
                    return true;
                }
            }
        }

        return false;
    }

    /**
     * 指定された日付の曜日を数値で返す
     *
     * @params Date d 調べたい日付
     * @return boolean 0:日曜日 / 1:月曜日 / ... / 6:土曜日
     **/
    @TestVisible
    private static Integer getDayOfWeek(Date d) {
        Date base = Date.newInstance(1900, 1, 7);
        Integer days = base.daysBetween(d);
        return Math.mod(days, 7);
    }

    /**
     * 春分の日かどうか
     *
     * @params Date d 調べたい日付
     * @return boolean true:春分の日 / false:春分の日ではない
     **/
    @TestVisible
    private static boolean isSpringHoliday(Date d) {
        return d.month() == 3 && d.day() == checkFourSeasons(20.8431, d.year());
    }

    /**
     * 秋分の日かどうか
     *
     * @params Date d 調べたい日付
     * @return boolean true:秋分の日 / false:秋分の日ではない
     **/
    @TestVisible
    private static boolean isAutumnHoliday(Date d) {
        return d.month() == 9 && d.day() == checkFourSeasons(23.2488, d.year());
    }

    /**
     * 指定された年の春分／秋分の日を求める
     * @params Decimal d 係数
     * @params Integer year 年
     * @return 日
     **/
    private static Decimal checkFourSeasons(Decimal d, Integer year) {
        return Math.floor(d + 0.242194 * (year - 1980) - Math.floor((year - 1980) / 4));
    }

}