package com.bookstore.service;

import java.util.List;

import javax.transaction.Transactional;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookstore.dao.ProductOrderDao;
import com.bookstore.domain.ProductOrder;
import com.bookstore.enums.OrderStatus;
import com.bookstore.util.CustomerUtils;
import com.bookstore.util.DateUtils;
import com.bookstore.util.ProductOrderUtils;

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
	
	public List<ProductOrder> getLatestProductOrders(int first, int max){
		return this.productOrderDao.getLatestProductOrders(first, max);
	}
	
	public Long countProductOrdersByStatus(OrderStatus status) {
		return this.productOrderDao.countProductOrdersByStatus(status);
	}
	
	public Long countProductOrdersByStatus() {
		return this.productOrderDao.countProductOrdersByStatus();
	}

	@SuppressWarnings("unchecked")
	public JSONArray getProductOrdersJsonArray(int first, int max) {
		JSONArray jsonArray = new JSONArray();
		try {
			List<ProductOrder> orders = getLatestProductOrders(first, max);
			if(orders != null && !orders.isEmpty()) {
				
				for(ProductOrder order : orders) {
					JSONObject jsonOrder = new JSONObject();
					jsonOrder.put("product_order_id", order.getProductOrderId());
					jsonOrder.put("order_status", ProductOrderUtils.getProductOrderStatus(order.getOrderStatus()));
					jsonOrder.put("order_status_label", ProductOrderUtils.getProductOrderStatusClass(order.getOrderStatus()));
					jsonOrder.put("payment_status", "Pending");
					jsonOrder.put("customer", CustomerUtils.getCustomerNameWithEmail(order.getRegistration()));
					jsonOrder.put("store", "");
					jsonOrder.put("create_date", DateUtils.fullFormat.format(order.getCreateDate()));
					jsonOrder.put("total_order", order.getFinalPrice());
					jsonArray.add(jsonOrder);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonArray;
		
	}
	
}
