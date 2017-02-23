package cn.ticket.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ticket.dao.AdminsMapper;
import cn.ticket.entity.Admins;
import cn.ticket.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminsMapper dao;

	@Override
	public boolean login(String u, String p) {

		Admins admin = dao.selectByAccount(u);
		if (admin != null && admin.getPassword().equals(p)) {

			return true;
		}
		return false;
	}

	@Override
	public boolean updAdminInfo(Admins admin) {

		int i = dao.updateByPrimaryKey(admin);
		
		return i > 0 ? true : false;
	}

	@Override
	public Admins getAdminInfo(String account) {
		Admins admin = dao.selectByAccount(account);
		
		return admin;
	}

}
