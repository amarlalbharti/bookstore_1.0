package com.bookstore.domain;

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
@Table(name="user_role")
public class UserRole implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1328046800720780173L;

	@Id
	@Column(name = "sn", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int sn;
	
	@Column(name = "user_role", nullable=false)
	private String userrole;
	
	@ManyToOne() 
	@JoinColumn(name="userid", referencedColumnName="userid")
	private LoginInfo loginInfo;
	
	public int getSn() {
		return sn;
	}
	public void setSn(int sn) {
		this.sn = sn;
	}
	
	
	public String getUserrole() {
		return userrole;
	}
	public void setUserrole(String userrole) {
		this.userrole = userrole;
	}
	public LoginInfo getLoginInfo()
	{
		return loginInfo;
	}
	public void setLoginInfo(LoginInfo loginInfo)
	{
		this.loginInfo = loginInfo;
	}
	
	
}
