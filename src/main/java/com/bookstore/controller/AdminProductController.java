package com.bookstore.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bookstore.config.ProjectConfig;
import com.bookstore.config.Validation;
import com.bookstore.domain.Category;
import com.bookstore.domain.Product;
import com.bookstore.domain.ProductImage;
import com.bookstore.model.CategoryModel;
import com.bookstore.model.ProductModel;
import com.bookstore.service.CategoryService;
import com.bookstore.service.ProductImageService;
import com.bookstore.service.ProductService;
import com.bookstore.util.DateUtils;
import com.bookstore.util.Util;

@Controller
public class AdminProductController
{
	@Autowired private CategoryService categoryService; 
	@Autowired private ProductService productService; 
	@Autowired private ProductImageService productImageService; 
	
	@RequestMapping(value = "admin/products", method = RequestMethod.GET)
	public String categories(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from products");
		
		return "products";
	}
	@RequestMapping(value = "admin/products/edit/{pid}", method = RequestMethod.GET)
	public String viewProduct(@PathVariable(value="pid" ) String pid,ModelMap map, HttpServletRequest request, Principal principal)
	{
		try{
//			String pid = request.getParameter("pid");
			if(Validation.isNumeric(pid)){
				Product product = productService.getProductById(Util.getNumeric(pid));
				if(product != null) {
					ProductModel model = new ProductModel();
					model.setPid(product.getPid());
					model.setProductName(product.getProductName());
					model.setShortDesc(product.getShortDesc());
					model.setProductSKU(product.getProductSKU());
					model.setProductPrice(String.valueOf(product.getProductPrice()));
					model.setProductMRP(String.valueOf(product.getProductMRP()));
					model.setActive(product.isActive());
					model.setProductTin(product.getProductTin());
					model.setDisableBuyButton(product.isDisableBuyButton());
					model.setShowOnHomePage(product.isShowOnHomePage());
					model.setCustomerReview(product.isCustomerReview());
					model.setCreateDate(DateUtils.clientFullformat.format(product.getCreateDate()));
					model.setModifyDate(DateUtils.clientFullformat.format(product.getModifyDate()));
					if(product.getCategories() != null && !product.getCategories().isEmpty()) {
						Iterator<Category> it = product.getCategories().iterator();
						while(it.hasNext()) {
							model.getCategories().add(it.next().getCid());
						}
					}
					map.addAttribute("productForm", model);
					map.addAttribute("categoryList", categoryService.getAllCategories());
					return "productView";	
				}
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:/admin/products";
	}
	
	@RequestMapping(value = "admin/products/add", method = RequestMethod.GET)
	public String addProduct(ModelMap map, HttpServletRequest request, Principal principal)
	{
		try{
			ProductModel model = new ProductModel();
			map.addAttribute("productForm", model);
			map.addAttribute("categoryList", categoryService.getAllCategories());
		}catch(Exception e){
			e.printStackTrace();
		}
		return "productView";
	}
	
	@RequestMapping(value = "admin/products/add", method = RequestMethod.POST)
	public String addProduct(@ModelAttribute(value = "productForm") @Valid ProductModel model,BindingResult result,
			                  ModelMap map, HttpServletRequest request,Principal principal)
	{
		String submit = request.getParameter("submit");
		if (result.hasErrors()) {
			System.out.println("Product Validation failed with error(s) : " + result.getTarget());
			map.addAttribute("categoryList", categoryService.getAllCategories());
			return "productView";
		} else {
			try {
				if (model.getPid() > 0) {
					Product product = productService.getProductById(model.getPid());
					if(product != null) {
						product.setProductName(model.getProductName());
						product.setShortDesc(model.getShortDesc());
						product.setProductSKU(model.getProductSKU());
						product.setProductPrice(Double.valueOf(model.getProductPrice()));
						product.setProductMRP(Double.valueOf(model.getProductMRP()));
						product.setActive(model.isActive());
						product.setProductTin(model.getProductTin());
						product.setDisableBuyButton(model.isDisableBuyButton());
						product.setShowOnHomePage(model.isShowOnHomePage());
						product.setCustomerReview(model.isCustomerReview());
						product.setModifyDate(new Date());
						if(model.getCategories() != null && !model.getCategories().isEmpty()){
							List<Category> categories = categoryService.getAllCategories(model.getCategories());
							product.setCategories(new HashSet<Category>(categories));
						}
						productService.updateProduct(product);
						if(submit != null && !submit.equals("save")) {
							return "redirect:/admin/products/edit/" + product.getPid();
						}
						
					}
					
				} else {
					Product product = new Product();
					product.setProductName(model.getProductName());
					product.setShortDesc(model.getShortDesc());
					product.setProductSKU(model.getProductSKU());
					product.setProductPrice(Double.valueOf(model.getProductPrice()));
					product.setProductMRP(Double.valueOf(model.getProductMRP()));
					product.setActive(model.isActive());
					product.setProductTin(model.getProductTin());
					product.setDisableBuyButton(model.isDisableBuyButton());
					product.setShowOnHomePage(model.isShowOnHomePage());
					product.setCustomerReview(model.isCustomerReview());
					if(model.getCategories() != null && !model.getCategories().isEmpty()){
						List<Category> categories = categoryService.getAllCategories(model.getCategories());
						product.setCategories(new HashSet<Category>(categories));
					}
					product.setCreateDate(new Date());
					product.setModifyDate(new Date());
					int pid = productService.addProduct(product);
					if(submit != null && !submit.equals("save")) {
						return "redirect:/admin/products/edit/" + pid;
					}
				}

				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "redirect:/admin/products";
	}
	
	@RequestMapping(value = "admin/products/copy", method = RequestMethod.POST)
	public String copyProduct(ModelMap map, HttpServletRequest request, Principal principal)
	{
		try{
			String pid = request.getParameter("pid");
			String submitbtn = request.getParameter("submitbtn");
			if(Validation.isNumeric(pid)){
				Product product = productService.getProductById(Util.getNumeric(pid));
				if(product != null) {
					String productName = request.getParameter("productName");
					boolean active = request.getParameter("active") != null ? true : false;
					boolean copyPictures = request.getParameter("copyPictures") != null ? true : false;
					product = (Product)product.clone();
					product.setProductName(productName);
					product.setActive(active);
					product.setProductUrl(null);
					product.setPid(0);
					product.setProductAttributes(null);
					int productid = productService.addProduct(product);
					product.setPid(productid);
					if(copyPictures) {
						List<ProductImage> images = productImageService.getProductImageByProductId(Util.getNumeric(pid));
						for(ProductImage image : images) {
							image.setProduct(product);
							productImageService.addProductImage(image);
						}
						
					}
					productImageService.setProductImage(productid);
					if(submitbtn != null && submitbtn.equals("continue")) {
						return "redirect:/admin/products/edit/" + productid;
					}else {
						return "redirect:/admin/products";
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:/admin/products";
	}
	
	
	@RequestMapping(value = "admin/products/list/{pn}", method = RequestMethod.GET)
	public String getProductList(@PathVariable(value="pn" ) String pageno, ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from products");
		
		int pn = Validation.isNumeric(pageno) ? Util.getNumeric(pageno) : 1;
		int rpp = Validation.isNumeric(request.getParameter("rpp")) ? Util.getNumeric(request.getParameter("rpp")) : Util.RPP;
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
		return "productList";
	}
	
}
