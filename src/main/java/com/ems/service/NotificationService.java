package com.ems.service;

import java.util.Date;
import java.util.List;

import com.ems.domain.Notification;

public interface NotificationService {
	
	public long addNotification(Notification notification);

	public boolean updateNotification(Notification notification);

	public List<Notification> getUnviewedNotificationByUserId(String userid);
	
	public long countNotification(String userid);
	
	public boolean updateNotificationByUserId(String userid);
	
	public Notification getNotificationById(long nid);
	
	public List<Notification> getNotificationBetweenTwoDates(String userid, Date startDate, Date endDate);

}
