package com.bookstore.model;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

public class ProductModel
{
	private int pid;
	
	private String productName;
	
	private String shortDesc;
	
	private Double productPrice;
	
	private boolean active;

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
	
	
}
