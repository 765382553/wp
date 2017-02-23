package cn.ticket.util;

public class ValidateCodeUtil {

//	生存验证码(6位数随机验证码)
	public static String createCode() {

		String code = "";
		for (int i = 0; i < 6; i++) {

			code += (int) (Math.random() * 10);
		}

		return code;

	}
}
