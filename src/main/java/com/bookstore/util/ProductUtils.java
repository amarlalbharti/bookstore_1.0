package com.bookstore.util;

import com.bookstore.domain.Product;

public class ProductUtils
{
	
	public static String getFriendlyUrl(Product product ){
		StringBuilder friendlyUrl = new StringBuilder();
		try{
			if(product != null){
				friendlyUrl.append("product");
				friendlyUrl.append("/");
				friendlyUrl.append("view");
				friendlyUrl.append("/");
				friendlyUrl.append(product.getPid());
				friendlyUrl.append("/");
				friendlyUrl.append(friendlyProductName(product.getProductName()));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return friendlyUrl.toString(); 
	}
	
	public static String getProductImageUrl(Product product ){
		StringBuilder friendlyUrl = new StringBuilder();
		try{
			if(product != null && product.getProductUrl() != null){
				friendlyUrl.append("/");
				friendlyUrl.append("media");
				friendlyUrl.append("/");
				friendlyUrl.append(product.getProductUrl());
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return friendlyUrl.toString(); 
	}
	
	
	public static String friendlyProductName(String productName){
		if(productName != null && !productName.trim().isEmpty()){
			productName = productName.replaceAll(" +", "-");
			productName = productName.toLowerCase();
		}
		return productName;
	}
	
}
