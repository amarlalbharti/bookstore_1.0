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
@Table(name="attribute_value")
public class AttributeValue
{
	@Id
	@Column(name = "attribute_value_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int attributeValueId;
	
	@Column(name = "attribute_value", nullable=false)
	private String attributeValue;
	
	@Column(name = "active", nullable=false)
	private boolean active;
	
	@Column(name = "display_order", nullable=false)
	private int displayOrder;
	
	@Column(name = "create_date", nullable=false)
	private Date createDate;
	
	@ManyToOne
	@JoinColumn(name="attribute_id")
	private Attribute attribute;
	
	@ManyToMany(mappedBy="attributeValue", fetch = FetchType.LAZY)
	private Set<ProductAttribute> productAttributes = new HashSet();

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

	public int getDisplayOrder()
	{
		return displayOrder;
	}

	public void setDisplayOrder(int displayOrder)
	{
		this.displayOrder = displayOrder;
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

	public Set<ProductAttribute> getProductAttributes()
	{
		return productAttributes;
	}

	public void setProductAttributes(Set<ProductAttribute> productAttributes)
	{
		this.productAttributes = productAttributes;
	}

	
	
	
	
}
