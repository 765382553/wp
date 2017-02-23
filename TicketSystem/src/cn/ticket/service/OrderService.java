package cn.ticket.service;

import java.util.List;

import cn.ticket.entity.Orders;

public interface OrderService {

	/**
	 * 生成账单
	 * @param order:生成的账单实体
	 * @return 布尔
	 * 
	 */
	public boolean  createOrder(Orders order);
	
	/**
	 * 查询，根据编号
	 * @param orderNum:账单号
	 * @return 账单实体
	 */
	public Orders selectByOrderNum(Long orderNum);
	
	/**
	 * 根据账户查询(3个月内)
	 *  @param account;购买者的账户 ,start:页
	 *  @return List<Orders>
	 */
	public List<Orders> selectByNeed(String account,Long start);
	
	/**
	 * 分页查询所有订单记录
	 * @param page(start)
	 * @return List<Orders>
	 */
	public List<Orders> selectOrderList(String date,Long start);
	
	/**
	 * 修改订单票务状态
	 * @param orderNum:票Id,status:状态
	 * @return 布尔
	 */
	public Boolean updateStatus(Long orderNum,int status);

	/**
	 * 得到记录总数
	 * @param date
	 * @return
	 */
	public Long getOrderNum(String date);
	
	/**
	 * 查询用户最近订单总数
	 * @param account
	 * @return
	 */
	public Long selectByNeedCount(String account);
	
	/**
	 * 删除订单
	 * @param orderNum
	 * @return
	 */
	public boolean deleteOrder(Long orderNum);
	
	/**
	 * 根据帐号订单状态查询账单记录总数
	 * @param account,status
	 * @return Long型数目
	 */
	public Long selectByStatusCount(String account,Integer status);
	
	/**
	 * 根据帐号，开始的记录数，订单状态查询记录
	 * @param account,start,status
	 * @return List
	 */
	public List<Orders> selectOrderListByStatus(String account,Long statrt,Integer status);
	
	
	
}
