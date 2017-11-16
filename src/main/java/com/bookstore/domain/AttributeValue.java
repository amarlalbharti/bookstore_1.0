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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="attributevalue")
public class AttributeValue
{
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int attributeValueId;
	
	@Column(nullable=false)
	private String attributeValue;
	
	@Column(nullable=false)
	private boolean active;
	
	@Column(nullable=false)
	private Date createDate;
	
	@ManyToOne(cascade=CascadeType.ALL) 
	@JoinColumn(name="attributeid", referencedColumnName="id")
	private Attribute attribute;
	
	@ManyToMany(mappedBy="attributeValues", fetch = FetchType.LAZY)
	private Set<Attribute> products = new HashSet();

	public int getAttributeValueId()
	{
		return attributeValueId;
	}

	public void setAttributeValueId(int attributeValueId)
	{
		this.attributeValueId = attributeValueId;
	}

	public String getAttributeValue()
	{
		return attributeValue;
	}

	public void setAttributeValue(String attributeValue)
	{
		this.attributeValue = attributeValue;
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

	public Attribute getAttribute()
	{
		return attribute;
	}

	public void setAttribute(Attribute attribute)
	{
		this.attribute = attribute;
	}

	public Set<Attribute> getProducts()
	{
		return products;
	}

	public void setProducts(Set<Attribute> products)
	{
		this.products = products;
	}
	
	
	
	
}