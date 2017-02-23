package cn.ticket.action;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.ticket.entity.Users;
import cn.ticket.service.impl.UserServiceImpl;
import cn.ticket.util.CharacterHandleUtil;
import cn.ticket.util.MailSendUtil;
import cn.ticket.util.ValidateCodeUtil;

/*用户操作*/
@Controller
@RequestMapping("/user")
public class UserAction {

	@Autowired
	private UserServiceImpl useImpl;

	@Autowired
	private PassageInfoAction passInfo;

	/* 登录 */
	@RequestMapping("/login")
	@ResponseBody
	public String login(@RequestParam("u") String u,
			@RequestParam("p") String p, HttpSession session) {

		// u:帐号 p:密码，验证帐户
		Users user = useImpl.findUser(u);
		if (user == null) {

			return (new JSONObject()).toString();
		}
		Boolean flag = user.getPassword().equals(p.trim());

		if (flag) {

			// 验证成功，session保存信息，置空密码(安全)
			user.setPassword("");
			session.setAttribute("user", user);

			return JSONObject.fromObject(user).toString();
		}
		return (new JSONObject()).toString();
	}

	/* 注册 */
	@RequestMapping(value = "/register", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String register(@RequestParam("u") String u,
			@RequestParam("p") String p, @RequestParam("rp") String rp,
			@RequestParam("mail") String mail, HttpSession session)
			throws IOException {
		// u:帐号 p:密码 rp：重复密码 mail:邮箱
		try {
			// 验证两次密码是否一致
			if (p.equals(rp)) {

				Users user = new Users(u, p, 0.0f, mail, "", "");
				// 进行注册
				boolean flag = useImpl.register(user);
				if (flag) {

					// 注册成功，session保存，直接进行自动登录
					user.setPassword("");
					session.setAttribute("user", user);
					return "true";
				}
			}
			return "两次密码不一致";
		} catch (Exception e) {

			return "帐号已存在或服务器异常";

		}
	}

	/* 修改密码 */
	@RequestMapping("/updatePwd")
	@ResponseBody
	public String UpdatePwd(@RequestParam("old_pwd") String old_pwd,
			@RequestParam("new_pwd") String new_pwd,
			@RequestParam("repNew_pwd") String repNew_pwd,
			HttpServletRequest request) throws IOException {

		// 旧密码 新密码 重复新密码
		// 旧密码验证
		Users user = useImpl.findUser(((Users) (request.getSession()
				.getAttribute("user"))).getAccount());

		// 用户登录状态验证，新密码重复新密码进行对比
		if (user != null && new_pwd.equals(repNew_pwd)) {

			boolean flag = user.getPassword().equals(old_pwd);
			if (flag) {

				// 修改密码成功
				user.setPassword(new_pwd);
				boolean f = useImpl.updUser(user);

				return f == true ? "true" : "false";

			}
			return "false";
		}

		return "false";

	}

	/* 验证用户名是否已存在 */
	@RequestMapping("/queryRepeatUser")
	@ResponseBody
	public String queryRepeatAccount(@RequestParam("u") String u,
			HttpSession session) {

		// 判断用户是否存在
		Users user = useImpl.findUser(u);
		if (user != null) {

			session.setAttribute("lookForUserEmail", user.getEmail());
			return "false";
		}

		return "true";

	}

	/* 自动登录(已弃用) */
	@RequestMapping(value = "/autoLogin", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String autoLogin(HttpSession session) {
		Users user = (Users) (session.getAttribute("user"));
		if (user != null) {

			return user.getAccount();
		}
		return "";
	}

	/* 用户登出 */
	@RequestMapping("/logout")
	@ResponseBody
	public void logout(HttpSession session) {

		session.removeAttribute("user");
		session.removeAttribute("code");
		session.removeAttribute("code_time");

	}

	// 验证码验证
	@RequestMapping("/validateCodeSend")
	@ResponseBody
	public void validateCodeSend(HttpSession session) {

		try {
			// 获取邮箱
			String mail = session.getAttribute("lookForUserEmail").toString();

			// 随机生存验证码(ValidateCodeUtil 验证码 工具类)
			String code = ValidateCodeUtil.createCode();
			// 发送邮件
			MailSendUtil.send(mail, code, 1);
			// session保存相关时间，验证码，验证状态
			session.setAttribute("code", code);
			session.setAttribute("code_status", "false");
			session.setAttribute("code_time", new Date().getTime());

		} catch (Exception e) {

		}
	}

	// 验证码验证
	@RequestMapping("/valiCodeJude")
	@ResponseBody
	public String valiCodeJudge(@RequestParam("code") String code,
			HttpSession session) {
		// 前台获取验证码
		if (!code.trim().equals(session.getAttribute("code").toString())) {

			return "false";
		}
		// 验证 包括正确与否 和 是否超时(5分钟内有效)
		Long sub = (new Date().getTime())
				- Long.valueOf(
						String.valueOf(session.getAttribute("code_time") != null ? session
								.getAttribute("code_time").toString() : "0"))
						.longValue();
		if (sub <= 5 * 60 * 1000) {

			session.setAttribute("code_status", "true");
			return "true";
		}

		return "false";
	}

	// 获取用户信息
	@RequestMapping("/getUserInfo")
	@ResponseBody
	public String getUserInfo(@RequestParam("u") String u) {
		try {
			// 通过帐号
			Users user = useImpl.findUser(u);
			user.setPassword("");
			return JSONObject.fromObject(user).toString();
		} catch (Exception e) {

			return (new JSONObject()).toString();
		}
	}

	// 删除用户
	@RequestMapping("/deleteUser")
	@ResponseBody
	public String deleteUser(@RequestParam("u") String u) {

		// 通过帐号
		String info = getUserInfo(u);
		if (info.length() == 2) {

			return "false";
		}
		Boolean flag = useImpl.clearUser(u);

		return flag.toString();
	}

//	更新用户信息
	@RequestMapping("/updUserInfo")
	@ResponseBody
	public String updUserInfo(@RequestParam("email") String email,
			@RequestParam("cardId") String cardId,
			@RequestParam("name") String name, HttpSession session) {

//		通过前台获取用户资料信息，进行更新
		Users user = useImpl.findUser(((Users) (session.getAttribute("user")))
				.getAccount());
		user.setCardId(cardId);
		user.setEmail(email);
		user.setName(name);
		if (passInfo.selectInfoById(cardId) != null) {

			passInfo.deletePassagerInfo(cardId);

		}

//		更新相关乘客信息
		passInfo.addPassagerInfo(cardId, name);

		Boolean flag = useImpl.updUser(user);

		return flag.toString();
	}

//	忘记密码
	@RequestMapping("/forgetPwd")
	@ResponseBody
	public String lookForPassword(@RequestParam("u") String u,
			@RequestParam("p") String p, @RequestParam("rp") String rp,
			HttpSession session) {

		if ((!p.equals(rp))
				|| session.getAttribute("code_status").equals("false")) {

			return "false";
		}

		Users user = useImpl.findUser(u);
		user.setPassword(p);
		Boolean flag = useImpl.updUser(user);

		return flag.toString();

	}
//  获取用户邮箱
	@RequestMapping("/getUserEmail")
	@ResponseBody
	public String getUserEmail(HttpSession session) {

		String email = session.getAttribute("lookForUserEmail").toString();
		email = CharacterHandleUtil.emailEncrypt(email);
		return email;
	}

}
