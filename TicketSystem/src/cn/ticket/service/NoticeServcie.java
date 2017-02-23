package cn.ticket.service;

import java.util.List;

import cn.ticket.entity.Notice;

public interface NoticeServcie {

	/**
	 * 新增公告
	 * 
	 */
	public boolean addAnnouncement(String content);

	/**
	 * 修改公告
	 * 
	 */
	public boolean updAnnouncement(int id, String content);

	/**
	 * 删除公告
	 * 
	 */
	public boolean deleteAnnouncement(int id);

	/**
	 * 查询公告(ById)
	 * 
	 */
	public Notice selectById(int id);

	/**
	 * 查询公告列表
	 * 
	 */
	public List<Notice> selectAllNoticeList();
}
