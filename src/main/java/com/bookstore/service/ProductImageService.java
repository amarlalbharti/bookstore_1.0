package com.bookstore.service;

import java.util.List;

import com.bookstore.domain.ProductImage;

public interface ProductImageService
{
	public int addProductImage(ProductImage productImage);
	
	public boolean updateProductImage(ProductImage productImage);
	
	public int deleteProductImage(List<Integer> imageIds) ;
	
	public ProductImage getProductImageById(int imageId);
	
	public List<ProductImage> getProductImageByProductId(int productId);
	
	public boolean setProductImage(int productId);

}
