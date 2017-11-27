package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.Attribute;

public interface AttributeService
{
	public int addAttribute(Attribute attribute);
	
	public boolean updateAttribute(Attribute attribute);
	
	public Attribute getAttributeByAttributeId(int attributeId);
	
	public List<Attribute> getAttributes();
	
}
