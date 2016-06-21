package com.ems.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ems.domain.Documents;

@Repository
public class DocumentsDaoImpl implements DocumentsDao
{
	@Autowired private SessionFactory sessionFactory;
	
	public long addDocument(Documents document)
	{
		this.sessionFactory.getCurrentSession().save(document);
		this.sessionFactory.getCurrentSession().flush();
		return document.getDid();
	}
	
	public boolean updateDocument(Documents document)
	{
		try 
		{
			this.sessionFactory.getCurrentSession().update(document);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}
	public Documents getDocumentById(long did)
	{
		return (Documents)this.sessionFactory.getCurrentSession().get(Documents.class, did);
	}
	
	@SuppressWarnings("unchecked")
	public List<Documents> getDocumentsByUserId(String userid)
	{
		return this.sessionFactory.getCurrentSession().createCriteria(Documents.class)
				.createAlias("reg", "regAlias")
				.createAlias("regAlias.log", "logAlias")
				.add(Restrictions.eq("logAlias.userid", userid))
				.add(Restrictions.isNull("deleteDate"))
				.addOrder(Order.asc("documentName"))
				.list();
	}

}
