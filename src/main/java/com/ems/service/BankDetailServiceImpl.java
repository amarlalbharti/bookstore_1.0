package com.ems.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.BankDetailDao;
import com.ems.domain.BankDetail;

@Service
@Transactional
public class BankDetailServiceImpl implements BankDetailService{

	@Autowired private BankDetailDao bankDetailDao;
	public int addBankDetails(BankDetail bankDetail) {
	
		return this.bankDetailDao.addBankDetails(bankDetail);
	}
	public BankDetail getUserId(String userid) {
		
		return this.bankDetailDao.getUserId(userid);
	}
	public boolean editBankDetails(BankDetail bankDetail) {
	
		return this.bankDetailDao.editBankDetails(bankDetail);
	}

}
