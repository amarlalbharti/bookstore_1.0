package com.bookstore.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;

import com.bookstore.comparator.OrderItemComparator;
import com.bookstore.domain.OrderItem;
import com.bookstore.domain.ProductOrder;
import com.bookstore.enums.OrderStatus;
import com.bookstore.enums.PaymentMode;
import com.bookstore.enums.PaymentStatus;

public class ProductOrderUtils
{
	private static final Logger LOGGER = Logger.getLogger(ProductOrderUtils.class);
	
	
	public static List<OrderItem> getSortedOrderItems(Set<OrderItem> itemSet){
		List<OrderItem> itemList = null;
		if(itemSet != null && !itemSet.isEmpty()) {
			itemList = new ArrayList<OrderItem>();
			itemList.addAll(itemSet);
			Collections.sort(itemList, new OrderItemComparator());
		}
		return itemList;
	}
	
	public static String getProductOrderStatus(int status) {
		String ps = null;
		try
		{
			switch (OrderStatus.values()[status])
			{
				case AWAITING_EXCHANGE:
					ps = "Pending";
					break;
				case COMPLETED:
					ps = "Delivered";
					break;
				case CANCELLED:
					ps = "Canceled";
					break;
				case IN_PROGRESS:
					ps = "Shipped";
					break;
				case ONHOLD:
					ps = "On Hold";
					break;
				case PARTIALLY_SHIPPED:
					ps = "Shipped Partially";
					break;
					
				default:
					ps = "Pending";
					break;
			}
		} catch (Exception e) {
			LOGGER.error("Error in getProductOrderStatus(int status) >> for status :"+status, e);
		}
		return ps;
	}
	
	public static int getValidShippingStatus(String shippingStatus) {
		int status = -1;
		try {
			status = Util.getNumeric(shippingStatus);
			if(status >= 0 && status < OrderStatus.values().length) {
				return status;
			}
			
		} catch (Exception e) {
			LOGGER.error("Error in getValidShippingStatus(String shippingStatus) >> for status :"+shippingStatus, e);
		}
		return -1;
	}
	public static String getPaymentStatus(int paymentStatus) {
		String ps = null;
		try
		{
			switch (PaymentStatus.values()[paymentStatus])
			{
				case UNPAID:
					ps = "Unpaid";
					break;
				case PARTIALLY_PAID:
					ps = "Partially Paid";
					break;
				case PAID:
					ps = "Paid";
					break;
				case REFUNDED:
					ps = "Refunded";
					break;
				case PARTIALLY_REFUNDED:
					ps = "Partially Refunded";
					break;
				default:
					ps = "Unpaid";
					break;
			}
		} catch (Exception e) {
			LOGGER.error("Exception while retriving payment status for "+paymentStatus, e);
		}
		return ps;
	}
	
	public static String getPaymentMode(int paymentMode) {
		String ps = null;
		try
		{
			switch (PaymentMode.values()[paymentMode])
			{
				case COD:
					ps = "COD";
					break;
				default:
					ps = "COD";
					break;
			}
		} catch (Exception e) {
			LOGGER.error("Exception while retriving payment mode for "+paymentMode, e);
		}
		return ps;
	}
	
	public static String getProductOrderStatusClass(int status) {
		String ps = null;
		try
		{
			switch (OrderStatus.values()[status])
			{
				case AWAITING_EXCHANGE:
					ps = "label-warning";
					break;
				case COMPLETED:
					ps = "label-success";
					break;
				case CANCELLED:
					ps = "label-danger";
					break;
				case IN_PROGRESS:
					ps = "label-info";
					break;
				case ONHOLD:
					ps = "label-primary";
					break;
				case PARTIALLY_SHIPPED:
					ps = "label-default";
					break;
					
				default:
					ps = "Pending";
					break;
			}
		} catch (Exception e) {
			LOGGER.error("Error in getProductOrderStatusClass(int status) >> for status :"+status, e);
		}
		return ps;
	}
	
	public static synchronized Long getTransactionId() {
		Long transactionId = 0L;
		try
		{
			Date date = new Date();
			transactionId = date.getTime();
		} catch (Exception e) {
			LOGGER.error("Exception while generating transaction id ", e);
		}
		return transactionId;
	}
}
