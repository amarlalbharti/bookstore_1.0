package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.ProductOrder;

public interface ProductOrderService
{
	public int addProductOrder(ProductOrder productOrder);

	public boolean updateProductOrder(ProductOrder productOrder);
	
	public ProductOrder getProductOrder(int productOrderId);
	
	public List<ProductOrder> getProductOrderByCustomer(int rid);
	
}
