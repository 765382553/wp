package cn.ticket.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ticket.dao.BackMapper;
import cn.ticket.entity.Back;
import cn.ticket.service.BackService;

@Service
public class BackServiceImpl implements BackService {

	@Autowired
	private BackMapper dao;

	@Override
	public boolean addBackInfo(Back back) {

		int i = dao.insertSelective(back);

		return i > 0 ? true : false;
	}

	@Override
	public boolean delBackInfo(int id) {

		int i = dao.deleteByPrimaryKey(id);

		return i > 0 ? true : false;
	}

	@Override
	public List<Back> getBackList(Long start) {

		List<Back> list = dao.getBackListByDate(start);

		return list;
	}

	@Override
	public Long getNum() {

		Long num = dao.getNum();

		return num;
	}

	@Override
	public boolean updBackInfo(Back back) {

		int i = dao.updateByPrimaryKeySelective(back);

		return i > 0 ? true : false;
	}

	@Override
	public Back selectBackInfo(Integer id) {

		Back back = dao.selectByPrimaryKey(id);

		return back;
	}

}
