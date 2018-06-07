package com.bookstore.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.ProductOrder;
import com.bookstore.enums.OrderStatus;

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
					.setFetchMode("orderNotes", FetchMode.JOIN)
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
	public ProductOrder getProductOrderByTransationId(long transactionId) {
		try {
			List<ProductOrder> list = this.sessionFactory.getCurrentSession().createCriteria(ProductOrder.class)
					.add(Restrictions.eq("transactionId", transactionId))
					.setFetchMode("orderItems", FetchMode.JOIN)
					.setFetchMode("orderNotes", FetchMode.JOIN)
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
	
	@SuppressWarnings("unchecked")
	public List<ProductOrder> getLatestProductOrders(int first, int max){
		try {
			return  this.sessionFactory.getCurrentSession().createCriteria(ProductOrder.class)
					.addOrder(Order.desc("createDate"))
					.setFirstResult(first)
					.setMaxResults(max)
					.list();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Long countProductOrdersByStatus(){
		Long count = 0L;
		try {
			return  (Long)this.sessionFactory.getCurrentSession().createCriteria(ProductOrder.class)
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public Long countProductOrdersByStatus(OrderStatus status){
		Long count = 0L;
		try {
			return  (Long)this.sessionFactory.getCurrentSession().createCriteria(ProductOrder.class)
					.add(Restrictions.eq("orderStatus", status.ordinal()))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
}
