package cn.ticket.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.ticket.entity.PassagerInfo;
import cn.ticket.service.impl.PassagerInfoServiceImpl;

//乘客信息控制层
@Controller
@RequestMapping("/passager")
public class PassageInfoAction {

//	spring注入service
	@Autowired
	private PassagerInfoServiceImpl psImpl;

//	添加乘客信息
	@RequestMapping("/addPassagerInfo")
	@ResponseBody
	public String addPassagerInfo(@RequestParam("Id") String Id,
			@RequestParam("name") String name) {

//		id:身份证 ,name:姓名
		Boolean flag = psImpl.addInfo(new PassagerInfo(Id, name));

		return flag.toString();
	}

//	删除乘客信息
	@RequestMapping("/deletePassagerInfo")
	@ResponseBody
	public String deletePassagerInfo(@RequestParam("Id") String Id) {

//		通过身份证号
		Boolean flag = psImpl.deleteInfo(Id);

		return flag.toString();
	}

//	查询相关乘客信息(通过身份证)
	public PassagerInfo selectInfoById(String Id) {

		PassagerInfo info = psImpl.selectInfoById(Id);

		return info;
	}
}
