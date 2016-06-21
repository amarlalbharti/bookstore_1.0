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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Used for employee check In and Check Out 
 * 
 * @author Bharti
 *
 */
@Entity
@Table(name="attendance")
public class Attendance implements Serializable 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4821076592689041237L;

	private long aid;
	
	private Date inTime;
	
	private Date outTime;
	
	private String Task;
	
	private Registration registration;

	
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public long getAid() {
		return aid;
	}

	public void setAid(long aid) {
		this.aid = aid;
	}

	@Column(nullable=false)
	public Date getInTime() {
		return inTime;
	}

	public void setInTime(Date inTime) {
		this.inTime = inTime;
	}

	@Column
	public Date getOutTime() {
		return outTime;
	}

	public void setOutTime(Date outTime) {
		this.outTime = outTime;
	}
	
		
	@Column
	@Lob
	public String getTask() {
		return Task;
	}

	public void setTask(String task) {
		Task = task;
	}

	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="reg_id", referencedColumnName="lid")
	public Registration getRegistration() {
		return registration;
	}

	public void setRegistration(Registration registration) {
		this.registration = registration;
	}

	
	
	
	
	
	
	
}
