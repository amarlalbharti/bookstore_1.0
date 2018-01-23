package com.bookstore.dao;

import java.util.List;

import com.bookstore.domain.Basket;

public interface BasketDao
{
	public int addBasket(Basket basket);
	
	public boolean updateBasket(Basket basket);
	
	public Basket getBasketById(int basketId);
	
	public List<Basket> getBasketByCustomer(int rid);

	public boolean checkInBasket(int pid, int rid);
	
}
