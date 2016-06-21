package com.ems.service;

import java.util.List;

import com.ems.domain.Country;

public interface CountryService {
	
	
	public Country getCountryById(int countryId);
	
	public List<Country> getCountryList();
	
    public int addCountry(Country country);
	
	public boolean updateCountry(Country country);
}
