package cn.ticket.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeCompAndOperUtil {

//	得到指定日期的后x天
	public static String getAppointDay(String date,Integer num) throws ParseException {

		SimpleDateFormat simp = new SimpleDateFormat("yyyy-MM-dd");
		Date d = simp.parse(date);
		Long m = d.getTime() + num*24 * 60 * 60 * 1000;
		d.setTime(m);

		return simp.format(d);
	}
	
//	日期 时间 获取 对比
	public static boolean timeCompare(String date, String time) throws ParseException{
		
		SimpleDateFormat simp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date d = simp.parse(date+" "+time+":00");
		Long sub = d.getTime() - (new Date()).getTime();
		
		return sub>60*60*1000;
	}
}
