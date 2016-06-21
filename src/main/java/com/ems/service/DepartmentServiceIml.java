package com.ems.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.DepartmentDao;
import com.ems.domain.Department;

@Service
@Transactional
public class DepartmentServiceIml implements DepartmentService
{
	@Autowired private DepartmentDao departmentDao;
	
	public Department getDepartmentById(int departmentId)
	{
		return this.departmentDao.getDepartmentById(departmentId);
	}
	public List<Department> getDepartmentList()
	{
		return this.departmentDao.getDepartmentList();
	}
	public int addDepartment(Department department) {
	
		return this.departmentDao.addDepartment(department);
	}
	public boolean updateDepartment(Department department) {
		
		return this.departmentDao.updateDepartment(department);
	}
}
