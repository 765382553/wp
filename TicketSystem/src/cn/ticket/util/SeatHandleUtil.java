package cn.ticket.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

public class SeatHandleUtil {

	public static Integer temp;

//	初始化剩余座位信息
	public static String init(int sum) {

		List<Integer> list = new ArrayList<Integer>();

		for (int i = sum; i > 0; i--) {

			list.add(i);

		}
		return list.toString();
	}

//	购票成功，删除随机座位信息
	public static String subSeatNum(String s) {

		SeatHandleUtil.temp = null;
		String s1 = s.substring(1, s.length() - 1);
		ArrayList<String> list = new ArrayList<String>(Arrays.asList(s1
				.split(",")));
		Random random = new Random();
		int i = random.nextInt(list.size());
		SeatHandleUtil.temp = Integer.parseInt(list.get(i).trim());
		list.remove(i);
		return list.toString().replace(" ", "");

	}

//	退票，添加座位到座位列表中
	public static String addSeatNum(String s, Integer seat) {

		s = s.replace(" ", "");
		s = s.replace("[", "[" + seat + ",");
		return s;
	}

}
