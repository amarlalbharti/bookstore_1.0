package com.bookstore.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookstore.config.Validation;
import com.bookstore.domain.Basket;
import com.bookstore.domain.City;
import com.bookstore.domain.CustomerAddress;
import com.bookstore.domain.OrderItem;
import com.bookstore.domain.ProductOrder;
import com.bookstore.domain.Registration;
import com.bookstore.exceptions.SessionTimeoutException;
import com.bookstore.service.BasketService;
import com.bookstore.service.CityService;
import com.bookstore.service.CustomerAddressService;
import com.bookstore.service.ProductOrderService;
import com.bookstore.service.ProductService;
import com.bookstore.service.RegistrationService;
import com.bookstore.util.CheckoutSteps;
import com.bookstore.util.CustomerUtils;
import com.bookstore.util.Util;

@Controller
public class CustomerController
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
	
	static final Logger logger = Logger.getLogger(CustomerController.class);
	
	@RequestMapping(value = "customer/checkout", method = RequestMethod.GET)
	public String getCustomerCheckout(ModelMap map, HttpServletRequest request, Principal principal)
	{
		if(principal != null){
			Registration registration = this.registrationService.getRegistrationByUserid(principal.getName());
			if(registration != null){
				map.addAttribute("registration", registration);
				map.addAttribute("baskets", this.basketService.getBasketByCustomer(registration.getRid()));
			}
			return "checkout";
		}else{
			return "redirect:/login";
		}
		
	}
	
	
	
	
	@RequestMapping(value = "secure/checkout/steps", method = RequestMethod.GET)
	public String getCustomerCheckoutStep(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String step= request.getParameter("step");
		if(principal != null){
			List<CheckoutSteps> passedSteps = new ArrayList<CheckoutSteps>();
			if(CustomerUtils.isValidCheckoutStep(step)){
				Registration registration = this.registrationService.getRegistrationByUserid(principal.getName());
				if(registration != null){
					if(step == null) {
						passedSteps.add(CheckoutSteps.LOGIN);
						step = CheckoutSteps.SHIPPINGINFO.name();
						map.addAttribute("registration", registration);
						List<CustomerAddress> customerAddresses = this.customerAddressService.getCustomerAddressByCustomer(registration.getRid());
						if(customerAddresses != null && !customerAddresses.isEmpty()){
							for(CustomerAddress ca : customerAddresses){
								if(ca.isActive()){
									passedSteps.add(CheckoutSteps.SHIPPINGINFO);
									step = CheckoutSteps.PRODUCTREVIEW.name();
									break;
								}
							}
						}
						map.addAttribute("baskets", this.basketService.getBasketByCustomer(registration.getRid()));
						map.addAttribute("customerAddresses", customerAddresses);	
					}else{
						map.addAttribute("registration", registration);
						if(step.equalsIgnoreCase(CheckoutSteps.LOGIN.name())){
							step = CheckoutSteps.LOGIN.name();
						}else{
							passedSteps.add(CheckoutSteps.LOGIN);
							if(step.equalsIgnoreCase(CheckoutSteps.SHIPPINGINFO.name())){
								step = CheckoutSteps.SHIPPINGINFO.name();
								map.addAttribute("customerAddresses", this.customerAddressService.getCustomerAddressByCustomer(registration.getRid()));
							}else {
								passedSteps.add(CheckoutSteps.SHIPPINGINFO);
								map.addAttribute("activeAddresses", this.customerAddressService.getActiveCustomerAddressByRid(registration.getRid()));
								if(step.equalsIgnoreCase(CheckoutSteps.PRODUCTREVIEW.name())){
									step = CheckoutSteps.PRODUCTREVIEW.name();
									map.addAttribute("baskets", this.basketService.getBasketByCustomer(registration.getRid()));
								}else{
									passedSteps.add(CheckoutSteps.PRODUCTREVIEW);
									if (step.equalsIgnoreCase(CheckoutSteps.PAYMENTINFO.name())){
										step = CheckoutSteps.PAYMENTINFO.name();
									}
									
								}
							}
						}
					}
					
					
				}
				map.addAttribute("passedSteps",passedSteps);
				map.addAttribute("step",step);
				return "checkoutStep";
			}
			
		}else{
			return "redirect:/login";
		}
		return "redirect:/login";
	}
	

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "secure/customeraddress/add", method = RequestMethod.POST)
	public @ResponseBody String addCustomerAddress(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject response = new JSONObject();
		try {
			if(principal != null){
				String address = request.getParameter("address");
				String landmark = request.getParameter("landmark");
				String street = request.getParameter("street");
				String city = request.getParameter("city");
				String state = request.getParameter("state");
				String country = request.getParameter("country");
				String pin = request.getParameter("pin");
				String contact = request.getParameter("contact");
				String action = request.getParameter("action");
				String caid = request.getParameter("caid");
				
				String msg = "";
				boolean isValid = true;
				if(!Validation.isNotNullNotEmpty(address)) {
					msg = "Address is required";
					isValid = false;
				} else if(!Validation.isNotNullNotEmpty(landmark)) {
					msg = "Landmark is required";
					isValid = false;
				} else if(!Validation.isNumeric(city)) {
					msg = "City is required";
					isValid = false;
				} else if(!Validation.isNumeric(pin)) {
					msg = "Pin is required";
					isValid = false;
				} else if(!Validation.isNumeric(contact)) {
					msg = "Contact number is required";
					isValid = false;
				}
				
				City cityObj = null;
				if(isValid) {
					cityObj = this.cityService.getCity(Util.getNumeric(city));
					if(cityObj == null) {
						msg = "City not found !";
						isValid = false;
					}
				}
				
				CustomerAddress customerAddress = null;
				boolean isUpdate = false;
				if(action != null && action.equals("update")) {
					isUpdate = true;
					if(Validation.isNumeric(caid)) {
						customerAddress = this.customerAddressService.getCustomerAddress(principal.getName(), Util.getNumeric(caid));
						if(customerAddress == null) {
							isValid = false;
							msg = "Address not found !";
						}
					}
				}
				
				if(isValid) {
					Registration reg = registrationService.getRegistrationByUserid(principal.getName());
					if(customerAddress == null){
						customerAddress = new CustomerAddress();
					}
					customerAddress.setAddress(address);
					customerAddress.setLandmark(landmark);
					customerAddress.setCustomerStreet(street);
					customerAddress.setCustomerCity(cityObj);
					customerAddress.setCustomerPinCode(pin);
					customerAddress.setCustomerPhone(contact);
					customerAddress.setCreateDate(new Date());
					customerAddress.setActive(Boolean.TRUE);
					customerAddress.setRegistration(reg);
					this.customerAddressService.deactivateCustomerAddresses(reg.getRid(), null);
					if(isUpdate) {
						customerAddress.setActive(Boolean.TRUE);
						this.customerAddressService.updateCustomerAddress(customerAddress);
						response.put("msg", "Your address updated successfully !");
					}else {
						this.customerAddressService.addCustomerAddress(customerAddress);
						response.put("msg", "Your address saved successfully !");
					}
					response.put("status", "success");
					
					return response.toJSONString();
				}else {
					response.put("status", "failed");
					response.put("msg", msg);
				}
				
			}else{
				response.put("status", "loggedout");
				return response.toJSONString();
			}
			
		}catch (Exception e) {
			logger.error("Error in add custoemr address", e);
			response.put("status", "failed");
			response.put("msg", "Oops something wrong !");
		}
		return response.toJSONString();
	}

	
	
	@RequestMapping(value = "secure/customeraddress/update/{addressid}", method = RequestMethod.GET)
	public @ResponseBody String activateCustomeraddress(@PathVariable(value="addressid" ) String addressid, ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject response = new JSONObject();
		try {
			if(principal != null){
				if(Validation.isNumeric(addressid)){
					Registration registration = this.registrationService.getRegistrationByUserid(principal.getName());
					if(registration != null){
						List<CustomerAddress> list = this.customerAddressService.getCustomerAddressByCustomer(registration.getRid());
						if(list != null && !list.isEmpty()){
							for(CustomerAddress address : list){
								if(address.getCustomerAddressId() == Util.getNumeric(addressid)){
									if(!address.isActive()){
										address.setActive(Boolean.TRUE);
										this.customerAddressService.updateCustomerAddress(address);
									}
								}else{
									if(address.isActive()){
										address.setActive(Boolean.FALSE);
										this.customerAddressService.updateCustomerAddress(address);
									}
								}
							}
							response.put("status", "success");
							return response.toJSONString();
						}
					}else{
						response.put("status", "loggedout");
						return response.toJSONString();
					}
					
				}
			}else{
				response.put("status", "loggedout");
				return response.toJSONString();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		response.put("status", "failed");
		response.put("msg", "Oops something wrong !");
		return response.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "secure/customeraddress/addnew", method = RequestMethod.GET)
	public String addMoreCustomeraddress(ModelMap map, HttpServletRequest request, HttpServletResponse response, Principal principal)
	{
		try {
			if(principal == null){
				response.setStatus(HttpStatus.UNAUTHORIZED.value());	
			}else {
				String action = request.getParameter("action");
				if(action != null && action.equalsIgnoreCase("edit")) {
					String addressId = request.getParameter("addressId");
					if(Validation.isNumeric(addressId)) {
						CustomerAddress address = this.customerAddressService.getCustomerAddress(principal.getName(), Util.getNumeric(addressId));
						if(address != null) {
							map.addAttribute("editAddress", address);
							return "addUpdateAddress";
						}
					}
				}else {
					
					return "addUpdateAddress";
				}
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		response.setStatus(HttpStatus.BAD_REQUEST.value());	
		return "addUpdateAddress";
	}
	
	@RequestMapping(value = "testexception", method = RequestMethod.GET)
	public @ResponseBody String testException(ModelMap map, HttpServletRequest request, HttpServletResponse response, Principal principal)
	{
		response.setStatus(HttpStatus.UNAUTHORIZED.value());
//		try
//		{
//			response.sendError(HttpStatus.UNAUTHORIZED.value(), "Custom Session Timeout ");
//		} catch (IOException e)
//		{
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		return "ërror";
	}
	
	
	
	@RequestMapping(value = "customer/placeorder", method = RequestMethod.GET)
	public String placeOrder(ModelMap map, HttpServletRequest request, Principal principal)
	{
		if(principal != null){
			Registration registration = this.registrationService.getRegistrationByUserid(principal.getName());
			if(registration != null){
				List<Basket> baskets = this.basketService.getBasketByCustomer(registration.getRid());
				Set<OrderItem> orderedItems =  new HashSet<OrderItem>(); 
				double subtotal = 0;
				if(baskets != null && !baskets.isEmpty()) {
					ProductOrder order = new ProductOrder();
					
					for(Basket basket : baskets) {
						OrderItem item = new OrderItem();
						item.setProductOrder(order);
						item.setQuantity(basket.getQuantity());
						item.setProduct(basket.getProduct());
						item.setProductPrice(basket.getProduct().getProductPrice());
						item.setCreateDate(new Date());
						orderedItems.add(item);
						subtotal += (basket.getQuantity() * basket.getProduct().getProductPrice());
						basket.setDeletedDate(new Date());
						this.basketService.updateBasket(basket);
					}
					CustomerAddress address = this.customerAddressService.getActiveCustomerAddressByRid(registration.getRid());
					order.setRegistration(registration);
					order.setTotalItems(baskets.size());
					order.setShippingAddress(CustomerUtils.getShippingAddressValue(address));
					order.setFinalPrice(subtotal);
					order.setCustomerPhone(address.getCustomerPhone());
					order.setOrderItems(orderedItems);
					order.setCreateDate(new Date());
					int orderid = this.productOrderService.addProductOrder(order);
					return "redirect:/customer/order/confirmation/"+orderid;
				}else {
					
				}
			}
		}else{
		}
		return "redirect:/index";
	}
	@RequestMapping(value = "customer/order/confirmation/{orderid}", method = RequestMethod.GET)
	public String orderConfirmation(@PathVariable(value="orderid" ) String orderid, ModelMap map, HttpServletRequest request, Principal principal)
	{
		try {
			if(principal != null){
				Registration registration = this.registrationService.getRegistrationByUserid(principal.getName());
				if(registration != null) {
					if(Validation.isNumeric(orderid)) {
						map.addAttribute("productOrder", this.productOrderService.getProductOrder(Util.getNumeric(orderid), registration.getRid()));
					}
					return "orderConfirmation";
				}
				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/login";
	}

}
