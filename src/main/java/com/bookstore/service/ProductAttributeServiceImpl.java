package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.ProductAttributeDao;
import com.bookstore.domain.ProductAttribute;

@Service
@Transactional
public class ProductAttributeServiceImpl implements ProductAttributeService
{
	@Autowired
	private ProductAttributeDao productAttributeDao;
	
	public int addProductAttribute(ProductAttribute productAttribute)
	{
		return this.productAttributeDao.addProductAttribute(productAttribute);
	}

	public boolean updateProductAttribute(ProductAttribute productAttribute)
	{
		return this.productAttributeDao.updateProductAttribute(productAttribute);
	}

	public boolean deleteProductAttribute(ProductAttribute productAttribute)
	{
		return this.productAttributeDao.deleteProductAttribute(productAttribute);
	}

	public ProductAttribute getProductAttributeById(int productAttributeId)
	{
		return this.productAttributeDao.getProductAttributeById(productAttributeId);
	}

	public List<ProductAttribute> getProductAttributeByPid(int pid)
	{
		return this.productAttributeDao.getProductAttributeByPid(pid);
	}

}
