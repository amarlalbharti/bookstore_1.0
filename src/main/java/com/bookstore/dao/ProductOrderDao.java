package com.bookstore.dao;

import java.util.List;

import com.bookstore.domain.ProductOrder;

public interface ProductOrderDao
{
	public int addProductOrder(ProductOrder productOrder);

	public boolean updateProductOrder(ProductOrder productOrder);
	
	public ProductOrder getProductOrder(int productOrderId);
	
	public ProductOrder getProductOrder(int productOrderId, int rid);
	
	public List<ProductOrder> getProductOrderByCustomer(int rid);
	
}