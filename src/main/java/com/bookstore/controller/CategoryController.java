package com.bookstore.controller;

import java.security.Principal;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookstore.config.Util;
import com.bookstore.config.Validation;
import com.bookstore.domain.Category;
import com.bookstore.model.CategoryModel;
import com.bookstore.service.CategoryService;

/**
 * @author A. L. Bharti
 *
 */
@Controller
public class CategoryController
{
	@Autowired private CategoryService categoryService; 
	
	@RequestMapping(value = "/categories", method = RequestMethod.GET)
	public String categories(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from Categories");
		
		map.addAttribute("categoryList", categoryService.getAllCategories());
		
		return "categories";
	}
	
	@RequestMapping(value = "/addCategory", method = RequestMethod.GET)
	public String addCategory(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("categoryForm", new CategoryModel());
		map.addAttribute("categoryList", categoryService.getAllCategories());
		System.out.println("from addCategory");
		return "addCategory";
	}
	
	@RequestMapping(value = "/addCategory", method = RequestMethod.POST)
	public String addCategory(@ModelAttribute(value = "categoryForm") @Valid CategoryModel model,BindingResult result,
			                  ModelMap map, HttpServletRequest request,Principal principal)
	{
		if (result.hasErrors()) {
			System.out.println("in validation");
			map.addAttribute("categoryList", categoryService.getAllCategories());
			return "addCategory";
		} else
		{
	       Category category = new Category();
	       category.setCategoryName(model.getCategoryName());
	       category.setCategoryDetail(model.getCategoryDetail());
	       category.setDisplayOrder(model.getDisplayOrder());
	       category.setActive(model.isActive());
	       category.setCreateDate(new Date());
	       category.setModifyDate(new Date());
	       categoryService.addCategory(category);
	       
		}
		
		return "redirect:categories";
	}
	
	@RequestMapping(value = "/editCategory", method = RequestMethod.GET)
	public String editCategory(ModelMap map, HttpServletRequest request, Principal principal)
	{
		try{
			String cid = request.getParameter("cid");
			if(cid != null && cid.trim().length() > 0){
				Category category = categoryService.getCategoryById(Integer.parseInt(cid));
				if(category != null){
					CategoryModel model = new CategoryModel();
					model.setCid(category.getCid());
					model.setCategoryName(category.getCategoryName());
					model.setCategoryDetail(category.getCategoryDetail());
					model.setDisplayOrder(category.getDisplayOrder());
					model.setActive(category.isActive());
					model.setParent(category.getParent());
					map.addAttribute("categoryForm", model);
					map.addAttribute("categoryList", categoryService.getAllCategories());
					System.out.println("from editCategory");
					return "editCategory";
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:categories";
	}
	@RequestMapping(value = "/editCategory", method = RequestMethod.POST)
	public String updateCategory(@ModelAttribute(value = "categoryForm") @Valid CategoryModel model,BindingResult result,
			                  ModelMap map, HttpServletRequest request,Principal principal)
	{
		if (result.hasErrors()) {
			map.addAttribute("categoryList", categoryService.getAllCategories());
			System.out.println("in validation");
			return "editCategory";
		} else
		{
		   Category category = categoryService.getCategoryById(model.getCid());
		   if(category != null){
			   if(model.getParent() != null && model.getParent().getCid() > 0){
				   category.setParent(model.getParent());
			   }else{
				   category.setParent(null);
			   }
			   category.setCategoryName(model.getCategoryName());
		       category.setCategoryDetail(model.getCategoryDetail());
		       category.setDisplayOrder(model.getDisplayOrder());
		       category.setActive(model.isActive());
		       category.setModifyDate(new Date());
		       categoryService.updateCategory(category);
		   }
		}
		return "redirect:categories";
	}
	@RequestMapping(value = "/changeStatus")
    public @ResponseBody String changeStatus(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String catStatus = request.getParameter("catStatus");
		String cid = request.getParameter("cid");
		JSONObject resp = new JSONObject();
		if(Validation.isNotNullNotEmpty(catStatus) && Validation.isNumeric(cid)){
			Category category = categoryService.getCategoryById(Util.getNumeric(cid));
			if(category != null){
				if(catStatus.equals("activate")){
					category.setActive(true);
					resp.put("msg", "Category activated successfully !");
				}else{
					category.setActive(false);
					resp.put("msg", "Category de-activated successfully !");
				}
				categoryService.updateCategory(category);
				resp.put("status", "success");
			}else{
				resp.put("status", "failed");
				resp.put("msg", "Oops Category not found !");
			}
		}else{
			resp.put("status", "failed");
			resp.put("msg", "Oops Something wrong !");
		}
		
		return resp.toJSONString();
	}
}
