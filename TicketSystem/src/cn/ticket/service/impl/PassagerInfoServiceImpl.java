package cn.ticket.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ticket.dao.PassagerInfoMapper;
import cn.ticket.entity.PassagerInfo;
import cn.ticket.service.PassagerInfoService;

@Service
public class PassagerInfoServiceImpl implements PassagerInfoService {

	@Autowired
	private PassagerInfoMapper dao;

	@Override
	public boolean addInfo(PassagerInfo info) {

		int i = dao.insert(info);
		return i > 0 ? true : false;
	}

	@Override
	public boolean deleteInfo(String Id) {

		int i = dao.deleteByPrimaryKey(Id);
		return i > 0 ? true : false;
	}

	@Override
	public PassagerInfo selectInfoById(String Id) {

		PassagerInfo info = dao.selectByPrimaryKey(Id);
		return info;
	}

}
