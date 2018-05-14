package com.bookstore.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookstore.constraints.Roles;
import com.bookstore.domain.ProductOrder;
import com.bookstore.enums.OrderStatus;
import com.bookstore.parser.ProductOrderParser;
import com.bookstore.service.LoginInfoService;
import com.bookstore.service.ProductOrderService;
import com.bookstore.service.ProductService;
import com.bookstore.service.RegistrationService;

@Controller
public class AdminDashboardController
{
	private static final Logger LOGGER = Logger.getLogger(AdminDashboardController.class);
	
	@Autowired private LoginInfoService loginInfoService;
	@Autowired private RegistrationService registrationService;
	@Autowired private ProductOrderService productOrderService;
	@Autowired private ProductService productService;
	
	/**
	 * @param map
	 * @param request 
	 * @param principal is the object for detail of loged in user
	 * @return   name of view mapped in tiles for index page
	 */
	@RequestMapping(value = "admin/dashboard", method = RequestMethod.GET)
	public String dashboard(ModelMap map, HttpServletRequest request, Principal principal) {
		return "dashboard";
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "admin/dashboard/widgets", method = RequestMethod.GET)
	public @ResponseBody String getDashboardWidgetsData(ModelMap map, HttpServletRequest request, Principal principal) {
		JSONObject Json = new JSONObject();
		try {
			Json.put("pending_orders", this.productOrderService.countProductOrdersByStatus(OrderStatus.IN_PROGRESS));
			Json.put("new_orders",  this.productOrderService.countProductOrdersByStatus(OrderStatus.AWAITING_EXCHANGE));
			List<String> roles = new ArrayList();
			roles.add(Roles.ROLE_REGISTERED);
			Json.put("registered_users", this.registrationService.countRegistrationListByRoles(roles));
			Json.put("avail_products", this.productService.countAllProducts());
			
		} catch (Exception e) {
			LOGGER.error("Error in getDashboardWidgetsData() >> ", e);
		}
		return Json.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "admin/dashboard/latest/order", method = RequestMethod.GET)
	public @ResponseBody String getDashboardLatestOrders(ModelMap map, HttpServletRequest request, Principal principal) {
		JSONObject Json = new JSONObject();
		try {
			List<ProductOrder> orders = productOrderService.getLatestProductOrders(0, 10);
			Json.put("ordersList", ProductOrderParser.parseProductOrderList(orders));
			
		} catch (Exception e) {
			LOGGER.error("Error in getDashboardWidgetsData() >> ", e);
		}
		return Json.toJSONString();
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "admin/dashboard/sales", method = RequestMethod.GET)
	public @ResponseBody String getDashboardSales(ModelMap map, HttpServletRequest request, Principal principal) {
		JSONObject Json = new JSONObject();
		try {
			
		} catch (Exception e) {
			LOGGER.error("Error in getDashboardWidgetsData() >> ", e);
		}
		return Json.toJSONString();
	}
	
	
}
