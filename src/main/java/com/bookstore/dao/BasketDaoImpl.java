package com.bookstore.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.Basket;

@Repository
public class BasketDaoImpl implements BasketDao
{
	@Autowired
	private SessionFactory sessionFactory;
	
	public int addBasket(Basket basket) {
		try{
			this.sessionFactory.getCurrentSession().save(basket);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return basket.getBasketId();
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}
	
	public boolean updateBasket(Basket basket) {
		try{
			this.sessionFactory.getCurrentSession().update(basket);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public Basket getBasketById(int basketId) {
		try{
			return (Basket)this.sessionFactory.getCurrentSession().get(Basket.class, basketId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Basket> getBasketByCustomer(int rid){
		try{
			return (List<Basket>)this.sessionFactory.getCurrentSession()
					.createCriteria(Basket.class)
					.createAlias("registration", "regAlias")
					.add(Restrictions.isNull("deletedDate"))
					.add(Restrictions.eq("regAlias.rid", rid))
					.list();
		}catch(Exception e){
			e.printStackTrace();
		}
		return new ArrayList<Basket>();
	}

	@SuppressWarnings("unchecked")
	public boolean checkInBasket(int pid, int rid) {
		try{
			List<Basket> list = this.sessionFactory.getCurrentSession()
					.createCriteria(Basket.class)
					.createAlias("registration", "regAlias")
					.createAlias("product", "productAlias")
					.add(Restrictions.isNull("deletedDate"))
					.add(Restrictions.eq("regAlias.rid", rid))
					.add(Restrictions.eq("productAlias.pid", pid))
					.list();
			if(list != null && !list.isEmpty()) {
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
}
