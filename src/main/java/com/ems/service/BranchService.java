package com.ems.service;

import java.util.List;

import com.ems.domain.Branch;


public interface BranchService
{
	public Branch getBranchById(int branchId);
	
	public List<Branch> getBranchList();
	
	public List<Branch> getBranchByCountryId(int countryId);
	
	public int addBranch(Branch branch);
	
	public int updateBranch(Branch branch);
	
}
