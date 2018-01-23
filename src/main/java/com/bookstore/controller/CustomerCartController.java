package com.bookstore.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CustomerCartController
{
	@RequestMapping(value = "customer/cart/header", method = RequestMethod.GET)
	public String categories(ModelMap map, HttpServletRequest request, Principal principal)
	{
		return "customerCartHeader";
	}
}
