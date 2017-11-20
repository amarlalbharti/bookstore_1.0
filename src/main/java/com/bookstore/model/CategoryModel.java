package com.bookstore.model;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import com.bookstore.domain.Category;

public class CategoryModel
{
	private int cid;
	
	@NotEmpty(message="{NotEmpty.categoryForm.categoryName}")
	private String categoryName;
	
	@NotEmpty(message="{NotEmpty.categoryForm.categoryDetail}")
	private String categoryDetail;
	
	private boolean active;
	
	private int displayOrder;
	
	private MultipartFile categoryImage;
	
	private Category parent;

	public int getCid()
	{
		return cid;
	}

	public void setCid(int cid)
	{
		this.cid = cid;
	}

	public String getCategoryName()
	{
		return categoryName;
	}

	public void setCategoryName(String categoryName)
	{
		this.categoryName = categoryName;
	}

	public String getCategoryDetail()
	{
		return categoryDetail;
	}

	public void setCategoryDetail(String categoryDetail)
	{
		this.categoryDetail = categoryDetail;
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

	public MultipartFile getCategoryImage()
	{
		return categoryImage;
	}

	public void setCategoryImage(MultipartFile categoryImage)
	{
		this.categoryImage = categoryImage;
	}

	public Category getParent()
	{
		return parent;
	}

	public void setParent(Category parent)
	{
		this.parent = parent;
	}
	
	
	
}
