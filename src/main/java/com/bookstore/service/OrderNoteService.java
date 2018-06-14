package com.bookstore.service;

import com.bookstore.domain.OrderNote;

public interface OrderNoteService
{
	public int addOrderNode(OrderNote orderNote);
	
	public Boolean updateOrderNode(OrderNote orderNote);
}
