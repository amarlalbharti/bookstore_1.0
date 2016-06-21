package com.ems.service;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.PayrollDao;
import com.ems.domain.Payroll;

@Service
@Transactional
public class PayrollServiceImpl implements PayrollService {
	@Autowired private PayrollDao payrollDao;

	public List<Payroll> getPayrollByEmpId(String empId) {
		return this.payrollDao.getPayrollByEmpId(empId);
	}

	public List<Payroll> getPayrollList() {
		return this.payrollDao.getPayrollList();
	}

	public boolean addPayroll(Payroll payroll) {
		return this.payrollDao.addPayroll(payroll);
	}

	public boolean updatePayroll(Payroll payroll) {
		return this.payrollDao.updatePayroll(payroll);
	}

	public Payroll getPayrollById(int pid) {
		return this.payrollDao.getPayrollById(pid);
	}

	public List<Payroll> getOneMonthPayroll(Date sDate, Date eDate) {
		return this.payrollDao.getOneMonthPayroll(sDate, eDate);
	}

	public List<Payroll> getOneMonthPayroll(String userId, Date sDate, Date eDate) {
		return this.payrollDao.getOneMonthPayroll(userId, sDate, eDate);
	}

}
