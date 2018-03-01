package com.bookstore.dao;

import java.util.List;

import org.hibernate.FetchMode;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
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
	
	@SuppressWarnings("unchecked")
	public ProductOrder getProductOrder(int productOrderId) {
		try {
			List<ProductOrder> list = this.sessionFactory.getCurrentSession().createCriteria(ProductOrder.class)
					.add(Restrictions.eq("productOrderId", productOrderId))
					.setFetchMode("orderItems", FetchMode.JOIN)
					.list();
			if(list != null && !list.isEmpty()) {
				return list.get(0);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	@SuppressWarnings("unchecked")
	public ProductOrder getProductOrder(int productOrderId, int rid) {
		try {
			List<ProductOrder> list = this.sessionFactory.getCurrentSession().createCriteria(ProductOrder.class)
					.createAlias("registration", "regAlias")
					.add(Restrictions.eq("regAlias.rid", rid))
					.add(Restrictions.eq("productOrderId", productOrderId))
					.setFetchMode("orderItems", FetchMode.JOIN)
					.list();
			if(list != null && !list.isEmpty()) {
				return list.get(0);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<ProductOrder> getProductOrderByCustomer(int rid){
		try {
			return  this.sessionFactory.getCurrentSession().createCriteria(ProductOrder.class)
					.createAlias("registration", "regAlias")
					.add(Restrictions.eq("regAlias.rid", rid))
					.list();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
