package com.bookstore.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.OrderNote;

@Repository
public class OrderNoteDaoImpl implements OrderNoteDao
{
	@Autowired
	private SessionFactory sessionFactory;
	
	public int addOrderNode(OrderNote orderNote) {
		this.sessionFactory.getCurrentSession().save(orderNote);
		this.sessionFactory.getCurrentSession().clear();
		this.sessionFactory.getCurrentSession().flush();
		return orderNote.getOrderNoteId();
		
	}
	
	public Boolean updateOrderNode(OrderNote orderNote) {
		this.sessionFactory.getCurrentSession().update(orderNote);
		return true;
	}
	
}
