package com.bookstore.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
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
import org.springframework.web.multipart.MultipartFile;

import com.bookstore.config.ProjectConfig;
import com.bookstore.config.Util;
import com.bookstore.config.Validation;
import com.bookstore.domain.Attribute;
import com.bookstore.domain.Category;
import com.bookstore.model.AttributeModel;
import com.bookstore.model.CategoryModel;
import com.bookstore.service.AttributeService;

@Controller
public class AttributeController
{
	@Autowired 
	private AttributeService attributeService; 
	
	@RequestMapping(value = "/attributes", method = RequestMethod.GET)
	public String attributes(ModelMap map, HttpServletRequest request, Principal principal)
	{
		System.out.println("from attributes");
		
		map.addAttribute("attributeList", attributeService.getAttributes());
		
		return "attributes";
	}
	
	@RequestMapping(value = "/addAttribute", method = RequestMethod.GET)
	public String addAttribute(ModelMap map, HttpServletRequest request, Principal principal)
	{
		map.addAttribute("attributeForm", new AttributeModel());
		return "addAttribute";
	}
	
	

	@RequestMapping(value = "/addAttribute", method = RequestMethod.POST)
	public String addCategory(@ModelAttribute(value = "attributeForm") @Valid AttributeModel model,BindingResult result,
			                  ModelMap map, HttpServletRequest request,Principal principal)
	{
		if (result.hasErrors()) {
			System.out.println("in validation addAttribute");
			return "addAttribute";
		} else {
	       Attribute attribute = new Attribute();
	       attribute.setAttributeName(model.getAttributeName());
	       attribute.setActive(model.isActive());
	       attribute.setCreateDate(new Date());
	       attribute.setModifyDate(new Date());
	       attributeService.addAttribute(attribute);
		}
		return "redirect:attributes";
	}
	
	@RequestMapping(value = "/editAttribute", method = RequestMethod.GET)
	public String editAttribute(ModelMap map, HttpServletRequest request, Principal principal)
	{
		String attributeId = request.getParameter("attributeId");
		if(Validation.isNumeric(attributeId)){
			Attribute attribute = attributeService.getAttributeByAttributeId(Util.getNumeric(attributeId));
			if(attribute != null){
				AttributeModel model = new AttributeModel();
				model.setAttributeId(attribute.getAttributeId());
				model.setAttributeName(attribute.getAttributeName());
				model.setActive(attribute.isActive());
				map.addAttribute("attributeForm", model);
				return "editAttribute";
			}
		}
		
		
		AttributeModel model = new AttributeModel();
		map.addAttribute("attributeForm", new AttributeModel());
		return "addAttribute";
	}
	
}
