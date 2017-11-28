package com.bookstore.model;


import org.hibernate.validator.constraints.NotEmpty;

public class AttributeModel
{
	private int attributeId;
	
	@NotEmpty(message="{NotEmpty.attributeForm.attributeName}")
	private String attributeName;
	
	private boolean active;

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
	
	
	
}
