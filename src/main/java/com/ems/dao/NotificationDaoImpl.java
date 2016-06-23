package com.ems.dao;

import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ems.domain.Notification;



@Repository
public class NotificationDaoImpl implements NotificationDao{

	@Autowired private SessionFactory sessionFactory;
	public long addNotification(Notification notification) {
		
		Date date = new Date();
		Date dt = new Date(date.getTime());
		
		notification.setCreateDate(dt);
		notification.setIsViewed("false");
		
		this.sessionFactory.getCurrentSession().save(notification);
		this.sessionFactory.getCurrentSession().flush();
		return notification.getnId();
	}
	
	
	public boolean updateNotification(Notification notification) {
		
		try{
			
			this.sessionFactory.getCurrentSession().update(notification);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		}
		catch(Exception e){
			
			e.printStackTrace();
		}
		
		return false;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Notification> getUnviewedNotificationByUserId(String userid) {
		
	List<Notification> list= this.sessionFactory.getCurrentSession().createCriteria(Notification.class)
			                  .add(Restrictions.eq("notiTo", userid))
			                  //.add(Restrictions.eq("isViewed", "false"))
			                  .add(Restrictions.isNull("deleteDate"))
			                  .setMaxResults(10)
			                  .addOrder(Order.desc("createDate"))
			                  .list();
		return list;
	}

	
	
	public long countNotification(String userid )
	{
		try
		{
			return (Long)this.sessionFactory.getCurrentSession()
					.createCriteria(Notification.class)
					.setProjection(Projections.distinct(Projections.property("notiTo")))
					.add(Restrictions.eq("isViewed", "false"))
					.add(Restrictions.eq("notiTo", userid))
					.setProjection(Projections.rowCount())
					.uniqueResult();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return 0;
	}


	@SuppressWarnings("unchecked")
	public boolean updateNotificationByUserId(String userid) {
		try 
		{
			Query query = this.sessionFactory.getCurrentSession().createSQLQuery("update notification set isViewed='true' where notiTo=:noti_to");
			query.setString("noti_to", userid);
			query.executeUpdate();
			return true;
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	return false;
	}


	public Notification getNotificationById(long nid) {
		
		return (Notification) this.sessionFactory.getCurrentSession().get(Notification.class, nid);
	}


	@SuppressWarnings("unchecked")
	public List<Notification> getNotificationBetweenTwoDates(String userid, Date startDate, Date endDate) {
		try{
			List<Notification> list= this.sessionFactory.getCurrentSession().createCriteria(Notification.class)
	                  .add(Restrictions.eq("notiTo", userid))
	                  .add(Restrictions.between("createDate", startDate, endDate))
	                  .add(Restrictions.isNull("deleteDate"))
	                  .addOrder(Order.desc("createDate"))
	                  .list();
           return list;
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
}
