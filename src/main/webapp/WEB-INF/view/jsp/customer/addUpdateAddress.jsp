<%@page import="com.bookstore.util.CheckoutSteps"%>
<%@page import="com.bookstore.util.CustomerUtils"%>
<%@page import="com.bookstore.domain.CustomerAddress"%>
<%@page import="com.bookstore.domain.Registration"%>
<%@page import="com.bookstore.domain.Basket"%>
<%@page import="com.bookstore.util.ProductUtils"%>
<%@page import="com.bookstore.domain.Product"%>
<%@page import="com.bookstore.domain.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <meta charset="utf-8">
  <meta class="viewport" name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>
<body>
<form class="row no-margin address_form">
  <div class="col-sm-6 col-md-6">
	<label>Address: <span class="required">*</span></label>
	<input class="form-control" id="shipping_address" type="text">
  </div>
  <div class="col-sm-6 col-md-6">
	<label>Landmark: <span class="required">*</span></label>
	<input class="form-control" id="shipping_landmark" type="text">
  </div>
  
  <div class="clearfix"></div>
  
  <div class="col-sm-6 col-md-6">
	<label>Street:</label>
	<input class="form-control" id="shipping_street" type="text">
  </div>
  <div class="col-sm-6 col-md-6">
	<label>City: <span class="required">*</span></label>
	<select class="form-control "  id="shipping_city">
	</select>
  </div>
  
  <div class="clearfix"></div>
  
  <div class="col-sm-6 col-md-6">
	<label>State: <span class="required">*</span></label>
	<select class="form-control" id="shipping_state">
	  <option value="0">Select State</option>
	</select>
  </div>
  <div class="col-sm-6 col-md-6">
	<label>Country: <span class="required">*</span></label>
	<select class="form-control" id="shipping_country">
	  <option value="0" >Select Country</option>
	</select>
  </div>
  <div class="clearfix"></div>
  <div class="col-sm-6 col-md-6">
	<label>Zip/Postal Code: <span class="required">*</span></label>
	<input class="form-control number_only" id="shipping_pin" type="text">
  </div>
  <div class="col-sm-6 col-md-6">
	<label>Contact: <span class="required">*</span></label>
	<input class="form-control number_only" id="shipping_contact" type="text" maxlength="10">
  </div>
  
  <div class="clearfix"></div>
  
  <div class="col-sm-12 buttons-box text-right">
	<button class="btn btn-primary text-uppercase save_customer_address" type="button">Save & Continue Checkout</button>
	<span class="required"><b>*</b> Required Field</span>
  </div>
</form>
</body>
</html>