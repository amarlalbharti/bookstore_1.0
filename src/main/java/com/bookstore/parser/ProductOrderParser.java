package com.bookstore.parser;

import java.util.List;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.bookstore.domain.ProductOrder;
import com.bookstore.enums.OrderStatus;
import com.bookstore.util.CustomerUtils;
import com.bookstore.util.DateUtils;
import com.bookstore.util.ProductOrderUtils;

public class ProductOrderParser
{
	private static final Logger LOGGER = Logger.getLogger(ProductOrderParser.class);
	
	@SuppressWarnings("unchecked")
	public static JSONArray parseProductOrderList(List<ProductOrder> orders) {
		JSONArray array = new JSONArray();
		try {
			if(orders != null && !orders.isEmpty()) {
				for(ProductOrder order : orders) {
					JSONObject json = parseProductOrder(order);
					if(json != null) {
						array.add(json);
					}
				}
			}
		}catch (Exception e) {
			LOGGER.error("Error in parseProductOrderList() >> ", e);
		}
		return array;
		
	}
	

	@SuppressWarnings("unchecked")
	public static JSONObject parseProductOrder(ProductOrder order) {
		try {
			if(order != null) {
				JSONObject json = new JSONObject();
				json.put("productOrderId", order.getProductOrderId());
				json.put("totalItems",order.getTotalItems());
				json.put("finalPrice",order.getFinalPrice());
				json.put("orderStatus",ProductOrderUtils.getProductOrderStatus(order.getOrderStatus()));
				json.put("orderStatusClass",ProductOrderUtils.getProductOrderStatusClass(order.getOrderStatus()));
				json.put("customerPhone",order.getCustomerPhone());
				json.put("customerName",CustomerUtils.getCustomerName(order.getRegistration()));
				json.put("createDate",DateUtils.fullFormat.format(order.getCreateDate()));
				json.put("shippingAddress",order.getShippingAddress());
				
				return json;
			}
		}catch (Exception e) {
			LOGGER.error("Error in parseProductOrderList() >> ", e);
		}
		return null;
	}
	
}
