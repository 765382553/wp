package cn.ticket.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ticket.dao.NoticeMapper;
import cn.ticket.entity.Notice;
import cn.ticket.service.NoticeServcie;

@Service
public class NoticeServiceImpl implements NoticeServcie {

	@Autowired
	private NoticeMapper dao;

	@Override
	public boolean addAnnouncement(String content) {

		int i = dao.insertSelective(new Notice(content));

		return i > 0 ? true : false;
	}

	@Override
	public boolean updAnnouncement(int id, String content) {

		int i = dao.updateByPrimaryKey(new Notice(id, content));

		return i > 0 ? true : false;
	}

	@Override
	public boolean deleteAnnouncement(int id) {

		int i = dao.deleteByPrimaryKey(id);

		return i > 0 ? true : false;
	}

	@Override
	public Notice selectById(int id) {

		Notice notice = dao.selectByPrimaryKey(id);
		return notice;
	}

	@Override
	public List<Notice> selectAllNoticeList() {

		List<Notice> list = dao.selectAllList();
		return list;
	}

}
