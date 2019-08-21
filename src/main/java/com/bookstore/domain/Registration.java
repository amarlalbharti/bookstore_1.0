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
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name="registration")
public class Registration implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8719433485080003372L;
	
	private int rid;
	
	private String firstName;
	
	private String lastName;
	
	private String contactno;
	
	private Date dob;
	
	private Date createDate;

	private Date modifyDate;
	
	private String gender;
	
	private String profileImage;
	
	private LoginInfo loginInfo;
	
	private Set<Basket> baskets = new HashSet();
	
	private Set<CustomerAddress> customerAddresses = new HashSet();
	
	
	@Id
	@Column(name = "rid", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getRid() {
		return rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}
	
	@Column(name = "first_name", nullable=false)
	public String getFirstName()
	{
		return firstName;
	}

	public void setFirstName(String firstName)
	{
		this.firstName = firstName;
	}

	@Column(name = "last_name")
	public String getLastName()
	{
		return lastName;
	}

	public void setLastName(String lastName)
	{
		this.lastName = lastName;
	}

	@Column(name = "contact_no")
	public String getContactno()
	{
		return contactno;
	}

	public void setContactno(String contactno)
	{
		this.contactno = contactno;
	}



	@Column(name = "create_date", nullable=false)
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Column(name = "modify_date")
	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	

	@Column(name = "dob")
	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	@Column(name = "gender", nullable= false)
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	@Column(name = "profile_image")
	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	
	@OneToOne(fetch = FetchType.EAGER) 
    @JoinColumn(name="lid" , referencedColumnName="lid") 
	public LoginInfo getLoginInfo() {
		return loginInfo;
	}

	public void setLoginInfo(LoginInfo loginInfo) {
		this.loginInfo = loginInfo;
	}
	
	@OneToMany(mappedBy="registration", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	public Set<Basket> getBaskets()
	{
		return baskets;
	}

	public void setBaskets(Set<Basket> baskets)
	{
		this.baskets = baskets;
	}

	@OneToMany(mappedBy="registration", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	public Set<CustomerAddress> getCustomerAddresses()
	{
		return customerAddresses;
	}

	public void setCustomerAddresses(Set<CustomerAddress> customerAddresses)
	{
		this.customerAddresses = customerAddresses;
	}
	
	

}
