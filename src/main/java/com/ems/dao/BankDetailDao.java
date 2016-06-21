package com.ems.dao;

import com.ems.domain.BankDetail;
import com.ems.domain.UserDetail;


public interface BankDetailDao {
	
	public int addBankDetails(BankDetail bankDetail);
	
    public BankDetail getUserId(String userid);
	
    public boolean editBankDetails(BankDetail bankDetail);
	

}
