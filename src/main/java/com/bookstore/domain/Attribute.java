package com.bookstore.domain;

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
import javax.persistence.Table;

@Entity
@Table(name="attribute")
public class Attribute
{
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	
	@Column(nullable=false)
	private String attributeName;
	
	@Column(nullable=false)
	private boolean active;
	
	@Column(nullable=false)
	private Date createDate;
	
	@Column(nullable=true)
	private Date modifyDate;

	@OneToMany(mappedBy="attribute", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	private Set<AttributeValue> attributeValues = new HashSet(); 
	
	
	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getAttributeName()
	{
		return attributeName;
	}

	public void setAttributeName(String attributeName)
	{
		this.attributeName = attributeName;
	}

	public boolean isActive()
	{
		return active;
	}

	public void setActive(boolean active)
	{
		this.active = active;
	}

	public Date getCreateDate()
	{
		return createDate;
	}

	public void setCreateDate(Date createDate)
	{
		this.createDate = createDate;
	}

	public Date getModifyDate()
	{
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate)
	{
		this.modifyDate = modifyDate;
	}

	public Set<AttributeValue> getAttributeValues()
	{
		return attributeValues;
	}

	public void setAttributeValues(Set<AttributeValue> attributeValues)
	{
		this.attributeValues = attributeValues;
	}
	
	
}