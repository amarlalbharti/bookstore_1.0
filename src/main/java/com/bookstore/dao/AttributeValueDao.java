package com.bookstore.dao;

import java.util.List;

import com.bookstore.domain.AttributeValue;

public interface AttributeValueDao
{
	public int addAttributeValue(AttributeValue attributeValue);
	
	public boolean updateAttributeValue(AttributeValue attributeValue);
	
	public boolean deleteAttributeValue(AttributeValue attributeValue);
	
	public AttributeValue getAttributeValueById(int attributeValueId);
	
	public List<AttributeValue> getAttrbuteValuesByAttributeId(int attributeId);
	
}
