package com.bookstore.service;

import java.util.Date;

import javax.transaction.Transactional;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.OrderNoteDao;
import com.bookstore.domain.OrderNote;
import com.bookstore.domain.ProductOrder;
import com.bookstore.domain.Registration;
import com.bookstore.enums.OrderStatus;
import com.bookstore.util.ProductOrderUtils;

@Service
@Transactional
public class OrderNoteServiceImpl implements OrderNoteService
{
	private static final Logger LOGGER = Logger.getLogger(OrderNoteServiceImpl.class);
	
	@Autowired
	private OrderNoteDao orderNoteDao;
	
	public int addOrderNode(OrderNote orderNote)
	{
		return this.orderNoteDao.addOrderNode(orderNote);
	}

	public Boolean updateOrderNode(OrderNote orderNote)
	{
		return this.orderNoteDao.updateOrderNode(orderNote);
	}
	
	public Boolean addNoteOnChangeActivity(ProductOrder order, int oldStatus, String comment, Registration reg) {
		Boolean status = Boolean.FALSE;
		try {
			OrderNote orderNote = new OrderNote();
			orderNote.setRegistration(reg);
			orderNote.setProductOrder(order);
			orderNote.setShowToCustomer(Boolean.FALSE);
			orderNote.setCreateDate(new Date());
			
			if(comment == null || comment.isEmpty()) {
				StringBuilder note = new StringBuilder();
				note.append("Order status changed from <span class='"+ProductOrderUtils.getProductOrderStatusTextClass(oldStatus)+"'>");
				note.append("<strike>");
				note.append(ProductOrderUtils.getProductOrderStatus(oldStatus));
				note.append("</strike>");
				note.append("</span>  to ");
				note.append("<span class='"+ProductOrderUtils.getProductOrderStatusTextClass(order.getOrderStatus())+"'>");
				note.append(ProductOrderUtils.getProductOrderStatus(order.getOrderStatus()));
				note.append("</span>.");
				orderNote.setNote(note.toString());
			}else {
				orderNote.setNote(comment);
			}
			addOrderNode(orderNote);
			status = Boolean.TRUE;
		}catch (Exception e) {
			LOGGER.error("Exception while changing statuc ", e);
		}
		return status;
	}
}
