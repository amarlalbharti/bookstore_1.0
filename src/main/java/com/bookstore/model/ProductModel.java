package com.bookstore.model;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

import com.bookstore.domain.Category;

public class ProductModel
{
	private int pid;
	
	@NotEmpty(message="{NotEmpty.productForm.productName}")
	private String productName;
	
	@NotEmpty(message="{NotEmpty.productForm.shortDesc}")
	private String shortDesc;
	
	private String productSKU;
	
	@NotNull(message="{NotEmpty.productForm.reqMRP}")
	@NumberFormat(style = Style.NUMBER, pattern = "#.###")
	private String productMRP;
	
	@NotNull(message="{NotEmpty.productForm.reqPrice}")
	@NumberFormat(style = Style.NUMBER, pattern = "#.###")
	private String productPrice;
	
	private String productTin;
	
	private boolean active;

	private boolean disableBuyButton;
	
	private boolean customerReview;

	private boolean showOnHomePage;
	
	private List<Integer> categories = new ArrayList<Integer>();
	
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

	public String getProductSKU()
	{
		return productSKU;
	}

	public void setProductSKU(String productSKU)
	{
		this.productSKU = productSKU;
	}

	public String getProductMRP()
	{
		return productMRP;
	}

	public void setProductMRP(String productMRP)
	{
		this.productMRP = productMRP;
	}

	public String getProductPrice()
	{
		return productPrice;
	}

	public void setProductPrice(String productPrice)
	{
		this.productPrice = productPrice;
	}

	public String getProductTin()
	{
		return productTin;
	}

	public void setProductTin(String productTin)
	{
		this.productTin = productTin;
	}

	public boolean isActive()
	{
		return active;
	}

	public void setActive(boolean active)
	{
		this.active = active;
	}

	public boolean isDisableBuyButton()
	{
		return disableBuyButton;
	}

	public void setDisableBuyButton(boolean disableBuyButton)
	{
		this.disableBuyButton = disableBuyButton;
	}

	public boolean isCustomerReview()
	{
		return customerReview;
	}

	public void setCustomerReview(boolean customerReview)
	{
		this.customerReview = customerReview;
	}

	public boolean isShowOnHomePage()
	{
		return showOnHomePage;
	}

	public void setShowOnHomePage(boolean showOnHomePage)
	{
		this.showOnHomePage = showOnHomePage;
	}

	public List<Integer> getCategories()
	{
		return categories;
	}

	public void setCategories(List<Integer> categories)
	{
		this.categories = categories;
	}

	
	
	
}
