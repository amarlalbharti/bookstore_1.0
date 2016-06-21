package com.ems.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.FetchMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ems.domain.Attendance;
import com.ems.domain.LeaveDetail;
import com.ems.domain.Registration;
import com.ems.domain.UserDetail;

@Repository
public class LeaveDaoImpl implements LeaveDao{

	@Autowired private SessionFactory sessionFactory;
	public int addLeaveDetail(LeaveDetail leaveDetail) {
		this.sessionFactory.getCurrentSession().save(leaveDetail);
		this.sessionFactory.getCurrentSession().flush();
		return leaveDetail.getLeaveId();
	}
	
	@SuppressWarnings("unchecked")
	public List<LeaveDetail> getLeaveBetweenTwoDates(String userid, Date startDate, Date endDate) {
		try
		{
			List<LeaveDetail> list = this.sessionFactory.getCurrentSession()
					.createCriteria(LeaveDetail.class)
					.createAlias("registration", "regAlias")
					.createAlias("regAlias.log", "logAlias")
					.add(Restrictions.eq("logAlias.userid", userid))
					.add(Restrictions.between("requestDate", startDate, endDate))
					.addOrder(Order.desc("requestDate"))
					.list();
			
			return list;
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return null;
	}


	public LeaveDetail getLeaveId(int leaveId) {
		
	return (LeaveDetail) this.sessionFactory.getCurrentSession().get(LeaveDetail.class,leaveId);
	}

	public boolean updateLeaveDetail(LeaveDetail leaveDetail) {
		try{
			
			this.sessionFactory.getCurrentSession().update(leaveDetail);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		
	}

	@SuppressWarnings("unchecked")
	public List<LeaveDetail> getLeaveList(Date startDate, Date endDate) {
		return this.sessionFactory.getCurrentSession().createCriteria(LeaveDetail.class)
				.addOrder(Order.desc("requestDate"))
				.add(Restrictions.between("requestDate", startDate, endDate))
				.setFetchMode("registration", FetchMode.JOIN)
				.list();
	}

	@SuppressWarnings("unchecked")
	public LeaveDetail getLeaveListByUser(String userid) {
		List<LeaveDetail> list = this.sessionFactory.getCurrentSession().createCriteria(LeaveDetail.class)
				.createAlias("registration", "regAlias")
				.add(Restrictions.eq("regAlias.userid", userid))
				.setFetchMode("registration", FetchMode.JOIN)
				.list();
		if(!list.isEmpty())
		{
			return list.get(0);
		}
		
	return null;
	}
	
	
}
