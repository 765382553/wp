package cn.ticket.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ticket.dao.OrdersMapper;
import cn.ticket.entity.Orders;
import cn.ticket.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrdersMapper dao;

	@Override
	public boolean createOrder(Orders order) {

		int i = dao.insertSelective(order);

		return i > 0 ? true : false;
	}

	@Override
	public Orders selectByOrderNum(Long orderNum) {

		Orders order = dao.selectByPrimaryKey(orderNum);

		return order;
	}

	@Override
	public List<Orders> selectByNeed(String account, Long start) {

		List<Orders> list = dao.selectByNeed(account, start);

		return list;
	}

	@Override
	public Boolean updateStatus(Long orderNum, int status) {

		Orders order = dao.selectByPrimaryKey(orderNum);
		order.setTicketStatus(status);
		int i = dao.updateByPrimaryKey(order);
		return i > 0 ? true : false;
	}

	@Override
	public List<Orders> selectOrderList(String date,Long start) {

		List<Orders> list = dao.selectOrderList(date,start);
		return list;
	}

	@Override
	public Long getOrderNum(String date) {

		Long num = dao.getOrderNum(date);
		return num;
	}

	@Override
	public Long selectByNeedCount(String account) {
		Long num = dao.selectByNeedCount(account);
		return num;
	}

	@Override
	public boolean deleteOrder(Long orderNum) {
		int i = dao.deleteByPrimaryKey(orderNum);
		return i > 0 ? true : false;
	}

	@Override
	public Long selectByStatusCount(String account, Integer status) {

		Long count = dao.selectByStatusCount(account, status);
		return count;
	}

	@Override
	public List<Orders> selectOrderListByStatus(String account, Long statrt,
			Integer status) {

		List<Orders> list = dao
				.selectOrderListByStatus(account, statrt, status);

		return list;
	}

}
