package cn.ticket.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ticket.dao.TicketsMapper;
import cn.ticket.entity.Tickets;
import cn.ticket.service.TicketService;

@Service
public class TicketServiceImpl implements TicketService {

	@Autowired
	private TicketsMapper dao;

	@Override
	public boolean addTicket(Tickets ticket) {

		int i = dao.insert(ticket);

		return i > 0 ? true : false;
	}

	@Override
	public boolean deleteTicket(String trainsNum) {

		int i = dao.deleteByTrainsNum(trainsNum);

		return i > 0 ? true : false;
	}

	@Override
	public boolean updateTicket(Tickets ticket) {

		int i = dao.updateByPrimaryKey(ticket);

		return i > 0 ? true : false;
	}

	@Override
	public Tickets selectByTicketId(Long id) {

		Tickets ticket = dao.selectByPrimaryKey(id);

		return ticket;
	}

	@Override
	public List<Tickets> selectAllInfo(String departPlace, String destination,
			String date) {

		if (destination != "") {

			return dao.selectByNeed(departPlace, destination, date);
		} else {

			return dao.selectByNeed_1(departPlace, date);
		}

	}

	@Override
	public boolean updateBusType(String trainsNum, int type) {

		boolean flag = dao.updateBusType(trainsNum, type);

		return flag;
	}

	@Override
	public Long queryForId(String trainsNum, String date, String departTime) {

		Long id = dao.queryForId(trainsNum, date, departTime);

		return id;
	}

	@Override
	public List<Tickets> selectAllTicketsByCommon() {

		List<Tickets> list = dao.selectAllTicketsByCommon();

		return list;
	}

	@Override
	public List<Tickets> selectAllTickets() {

		List<Tickets> list = dao.selectAllTickets();

		return list;
	}

}
