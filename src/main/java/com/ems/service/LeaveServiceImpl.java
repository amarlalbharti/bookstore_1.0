package com.ems.service;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.LeaveDao;
import com.ems.domain.LeaveDetail;

@Service
@Transactional
public class LeaveServiceImpl implements LeaveService{

	@Autowired private LeaveDao leaveDao;
	public int addLeaveDetail(LeaveDetail leaveDetail) {
		
		return this.leaveDao.addLeaveDetail(leaveDetail);
	}
	public List<LeaveDetail> getLeaveBetweenTwoDates(String userid, Date startDate, Date endDate) {
		
		return this.leaveDao.getLeaveBetweenTwoDates(userid, startDate, endDate);
	}
	public LeaveDetail getLeaveId(int userid) {
		
		return this.leaveDao.getLeaveId(userid);
	}
	public boolean updateLeaveDetail(LeaveDetail leaveDetail) {
		
		return this.leaveDao.updateLeaveDetail(leaveDetail);
	}
	public List<LeaveDetail> getLeaveList(Date startDate, Date endDate) {
		
		return this.leaveDao.getLeaveList(startDate, endDate);
	}
	public LeaveDetail getLeaveListByUser(String userid) {
		
		return this.leaveDao.getLeaveListByUser(userid);
	}

}
