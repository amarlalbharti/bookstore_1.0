package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.AttributeValueDao;
import com.bookstore.domain.AttributeValue;

@Service
@Transactional
public class AttributeValueServiceImpl implements AttributeValueService
{
	@Autowired
	private AttributeValueDao attributeValueDao;
	
	public int addAttributeValue(AttributeValue attributeValue)
	{
		return this.attributeValueDao.addAttributeValue(attributeValue);
	}

	public boolean updateAttributeValue(AttributeValue attributeValue)
	{
		return this.attributeValueDao.updateAttributeValue(attributeValue);
	}

	public boolean deleteAttributeValue(AttributeValue attributeValue)
	{
		return this.attributeValueDao.deleteAttributeValue(attributeValue);
	}
	public AttributeValue getAttributeValueById(int attributeValueId)
	{
		return this.attributeValueDao.getAttributeValueById(attributeValueId);
	}

	public List<AttributeValue> getAttrbuteValuesByAttributeId(int attributeId)
	{
		return this.attributeValueDao.getAttrbuteValuesByAttributeId(attributeId);
	}

}
