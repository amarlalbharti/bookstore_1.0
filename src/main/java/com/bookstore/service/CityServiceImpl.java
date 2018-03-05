package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.CityDao;
import com.bookstore.domain.City;

@Service
@Transactional
public class CityServiceImpl implements CityService
{
	@Autowired
	private CityDao cityDao;
	
	public int addCity(City city) {
		return this.cityDao.addCity(city);
	}
	
	public boolean updateCity(City city) {
		return this.cityDao.updateCity(city);
	}
	
	public City getCity(int cityId) {
		return this.cityDao.getCity(cityId);
	}
	
	public List<City> searchCity(String text){
		return this.cityDao.searchCity(text);
	}
	
	public List<City> getCityByStateId(int stateId){
		return this.cityDao.getCityByStateId(stateId);
	}
	
}
