package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.ProductDao;
import com.bookstore.domain.Product;

@Service
@Transactional
public class ProductServiceImpl implements ProductService
{
	@Autowired private ProductDao productDao;
	
	public int addProduct(Product product)
	{
		return this.productDao.addProduct(product);
	}

	public boolean updateProduct(Product product)
	{
		return this.productDao.updateProduct(product);
	}

	public Product getProductById(Integer productId)
	{
		return this.productDao.getProductById(productId);
	}

	public List<Product> getAllProducts()
	{
		return this.productDao.getAllProducts();
	}

	public List<Product> getAllProducts(int first, int max)
	{
		return this.productDao.getAllProducts(first, max);
	}

	public List<Product> getProducts(int first, int max)
	{
		return this.productDao.getProducts(first, max);
	}

	public List<Product> getProductsByCategoryIds(List<Integer> categoryIds, int first, int max)
	{
		return this.productDao.getProductsByCategoryIds(categoryIds, first, max);
	}

	public long countAllProducts()
	{
		return this.productDao.countAllProducts();
	}

	public long countProducts()
	{
		return this.productDao.countProducts();
	}

	public long countProductsByCategoryIds(List<Integer> categoryIds)
	{
		return this.productDao.countProductsByCategoryIds(categoryIds);
	}
}
