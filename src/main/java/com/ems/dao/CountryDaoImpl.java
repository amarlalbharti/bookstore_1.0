package com.ems.dao;

import java.util.List;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ems.domain.Branch;
import com.ems.domain.Country;

@Repository
public class CountryDaoImpl implements CountryDao {

	@Autowired private SessionFactory sessionFactory;
	
	public Country getCountryById(int countryId) {
		return (Country)this.sessionFactory.getCurrentSession().get(Country.class, countryId);
	}

	@SuppressWarnings("unchecked")
	public List<Country> getCountryList() {
		
		return this.sessionFactory.getCurrentSession().createCriteria(Country.class)
				.add(Restrictions.isNull("deleteDate")).list();
	}

	public int addCountry(Country country) {
		
		this.sessionFactory.getCurrentSession().save(country);
		this.sessionFactory.getCurrentSession().flush();
		return country.getCountryId();
	}

	public boolean updateCountry(Country country) {
		try
		{
			this.sessionFactory.getCurrentSession().update(country);
			this.sessionFactory.getCurrentSession().flush();
			return true;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		
		
	}

}
