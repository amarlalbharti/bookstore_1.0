package com.bookstore.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="login_info")
public class LoginInfo implements Serializable
{
	
	private static final long serialVersionUID = 503239969044315259L;

	private int lid;
	
	private String userid;
	
	private String password;
	
	private Date modifyDate;
	
	private String forgotpwdid;
	
	private String isActive;
	
	
	private Set<UserRole> roles = new HashSet();

	
	@Id
	@Column(name = "lid", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getLid() {
		return lid;
	}
	public void setLid(int lid) {
		this.lid = lid;
	}
	
	@Column(name = "userid", nullable=false, unique=true)
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	@Column(name = "password", nullable=false)
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	@Column(name = "modify_date")
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	
	@Column(name = "forgotpwdid")
	public String getForgotpwdid() {
		return forgotpwdid;
	}
	public void setForgotpwdid(String forgotpwdid) {
		this.forgotpwdid = forgotpwdid;
	}
	
	@Column(name = "active", nullable=false)
	public String getIsActive() {
		return isActive;
	}
	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}
	
	@OneToMany(fetch = FetchType.LAZY, cascade=CascadeType.ALL, mappedBy="userrole" )  
	public Set<UserRole> getRoles() {
		return roles;
	}
	public void setRoles(Set<UserRole> roles) {
		this.roles = roles;
	}
	
	private Registration registration;


	@OneToOne(mappedBy="loginInfo")
    public Registration getRegistration() {
		return registration;
	}
	public void setRegistration(Registration registration) {
		this.registration = registration;
	}
	
}
