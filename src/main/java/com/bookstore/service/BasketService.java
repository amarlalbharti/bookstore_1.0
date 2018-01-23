package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.Basket;

public interface BasketService
{
	public int addBasket(Basket basket);
	
	public boolean updateBasket(Basket basket);
	
	public Basket getBasketById(int basketId);
	
	public List<Basket> getBasketByCustomer(int customerId);
	
	public List<Basket> getBasketByCustomer(String userid);
	
	public boolean checkInBasket(int pid, int rid);

}
