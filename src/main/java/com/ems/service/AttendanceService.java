package com.ems.service;

import java.util.Date;
import java.util.List;

import com.ems.domain.Attendance;

/**
 * interface to interact with service layer for attendance
 * @author bharti
 *
 */
public interface AttendanceService 
{
	/**
	 * Add new Attendance entry in database by passing Attendance class object
	 * @param attendance
	 * @return returns true if successfully added, otherwise false.
	 */
	public long addAddtendance(Attendance attendance);
	
	/**
	 * Update existing Attendance entry in database by passing Attendance class object
	 * @param attendance
	 * @return
	 */
	public boolean updateAddtendance(Attendance attendance);
	
	/**
	 * Get List of attendance for today's
	 * @param userid
	 * @return
	 */
	public List<Attendance> getTodaysAttendance(String userid);
	
	/**
	 * Get User check in and check out tile between two dates
	 * 
	 */
	public List<Attendance> getAttendanceBetweenTwoDates(String userid, Date startDate, Date endDate);
	
	/**
	 * Get check in and check out time for users at specific date 
	 * 
	 */
	public List<Attendance> getAttendanceByDate(Date date);
	
	public List<Attendance> getUserAttendanceByDate(Date date);
	
	public long countTodaysAttendance();
	
	public long countTodaysUserAttendance();
	
	public Attendance getAttendanceById(long aid);
	
	public List<Attendance> getAttendance(String userid, Date date);
}
