package com.ems.service;

import com.ems.domain.BankDetail;

public interface BankDetailService {
	
	public int addBankDetails(BankDetail bankDetail);
	
    public BankDetail getUserId(String userid);
	
    public boolean editBankDetails(BankDetail bankDetail);

}
