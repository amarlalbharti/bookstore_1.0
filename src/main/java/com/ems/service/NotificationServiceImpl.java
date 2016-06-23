package com.ems.service;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.NotificationDao;
import com.ems.domain.Notification;

@Service
@Transactional
public class NotificationServiceImpl implements NotificationService{

	@Autowired private NotificationDao notificationDao;
	
	public long addNotification(Notification notification) {
		
		return this.notificationDao.addNotification(notification);
	}

	public boolean updateNotification(Notification notification) {
		
		return this.notificationDao.updateNotification(notification);
	}

	public List<Notification> getUnviewedNotificationByUserId(String userid) {
		
		return this.notificationDao.getUnviewedNotificationByUserId(userid);
	}

	public long countNotification(String userid) {
		
		return this.notificationDao.countNotification(userid);
	}

	public boolean updateNotificationByUserId(String userid) {
		
		return this.notificationDao.updateNotificationByUserId(userid);
	}

	public Notification getNotificationById(long nid) {
		
		return this.notificationDao.getNotificationById(nid);
	}

	public List<Notification> getNotificationBetweenTwoDates(String userid, Date startDate, Date endDate) {
		
		return this.notificationDao.getNotificationBetweenTwoDates(userid, startDate, endDate);
	}

}
