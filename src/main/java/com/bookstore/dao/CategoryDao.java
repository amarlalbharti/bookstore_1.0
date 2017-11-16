package com.bookstore.dao;

import java.util.List;

import com.bookstore.domain.Category;

public interface CategoryDao
{
	public int addCategory(Category category);
	
	public boolean updateCategory(Category category);
	
	public Category getCategoryById(Integer categoryId);
	
	public List<Category> getAllCategories();
	
	public List<Category> getAllCategories(int first, int max);
	
	public List<Category> getAllRootCategories(int first, int max);
	
	public List<Category> getRootCategories(int first, int max);
	
	public List<Category> getCategoriesByParentid(int parentId, int first, int max);
	
	public long countAllCategories();
	
	public long countAllRootCategories();
	
	public long countRootCategories();
	
	public long countCategoriesByParentid(int parentId);
	
}
