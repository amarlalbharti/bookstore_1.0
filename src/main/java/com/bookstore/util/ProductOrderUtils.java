package com.bookstore.util;

import java.util.Date;

import org.apache.log4j.Logger;

import com.bookstore.enums.OrderStatus;

public class ProductOrderUtils
{
	private static final Logger LOGGER = Logger.getLogger(ProductOrderUtils.class);
	
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
