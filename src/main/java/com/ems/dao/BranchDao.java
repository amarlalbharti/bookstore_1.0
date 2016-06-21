package com.ems.dao;

import java.util.List;

import com.ems.domain.Branch;
import com.ems.domain.LoginInfo;
;

public interface BranchDao 
{
	public Branch getBranchById(int branchId);
	
	public List<Branch> getBranchList();
	
	public List<Branch> getBranchByCountryId(int countryId);

	public int addBranch(Branch branch);
	
	public int updateBranch(Branch branch);
	
	public boolean deleteBranch(int branchId);
	
}
