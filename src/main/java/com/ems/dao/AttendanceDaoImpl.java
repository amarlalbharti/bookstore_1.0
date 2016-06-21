package com.ems.dao;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ems.config.DateFormats;
import com.ems.config.Roles;
import com.ems.domain.Attendance;
import com.ems.domain.UserRole;

@Repository
public class AttendanceDaoImpl implements AttendanceDao
{
	@Autowired private SessionFactory  sessionFactory;
	
	
	public long addAddtendance(Attendance attendance)
	{
		this.sessionFactory.getCurrentSession().save(attendance);
		this.sessionFactory.getCurrentSession().flush();
		return attendance.getAid();
	}
	
	public boolean updateAddtendance(Attendance attendance)
	{
		try 
		{
			this.sessionFactory.getCurrentSession().update(attendance);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}
	
	@SuppressWarnings("unchecked")
	public List<Attendance> getTodaysAttendance(String userid)
	{
		Date date;
		try
		{
			date = DateFormats.ddMMyyyy().parse(DateFormats.ddMMyyyy().format(new Date()));
			List<Attendance> list = this.sessionFactory.getCurrentSession()
					.createCriteria(Attendance.class)
					.createAlias("registration", "regAlias")
					.createAlias("regAlias.log", "logAlias")
					.add(Restrictions.eq("logAlias.userid", userid))
					.add(Restrictions.between("inTime", date, new Date()))
					.addOrder(Order.desc("inTime"))
					.list();
			
			return list;
			
		} 
		catch (ParseException e) 
		{
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Attendance> getAttendanceBetweenTwoDates(String userid, Date startDate, Date endDate)
	{
		try
		{
			List<Attendance> list = this.sessionFactory.getCurrentSession()
					.createCriteria(Attendance.class)
					.createAlias("registration", "regAlias")
					.createAlias("regAlias.log", "logAlias")
					.add(Restrictions.eq("logAlias.userid", userid))
					.add(Restrictions.between("inTime", startDate, endDate))
					.addOrder(Order.desc("inTime"))
					.list();
			
			return list;
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return null;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Attendance> getAttendanceByDate(Date date)
	{
		try
		{
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
			Date startDate = cal.getTime();
			
			cal.set(Calendar.HOUR_OF_DAY, 23);
			cal.set(Calendar.MINUTE, 59);
			cal.set(Calendar.SECOND, 59);
			cal.set(Calendar.MILLISECOND, 0);
			Date endDate = cal.getTime();
			
			List<Attendance> list = this.sessionFactory.getCurrentSession()
					.createCriteria(Attendance.class)
					.createAlias("registration", "regAlias")
					.createAlias("regAlias.log", "logAlias")
					.add(Restrictions.between("inTime", startDate, endDate))
					.addOrder(Order.asc("inTime"))
					.list();
			
			return list;
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Attendance> getUserAttendanceByDate(Date date) {
		try
		{
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
			Date startDate = cal.getTime();
			
			cal.set(Calendar.HOUR_OF_DAY, 23);
			cal.set(Calendar.MINUTE, 59);
			cal.set(Calendar.SECOND, 59);
			cal.set(Calendar.MILLISECOND, 0);
			Date endDate = cal.getTime();
			
			List<UserRole> rlist = this.sessionFactory.getCurrentSession().createCriteria(UserRole.class)
	                .add(Restrictions.or(Restrictions.eq("userrole", Roles.ROLE_ADMIN.toString()),Restrictions.eq("userrole", Roles.ROLE_MANAGER.toString())))
	                .list();
	        List<String> rl = new ArrayList<String>();
	        for(UserRole role : rlist)
	        {
	            rl.add(role.getLog().getUserid());
	        }
			
			List<Attendance> list = this.sessionFactory.getCurrentSession()
					.createCriteria(Attendance.class)
					.createAlias("registration", "regAlias")
					.createAlias("regAlias.log", "logAlias")
					.add(Restrictions.not(Restrictions.in("logAlias.userid",rl)))
					.add(Restrictions.between("inTime", startDate, endDate))
					.addOrder(Order.asc("inTime"))
					.list();
			
			return list;
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return null;
	}

	
	public long countTodaysAttendance()
	{
		Date date = new Date();
		try
		{
//			date = DateFormats.ddMMyyyy().parse(DateFormats.ddMMyyyy().format(new Date()));
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.MILLISECOND, 0);
			Date startDate = cal.getTime();
			
			cal.set(Calendar.HOUR_OF_DAY, 23);
			cal.set(Calendar.MINUTE, 59);
			cal.set(Calendar.SECOND, 59);
			cal.set(Calendar.MILLISECOND, 0);
			Date endDate = cal.getTime();
			
			return (Long)this.sessionFactory.getCurrentSession()
					.createCriteria(Attendance.class)
					.createAlias("registration", "regAlias")
					.createAlias("regAlias.log", "logAlias")
					.setProjection(Projections.distinct(Projections.property("logAlias.userid")))
					.add(Restrictions.between("inTime", startDate, endDate))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return 0;
	}
	
	public Attendance getAttendanceById(long aid)
	{
		return (Attendance)this.sessionFactory.getCurrentSession().get(Attendance.class, aid);
	}

	@SuppressWarnings("unchecked")
	public long countTodayUserAttendance() {
		Date date;
		try
		{
			List<UserRole> list = this.sessionFactory.getCurrentSession().createCriteria(UserRole.class)
	                .add(Restrictions.or(Restrictions.eq("userrole", Roles.ROLE_ADMIN.toString()),Restrictions.eq("userrole", Roles.ROLE_MANAGER.toString())))
	                .list();
	        List<String> rl = new ArrayList<String>();
	        for(UserRole role : list)
	        {
	            rl.add(role.getLog().getUserid());
	        }
	        
			date = DateFormats.ddMMyyyy().parse(DateFormats.ddMMyyyy().format(new Date()));
			return (Long)this.sessionFactory.getCurrentSession()
					.createCriteria(Attendance.class)
					.createAlias("registration", "regAlias")
					.createAlias("regAlias.log", "logAlias")
					.add(Restrictions.not(Restrictions.in("logAlias.userid",rl)))
					.add(Restrictions.between("inTime", date, new Date()))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
		} 
		catch (ParseException e) 
		{
			e.printStackTrace();
		}
		return 0;
	}
	
	@SuppressWarnings("unchecked")
	public List<Attendance> getAttendance(String userid, Date date)
	{
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		Date startDate = cal.getTime();
		
		cal.set(Calendar.HOUR_OF_DAY, 23);
		cal.set(Calendar.MINUTE, 59);
		cal.set(Calendar.SECOND, 59);
		cal.set(Calendar.MILLISECOND, 0);
		Date endDate = cal.getTime();
		
		List<Attendance> list = this.sessionFactory.getCurrentSession()
				.createCriteria(Attendance.class)
				.createAlias("registration", "regAlias")
				.createAlias("regAlias.log", "logAlias")
				.add(Restrictions.eq("logAlias.userid",userid))
				.add(Restrictions.between("inTime", startDate, endDate))
				.addOrder(Order.asc("inTime"))
				.list();
		
		return list;
	}
}
