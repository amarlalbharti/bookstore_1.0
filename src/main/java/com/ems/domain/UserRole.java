package com.ems.domain;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="userrole")
public class UserRole implements Serializable
{
	private int sn;
	
//	private String userid;
	
	private String userrole;
	
	private LoginInfo log;
	
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getSn() {
		return sn;
	}
	public void setSn(int sn) {
		this.sn = sn;
	}
	
	
	@Column(nullable=false)
	public String getUserrole() {
		return userrole;
	}
	public void setUserrole(String userrole) {
		this.userrole = userrole;
	}
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="userid", referencedColumnName="userid")
	public LoginInfo getLog() {
		return log;
	}
	public void setLog(LoginInfo log) {
		this.log = log;
	}
}
