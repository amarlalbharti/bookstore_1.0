package com.bookstore.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bookstore.config.ProjectConfig;
import com.bookstore.config.Util;
import com.bookstore.config.Validation;
import com.bookstore.domain.Category;
import com.bookstore.domain.Product;
import com.bookstore.model.CategoryModel;
import com.bookstore.service.CategoryService;
import com.bookstore.service.ProductService;

/**
 * @author A. L. Bharti
 *
 */
@Controller
public class CategoryController
{
	@Autowired private CategoryService categoryService; 
	@Autowired private ProductService productService; 
	
	@RequestMapping(value = "admin/category", method = RequestMethod.GET)
	public String categories(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from Categories");
		
		map.addAttribute("categoryList", categoryService.getAllCategories());
		
		return "categories";
	}
	
	@RequestMapping(value = "admin/category/add", method = RequestMethod.GET)
	public String addCategory(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("categoryForm", new CategoryModel());
		map.addAttribute("categoryList", categoryService.getAllCategories());
		System.out.println("from addCategory");
		return "addCategory";
	}
	
	@RequestMapping(value = "admin/category/add", method = RequestMethod.POST)
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
	       if(model.getParent() != null && model.getParent().getCid() > 0){
			   category.setParent(model.getParent());
		   }else{
			   category.setParent(null);
		   }
	       category.setCategoryName(model.getCategoryName());
	       category.setCategoryDetail(model.getCategoryDetail());
	       category.setDisplayOrder(model.getDisplayOrder());
	       category.setActive(model.isActive());
	       category.setCreateDate(new Date());
	       category.setModifyDate(new Date());
	       category.setCreatedBy(principal.getName());
	       category.setModifyBy(principal.getName());
	       int cid = categoryService.addCategory(category);
	       MultipartFile image = model.getCategoryImage();
	       if(image != null){
	    	   String imageName = image.getOriginalFilename();
				try
				{
					if (imageName != null && !imageName.equals(""))
					{
						imageName = imageName.replace(" ", "-");
						String imgUrl = ProjectConfig.UPLOAD_PATH+"category/" + cid + "/" + imageName;
						category.setCategoryImage(imageName);
						category.setCid(cid);
						File img = new File(ProjectConfig.UPLOAD_PATH + imgUrl);
						if (!img.exists())
						{
							img.mkdirs();
						}
						image.transferTo(img);
						categoryService.updateCategory(category);
					}
				} catch (IOException ie)
				{
					ie.printStackTrace();
				}
	            
	       }
           
	       
		}
		
		return "redirect:/admin/category";
	}
	
	@RequestMapping(value = "admin/category/edit/{cid}", method = RequestMethod.GET)
	public String editCategory(@PathVariable(value="cid" ) String cid, ModelMap map, HttpServletRequest request, Principal principal)
	{
		try{
//			String cid = request.getParameter("cid");
			if(cid != null && cid.trim().length() > 0){
				Category category = categoryService.getCategoryById(Integer.parseInt(cid));
				if(category != null){
					CategoryModel model = new CategoryModel();
					model.setCid(category.getCid());
					model.setCategoryName(category.getCategoryName());
					model.setCategoryDetail(category.getCategoryDetail());
					model.setCategoryImageUrl(category.getCategoryImage());
					model.setDisplayOrder(category.getDisplayOrder());
					model.setActive(category.isActive());
					model.setParent(category.getParent());
					map.addAttribute("categoryForm", model);
					map.addAttribute("categoryList", categoryService.getAllCategories());
					System.out.println("Edit category cid : "+ category.getCid()+", category : "+category.getCategoryName());
					return "editCategory";
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:admin/category";
	}
	@RequestMapping(value = "/admin/category/update", method = RequestMethod.POST)
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
		       category.setModifyBy(principal.getName());
		       MultipartFile image = model.getCategoryImage();
		       if(image != null) {
		    	   String imageName = image.getOriginalFilename();
					try {
						if (imageName != null && !imageName.equals("")) {
							imageName = imageName.replace(" ", "-");
							String imgUrl = "category/" + category.getCid() + "/" + imageName;
							category.setCategoryImage(imgUrl);
							File img = new File(ProjectConfig.UPLOAD_PATH+imgUrl);
							if (!img.exists())
							{
								img.mkdirs();
							}
							image.transferTo(img);
						}
					} catch (IOException ie) {
						ie.printStackTrace();
					}
		       }
		       categoryService.updateCategory(category);
		   }
		}
		return "redirect:/admin/category";
	}
	
	@RequestMapping(value = "/admin/category/delete/{cid}", method = RequestMethod.GET)
	public String deleteCategory(@PathVariable(value="cid" ) String cid, ModelMap map, HttpServletRequest request, Principal principal)
	{
		HttpSession session = request.getSession();
		try{
//			String cid = request.getParameter("cid");
			if(Validation.isNumeric(cid)){
				Category category = categoryService.getCategoryById(Util.getNumeric(cid));
				if(category != null){
					category.setDeleteDate(new Date());
					categoryService.updateCategory(category);
					session.setAttribute("msgType", "success");
					session.setAttribute("msg", "Category deleted successfully !");
					return "redirect:categories";
				}else{
					session.setAttribute("msg", "Category not found !");
				}
			}
		}catch(Exception e){
			session.setAttribute("msg", "Oopps something wrong !");
			e.printStackTrace();
		}
		session.setAttribute("msgType", "error");
		return "redirect:/admin/category";
	}
	
	
	@RequestMapping(value = "/admin/getCategoryProducts", method = RequestMethod.GET)
	public String getCategoryProducts(ModelMap map, HttpServletRequest request, Principal principal)
	{
		HttpSession session = request.getSession();
		try{
			String cid = request.getParameter("cid");
			String pn = request.getParameter("pn");
			int pageno = Validation.isNumeric(pn) ? Util.getNumeric(pn):1;
			if(Validation.isNumeric(cid)){
				List<Integer> cids = new ArrayList();
				cids.add(Util.getNumeric(cid));
				List<Product> products = productService.getProductsByCategoryIds(cids, (pageno-1)*Util.RPP, Util.RPP);
				map.addAttribute("countProducts", productService.countProductsByCategoryIds(cids));
				map.addAttribute("productList", products);
				map.addAttribute("rpp", Util.RPP);
				map.addAttribute("pn", pageno);
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "categoryProducts";
	}
	
	
}
