package com.bookstore.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.ProductOrder;

@Repository
public class ProductOrderDaoImpl implements ProductOrderDao
{
	@Autowired
	private SessionFactory sessionFactory;
	
	
	public int addProductOrder(ProductOrder productOrder) {
		try {
			this.sessionFactory.getCurrentSession().save(productOrder);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return productOrder.getProductOrderId();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public boolean updateProductOrder(ProductOrder productOrder) {
		try {
			this.sessionFactory.getCurrentSession().update(productOrder);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return true;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public ProductOrder getProductOrder(int productOrderId) {
		try {
			return (ProductOrder)this.sessionFactory.getCurrentSession().get(ProductOrder.class, productOrderId);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<ProductOrder> getProductOrderByCustomer(int rid){
		return null;
	}

}
