package cn.ticket.service;

import cn.ticket.entity.Admins;


public interface AdminService {

/**
 * 登陆
 * @param 账号:u 密码:p
 * @return 布尔
 *
 */
public boolean login(String u,String p);

/**
 * 修改管理员信息
 * @param Admins 
 * return booelan
 */
public boolean updAdminInfo(Admins admin);

/**
 * 查询管理员信息
 * @param account
 * @return Admins
 */
public Admins getAdminInfo(String account);

}
