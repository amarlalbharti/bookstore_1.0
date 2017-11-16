package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.Product;

public interface ProductService
{
	public int addProduct(Product product);
	
	public boolean updateProduct(Product product);
	
	public Product getProductById(Integer productId);
	
	public List<Product> getAllProducts();
	
	public List<Product> getAllProducts(int first, int max);
	
	public List<Product> getProducts(int first, int max);
	
	public List<Product> getProductsByCategoryIds(List<Integer> categoryIds, int first, int max);
	
	public long countAllProducts();
	
	public long countProducts();
	
	public long countProductsByCategoryIds(List<Integer> categoryIds);
	
	
}
