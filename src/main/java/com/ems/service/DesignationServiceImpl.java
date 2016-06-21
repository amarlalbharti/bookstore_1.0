package com.ems.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.DesignationDao;
import com.ems.domain.Designation;

@Service
@Transactional
public class DesignationServiceImpl implements DesignationService 
{
	@Autowired private DesignationDao designationDao;
	
	public Designation getDesignationById(int designationId)
	{
		return this.designationDao.getDesignationById(designationId);
	}
	public List<Designation> getDesignationList()
	{
		return this.designationDao.getDesignationList();
	}
	public int addDesignation(Designation designation) {
		
		return this.designationDao.addDesignation(designation);
	}
	public boolean updateDesignation(Designation designation) {
		
		return this.designationDao.updateDesignation(designation);
	}
}
