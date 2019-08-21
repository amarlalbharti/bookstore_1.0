package com.bookstore.domain;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="product_attribute_value")
public class ProductAttribute
{
	@Id
	@Column(name = "product_attribute_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int productAttributeId;
	
	@Column(name = "attribute_type", nullable=false)
	private String attributeType;
	
	@Column(name = "attribute_custom_value")
	private String attributeCustomValue;
	
	@Column(name = "allow_filter", nullable=false)
	private boolean allowFilter;
	
	@Column(name = "show_on_product_page", nullable=false)
	private boolean showOnProductPage;
	
	@Column(name = "display_order", nullable=false)
	private int displayOrder;
	
	@Column(name = "create_date", nullable=false)
	private Date createDate;

	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "attribute_value_id", referencedColumnName = "attribute_value_id")
	private AttributeValue attributeValue;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "attribute_id", referencedColumnName = "attribute_id")
	private Attribute attribute;
	
	@ManyToOne 
    @JoinColumn(name = "pid")
	public Product product;


	public int getProductAttributeId()
	{
		return productAttributeId;
	}

	public void setProductAttributeId(int productAttributeId)
	{
		this.productAttributeId = productAttributeId;
	}

	public String getAttributeType()
	{
		return attributeType;
	}

	public void setAttributeType(String attributeType)
	{
		this.attributeType = attributeType;
	}

	public String getAttributeCustomValue()
	{
		return attributeCustomValue;
	}

	public void setAttributeCustomValue(String attributeCustomValue)
	{
		this.attributeCustomValue = attributeCustomValue;
	}

	public boolean isAllowFilter()
	{
		return allowFilter;
	}

	public void setAllowFilter(boolean allowFilter)
	{
		this.allowFilter = allowFilter;
	}

	public boolean isShowOnProductPage()
	{
		return showOnProductPage;
	}

	public void setShowOnProductPage(boolean showOnProductPage)
	{
		this.showOnProductPage = showOnProductPage;
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

	public AttributeValue getAttributeValue()
	{
		return attributeValue;
	}

	public void setAttributeValue(AttributeValue attributeValue)
	{
		this.attributeValue = attributeValue;
	}

	public Attribute getAttribute()
	{
		return attribute;
	}

	public void setAttribute(Attribute attribute)
	{
		this.attribute = attribute;
	}

	public Product getProduct()
	{
		return product;
	}

	public void setProduct(Product product)
	{
		this.product = product;
	}
	
	
	
	
}
