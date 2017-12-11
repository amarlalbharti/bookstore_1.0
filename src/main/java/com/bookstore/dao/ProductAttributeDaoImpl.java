package com.bookstore.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.ProductAttribute;

@Repository
public class ProductAttributeDaoImpl implements ProductAttributeDao
{
	@Autowired
	private SessionFactory sessionFactory;
	
	public int addProductAttribute(ProductAttribute productAttribute) {
		try {
			this.sessionFactory.getCurrentSession().save(productAttribute);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return productAttribute.getProductAttributeId();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public boolean updateProductAttribute(ProductAttribute productAttribute) {
		try {
			this.sessionFactory.getCurrentSession().update(productAttribute);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return true;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean deleteProductAttribute(ProductAttribute productAttribute) {
		try {
			this.sessionFactory.getCurrentSession().delete(productAttribute);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public ProductAttribute getProductAttributeById(int productAttributeId) {
		return (ProductAttribute)this.sessionFactory.getCurrentSession().get(ProductAttribute.class, productAttributeId);
	}
	
	@SuppressWarnings("unchecked")
	public List<ProductAttribute> getProductAttributeByPid(int pid){
		try {
			return this.sessionFactory.getCurrentSession().createCriteria(ProductAttribute.class)
			.add(Restrictions.eq("product.pid", pid))
			.addOrder(Order.asc("displayOrder"))
			.list();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	

}
