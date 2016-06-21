package com.ems.dao;

import java.util.List;

import com.ems.domain.Department;

public interface DepartmentDao 
{
	public Department getDepartmentById(int departmentId);
	
	public List<Department> getDepartmentList();
	
	public int addDepartment(Department department);
	
	public boolean updateDepartment(Department department);
	
}
