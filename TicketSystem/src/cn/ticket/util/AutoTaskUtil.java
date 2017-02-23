package cn.ticket.util;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.ticket.entity.Tickets;
import cn.ticket.service.impl.TicketServiceImpl;

public class AutoTaskUtil {

    @Autowired
	private TicketServiceImpl tsImpl;
    

	/*
	 * 自动生成(相对明天的)第七天常规票
	 */
	public void execute() {

		
		try {
			List<Tickets> list = tsImpl.selectAllTicketsByCommon();
			
			for (Tickets t : list) {

				t.setId(null);
				t.setDate(TimeCompAndOperUtil.getAppointDay(t.getDate(), 7));

				
				if (tsImpl.selectAllInfo(t.getDepartPlace(),
						t.getDestination(), t.getDate()).size()==0) {

					 tsImpl.addTicket(t);
				
				}
				
			}
	  
		} catch (Exception e) {

			System.out.println(e);
		}

	}
}
