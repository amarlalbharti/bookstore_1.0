package com.bookstore.dao;

import java.util.List;

import com.bookstore.domain.Attribute;

public interface AttributeDao
{
	public int addAttribute(Attribute attribute);
	
	public boolean updateAttribute(Attribute attribute);
	
	public Attribute getAttributeByAttributeId(int attributeId);
	
	public List<Attribute> getAttributes();
	
	public List<Attribute> getAttributeNotMappedByPid(int pid);
	
}
