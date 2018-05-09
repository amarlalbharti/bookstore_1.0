package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.ProductOrderDao;
import com.bookstore.domain.ProductOrder;
import com.bookstore.enums.OrderStatus;

@Service
@Transactional
public class ProductOrderServiceImpl implements ProductOrderService
{
	@Autowired
	private ProductOrderDao productOrderDao;
	
	public int addProductOrder(ProductOrder productOrder) {
		return this.productOrderDao.addProductOrder(productOrder);
	}

	public boolean updateProductOrder(ProductOrder productOrder) {
		return this.productOrderDao.updateProductOrder(productOrder);
	}
	
	public ProductOrder getProductOrder(int productOrderId) {
		return this.productOrderDao.getProductOrder(productOrderId);
	}
	
	public ProductOrder getProductOrder(int productOrderId, int rid) {
		return this.productOrderDao.getProductOrder(productOrderId, rid);
	}
	
	public List<ProductOrder> getProductOrderByCustomer(int rid){
		return this.productOrderDao.getProductOrderByCustomer(rid);
	}
	
	public Long countProductOrdersByStatus(OrderStatus status) {
		return this.productOrderDao.countProductOrdersByStatus(status);
	}
}
