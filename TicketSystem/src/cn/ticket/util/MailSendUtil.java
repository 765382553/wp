package cn.ticket.util;

import java.io.UnsupportedEncodingException;

import javax.mail.internet.MimeUtility;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;

public class MailSendUtil {

//	指定接收信箱，内容与 邮箱发送原因(1-->验证码，2-->反馈)
	public static void send(String address, String text, Integer x)
			throws UnsupportedEncodingException {
//邮箱帐号 ticketsystemtestu	密码 ticketsystemp
		JavaMailSenderImpl simpl = new JavaMailSenderImpl();
		simpl.setHost("smtp.163.com");
		simpl.setPort(25);
		simpl.setUsername("ticketsystemtestu@163.com");
		simpl.setPassword("ticketsystem110");

		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(address);
		String name = MimeUtility.encodeText("spped");
		message.setFrom(name + " <ticketsystemtestu@163.com>");
		if (x == 1) {

			message.setSubject("验证码");
			message.setText("您的验证码为:" + text + "  ,(5分钟内有效。)");

		} else if (x == 2) {

			message.setSubject("反馈回复");
			message.setText(text);
		}
		simpl.send(message);
	}

}
