package cn.ticket.util;

public class CharacterHandleUtil {

//	前台隐藏email部分信息
	public static String emailEncrypt(String mail) {

		String as = mail.substring(0, 3);
		String bs = mail.substring(mail.length() - 3);

		return as + "*******" + bs;
	}

}
