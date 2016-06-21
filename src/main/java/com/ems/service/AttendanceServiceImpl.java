package com.ems.service;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.AttendanceDao;
import com.ems.domain.Attendance;

@Service
@Transactional
public class AttendanceServiceImpl implements AttendanceService
{
	@Autowired private AttendanceDao attendanceDao;

	public long addAddtendance(Attendance attendance)
	{
		return this.attendanceDao.addAddtendance(attendance);
	}

	public boolean updateAddtendance(Attendance attendance) 
	{
		return this.attendanceDao.updateAddtendance(attendance);
	}

	public List<Attendance> getTodaysAttendance(String userid)
	{
		return this.attendanceDao.getTodaysAttendance(userid);
	}
	
	
	public List<Attendance> getAttendanceBetweenTwoDates(String userid, Date startDate, Date endDate)
	{
		return this.attendanceDao.getAttendanceBetweenTwoDates(userid, startDate, endDate);
	}
	
	public List<Attendance> getAttendanceByDate(Date date)
	{
		return this.attendanceDao.getAttendanceByDate(date);
	}
	
	public long countTodaysAttendance()
	{
		return this.attendanceDao.countTodaysAttendance();
	}
	
	public Attendance getAttendanceById(long aid)
	{
		return this.attendanceDao.getAttendanceById(aid);
	}

	public long countTodaysUserAttendance()
	{
		return this.attendanceDao.countTodayUserAttendance();
	}

	public List<Attendance> getUserAttendanceByDate(Date date) 
	{
		return this.attendanceDao.getUserAttendanceByDate(date);
	}
	
	public List<Attendance> getAttendance(String userid, Date date)
	{
		return this.attendanceDao.getAttendance(userid, date);
	}
}
