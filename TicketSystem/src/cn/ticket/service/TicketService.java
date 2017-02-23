package cn.ticket.service;

import java.util.List;

import cn.ticket.entity.Tickets;

public interface TicketService {

	/**
	 * 新增车次
	 * 
	 * @param ticket
	 *            : Tickets实体
	 * @return 布尔
	 */
	public boolean addTicket(Tickets ticket);

	/**
	 * 删除车次
	 * 
	 * @param trainsNum
	 *            :车次号
	 * @return 布尔
	 */
	public boolean deleteTicket(String trainsNum);

	/**
	 * 修改车次信息
	 * 
	 * @param ticket
	 *            :修改车次信息的实体
	 * @return 布尔
	 */

	public boolean updateTicket(Tickets ticket);

	/**
	 * 查询指定班次的车次信息
	 * 
	 * @param taisnNum
	 *            :指定的车票ID
	 * @return Tickets 相应车次信息
	 */
	public Tickets selectByTicketId(Long id);

	/**
	 * 查询相应的车次(根据出发地、目的地和日期)
	 * 
	 * @param departure
	 *            :出发地，destination:目的地，date:日期
	 * @return List<Tickets> 根据要求筛选出列表
	 */
	public List<Tickets> selectAllInfo(String departure, String destination,
			String date);

	/**
	 * 修改车次类型 或状态
	 * 
	 * @param type
	 *            :类型(1:常规票、2:加班票、3:暂停使用)
	 * @return 布尔
	 */
	public boolean updateBusType(String trainsNum, int type);

	/**
	 * 根据车次号，日期，发车时间查询票Id
	 * 
	 * @param trainsNum
	 *            : 车次号 ,date:日期 ,departTime:发车时间
	 * @return 布尔
	 */
	public Long queryForId(String trainsNum, String date, String departTime);

	/**
	 * 获得当天所有常规班次
	 * 
	 */
	public List<Tickets> selectAllTicketsByCommon();

	/**
	 * 获得所有班次列表(包括常规与加班)
	 */
	public List<Tickets> selectAllTickets();

}
