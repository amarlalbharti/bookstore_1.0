<%@page import="com.bookstore.util.ProductOrderUtils"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.bookstore.domain.ProductOrder"%>
<%@page import="com.bookstore.config.ProjectConfig"%>
<%@page import="com.bookstore.domain.Product"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="com.bookstore.util.DateUtils"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.bookstore.domain.Category"%>
<%@page import="java.util.List"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

</head>
<body>
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header clearfix" >
      <h1 class="pull-left">Product Order Detail</h1>
      <div class="pull-right">
      	<a href="${pageContext.request.contextPath}/admin/products/add" class="btn btn-flat btn-primary pull-right"><i class="fa fa-fw fa-plus-square"></i> Add New</a>
      </div>
    </section>

    <!-- Main content -->
    <section class="content" style="min-height: 530px;">
     <%
     	ProductOrder productOrder = (ProductOrder)request.getAttribute("productOrder");
     	if(productOrder != null){
     		%>
     		
      <!-- Main row -->
      <div class="row">
      <div class="col-md-7">
          <div class="box box-solid">
            <div class="box-header with-border">
              <h3 class="box-title"><spring:message code="label.product.order.tab.order"/></h3>
            </div>
            <div class="box-body">
              <dl class="dl-horizontal">
                <dt><spring:message code="label.product.order.header.orderstatus"/></dt>
                <dd><%= ProductOrderUtils.getProductOrderStatus(productOrder.getOrderStatus()) %></dd>
                <dt><spring:message code="label.product.order.header.order"/></dt>
                <dd><%= productOrder.getTransactionId() %></dd>
              </dl>
            </div>
          </div>
        </div>
        <div class="col-md-5">
          <div class="box box-solid">
            <div class="box-header with-border">
              <h3 class="box-title"><spring:message code="label.product.order.tab.payment"/></h3>
            </div>
            <div class="box-body">
              <dl class="dl-horizontal">
                <dt><spring:message code="label.product.order.header.orderstatus"/></dt>
                <dd><%= ProductOrderUtils.getProductOrderStatus(productOrder.getOrderStatus()) %></dd>
                <dt><spring:message code="label.product.order.header.order"/></dt>
                <dd><%= productOrder.getTransactionId() %></dd>
              </dl>
            </div>
          </div>
        </div>
        
        <div class="col-md-7">
          <div class="box box-solid">
            <div class="box-header with-border">
              <h3 class="box-title"><spring:message code="label.product.order.tab.product"/></h3>
            </div>
            <div class="box-body">
              <dl class="dl-horizontal">
                <dt><spring:message code="label.product.order.header.orderstatus"/></dt>
                <dd><%= ProductOrderUtils.getProductOrderStatus(productOrder.getOrderStatus()) %></dd>
                <dt><spring:message code="label.product.order.header.order"/></dt>
                <dd><%= productOrder.getTransactionId() %></dd>
              </dl>
            </div>
          </div>
        </div>
        
        
      </div>
			<%
     	}
     %>
    </section>
  </div>
	
</body>
</html>