package com.bookstore.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bookstore.config.ProjectConfig;
import com.bookstore.config.Util;
import com.bookstore.config.Validation;
import com.bookstore.domain.Attribute;
import com.bookstore.domain.AttributeValue;
import com.bookstore.domain.Category;
import com.bookstore.model.AttributeModel;
import com.bookstore.model.CategoryModel;
import com.bookstore.service.AttributeService;
import com.bookstore.service.AttributeValueService;

@Controller
public class AttributeController
{
	@Autowired 
	private AttributeService attributeService; 
	@Autowired 
	private AttributeValueService attributeValueService; 
	
	
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
		return "attributeView";
	}
	
	

	@RequestMapping(value = "/addAttribute", method = RequestMethod.POST)
	public String addCategory(@ModelAttribute(value = "attributeForm") @Valid AttributeModel model,BindingResult result,
			                  ModelMap map, HttpServletRequest request,Principal principal)
	{
		if (result.hasErrors()) {
			System.out.println("in validation addAttribute");
			return "attributeView";
		} else {
			if(model.getAttributeId() <= 0) {
				Attribute attribute = new Attribute();
				attribute.setAttributeName(model.getAttributeName());
				attribute.setActive(model.isActive());
				attribute.setCreateDate(new Date());
				attribute.setModifyDate(new Date());
				attributeService.addAttribute(attribute);
			}else {
				Attribute attribute = attributeService.getAttributeByAttributeId(model.getAttributeId());
				attribute.setAttributeName(model.getAttributeName());
				attribute.setActive(model.isActive());
				attribute.setCreateDate(new Date());
				attribute.setModifyDate(new Date());
				attributeService.updateAttribute(attribute);
			}
		}
		return "redirect:attributes";
	}
	
	@RequestMapping(value = "/attributeView", method = RequestMethod.GET)
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
				return "attributeView";
			}
		}
		return "redirect:attributes";
	}
	
	@RequestMapping(value = "/getAttributeValues", method = RequestMethod.GET)
	public String getAttributeValues(ModelMap map, HttpServletRequest request, Principal principal)
	{
		try {
			String attributeId = request.getParameter("attributeId");
			if(Validation.isNumeric(attributeId)) {
				map.addAttribute("attribute", attributeService.getAttributeByAttributeId(Util.getNumeric(attributeId)));
				map.addAttribute("attributeValueList", attributeValueService.getAttrbuteValuesByAttributeId(Util.getNumeric(attributeId)));
				String attributeValueId = request.getParameter("attributeValueId");
				if(Validation.isNumeric(attributeValueId)) {
					AttributeValue value = attributeValueService.getAttributeValueById(Util.getNumeric(attributeValueId));
					if(value != null) {
						map.addAttribute("editAttributeValue",value);
					}
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "attributeValues";
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/saveAttributeValue", method = RequestMethod.POST)
	public @ResponseBody String saveAttributeValue(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject json = new JSONObject();
		try {
			
			String attributeId = request.getParameter("attributeId");
			String attributeValue = request.getParameter("attributeValue");
			if(Validation.isNumeric(attributeId)) {
				if(!Validation.isNotNullNotEmpty(attributeValue)) {
					json.put("status", "error");
					json.put("msg", "Attribute value is required !");
					return json.toJSONString();
				}
				Attribute attribute =  attributeService.getAttributeByAttributeId(Util.getNumeric(attributeId));
				if(attribute != null) {
					String attributeValueId = request.getParameter("attributeValueId");
					if(Validation.isNumeric(attributeValueId) && Util.getNumeric(attributeValueId) > 0)  {
						AttributeValue value = attributeValueService.getAttributeValueById(Util.getNumeric(attributeValueId));
						if(value != null) {
							value.setAttributeValue(attributeValue);
							attributeValueService.updateAttributeValue(value);
							json.put("status", "success");
							json.put("msg", "Attribute value updated successfully !");
							return json.toJSONString();
						}
					}else {
						AttributeValue value = new AttributeValue();
						value.setAttributeValue(attributeValue);
						value.setAttribute(attribute);
						value.setCreateDate(new Date());
						attributeValueService.addAttributeValue(value);
						json.put("status", "success");
						json.put("msg", "Attribute value added successfully !");
						return json.toJSONString();
					}
				}else {
					json.put("status", "error");
					json.put("msg", "Attribute not found !");
				}
			}else {
				json.put("status", "error");
				json.put("msg", "Attribute not saved !");
			}
		}catch (Exception e) {
			e.printStackTrace();
			json.put("msg", "Oops spnething wrong!");
		}
		return json.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/deleteAttributeValue", method = RequestMethod.GET)
	public @ResponseBody String deleteAttributeValue(ModelMap map, HttpServletRequest request, Principal principal)
	{
		JSONObject json = new JSONObject();
		try {
			String attributeValueId = request.getParameter("attributeValueId");
			if(Validation.isNumeric(attributeValueId)) {
				AttributeValue value = attributeValueService.getAttributeValueById(Util.getNumeric(attributeValueId));
				if(value != null) {
					attributeValueService.deleteAttributeValue(value);
					json.put("status", "success");
					json.put("msg", "Attribute value deleted successfully !");
					return json.toJSONString();
				}else {
					json.put("msg", "Attribute value not found !");
				}
			}else {
				json.put("msg", "Oops spnething wrong!");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			json.put("msg", "Oops spnething wrong!");
		}
		json.put("status", "error");
		return json.toJSONString();
	}
	
	
}
