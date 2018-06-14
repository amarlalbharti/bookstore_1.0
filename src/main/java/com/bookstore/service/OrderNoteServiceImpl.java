package com.bookstore.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.OrderNoteDao;
import com.bookstore.domain.OrderNote;

@Service
@Transactional
public class OrderNoteServiceImpl implements OrderNoteService
{
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

}
