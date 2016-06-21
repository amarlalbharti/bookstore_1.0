package com.ems.service;

import java.util.Date;
import java.util.List;

import com.ems.domain.LeaveDetail;

public interface LeaveService {
	
	public int addLeaveDetail(LeaveDetail leaveDetail);
	public List<LeaveDetail> getLeaveBetweenTwoDates(String userid, Date startDate, Date endDate);
	public LeaveDetail getLeaveId(int leaveId);
	public boolean updateLeaveDetail(LeaveDetail leaveDetail);
	public List<LeaveDetail> getLeaveList(Date startDate, Date endDate);
	public LeaveDetail getLeaveListByUser(String userid);
}
