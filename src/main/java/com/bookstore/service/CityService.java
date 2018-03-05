package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.City;

public interface CityService
{
	public int addCity(City city);
	
	public boolean updateCity(City city);
	
	public City getCity(int cityId);
	
	public List<City> searchCity(String text);
	
	public List<City> getCityByStateId(int stateId);
	
}
