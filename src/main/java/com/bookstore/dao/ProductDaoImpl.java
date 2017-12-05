package com.bookstore.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bookstore.domain.Product;

@Repository
public class ProductDaoImpl implements ProductDao
{
	@Autowired private SessionFactory sessionFactory;
	
	public int addProduct(Product product)
	{
		try{
			this.sessionFactory.getCurrentSession().save(product);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return product.getPid();
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}

	public boolean updateProduct(Product product)
	{
		try{
			this.sessionFactory.getCurrentSession().update(product);
			return true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	@SuppressWarnings("unchecked")
	public Product getProductById(Integer productId)
	{
		try{
			List<Product> list = this.sessionFactory.getCurrentSession().createCriteria(Product.class).add(Restrictions.eq("pid", productId)).setFetchMode("categories", FetchMode.JOIN).list();
			if(list != null && !list.isEmpty()) {
				return list.get(0);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public List<Product> getAllProducts()
	{
		try {
			
			return this.sessionFactory.getCurrentSession().createCriteria(Product.class).addOrder(Order.asc("categoryName")).list();
			
		} catch (Exception e){
			System.out.println("Error in getAllCategories ");
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<Product> getAllProducts(int first, int max)
	{
		try {
			
			return this.sessionFactory.getCurrentSession().createCriteria(Product.class)
					.setFirstResult(first)
					.setMaxResults(max)
					.addOrder(Order.asc("productName"))
					.list();
		} catch (Exception e){
			System.out.println("Error in getAllProducts ");
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<Product> getProducts(int first, int max)
	{
		try {
			
			return this.sessionFactory.getCurrentSession().createCriteria(Product.class)
					.add(Restrictions.isNull("deleteDate"))
					.setFirstResult(first)
					.setMaxResults(max)
					.addOrder(Order.asc("productName"))
					.list();
		} catch (Exception e){
			System.out.println("Error in getProducts ");
			e.printStackTrace();
		}
		return null;

	}

	@SuppressWarnings("unchecked")
	public List<Product> getProductsByCategoryIds(List<Integer> categoryIds, int first, int max)
	{
		try {
			return this.sessionFactory.getCurrentSession().createCriteria(Product.class)
					.add(Restrictions.isNull("deleteDate"))
					.createAlias("categories", "catAlias")
					.add(Restrictions.in("catAlias.cid", categoryIds))
					.setFirstResult(first)
					.setMaxResults(max)
					.addOrder(Order.asc("productName"))
					.list();
		} catch (Exception e){
			System.out.println("Error in getProducts ");
			e.printStackTrace();
		}
		return null;
	}

	public long countAllProducts()
	{
		try {
			
			return (Long)this.sessionFactory.getCurrentSession().createCriteria(Product.class)
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
		} catch (Exception e){
			System.out.println("Error in getAllRootCategories ");
			e.printStackTrace();
		}
		return 0;
	}

	public long countProducts()
	{
		try {
			
			return (Long)this.sessionFactory.getCurrentSession().createCriteria(Product.class)
					.add(Restrictions.isNull("deleteDate"))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
		} catch (Exception e){
			System.out.println("Error in getAllRootCategories ");
			e.printStackTrace();
		}
		return 0;
	}

	public long countProductsByCategoryIds(List<Integer> categoryIds)
	{
		try {
			
			return (Long)this.sessionFactory.getCurrentSession().createCriteria(Product.class)
					.add(Restrictions.isNull("deleteDate"))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
		} catch (Exception e){
			System.out.println("Error in getAllRootCategories ");
			e.printStackTrace();
		}
		return 0;
	}

}
