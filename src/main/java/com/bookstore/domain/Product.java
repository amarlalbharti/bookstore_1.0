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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.JoinColumn;

@Entity
@Table(name="product")
public class Product
{
	
	@Id
	@Column(nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int pid;
	
	@Column(nullable=false)
	private String productName;
	
	@Column(nullable=false)
	private String shortDesc;
	
	@Column
	private String productUrl;
	
	@Column(nullable=false)
	private int productViewed;
	
	@Column
	private String productImage;
	
	@Column(nullable=false)
	private Double productPrice;

	@Column(nullable=false)
	private Double productMRP;
	
	@Column(nullable=false)
	private boolean active;

	@Column(nullable=false)
	private Date createDate;

	@Column(nullable=false)
	private Date modifyDate;

	@Column
	private Date deleteDate;

	
	@Column(nullable=false)
	private boolean disableByButton;

	@Column(nullable=false)
	private boolean showOnHomePage;
	
	@Column(nullable=false)
	private boolean customerReview;

	@Column
	private String productTin;

	
	@ManyToMany(cascade = {CascadeType.ALL}, fetch = FetchType.LAZY)
    @JoinTable(name="product_attributevalue", 
                joinColumns={@JoinColumn(name="pid")}, 
                inverseJoinColumns={@JoinColumn(name="attributeValueId")})
	private Set<AttributeValue> attributeValues = new HashSet();

	public int getPid()
	{
		return pid;
	}

	public void setPid(int pid)
	{
		this.pid = pid;
	}

	public String getProductName()
	{
		return productName;
	}

	public void setProductName(String productName)
	{
		this.productName = productName;
	}

	public String getShortDesc()
	{
		return shortDesc;
	}

	public void setShortDesc(String shortDesc)
	{
		this.shortDesc = shortDesc;
	}

	public String getProductUrl()
	{
		return productUrl;
	}

	public void setProductUrl(String productUrl)
	{
		this.productUrl = productUrl;
	}

	public int getProductViewed()
	{
		return productViewed;
	}

	public void setProductViewed(int productViewed)
	{
		this.productViewed = productViewed;
	}

	public String getProductImage()
	{
		return productImage;
	}

	public void setProductImage(String productImage)
	{
		this.productImage = productImage;
	}

	public Double getProductPrice()
	{
		return productPrice;
	}

	public void setProductPrice(Double productPrice)
	{
		this.productPrice = productPrice;
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

	public Date getDeleteDate()
	{
		return deleteDate;
	}

	public void setDeleteDate(Date deleteDate)
	{
		this.deleteDate = deleteDate;
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
