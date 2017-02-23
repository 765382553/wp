package cn.ticket.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ticket.dao.UsersMapper;
import cn.ticket.entity.Users;
import cn.ticket.service.UserSevice;

@Service
public class UserServiceImpl implements UserSevice {

	@Autowired
	private UsersMapper dao;

	// private static Users users;

	@Override
	public boolean register(Users user) {

		int i = dao.insert(user);

		return i >= 0 ? true : false;
	}

	@Override
	public Users findUser(String u) {

		Users user = dao.selectByPrimaryKey(u);

		return user;
	}

	@Override
	public boolean recharge(String u, float money) {

		Users user = dao.selectByPrimaryKey(u);
		user.setBalance(user.getBalance() + money);
		int i = dao.updateByPrimaryKeySelective(user);
		return i >= 0 ? true : false;
	}

	@Override
	public boolean pay(String u, float money) {

		Users user = dao.selectByPrimaryKey(u);
		if ((user.getBalance() - money) < 0)
			return false;
		user.setBalance(user.getBalance() - money);
		int i = dao.updateByPrimaryKeySelective(user);
		return i >= 0 ? true : false;

	}

	@Override
	public boolean clearUser(String u) {

		int i = dao.deleteByPrimaryKey(u);
		return i >= 0 ? true : false;
	}

	@Override
	public boolean updUser(Users user) {

		int i = dao.updateByPrimaryKeySelective(user);

		return i >= 0 ? true : false;
	}

}
