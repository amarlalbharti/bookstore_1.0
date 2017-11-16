package com.bookstore.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bookstore.config.Util;
import com.bookstore.config.Validation;
import com.bookstore.domain.Category;
import com.bookstore.domain.Product;
import com.bookstore.model.CategoryModel;
import com.bookstore.model.ProductModel;
import com.bookstore.service.CategoryService;
import com.bookstore.service.ProductService;

@Controller
public class ProductController
{
	@Autowired private CategoryService categoryService; 
	@Autowired private ProductService productService; 
	
	@RequestMapping(value = "/products", method = RequestMethod.GET)
	public String categories(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from products");
		
		int pn = request.getParameter("pn") != null? Integer.parseInt(request.getParameter("pn")) : 1;
		int rpp = request.getParameter("rpp") != null? Integer.parseInt(request.getParameter("rpp")) : Util.rpp;
		String cid = request.getParameter("cid");
		if(Validation.isNumeric(cid)){
			map.addAttribute("listcount", productService.countProductsByCategoryIds(new ArrayList<Integer>(Util.getNumeric(cid))));
			map.addAttribute("productList", productService.getProductsByCategoryIds(new ArrayList<Integer>(Util.getNumeric(cid)), (pn-1)*rpp, rpp));
		}else{
			map.addAttribute("listcount", productService.countProducts());
			map.addAttribute("productList", productService.getProducts((pn-1)*rpp, rpp));
		}
		map.addAttribute("pn", pn);
		map.addAttribute("rpp", rpp);
		return "products";
	}
	@RequestMapping(value = "/viewProduct", method = RequestMethod.GET)
	public String viewProduct(ModelMap map, HttpServletRequest request, Principal principal)
	{
		try{
			String pid = request.getParameter("pid");
			if(Validation.isNumeric(pid)){
				map.addAttribute("viewmode", "view");
				map.addAttribute("product", productService.getProductById(Util.getNumeric(pid)));
				System.out.println("from viewProduct");
				return "productView";	
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:products";
	}
	
	@RequestMapping(value = "/addProduct", method = RequestMethod.GET)
	public String addProduct(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("productForm", new ProductModel());
		map.addAttribute("viewmode", "add");
		System.out.println("from addProduct");
		return "productView";
	}
	
	@RequestMapping(value = "/addProduct", method = RequestMethod.POST)
	public String addProduct(@ModelAttribute(value = "productForm") @Valid ProductModel model,BindingResult result,
			                  ModelMap map, HttpServletRequest request,Principal principal)
	{
		if (result.hasErrors()) {
			System.out.println("in validation");
			return "addCategory";
		} else
		{
			try{
		       Product product = new Product();
		       product.setProductName(model.getProductName());
		       product.setShortDesc(model.getShortDesc());
		       product.setActive(model.isActive());
		       product.setProductPrice(model.getProductPrice());
		       product.setCreateDate(new Date());
		       product.setModifyDate(new Date());
		       int pid = productService.addProduct(product);
		       return "redirect:viewProduct?pid="+pid;
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return "redirect:products";
	}
	
	
	@RequestMapping(value = "/editProduct", method = RequestMethod.GET)
	public String editProduct(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("viewmode", "edit");
		System.out.println("from editProduct");
		return "productView";
	}
	
	
}
