package com.bookstore.dao;

import java.util.List;

import com.bookstore.domain.ProductAttribute;

public interface ProductAttributeDao
{
	public int addProductAttribute(ProductAttribute productAttribute);
	
	public boolean updateProductAttribute(ProductAttribute productAttribute);
	
	public boolean deleteProductAttribute(ProductAttribute productAttribute);
	
	public ProductAttribute getProductAttributeById(int productAttributeId);
	
	public List<ProductAttribute> getProductAttributeByPid(int pid);
	
}
