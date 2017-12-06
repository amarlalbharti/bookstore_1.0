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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.JoinColumn;

@Entity
@Table(name="product")
public class Product
{
	@Id
	@Column(name = "pid", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int pid;
	
	@Column(name = "product_name", nullable=false)
	private String productName;
	
	@Column(name = "short_desc", nullable=false)
	private String shortDesc;
	
	@Column(name = "product_url")
	private String productUrl;
	
	@Column(name = "product_viewed", nullable=false)
	private int productViewed;
	
	@Column(name = "product_sku")
	private String productSKU;
	
	@Column(name = "product_price", nullable=false)
	private Double productPrice;

	@Column(name = "product_mrp", nullable=false)
	private Double productMRP;
	
	@Column(name = "active", nullable=false)
	private boolean active;

	@Column(name = "create_date", nullable=false)
	private Date createDate;

	@Column(name = "modify_date", nullable=false)
	private Date modifyDate;

	@Column(name = "delete_date")
	private Date deleteDate;

	@Column(name = "disable_buy_button", nullable=false)
	private boolean disableBuyButton;

	@Column(name = "show_on_home_page", nullable=false)
	private boolean showOnHomePage;
	
	@Column(name = "customer_review", nullable=false)
	private boolean customerReview;

	@Column(name = "product_tin")
	private String productTin;

	@ManyToMany(cascade = {CascadeType.ALL}, fetch = FetchType.LAZY)
    @JoinTable(name="product_category", 
                joinColumns={@JoinColumn(name="pid")}, 
                inverseJoinColumns={@JoinColumn(name="cid")})
	private Set<Category> categories = new HashSet();

	
	@OneToMany(mappedBy="product", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	private Set<ProductImage> productImages = new HashSet();
	
	@OneToMany(mappedBy="product", cascade=CascadeType.ALL, fetch=FetchType.LAZY) 
	private Set<ProductAttribute> productAttributes = new HashSet();
	
	
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

	public String getProductSKU()
	{
		return productSKU;
	}

	public void setProductSKU(String productSKU)
	{
		this.productSKU = productSKU;
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

	public Set<Category> getCategories()
	{
		return categories;
	}

	public void setCategories(Set<Category> categories)
	{
		this.categories = categories;
	}

	public Double getProductMRP()
	{
		return productMRP;
	}

	public void setProductMRP(Double productMRP)
	{
		this.productMRP = productMRP;
	}

	public boolean isDisableBuyButton()
	{
		return disableBuyButton;
	}

	public void setDisableBuyButton(boolean disableBuyButton)
	{
		this.disableBuyButton = disableBuyButton;
	}

	public boolean isShowOnHomePage()
	{
		return showOnHomePage;
	}

	public void setShowOnHomePage(boolean showOnHomePage)
	{
		this.showOnHomePage = showOnHomePage;
	}

	public boolean isCustomerReview()
	{
		return customerReview;
	}

	public void setCustomerReview(boolean customerReview)
	{
		this.customerReview = customerReview;
	}

	public String getProductTin()
	{
		return productTin;
	}

	public void setProductTin(String productTin)
	{
		this.productTin = productTin;
	}

	public Set<ProductImage> getProductImages()
	{
		return productImages;
	}

	public void setProductImages(Set<ProductImage> productImages)
	{
		this.productImages = productImages;
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
