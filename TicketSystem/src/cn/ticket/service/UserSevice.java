package cn.ticket.service;

import cn.ticket.entity.Users;
	
public interface UserSevice {

	
	/**
	 * 查找用户
	 * @param 账号:u
	 * @return 用户实体
	 */
	public Users findUser(String u);
	
	/**
	 * 注册
	 *@param User
	 * @return 布尔
	 */
	public boolean register(Users user);
	
	/**
	 * 充值
	 * @param 账户:u 金额:money 
	 * @return 布尔
	 */
	public boolean recharge(String u,float money);
	
	/**
	 * 支付
	 * @param 账户:u 金额:money
	 * @return 布尔
	 */
	public boolean pay(String u,float money);
	
	/**
	 * 清理长期未使用的账户
	 * @param 账号 :u 
	 * @return 布尔
	 */
	public boolean clearUser(String u); 
	
	/**
	 * 修改用户信息
	 * @param user
	 * @return
	 */
	public boolean updUser(Users user);
}
