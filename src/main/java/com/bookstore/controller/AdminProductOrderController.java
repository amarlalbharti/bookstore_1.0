package com.bookstore.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookstore.config.Validation;
import com.bookstore.domain.City;
import com.bookstore.domain.CustomerAddress;
import com.bookstore.domain.ProductOrder;
import com.bookstore.domain.Registration;
import com.bookstore.service.BasketService;
import com.bookstore.service.CityService;
import com.bookstore.service.CustomerAddressService;
import com.bookstore.service.ProductOrderService;
import com.bookstore.service.ProductService;
import com.bookstore.service.RegistrationService;
import com.bookstore.util.Util;

@Controller
public class AdminProductOrderController
{
	@Autowired
	private BasketService basketService;
	@Autowired
	private ProductService productService;
	@Autowired
	private RegistrationService registrationService;
	@Autowired
	private CustomerAddressService customerAddressService;
	@Autowired
	private ProductOrderService productOrderService;
	@Autowired
	private CityService cityService; 
	
	
	private static final Logger LOGGER = Logger.getLogger(AdminProductOrderController.class);
	
	@RequestMapping(value = "admin/sales/orders", method = RequestMethod.GET)
	public String getCustomerCheckout(ModelMap map, HttpServletRequest request, Principal principal)
	{
		
		return "productOrders";
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "admin/sales/orders/list", method = RequestMethod.GET)
	public @ResponseBody String getSalesOrderList(ModelMap map, HttpServletRequest request, HttpServletResponse response, Principal principal)
	{
		JSONObject json = new JSONObject();
		try {
			if(principal != null){
				json.put("product_orders", this.productOrderService.getProductOrdersJsonArray(0, 10));
			}else{
				response.setStatus(HttpStatus.UNAUTHORIZED.value());
				return json.toJSONString();
			}
			
		}catch (Exception e) {
			LOGGER.error("Error in add custoemr address", e);
			json.put("status", "failed");
			json.put("msg", "Oops something wrong !");
		}
		return json.toJSONString();
	}
	
}