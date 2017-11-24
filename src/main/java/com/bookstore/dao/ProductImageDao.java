package com.bookstore.dao;

import java.util.List;

import com.bookstore.domain.ProductImage;

public interface ProductImageDao
{
	public int addProductImage(ProductImage productImage);
	
	public boolean updateProductImage(ProductImage productImage);
	
	public ProductImage getProductImageById(int imageId);
	
	public List<ProductImage> getProductImageByProductId(int productId);
	
	public boolean setProductImage(int productId);
	
}
