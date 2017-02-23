package cn.ticket.service;

import java.util.List;

import cn.ticket.entity.Back;

public interface BackService {

	/**
	 * 添加反馈信息
	 * 
	 * @param back
	 * @return bool
	 */
	public boolean addBackInfo(Back back);

	/**
	 * 删除反馈信息
	 * 
	 * @param id
	 * @return bool
	 */
	public boolean delBackInfo(int id);

	/**
	 * 修改反馈信息
	 * 
	 * @param back
	 * @return bool
	 * 
	 */
	public boolean updBackInfo(Back back);

	/**
	 * 查询反馈信息
	 * 
	 * @param id
	 * @return back
	 * 
	 */
	public Back selectBackInfo(Integer id);

	/**
	 * 查询列表
	 * 
	 * @param Start
	 * @return list
	 */
	public List<Back> getBackList(Long start);

	/**
	 * 查询列表数目
	 * 
	 * @Long
	 */
	public Long getNum();

}
