package com.ems.service;

import java.util.Date;
import java.util.List;

import com.ems.domain.Notification;

public interface NotificationService {
	
	public long addNotification(Notification notification);

	public boolean updateNotification(Notification notification);

	public List<Notification> getUnviewedNotificationByUserId(int userid);
	
	public long countNotification(int userid);
	
	public boolean updateNotificationByUserId(int userid);
	
	public Notification getNotificationById(long nid);
	
	public List<Notification> getNotificationBetweenTwoDates(int userid, Date startDate, Date endDate);

}
