package cn.ticket.action;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.ticket.entity.Notice;
import cn.ticket.service.impl.NoticeServiceImpl;

// 公告信息表控制层
@Controller
@RequestMapping("/notice")
public class NoticeAction {

//	spring注入service
	@Autowired
	private NoticeServiceImpl sImpl;

//	新增公告
	@RequestMapping("/addNioticeMessage")
	@ResponseBody
	public String addMessage(@RequestParam("content") String content) {

//		前台获取内容直接添加
		Boolean flag = sImpl.addAnnouncement(content);

		return flag.toString();
	}

//	删除公告
	@RequestMapping("/delNoticeMessage")
	@ResponseBody
	public String delMessage(@RequestParam("id") Integer id) {

//		通过id
		Boolean flag = sImpl.deleteAnnouncement(id);

		return flag.toString();
	}

//	更新公告
	@RequestMapping("/updNoticeMessage")
	@ResponseBody
	public String updMessage(@RequestParam("id") Integer id,
			@RequestParam("content") String content) {

//		通过id ,content 
		Boolean flag = sImpl.updAnnouncement(id, content);

		return flag.toString();
	}

	
//	查询公告
	@RequestMapping(value="/selNoticeMessage", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selMessage(@RequestParam("id") Integer id) {

//		通过id获取公告 转换为json返回前台页面
		Notice notice = sImpl.selectById(id);

		return JSONObject.fromObject(notice).toString();
	}

//	获取公告列表
	@RequestMapping(value="/selNoticeList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selMessageList() {

//		直接获取公告列表，封装成List,转换为JSON数组返回前台页面
		List<Notice> list = sImpl.selectAllNoticeList();

		return JSONArray.fromObject(list).toString();
	}
}
