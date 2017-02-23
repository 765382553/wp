package cn.ticket.service;

import cn.ticket.entity.PassagerInfo;

public interface PassagerInfoService {

	/**
	 * 添加乘客信息
	 * @param info:乘客实体类
	 * @return 布尔
	 */
	public boolean addInfo(PassagerInfo info);
	
	/**
	 * 删除乘客信息
	 * @param Id:身份证号码
	 * @return 布尔
	 */
	public boolean deleteInfo(String Id);
	
	/**
	 * 查询乘客信息
	 * @param Id:身份证
	 * @return 乘客信息实体
	 */
	public PassagerInfo selectInfoById(String Id);
	
	
}
