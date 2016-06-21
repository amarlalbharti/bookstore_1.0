package com.ems.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * Used for Notifications 
 * 
 * @author Saumya
 *
 */

@Entity
@Table(name="notification")
public class Notification implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8300538530027367750L;
	
	private long nId;
	
	private String type;
	
	private long notiId;
	
	private String notiMsg;
	
	private String isViewed;
	
	private Date createDate;
	
	private Date deleteDate;
	
	private Registration notiBy;
	
	private Registration notiTo;
	
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public long getnId() {
		return nId;
	}
	public void setnId(long nId) {
		this.nId = nId;
	}
	
	@Column
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	@Column
	public long getNotiId() {
		return notiId;
	}
	public void setNotiId(long notiId) {
		this.notiId = notiId;
	}
	
	@Column
	public String getNotiMsg() {
		return notiMsg;
	}
	public void setNotiMsg(String notiMsg) {
		this.notiMsg = notiMsg;
	}
	
	@Column
	public String getIsViewed() {
		return isViewed;
	}
	public void setIsViewed(String isViewed) {
		this.isViewed = isViewed;
	}
	
	
	
	
	@Column
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	@Column
	public Date getDeleteDate() {
		return deleteDate;
	}
	public void setDeleteDate(Date deleteDate) {
		this.deleteDate = deleteDate;
	}
	
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="noti_by", referencedColumnName="lid")
	public Registration getNotiBy() {
		return notiBy;
	}
	public void setNotiBy(Registration notiBy) {
		this.notiBy = notiBy;
	}
	
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="noti_to", referencedColumnName="lid")
	public Registration getNotiTo() {
		return notiTo;
	}
	public void setNotiTo(Registration notiTo) {
		this.notiTo = notiTo;
	}
	
	
	

}
