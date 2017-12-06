package com.bookstore.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookstore.config.Util;
import com.bookstore.config.Validation;
import com.bookstore.domain.ProductAttribute;
import com.bookstore.service.ProductAttributeService;
import com.bookstore.service.ProductService;

@Controller
public class ProductAttributeController
{
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductAttributeService productAttributeService;
	
	@RequestMapping(value = "/getProductAttributes")
    public String getProductImages(ModelMap map, HttpServletRequest request, Principal principal)
    {
		try{
			String pid = request.getParameter("pid");
			if(Validation.isNumeric(pid)){
				List<ProductAttribute> productAttributes = productAttributeService.getProductAttributeByPid(Util.getNumeric(pid));
				map.addAttribute("productAttributes", productAttributes);
				map.addAttribute("product", productService.getProductById(Util.getNumeric(pid)));
				String productAttributeId = request.getParameter("productAttributeId");
				if(Validation.isNumeric(productAttributeId)) {
					map.addAttribute("editproductAttribute", productAttributeService.getProductAttributeById(Util.getNumeric(productAttributeId)));
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "productAttributes";
    }
}
