package cn.ticket.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class TodayDateUtil {

	private static Calendar cal;
	private static SimpleDateFormat simple;

//	获取当前时间戳
	public static Long getTime() {

		cal = Calendar.getInstance();
		cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTimeInMillis();
	}

//	获取时间戳之差
	public static Long getTimeSub(String time) throws ParseException {

		simple = new SimpleDateFormat("HH:mm");
		long t1 = simple.parse("9:53").getTime() + 8 * 3600 * 1000;
		long t2 = new Date().getTime() - TodayDateUtil.getTime();
		return t1 - t2;
	}

//	获取今天的日期字串
	public static String getTodayDate() {

		simple = new SimpleDateFormat("yyyy-MM-dd");

		return simple.format(new Date());

	}
}
