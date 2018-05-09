package com.bookstore.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookstore.config.Validation;
import com.bookstore.domain.Attribute;
import com.bookstore.domain.AttributeValue;
import com.bookstore.domain.Product;
import com.bookstore.domain.ProductAttribute;
import com.bookstore.enums.AttributeType;
import com.bookstore.service.AttributeService;
import com.bookstore.service.AttributeValueService;
import com.bookstore.service.ProductAttributeService;
import com.bookstore.service.ProductService;
import com.bookstore.util.Util;

@Controller
public class AdminProductAttributeController
{
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductAttributeService productAttributeService;
	@Autowired
	private AttributeService attributeService;
	@Autowired
	private AttributeValueService attributeValueService;
	
	@RequestMapping(value = "/admin/getProductAttributes")
    public String getProductAttributes(ModelMap map, HttpServletRequest request, Principal principal)
    {
		try{
			String pid = request.getParameter("pid");
			if(Validation.isNumeric(pid)){
				List<ProductAttribute> productAttributes = productAttributeService.getProductAttributeByPid(Util.getNumeric(pid));
				map.addAttribute("productAttributes", productAttributes);
				
				List<Attribute> attributes = attributeService.getAttributeNotMappedByPid(Util.getNumeric(pid));
				map.addAttribute("product", productService.getProductById(Util.getNumeric(pid)));
				String productAttributeId = request.getParameter("productAttributeId");
				if(Validation.isNumeric(productAttributeId)) {
					ProductAttribute productAttribute = productAttributeService.getProductAttributeById(Util.getNumeric(productAttributeId));
					attributes.add(0, productAttribute.getAttribute());
					map.addAttribute("editProductAttribute", productAttribute);
				}
				map.addAttribute("attributeList", attributes);
				
				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "productAttributes";
    }
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/admin/saveProductAttribute", method = RequestMethod.POST)
    public @ResponseBody String saveProductAttribute(ModelMap map, HttpServletRequest request, Principal principal)
    {
		JSONObject json = new JSONObject();
		try{
			String pid = request.getParameter("pid");
			String submitType = request.getParameter("submitType");
			String productAttributeId = request.getParameter("product_attribute");
			
			String attribute_type = request.getParameter("attribute_type");
			String attribute = request.getParameter("attribute");
			String product_attribute_option = request.getParameter("product_attribute_option");
			String product_attribute_value = request.getParameter("product_attribute_value");
			boolean allow_filter = request.getParameter("allow_filter") != null ? Boolean.parseBoolean(request.getParameter("allow_filter")) : false;
			boolean show_on_product_page = request.getParameter("show_on_product_page") != null ? Boolean.parseBoolean(request.getParameter("show_on_product_page")) : false;
			String attribute_order = request.getParameter("attribute_order");
			
			Attribute attr = null;
			AttributeValue attributeValue = null;
			Product product = null; 
			json.put("status", 400);
			if(Validation.isNumeric(pid)) {
				product = productService.getProductById(Util.getNumeric(pid));
				if(product == null) {
					json.put("msg", "Product not found !");
					return json.toJSONString();
				}
			}
			if(attribute_type == null || attribute_type.trim().equals("")) {
				json.put("msg", "Invalid attribute type !");
				return json.toJSONString();
				
			}else if(!Validation.isNumeric(attribute)){
				json.put("msg", "Invalid attribute !");
				return json.toJSONString();
				
			} else if(attribute_type.trim().equals(AttributeType.OPTIONS.name())){
				
				if(!Validation.isNumeric(attribute)) {
					json.put("msg", "Invalid attribute option !");
					return json.toJSONString();
				}else {
					attr = attributeService.getAttributeByAttributeId(Util.getNumeric(attribute));
					if(attribute == null) {
						json.put("msg", "Attribute not found !");
						return json.toJSONString();
					}
					if(!Validation.isNumeric(product_attribute_option)) {
						json.put("msg", "Invalid attribute option !");
						return json.toJSONString();
					}else {
						attributeValue = attributeValueService.getAttributeValueById(Util.getNumeric(product_attribute_option));
						if(attributeValue == null) {
							json.put("msg", "Attribute option not found !");
							return json.toJSONString();
						}
					}
				}
			}else {
				if(product_attribute_value == null || product_attribute_value.trim().equals("") ) {
					json.put("msg", "Invalid attribute value !");
					return json.toJSONString();
				}else {
					attr = attributeService.getAttributeByAttributeId(Util.getNumeric(attribute));
					if(attribute == null) {
						json.put("msg", "Attribute not found !");
						return json.toJSONString();
					}
				}
				allow_filter = false;
				
			}
			
			
			
			if(Validation.isNumeric(pid)){
				if(product != null) {
					ProductAttribute productAttribute = null;
					if(submitType !=  null && submitType.equals("update") ) {
						if(Validation.isNumeric(productAttributeId)) {
							productAttribute = productAttributeService.getProductAttributeById(Util.getNumeric(productAttributeId));
							if(productAttribute != null) {
								productAttribute.setAttribute(attr);
								productAttribute.setAttributeCustomValue(product_attribute_value);
								productAttribute.setAttributeType(attribute_type);
								productAttribute.setAttributeValue(attributeValue);
								productAttribute.setDisplayOrder(Util.getNumeric(attribute_order));
								productAttribute.setProduct(product);
								productAttribute.setAllowFilter(allow_filter);
								productAttribute.setShowOnProductPage(show_on_product_page);
								productAttributeService.updateProductAttribute(productAttribute);
								json.put("status", 200);
								json.put("msg", "Product attribute updated successfully !");
								return json.toJSONString();
							}
							else {
								json.put("status", 400);
								json.put("msg", "Product attribute not found !");
							}
						}else {
							json.put("status", 400);
							json.put("msg", "Invalid request !");
						}
					}else {
						productAttribute = new ProductAttribute();
						productAttribute.setAttribute(attr);
						productAttribute.setAttributeCustomValue(product_attribute_value);
						productAttribute.setAttributeType(attribute_type);
						productAttribute.setAttributeValue(attributeValue);
						productAttribute.setDisplayOrder(Util.getNumeric(attribute_order));
						productAttribute.setProduct(product);
						productAttribute.setAllowFilter(allow_filter);
						productAttribute.setShowOnProductPage(show_on_product_page);
						productAttribute.setCreateDate(new Date());
						productAttributeService.addProductAttribute(productAttribute);
						json.put("status", 200);
						json.put("msg", "Product attribute added successfully !");
						return json.toJSONString();
					}
				}else {
					json.put("status", 400);
					json.put("msg", "Product not found !");
				}
				
			}else {
				json.put("status", 400);
				json.put("msg", "Invalid request !");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return json.toJSONString();
    }
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/admin/getProductAttributeValues")
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
