package cn.ticket.action;

import java.io.UnsupportedEncodingException;
import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.ticket.entity.Back;
import cn.ticket.service.impl.BackServiceImpl;
import cn.ticket.util.MailSendUtil;
import cn.ticket.util.TodayDateUtil;

// 反馈信息相关控制层
@Controller
@RequestMapping("/back")
public class BackAction {

//	spring 注入 service Bean
	@Autowired
	private BackServiceImpl service;

	
//	添加反馈信息
	@RequestMapping("/addBackInfo")
	@ResponseBody
	public String addBackInfo(@RequestParam("name") String name,
			@RequestParam("email") String email,
			@RequestParam("content") String content) {

//		前台传入 name:姓名  email:联系邮箱  content: 反馈内容 进行添加操作
		Boolean flag = service.addBackInfo(new Back(name, email, content,
				TodayDateUtil.getTodayDate()));

		return flag.toString();
	}

//	获取符合要求反馈表的条页数 (3天以内，未回复)
	@RequestMapping("/getNum")
	@ResponseBody
	public String getNum() {

//		获取数据库中满足要求记录数
		Long num = service.getNum();
		
		if(num==null){
			
			return "0";
		}
//		每页5条记录，返回页数
		num = ((num-1)/5)+1;
		return num.toString();
	}

//	获取指定页数的List,记录列表
	@RequestMapping(value = "/getList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String getList(@RequestParam("page") Integer page) {

//		通过指定页数查询
		List<Back> list = service.getBackList(Long.parseLong(""
				+ (5 * (page - 1))));

		return JSONArray.fromObject(list).toString();
	}

//	删除反馈表信息
	@RequestMapping("/delBackInfo")
	@ResponseBody
	public String delBackInfo(@RequestParam("id") Integer id) {

//		通过id删除
		Boolean flag = service.delBackInfo(id);

		return flag.toString();
	}

//	回复
	@RequestMapping("/reply")
	@ResponseBody
	public void reply(@RequestParam("id") Integer id,
			@RequestParam("email") String email,
			@RequestParam("content") String content) {

//		回复反馈人的信息 通过相关 id,email,content(回复的信息)
		try {
//			指定邮箱，将内容发送
			MailSendUtil.send(email.trim(), content.trim(), 2);
//			通过id 查询到该条反馈信息，并将之状态进行修改(1为已处理)
			Back back = service.selectBackInfo(id);
			back.setStatus(1);
			service.updBackInfo(back);

		} catch (UnsupportedEncodingException e) {

			// e.printStackTrace();
		}
	}
}
