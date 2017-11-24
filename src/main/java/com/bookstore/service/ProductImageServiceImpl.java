package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.ProductImageDao;
import com.bookstore.domain.ProductImage;

@Service
@Transactional
public class ProductImageServiceImpl implements ProductImageService
{
	@Autowired private ProductImageDao productImageDao;
	
	public int addProductImage(ProductImage productImage)
	{
		return this.productImageDao.addProductImage(productImage);
	}

	public boolean updateProductImage(ProductImage productImage)
	{
		return this.productImageDao.updateProductImage(productImage);
	}

	public ProductImage getProductImageById(int imageId)
	{
		return this.productImageDao.getProductImageById(imageId);
	}

	public List<ProductImage> getProductImageByProductId(int productId)
	{
		return this.productImageDao.getProductImageByProductId(productId);
	}
	
	public boolean setProductImage(int productId) {
		return this.productImageDao.setProductImage(productId);
	}

}
