package com.ems.dao;

import java.util.Date;
import java.util.List;
import com.ems.domain.Payroll;
import com.ems.domain.Registration;

public interface PayrollDao {

	public List<Payroll> getPayrollByEmpId(String empId);
	
	public List<Payroll> getPayrollList();
	
	public boolean addPayroll(Payroll payroll);
	
	public boolean updatePayroll(Payroll payroll);
	
	public Payroll getPayrollById(int pid);
	
	public List<Payroll> getOneMonthPayroll(Date sDate, Date eDate);
	
	public List<Payroll> getOneMonthPayroll(String userId, Date sDate, Date eDate);
	
}
