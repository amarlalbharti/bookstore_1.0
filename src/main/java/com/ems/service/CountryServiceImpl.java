package com.ems.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.dao.CountryDao;
import com.ems.domain.Country;

@Service
@Transactional
public class CountryServiceImpl implements CountryService {

	@Autowired private CountryDao countryDao;
	
	public Country getCountryById(int countryId) {
		return this.countryDao.getCountryById(countryId);
	}

	public List<Country> getCountryList() {
		return this.countryDao.getCountryList();
	}

	public int addCountry(Country country) {
	
		return this.countryDao.addCountry(country);
	}

	public boolean updateCountry(Country country) {
		
		return this.countryDao.updateCountry(country);
	}
}
