package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.AttributeDao;
import com.bookstore.domain.Attribute;

@Service
@Transactional
public class AttributeServiceImlp implements AttributeService
{
	@Autowired 
	private AttributeDao attributeDao;
	
	public int addAttribute(Attribute attribute){
		return this.attributeDao.addAttribute(attribute);
	}
	
	public boolean updateAttribute(Attribute attribute){
		return this.attributeDao.updateAttribute(attribute);
	}
	
	public Attribute getAttributeByAttributeId(int attributeId){
		return this.attributeDao.getAttributeByAttributeId(attributeId);
	}
	
	public List<Attribute> getAttributes(){
		return this.attributeDao.getAttributes();
	}
	
	public List<Attribute> getAttributeNotMappedByPid(int pid){
		return this.attributeDao.getAttributeNotMappedByPid(pid);
	}
}
