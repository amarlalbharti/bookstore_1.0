package com.bookstore.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.Attribute;

@Repository
public class AttributeDaoImlp implements AttributeDao
{
	@Autowired private SessionFactory  sessionFactory;
	
	public int addAttribute(Attribute attribute){
		try{
			this.sessionFactory.getCurrentSession().save(attribute);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return attribute.getAttributeId();
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}
	
	public boolean updateAttribute(Attribute attribute){
		try{
			this.sessionFactory.getCurrentSession().update(attribute);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public Attribute getAttributeByAttributeId(int attributeId){
		try{
			return (Attribute) this.sessionFactory.getCurrentSession().get(Attribute.class, attributeId);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Attribute> getAttributes(){
		try{
			return this.sessionFactory.getCurrentSession().createCriteria(Attribute.class).list();
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
}
