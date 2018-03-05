package com.bookstore.dao;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.City;

@Repository
public class CityDaoImpl implements CityDao
{
	@Autowired
	private SessionFactory sessionFactory;
	static final Logger LOGGER = Logger.getLogger(CityDaoImpl.class);
	
	
	public int addCity(City city) {
		try {
			this.sessionFactory.getCurrentSession().save(city);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return city.getCityId();
		}catch (Exception e) {
			LOGGER.error("Error in addCity()", e);
		}
		return 0;
	}
	
	public boolean updateCity(City city) {
		try {
			this.sessionFactory.getCurrentSession().update(city);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return true;
		}catch (Exception e) {
			LOGGER.error("Error in updateCity() >> ", e);
		}
		return false;
	}
	
	public City getCity(int cityId) {
		try {
			return (City)this.sessionFactory.getCurrentSession().get(City.class , cityId);
		}catch (Exception e) {
			LOGGER.error("Error in getCity(int cityId) >>", e);
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<City> searchCity(String text){
		try {
			return this.sessionFactory.getCurrentSession().createCriteria(City.class)
					.add(Restrictions.like("cityName", text, MatchMode.ANYWHERE))
					.list();
		}catch (Exception e) {
			LOGGER.error("Error in searchCity(String text) >> ", e);
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<City> getCityByStateId(int stateId) {
		try {
			return this.sessionFactory.getCurrentSession().createCriteria(City.class)
					.createAlias("state", "stateAlias")
					.add(Restrictions.eq("stateAlias.stateId", stateId))
					.add(Restrictions.eq("active", Boolean.TRUE))
					.list();
		}catch (Exception e) {
			LOGGER.error("Error in getCityByStateId(int stateId)  >> ", e);
		}
		return null;
	}
	

}
