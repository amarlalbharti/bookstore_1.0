package com.bookstore.dao;

import java.util.List;

import com.bookstore.domain.ProductOrder;
import com.bookstore.enums.OrderStatus;

public interface ProductOrderDao
{
	public int addProductOrder(ProductOrder productOrder);

	public boolean updateProductOrder(ProductOrder productOrder);
	
	public ProductOrder getProductOrder(int productOrderId);
	
	public ProductOrder getProductOrderByTransationId(long transactionId);
	
	public ProductOrder getProductOrder(int productOrderId, int rid);
	
	public List<ProductOrder> getProductOrderByCustomer(int rid);
	
	public List<ProductOrder> getLatestProductOrders(int first, int max);
	
	public Long countProductOrdersByStatus();
	
	public Long countProductOrdersByStatus(OrderStatus status);
	
}
