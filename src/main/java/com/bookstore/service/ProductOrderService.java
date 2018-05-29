package com.bookstore.service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.bookstore.domain.ProductOrder;
import com.bookstore.enums.OrderStatus;

public interface ProductOrderService
{
	public int addProductOrder(ProductOrder productOrder);

	public boolean updateProductOrder(ProductOrder productOrder);
	
	public ProductOrder getProductOrder(int productOrderId);
	
	public ProductOrder getProductOrder(int productOrderId, int rid);
	
	public List<ProductOrder> getProductOrderByCustomer(int rid);
	
	public List<ProductOrder> getLatestProductOrders(int first, int max);
	
	public Long countProductOrdersByStatus();
	
	public Long countProductOrdersByStatus(OrderStatus status);
	
	public JSONArray getProductOrdersJsonArray(int first, int max);
}
