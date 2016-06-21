package com.ems.service;

import java.util.List;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ems.dao.BranchDao;
import com.ems.domain.Branch;


@Service
@Transactional
public class BranchServiceImpl implements BranchService
{
	@Autowired private BranchDao branchDao;

	public Branch getBranchById(int branchId) {
		
		return this.branchDao.getBranchById(branchId);
	}

	public List<Branch> getBranchList() {
		
		return this.branchDao.getBranchList();
	}

	public List<Branch> getBranchByCountryId(int countryId) {
		return this.branchDao.getBranchByCountryId(countryId);
	}

	public int addBranch(Branch branch) {
		return this.branchDao.addBranch(branch);
	}

	public int updateBranch(Branch branch) {
		return this.branchDao.updateBranch(branch);
	}
	
}
