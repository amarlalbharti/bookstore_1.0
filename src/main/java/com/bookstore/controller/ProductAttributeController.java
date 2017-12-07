package com.bookstore.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookstore.config.Util;
import com.bookstore.config.Validation;
import com.bookstore.domain.AttributeValue;
import com.bookstore.domain.ProductAttribute;
import com.bookstore.service.AttributeService;
import com.bookstore.service.AttributeValueService;
import com.bookstore.service.ProductAttributeService;
import com.bookstore.service.ProductService;

@Controller
public class ProductAttributeController
{
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductAttributeService productAttributeService;
	@Autowired
	private AttributeService attributeService;
	@Autowired
	private AttributeValueService attributeValueService;
	
	@RequestMapping(value = "/getProductAttributes")
    public String getProductAttributes(ModelMap map, HttpServletRequest request, Principal principal)
    {
		try{
			String pid = request.getParameter("pid");
			if(Validation.isNumeric(pid)){
				List<ProductAttribute> productAttributes = productAttributeService.getProductAttributeByPid(Util.getNumeric(pid));
				map.addAttribute("productAttributes", productAttributes);
				map.addAttribute("attributeList", attributeService.getAttributes());
				map.addAttribute("product", productService.getProductById(Util.getNumeric(pid)));
				String productAttributeId = request.getParameter("productAttributeId");
				if(Validation.isNumeric(productAttributeId)) {
					map.addAttribute("editProductAttribute", productAttributeService.getProductAttributeById(Util.getNumeric(productAttributeId)));
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "productAttributes";
    }
	
	
	
	@RequestMapping(value = "/getProductAttributeValues")
    public @ResponseBody String getProductAttributeValues(ModelMap map, HttpServletRequest request, Principal principal)
    {
		JSONObject json = new JSONObject();
		try{
			String attributeId = request.getParameter("attributeId");
			if(Validation.isNumeric(attributeId)){
				List<AttributeValue> list = attributeValueService.getAttrbuteValuesByAttributeId(Util.getNumeric(attributeId));
				JSONArray array = new JSONArray();
				if(list != null && !list.isEmpty()){
					for(AttributeValue value : list){
						JSONObject val = new JSONObject();
						val.put("attributeValueId", value.getAttributeValueId());
						val.put("attributeValue", value.getAttributeValue());
						array.add(val);
					}
				}
				json.put("status", 200);
				json.put("msg", "success");
				json.put("values", array);
				return json.toJSONString();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		json.put("status", 400);
		json.put("msg", "success");
		return json.toJSONString();
    }
}
