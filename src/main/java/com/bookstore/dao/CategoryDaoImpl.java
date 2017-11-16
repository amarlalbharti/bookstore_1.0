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

import com.bookstore.domain.Category;

@Repository
public class CategoryDaoImpl implements CategoryDao
{

	@Autowired private SessionFactory sessionFactory;
	
	public int addCategory(Category category)
	{
		try {
			this.sessionFactory.getCurrentSession().save(category);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return category.getCid();
			
		} catch (Exception e){
			System.out.println("Error in Adding category : " + category.getCategoryName());
			e.printStackTrace();
		}
		return 0;
	}

	public boolean updateCategory(Category category)
	{
		try {
			this.sessionFactory.getCurrentSession().saveOrUpdate(category);
			this.sessionFactory.getCurrentSession().flush();
			this.sessionFactory.getCurrentSession().clear();
			return true;
			
		} catch (Exception e){
			System.out.println("Error in Update category : " + category.getCid() +" : "+ category.getCategoryName());
		}
		return false;
	}

	public Category getCategoryById(Integer categoryId)
	{
		try {
			
			return (Category)this.sessionFactory.getCurrentSession().get(Category.class, categoryId);
			
		} catch (Exception e){
			System.out.println("Error in getCategoryById : " + categoryId);
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Category> getAllCategories(){
		try {
			
			return this.sessionFactory.getCurrentSession().createCriteria(Category.class)
					.addOrder(Order.asc("displayOrder"))
					.list();
			
		} catch (Exception e){
			System.out.println("Error in getAllCategories ");
			e.printStackTrace();
		}
		return null;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Category> getAllCategories(int first, int max){
		try {
			
			return this.sessionFactory.getCurrentSession().createCriteria(Category.class).addOrder(Order.asc("categoryName"))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setFirstResult(first)
					.setMaxResults(max)
					.list();
			
		} catch (Exception e){
			System.out.println("Error in getAllCategories ");
			e.printStackTrace();
		}
		return null;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Category> getAllRootCategories(int first, int max){
		try {
			
			return this.sessionFactory.getCurrentSession().createCriteria(Category.class)
					.add(Restrictions.isNull("parent"))
					.setFirstResult(first)
					.setMaxResults(max)
					.setFetchMode("childCategories", FetchMode.JOIN)
					.addOrder(Order.asc("categoryName"))
					.list();
		} catch (Exception e){
			System.out.println("Error in getAllRootCategories ");
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Category> getRootCategories(int first, int max)
	{
		try {
			
			return this.sessionFactory.getCurrentSession().createCriteria(Category.class)
					.add(Restrictions.isNull("deleteDate"))
					.add(Restrictions.isNull("parent"))
					.setFirstResult(first)
					.setMaxResults(max)
					.addOrder(Order.asc("categoryName"))
					.list();
		} catch (Exception e){
			System.out.println("Error in getAllRootCategories ");
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Category> getCategoriesByParentid(int parentId, int first, int max){
		try {
			
			return this.sessionFactory.getCurrentSession().createCriteria(Category.class)
					.add(Restrictions.isNull("deleteDate"))
					.add(Restrictions.eq("parent.cid", parentId))
					.setFirstResult(first)
					.setMaxResults(max)
					.addOrder(Order.asc("categoryName"))
					.list();
		} catch (Exception e){
			System.out.println("Error in getAllRootCategories ");
			e.printStackTrace();
		}
		return null;
	}
	
	public long countAllCategories(){
		try {
			
			return (Long)this.sessionFactory.getCurrentSession().createCriteria(Category.class)
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
		} catch (Exception e){
			System.out.println("Error in getAllCategories ");
			e.printStackTrace();
		}
		return 0;
	}
	
	public long countAllRootCategories(){
		try {
			
			return (Long)this.sessionFactory.getCurrentSession().createCriteria(Category.class)
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.add(Restrictions.isNull("parent"))
					.setProjection(Projections.rowCount())
					.uniqueResult();
		} catch (Exception e){
			System.out.println("Error in getAllRootCategories ");
			e.printStackTrace();
		}
		return 0;
	}
	
	public long countRootCategories()
	{
		try {
			
			return (Long)this.sessionFactory.getCurrentSession().createCriteria(Category.class)
					.add(Restrictions.isNull("deleteDate"))
					.add(Restrictions.isNull("parent"))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.setProjection(Projections.rowCount())
					.uniqueResult();
		} catch (Exception e){
			System.out.println("Error in getAllRootCategories ");
			e.printStackTrace();
		}
		return 0;
	}
	
	public long countCategoriesByParentid(int parentId){
		try {
			
			return (Long)this.sessionFactory.getCurrentSession().createCriteria(Category.class)
					.add(Restrictions.isNull("deleteDate"))
					.add(Restrictions.eq("parent.cid", parentId))
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
