package com.bookstore.controller;

import java.security.Principal;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookstore.config.Validation;
import com.bookstore.domain.Basket;
import com.bookstore.domain.Product;
import com.bookstore.domain.Registration;
import com.bookstore.service.BasketService;
import com.bookstore.service.ProductService;
import com.bookstore.service.RegistrationService;
import com.bookstore.util.Util;

@Controller
public class CustomerCartController
{
	@Autowired
	private BasketService basketService;
	@Autowired
	private ProductService productService;
	@Autowired
	private RegistrationService registrationService;
	
	
	@RequestMapping(value = "customer/cart/header", method = RequestMethod.GET)
	public String getCustomerCartHeader(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("basketList", this.basketService.getBasketByCustomer(principal.getName()));
		return "customerCartHeader";
	}
	
	@RequestMapping(value = "customer/cart/add/{pid}", method = RequestMethod.GET)
	public @ResponseBody String addProductCart(@PathVariable(value="pid" ) String pid, ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject response = new JSONObject();
		try {
			if(Validation.isNumeric(pid)){
				Product product = this.productService.getProductById(Util.getNumeric(pid));
				Registration reg = this.registrationService.getRegistrationByUserid(principal.getName()); 
				if(product != null && reg != null) {
					if(!this.basketService.checkInBasket(product.getPid(), reg.getRid())) {
						Basket basket = new Basket();
						basket.setProduct(product);
						basket.setQuantity(1);
						basket.setRegistration(reg);
						basket.setModifyDate(new Date());
						basket.setFinalPrice(product.getProductPrice());
						int basketId = this.basketService.addBasket(basket);
						if(basketId > 0) {
							response.put("status", "success");
							response.put("msg", "Produt added in cart successfully !");
							return response.toJSONString();
						}
						
					}else {
						response.put("status", "failed");
						response.put("msg", "Produt already added in cart !");
						return response.toJSONString();
					}
				}
				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		response.put("status", "failed");
		response.put("msg", "Oops something wrong !");
		return response.toJSONString();
	}

	@RequestMapping(value = "customer/cart/remove/{basketId}", method = RequestMethod.GET)
	public @ResponseBody String removeProductCart(@PathVariable(value="basketId" ) String basketId, ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject response = new JSONObject();
		try {
			if(Validation.isNumeric(basketId)){
				Basket basket = this.basketService.getBasketById(Util.getNumeric(basketId));
				if(basket != null) {
					basket.setDeletedDate(new Date());
					boolean flag = this.basketService.updateBasket(basket);
					if(flag) {
						response.put("status", "success");
						response.put("msg", "Product removed from cart successfully !");
						return response.toJSONString();
					}
				}else {
					response.put("status", "failed");
					response.put("msg", "Product not exist in cart !");
					return response.toJSONString();
				}
				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		response.put("status", "failed");
		response.put("msg", "Oops something wrong !");
		return response.toJSONString();
	}

	
}
