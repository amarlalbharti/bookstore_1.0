package com.bookstore.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.AttributeValue;

@Repository
public class AttributeValueDaoImpl implements AttributeValueDao
{
	@Autowired
	private SessionFactory sessionFactory;
	
	public int addAttributeValue(AttributeValue attributeValue)
	{
		this.sessionFactory.getCurrentSession().save(attributeValue);
		this.sessionFactory.getCurrentSession().flush();
		this.sessionFactory.getCurrentSession().clear();
		return attributeValue.getAttributeValueId();
	}

	public boolean updateAttributeValue(AttributeValue attributeValue)
	{
		try {
			this.sessionFactory.getCurrentSession().update(attributeValue);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public boolean deleteAttributeValue(AttributeValue attributeValue)
	{
		try {
			this.sessionFactory.getCurrentSession().delete(attributeValue);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	

	public AttributeValue getAttributeValueById(int attributeValueId)
	{
		try {
			return (AttributeValue)this.sessionFactory.getCurrentSession().get(AttributeValue.class, attributeValueId);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<AttributeValue> getAttrbuteValuesByAttributeId(int attributeId)
	{
		try {
			return (List)this.sessionFactory.getCurrentSession().createCriteria(AttributeValue.class)
					.add(Restrictions.eq("attribute.attributeId", attributeId))
					.addOrder(Order.asc("displayOrder"))
					.list();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	

}
