package cn.ticket.action;

import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.ticket.entity.Orders;
import cn.ticket.entity.Users;
import cn.ticket.service.OrderService;

//订单相关控制层
@Controller
@RequestMapping("/order")
public class OrderAction {

	// spring注入订单service
	@Autowired
	private OrderService service;

	// spring注入票务相关action
	@Autowired
	private TicketAction tAction;

	// 新建静态变量 pagecache作为缓存
	static int pageCache;

	// 创建订单(当票被购买后，直接调用该方法进行订单创建)
	public String createOrder(String trainsNum, Integer seatNum,
			Float totalPrice, String customId, String customName,
			String account, String departPlace, String destination,
			String date, String departTime, Integer ticketBarrier) {
		try {
			/*
			 * Calendar calendar = Calendar.getInstance(); String date = "" +
			 * calendar.get(Calendar.YEAR) + "-" + calendar.get(Calendar.MONTH)
			 * + "-" + calendar.get(Calendar.DAY_OF_MONTH);
			 */
			// 通过订单相关参数进行创建
			Boolean flag = service.createOrder(new Orders(trainsNum, seatNum,
					totalPrice, customId, account, customName, date, 1,
					departPlace, destination, departTime, ticketBarrier));

			return flag.toString();
		} catch (Exception e) {
			// System.out.println(e);
			// System.out.println("账单添加异常...");
			return "false";
		}
	}

	// 通过订单号进行查找相关订单信息
	@RequestMapping(value = "/selectByOrderNum", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectByOrderNum(@RequestParam("orderNum") Long orderNum) {

		try {
			Orders order = service.selectByOrderNum(orderNum);

			return JSONObject.fromObject(order).toString();
		} catch (Exception e) {

			// System.out.println("查询账单异常...");
			return new JSONObject().toString();
		}
	}

	// 查询订单列表
	@RequestMapping(value = "/selectOrderList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectOrderList(@RequestParam("date") String date,
			@RequestParam("page") Integer page) {

		// 通过指定日期与页数进行查找订单列表，获取List转换为JSON数组返回前台
		List<Orders> list = service.selectOrderList(date,
				Long.parseLong("" + (page - 1) * 8));

		return JSONArray.fromObject(list).toString();
	}

	// 获取有效(根据需求)订单页数
	@RequestMapping("/getOrderNum")
	@ResponseBody
	public String getPageNum(@RequestParam("date") String date) {

		// 通过指定日期 查出订单总数
		Long num = service.getOrderNum(date);
		// 每页8条，返回页数
		if (num % 8 > 0) {
			return "" + ((num / 8) + 1);
		}

		return "" + num / 8;
	}

	// 通过帐号查询订单页数
	@RequestMapping("/getUserPageNum")
	@ResponseBody
	public String getUserPageNum(@RequestParam("account") String account,
			HttpSession session) {

		if (account == "") {

			account = ((Users) session.getAttribute("user")).getAccount();
		}
		// 每页7条，返回订单页数
		Long num = service.selectByNeedCount(account);
		if (num % 7 > 0) {

			/*
			 * session.setAttribute("myOrderPageNum", new String("" + ((num / 7)
			 * + 1)));
			 */
			return "" + ((num / 7) + 1);
		}

		/* session.setAttribute("myOrderPageNum", new String("" + num / 7)); */
		return "" + num / 7;
	}

	// 根据帐号，页数 获取订单列表
	@RequestMapping(value = "/selectByNeed", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectByNeed(@RequestParam("account") String account,
			@RequestParam("page") Integer page, HttpSession session) {

		try {
			if (account == "" || account == null) {

				account = ((Users) session.getAttribute("user")).getAccount();
			}
			if (page == 0) {

				// 如果page没有获取到，拿出缓存page
				page = pageCache;
			} else {
				// 缓存page
				pageCache = page;
			}
			// 每页7条，获取List-->Json数组 返回前台页面
			List<Orders> list = service.selectByNeed(account,
					Long.parseLong("" + (page - 1) * 7));
			return JSONArray.fromObject(list).toString();
		} catch (Exception e) {

			// System.out.println("查询账单列表异常...");
			return new JSONArray().toString();
		}
	}

	// 查询自己账户的相关订单
	@RequestMapping(value = "/selectMyOrder", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectMyOrder(@RequestParam("page") Integer page,
			HttpSession session) {

		try {
			// 从session中取得帐号
			String account = ((Users) session.getAttribute("user"))
					.getAccount();
			// 获取List-->JSON数组返回前台
			List<Orders> list = service.selectByNeed(account,
					Long.parseLong("" + (page - 1) * 7));
			// session.setAttribute("myOrderList", list);

			return JSONArray.fromObject(list).toString();
		} catch (Exception e) {

			// System.out.println("查询账单列表异常...");
			return new JSONArray().toString();
		}
	}

	// 通过订单状态查询我的订单页数(订单状态:已购买和已退订)
	@RequestMapping("/selectByStatusCount")
	@ResponseBody
	public String selectByStatusCount(@RequestParam("status") String status,
			HttpSession session) {

		try {
			// 通过status字段进行查找List,返回页数
			Long count = service.selectByStatusCount(
					((Users) session.getAttribute("user")).getAccount(),
					Integer.parseInt(status));

			if (count % 7 > 0) {

				/*
				 * if (status == "1") {
				 * 
				 * session.setAttribute("myOrderStatusPageNum_1", new String(""
				 * + ((count / 7) + 1)));
				 * 
				 * } else {
				 * 
				 * session.setAttribute("myOrderStatusPageNum_2", new String(""
				 * + ((count / 7) + 1)));
				 * 
				 * }
				 */
				return "" + ((count / 7) + 1);
			}
			/*
			 * if (status == "1") {
			 * 
			 * session.setAttribute("myOrderStatusPageNum_1", new String("" +
			 * count / 7)); } else {
			 * 
			 * session.setAttribute("myOrderStatusPageNum_2", new String("" +
			 * count / 7)); }
			 */
			return "" + count / 7;
		} catch (Exception e) {

			return "";
		}

	}

	// 通过订单状态查询我的订单具体列表
	@RequestMapping(value = "/selectOrderListByStatus", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectOrderListByStatus(
			@RequestParam("status") Integer status,
			@RequestParam("page") Integer page, HttpSession session) {

		// 获取status:订单状态 page:页数
		try {
			// 获取List-->JSON数组 返回前台
			List<Orders> list = service.selectOrderListByStatus(
					((Users) session.getAttribute("user")).getAccount(),
					Long.parseLong("" + (page - 1) * 7), status);

			return JSONArray.fromObject(list).toString();

		} catch (Exception e) {

			// System.out.println("查询账单列表异常...");
			// System.out.println(e);
			return new JSONArray().toString();

		}

	}

	// 退票
	@RequestMapping("/refunTicket")
	@ResponseBody
	public String refunfTicket(@RequestParam("orderNum") Long orderNum) {
		try {
			// 通过订单号获取相关车票的id
			Orders order = service.selectByOrderNum(orderNum);

			// 通过车票id获取相关票务 信息-->退票（票的余量+1，退票是有要求的，只允许发车前1小时之前退票）
			boolean flag = tAction.refunfTicket(tAction.queryForId(
					order.getTrainsNum(), order.getDate(),
					order.getDepartTime()), order.getSeatNum());

			if (flag) {
				// 更新订单状态 2-->已退票
				return service.updateStatus(orderNum, 2).toString();
			}
			return "false";
		} catch (Exception e) {

			// System.out.println("退票账单异常...");
			return "false";
		}
	}

	// 用户删除订单
	@RequestMapping("/deleteOrder")
	@ResponseBody
	public String deleteOrder(@RequestParam("orderNum") Long orderNum,
			HttpSession session) {

		// 通过订单id删除订单
		Boolean flag = service.deleteOrder(orderNum);
		// 更新前台订单列表，重新显示，调用page缓存的页数
		selectByNeed(null, 0, session);

		return flag.toString();

	}
}
