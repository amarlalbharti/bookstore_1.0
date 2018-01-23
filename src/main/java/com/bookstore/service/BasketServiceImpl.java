package com.bookstore.service;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.BasketDao;
import com.bookstore.dao.RegistrationDao;
import com.bookstore.domain.Basket;
import com.bookstore.domain.Registration;

@Service
@Transactional
public class BasketServiceImpl implements BasketService
{
	@Autowired 
	private BasketDao basketDao;
	
	@Autowired
	private RegistrationDao registrationDao;
	
	public int addBasket(Basket basket) {
		return this.basketDao.addBasket(basket);
	}
	
	public boolean updateBasket(Basket basket) {
		return this.basketDao.updateBasket(basket);
	}
	
	public Basket getBasketById(int basketId) {
		return this.basketDao.getBasketById(basketId);
	}
	
	public List<Basket> getBasketByCustomer(int customerId){
		return this.basketDao.getBasketByCustomer(customerId);
	}

	public List<Basket> getBasketByCustomer(String userid){
		Registration reg = this.registrationDao.getRegistrationByUserid(userid);
		if(reg != null) {
			return getBasketByCustomer(reg.getRid());
		}
		return new ArrayList<Basket>();
	}
	
	public boolean checkInBasket(int pid, int rid) {
		return this.basketDao.checkInBasket(pid, rid);
		
	}
}
