package com.bookstore.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.comparator.CategoryComparator;
import com.bookstore.dao.CategoryDao;
import com.bookstore.dao.LoginInfoDao;
import com.bookstore.domain.Category;

@Service
@Transactional
public class CategoryServiceImpl implements CategoryService
{
	@Autowired private CategoryDao categoryDao;
	public int addCategory(Category category)
	{
		return this.categoryDao.addCategory(category);
	}

	public boolean updateCategory(Category category)
	{
		return this.categoryDao.updateCategory(category);
	}

	public Category getCategoryById(Integer categoryId)
	{
		return this.categoryDao.getCategoryById(categoryId);
	}
	
	public List<Category> getAllCategories(){
		List<Category> categories = this.categoryDao.getAllCategories();
		List<Category> mainlist = new ArrayList();
		for(Category cat : categories){
			if(cat.getParent() == null){
				mainlist.add(cat);
			}
		}
		Collections.sort(mainlist, new CategoryComparator());
		List<Category> finallist = new ArrayList();
        categories.removeAll(mainlist);
        for(Category cat : mainlist){
                finallist.add(cat);
                finallist.addAll(getChildCategories(cat, categories));
        }
        return finallist;
	}
	
	public List<Category> getAllCategories(int first, int max){
		return this.categoryDao.getAllCategories(first, max);
	}
	public List<Category> getAllRootCategories(int first, int max){
		return this.categoryDao.getAllRootCategories(first, max);
	}
	
	public List<Category> getRootCategories(int first, int max){
		return this.categoryDao.getRootCategories(first, max);
	}
	
	public List<Category> getCategoriesByParentid(int parentId, int first, int max){
		return this.categoryDao.getCategoriesByParentid(parentId, first, max);
	}
	
	
	public long countAllCategories(){
		return this.categoryDao.countAllCategories();
	}
	
	public long countAllRootCategories(){
		return this.categoryDao.countAllRootCategories();
	}
	
	public long countRootCategories(){
		return this.categoryDao.countRootCategories();
	}
	
	public long countCategoriesByParentid(int parentId){
		return this.categoryDao.countCategoriesByParentid(parentId);
	}


    public static List<Category> getChildCategories(Category parent , List<Category> categories){
        List<Category> res = new ArrayList();
        Iterator it = categories.iterator();
        while(it.hasNext()){
            Category cat = (Category)it.next();
            if(cat.getParent() != null && parent.getCid() == cat.getParent().getCid()){
                res.add(cat);
                res.addAll(getChildCategories(cat, categories));
            }
        }
        return res; 
    }
}
