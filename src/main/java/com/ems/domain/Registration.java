package com.ems.domain;

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
	
	private int lid;
	
	private String eId;
	
	private String name;
	
	private String userid;
	
	private String dob;
	
	private Department department;
	
	private Designation designation;
	
	private Date joiningDate; 
	
	private Date regdate;

	private Date modification_date;
	
	private String gender;
	
	private String profileImage;
	
	private String panImage;
	
	private LoginInfo log;
	
	private Branch branch;
	
	private Set<Attendance> attendances = new HashSet<Attendance>();

	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getLid() {
		return lid;
	}

	public void setLid(int lid) {
		this.lid = lid;
	}

	@Column(nullable=false)
	public String geteId() {
		return eId;
	}

	public void seteId(String eId) {
		this.eId = eId;
	}
	
	@Column(nullable=false)
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	@Column(nullable=false)
	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	@Column(nullable=false)
	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	@Column
	public Date getModification_date() {
		return modification_date;
	}

	public void setModification_date(Date modification_date) {
		this.modification_date = modification_date;
	}

	

	@Column(nullable=false)
	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	
	
	@Column(nullable=false)
	public Date getJoiningDate() {
		return joiningDate;
	}

	public void setJoiningDate(Date joiningDate) {
		this.joiningDate = joiningDate;
	}

	
	
	@Column(nullable= false)
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	@Column
	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	
	@Column
	public String getPanImage() {
		return panImage;
	}

	public void setPanImage(String panImage) {
		this.panImage = panImage;
	}

	
	
	@ManyToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="department_id", referencedColumnName="departmentId")
	public Department getDepartment() {
		return department;
	}

	
	public void setDepartment(Department department) {
		this.department = department;
	}

	@ManyToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="designation_id", referencedColumnName="designationId")
	public Designation getDesignation() {
		return designation;
	}

	public void setDesignation(Designation designation) {
		this.designation = designation;
	}
	
	
	@ManyToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="branch_id", referencedColumnName="branchId")
	public Branch getBranch() {
		return branch;
	}

	public void setBranch(Branch branch) {
		this.branch = branch;
	}

	@OneToOne(fetch = FetchType.LAZY) 
    @JoinColumn(name="log_id" , referencedColumnName="lid") 
	public LoginInfo getLog() {
		return log;
	}

	public void setLog(LoginInfo log) {
		this.log = log;
	}

	
	@OneToMany(fetch = FetchType.LAZY, cascade=CascadeType.ALL, mappedBy="registration" )  
	public Set<Attendance> getAttendances() {
		return attendances;
	}

	public void setAttendances(Set<Attendance> attendances) {
		this.attendances = attendances;
	}
	
	
	
	private UserDetail userDetail;

	@OneToOne(fetch = FetchType.LAZY, cascade=CascadeType.ALL, mappedBy="registration" )  
	public UserDetail getUserDetail() {
		return userDetail;
	}

	public void setUserDetail(UserDetail userDetail) {
		this.userDetail = userDetail;
	}
	
	
	private Set<LeaveDetail> leaveDetail = new HashSet<LeaveDetail>();

	@OneToMany(fetch = FetchType.LAZY, cascade=CascadeType.ALL, mappedBy="registration" )  
	public Set<LeaveDetail> getLeaveDetail() {
		return leaveDetail;
	}

	public void setLeaveDetail(Set<LeaveDetail> leaveDetail) {
		this.leaveDetail = leaveDetail;
	}
	
	
	private BankDetail bankDetail;

	@OneToOne(fetch = FetchType.LAZY, cascade=CascadeType.ALL, mappedBy="registration" )
	public BankDetail getBankDetail() {
		return bankDetail;
	}

	public void setBankDetail(BankDetail bankDetail) {
		this.bankDetail = bankDetail;
	}
	
	private int weekOff;
	@Column(nullable=false)
	public int getWeekOff() {
		return weekOff;
	}
	public void setWeekOff(int weekOff) {
		this.weekOff = weekOff;
	}
	
	private Set<Payroll> payRolls = new HashSet<Payroll>();
    
    @OneToMany(fetch = FetchType.LAZY, cascade=CascadeType.ALL, mappedBy="registration" )  
    public Set<Payroll> getPayRolls() {
        return payRolls;
    }

    public void setPayRolls(Set<Payroll> payRolls) {
        this.payRolls = payRolls;
    }
	
}
