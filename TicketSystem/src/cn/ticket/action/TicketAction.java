package cn.ticket.action;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.ticket.entity.Tickets;
import cn.ticket.entity.Users;
import cn.ticket.service.impl.TicketServiceImpl;
import cn.ticket.util.SeatHandleUtil;
import cn.ticket.util.TimeCompAndOperUtil;
import cn.ticket.util.TodayDateUtil;

//票务相关控制层
@Controller
@RequestMapping("/ticket")
public class TicketAction {

	// 注入相关serice与action

	@Autowired
	private TicketServiceImpl service;

	@Autowired
	private OrderAction orderAction;

	@Autowired
	private PassageInfoAction pAction;

	// 添加票务信息
	@RequestMapping("/addTicket")
	@ResponseBody
	public String addTicket(@RequestParam("trainsNum") String trainsNum,
			@RequestParam("busType") Integer busType,
			@RequestParam("departPlace") String departPlace,
			@RequestParam("destination") String destination,
			@RequestParam("departureTime") String departureTime,
			@RequestParam("ticketPrice") Float ticketPrice,
			@RequestParam("count") Integer count,
			@RequestParam("ticketBarrier") Integer ticketBarrier,
			@RequestParam("date") String date) {

		// 初始化剩余座位信息
		String list = SeatHandleUtil.init(count);
		try {
			// 添加
			Boolean flag = service.addTicket(new Tickets(trainsNum, busType,
					departPlace, destination, departureTime, ticketPrice,
					count, ticketBarrier, list, date));
			// 判断常规与加班票
			if (busType == 1 && flag) {
				// 常规票，自动循环添加当前date之后后6天的票（常规票一次性添加7天的票）
				for (int i = 0; i <= 5; i++) {
					date = TimeCompAndOperUtil.getAppointDay(date, 1);

					service.addTicket(new Tickets(trainsNum, busType,
							departPlace, destination, departureTime,
							ticketPrice, count, ticketBarrier, list, date));

				}

			}
			return flag.toString();
		} catch (Exception e) {

			// System.out.println("置票异常....");

			return "false";
		}

	}

	// 删除车辆相关所有的票
	@RequestMapping("/deleteTicket")
	@ResponseBody
	public String deleteTicket(@RequestParam("trainsNum") String trainsNum) {

		try {
			// 通过车次号删除相关票
			Boolean flag = service.deleteTicket(trainsNum);
			return flag.toString();

		} catch (Exception e) {

			// System.out.println("删除票异常...");
			return "false";
		}
	}

	// 通过出发地 目的地【可为空（管理员可用）】 日期 来查询相关信息信息列表
	@RequestMapping(value = "/selectByNeed", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectByNeed(@RequestParam("departPlace") String departPlace,
			@RequestParam("destination") String destination,
			@RequestParam("date") String date, HttpSession session) {
		try {
			// 获取日期
			SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd");
			// 判断是否满足日期要求[不能查询今天之前的票，不能查询7天（包含今天）以后的票]
			Long sup = (simple.parse(date).getTime() - TodayDateUtil.getTime())
					/ (24 * 60 * 60 * 1000);

			if (sup > 7 || sup < 0) {

				return new JSONArray().toString();
			}

			// 查询出List
			List<Tickets> list = service.selectAllInfo(departPlace,
					destination, date);
			for (Tickets t : list) {
				// 删除出发时间已超过 的票
				if (!TimeCompAndOperUtil.timeCompare(t.getDate(),
						t.getDepartureTime())) {

					list.remove(t);
				}

			}
			// 保存在session中
			session.setAttribute("ticketList", list);
			// 返回list-->json数组
			return JSONArray.fromObject(list).toString();
		} catch (Exception e) {

			// System.out.println("查询异常...");
			return new JSONArray().toString();
		}
	}

	// 停用车相关的票
	@RequestMapping("/pauseTicket")
	@ResponseBody
	public String pauseTicket(@RequestParam("trainsNum") String trainsNum) {

		// 通过车次号停用
		try {
			Boolean flag = service.updateBusType(trainsNum, 3);

			return flag.toString();
		} catch (Exception e) {

			// System.out.println("停票异常...");
			// System.out.println(e);
			return "false";
		}
	}

	// 恢复使用
	@RequestMapping("/recoverUse")
	@ResponseBody
	public String recoverUse(@RequestParam("trainsNum") String trainsNum,
			@RequestParam("type") int type) {
		try {
			// 恢复使用，常规or加班
			Boolean flag = service.updateBusType(trainsNum, type);

			return flag.toString();
		} catch (Exception e) {

			// System.out.println("恢复票使用异常...");
			return "false";

		}
	}

	// 购票
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/buyTicket", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String buyTicket(@RequestParam("ticketId") Long ticketId,
			HttpSession session) {
		// 暂不启用添加乘客信息功能
		try {
			Users user = (Users) (session.getAttribute("user"));
			if (user.getAccount() == null) {

				return "您尚未登录，请登录以后再试!";
			}

			String customId = user.getCardId();
			if (customId.equals("")) {

				return "您的身份信息尚未完善，请完善以后进行操作!";
			}

			Tickets ticket = service.selectByTicketId(ticketId);

			if (ticket.getCount() <= 0) {
				return "票量不足!";
			}

			// 通过票的id与用户相关信息 进行购买
			ticket.setCount(ticket.getCount() - 1);
			ticket.setSeatResidual(SeatHandleUtil.subSeatNum(ticket
					.getSeatResidual()));
			// 进行订单创建
			orderAction.createOrder(ticket.getTrainsNum(), SeatHandleUtil.temp,
					ticket.getTicketPrice(), customId,
					pAction.selectInfoById(customId).getName(),
					((Users) (session.getAttribute("user"))).getAccount(),
					ticket.getDepartPlace(), ticket.getDestination(),
					ticket.getDate(), ticket.getDepartureTime(),
					ticket.getTicketBarrier());

			// SeatHandle.temp 座位号

			// 更新票
			Boolean flag = service.updateTicket(ticket);
			if (flag) {

				List<Tickets> list = (List<Tickets>) (session
						.getAttribute("ticketList"));
				int count = 0;
				for (Tickets t : list) {

					// 通过票的id更改余量 ，list中可能存在出发目的一样的票，但是车次号不同
					if (t.getId() == ticketId) {

						list.get(count)
								.setCount(list.get(count).getCount() - 1);
						break;
					}
					count++;

				}
				session.setAttribute("ticketList", list);
				return "true";
			}
			return "操作失败，请稍后再试!";
		} catch (Exception e) {
			// System.out.println(e);

			return "操作失败，请稍后再试!";
		}

	}

	// 退票（票的操作）
	public boolean refunfTicket(Long ticketId, Integer seat) {
		try {

			Tickets ticket = service.selectByTicketId(ticketId);

			SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd");
			long dateSub = simple.parse(ticket.getDate()).getTime()
					- TodayDateUtil.getTime();

			// 判断是否可以退票
			if (dateSub < 0
					|| (dateSub == 0 && TodayDateUtil.getTimeSub(ticket
							.getDepartureTime()) > 60 * 60 * 1000)) {

				return false;
			} else {
				// 剩余座位列表修改
				ticket.setSeatResidual(SeatHandleUtil.addSeatNum(
						ticket.getSeatResidual(), seat));
				ticket.setCount(ticket.getCount() + 1);
				service.updateTicket(ticket);

				return true;
			}
		} catch (Exception e) {

			// System.out.println(e);
			// System.out.println("退票异常...");
			return false;
		}
	}

	// 通过车次号，日期，发车时间查询出相关车票
	public Long queryForId(String trainsNum, String date, String departTime) {

		try {
			Long id = service.queryForId(trainsNum, date, departTime);

			return id;
		} catch (Exception e) {

			// System.out.println("查询Id异常...");
			return null;
		}
	}
}
