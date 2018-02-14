package com.bookstore.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

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
import com.bookstore.domain.CustomerAddress;
import com.bookstore.domain.Registration;
import com.bookstore.service.BasketService;
import com.bookstore.service.CustomerAddressService;
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
									step = CheckoutSteps.PAYMENTINFO.name();
									break;
								}
							}
						}
						map.addAttribute("baskets", this.basketService.getBasketByCustomer(registration.getRid()));
						map.addAttribute("customerAddresses", customerAddresses);	
					}else{
						map.addAttribute("registration", registration);
						if(step.equalsIgnoreCase(CheckoutSteps.LOGIN.name())){
							CheckoutSteps.LOGIN.name();
						}else{
							passedSteps.add(CheckoutSteps.LOGIN);
							if(step.equalsIgnoreCase(CheckoutSteps.SHIPPINGINFO.name())){
								step = CheckoutSteps.SHIPPINGINFO.name();
								map.addAttribute("customerAddresses", this.customerAddressService.getCustomerAddressByCustomer(registration.getRid()));
							}else {
								passedSteps.add(CheckoutSteps.SHIPPINGINFO);
								map.addAttribute("activeAddresses", this.customerAddressService.getActiveCustomerAddressById(registration.getRid()));
								if(step.equalsIgnoreCase(CheckoutSteps.PAYMENTINFO.name())){
									step = CheckoutSteps.PAYMENTINFO.name();
								}else{
									passedSteps.add(CheckoutSteps.SHIPPINGINFO);
									if (step.equalsIgnoreCase(CheckoutSteps.PRODUCTREVIEW.name())){
										step = CheckoutSteps.PRODUCTREVIEW.name();
										map.addAttribute("baskets", this.basketService.getBasketByCustomer(registration.getRid()));
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
	
	
	
}
