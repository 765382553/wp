package cn.ticket.action;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.ticket.entity.Admins;
import cn.ticket.service.impl.AdminServiceImpl;

/*管理员信息相关控制层*/
@Controller
@RequestMapping("/admin")
public class AdminAction {

//	spring初始化后ioc容器注入service Bean
	@Autowired
	private AdminServiceImpl aImpl;

//	 登录
	@RequestMapping("/login")
	@ResponseBody
	public String login(@RequestParam("u") String u,
			@RequestParam("p") String p, HttpSession session) {
//       通过获取前台传入 u：帐号 p:密码 来进行验证
		boolean flag = aImpl.login(u, p);

		if (flag) {
//        验证成功，session放入帐户信息，并返回true 
			session.setAttribute("admin", aImpl.getAdminInfo(u));
			return "true";
		}
		return "false";
	}

//	检测登录状态
	@RequestMapping("/getLoginStatus")
	@ResponseBody
	public String getLoginStatus(HttpSession session) {

//		通过检测session里的字段是否存在来检测登录状态，避免越权操作
		Admins adminObj = ((Admins) (session.getAttribute("admin")));
		return adminObj == null ? "" : adminObj.getAccount();

	}

//	更改管理员信息
	@RequestMapping("/updAdminsInfo")
	@ResponseBody
	public String updAdminsInfo(@RequestParam("id") Integer id,
			@RequestParam("account") String account,
			@RequestParam("password") String password,
			@RequestParam("email") String email,
			@RequestParam("address") String address) {

//		通过前台传入管理员表的相关信息来更新信息
		
		Boolean flag = aImpl.updAdminInfo(new Admins(id, account, password,
				email, address));
		return flag.toString();
	}

//	登出
	@RequestMapping("/logout")
	public void logout(HttpSession session) {

//  移除session内字段
		session.removeAttribute("admin");

	}

}
