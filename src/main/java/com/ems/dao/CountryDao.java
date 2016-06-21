package com.ems.dao;

import java.util.List;

import com.ems.domain.Branch;
import com.ems.domain.Country;

public interface CountryDao {
	public Country getCountryById(int countryId);
	
	public List<Country> getCountryList();
	
	
    public int addCountry(Country country);
	
	public boolean updateCountry(Country country);
	 
}
