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
@Table(name="state")
public class State
{
	@Id
	@Column(name = "state_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int stateId;
	
	@Column(name = "state_name", nullable=false)
	private String stateName;
	
	@Column(name = "comment", nullable=false)
	private String comment;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="country_id", referencedColumnName="country_id")
	private Country country;

	@OneToMany(mappedBy="state", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	private Set<City> cities;
	
	public int getStateId()
	{
		return stateId;
	}

	public void setStateId(int stateId)
	{
		this.stateId = stateId;
	}

	public String getStateName()
	{
		return stateName;
	}

	public void setStateName(String stateName)
	{
		this.stateName = stateName;
	}

	public String getComment()
	{
		return comment;
	}

	public void setComment(String comment)
	{
		this.comment = comment;
	}

	public Country getCountry()
	{
		return country;
	}

	public void setCountry(Country country)
	{
		this.country = country;
	}

	public Set<City> getCities()
	{
		return cities;
	}

	public void setCities(Set<City> cities)
	{
		this.cities = cities;
	}
	
	
}
