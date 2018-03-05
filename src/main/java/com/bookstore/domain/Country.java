package com.bookstore.domain;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="country")
public class Country
{
	@Id
	@Column(name = "country_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int countryId;
	
	@Column(name = "country_name", nullable=false)
	private String countryName;
	
	@Column(name = "country_code")
	private String countryCode;
	
	@Column(name = "comment")
	private String comment;

	@OneToMany(mappedBy="country", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	private Set<State> states;
	
	public int getCountryId()
	{
		return countryId;
	}

	public void setCountryId(int countryId)
	{
		this.countryId = countryId;
	}

	public String getCountryName()
	{
		return countryName;
	}

	public void setCountryName(String countryName)
	{
		this.countryName = countryName;
	}

	public String getCountryCode()
	{
		return countryCode;
	}

	public void setCountryCode(String countryCode)
	{
		this.countryCode = countryCode;
	}

	public String getComment()
	{
		return comment;
	}

	public void setComment(String comment)
	{
		this.comment = comment;
	}

	public Set<State> getStates()
	{
		return states;
	}

	public void setStates(Set<State> states)
	{
		this.states = states;
	}
	
	
	
}
