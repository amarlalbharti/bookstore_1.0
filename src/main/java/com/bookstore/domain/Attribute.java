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
import javax.persistence.Table;

@Entity
@Table(name="attribute")
public class Attribute implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1694865627897752349L;

	@Id
	@Column(name = "attribute_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int attributeId;
	
	@Column(name="attribute_name", nullable=false)
	private String attributeName;
	
	@Column(name = "active", nullable=false)
	private boolean active;
	
	@Column(name="create_date", nullable=false)
	private Date createDate;
	
	@Column(name="modify_date", nullable=true)
	private Date modifyDate;

	@OneToMany(mappedBy="attribute", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	private Set<AttributeValue> attributeValues = new HashSet(); 
	
	
	public int getAttributeId()
	{
		return attributeId;
	}

	public void setAttributeId(int attributeId)
	{
		this.attributeId = attributeId;
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
