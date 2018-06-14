package com.bookstore.dao;

import com.bookstore.domain.OrderNote;

public interface OrderNoteDao
{
	public int addOrderNode(OrderNote orderNote);
	
	public Boolean updateOrderNode(OrderNote orderNote);
	
}
