package com.bookstore.domain;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="city")
public class City
{
	@Id
	@Column(name = "city_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int cityId;
	
	@Column(name = "city_name", nullable=false)
	private String cityName;
	
	@Column(name = "comment", nullable=false)
	private String comment;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="state_id", referencedColumnName="state_id")
	private State state;

	@Column(name = "active", nullable=false)
	private boolean active;
	
	@OneToMany(mappedBy="customerCity", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	private Set<CustomerAddress> customerAddresses;
	
	
	public int getCityId()
	{
		return cityId;
	}

	public void setCityId(int cityId)
	{
		this.cityId = cityId;
	}

	public String getCityName()
	{
		return cityName;
	}

	public void setCityName(String cityName)
	{
		this.cityName = cityName;
	}

	public String getComment()
	{
		return comment;
	}

	public void setComment(String comment)
	{
		this.comment = comment;
	}

	public State getState()
	{
		return state;
	}

	public void setState(State state)
	{
		this.state = state;
	}

	public boolean isActive()
	{
		return active;
	}

	public void setActive(boolean active)
	{
		this.active = active;
	}
	
	
	
}
