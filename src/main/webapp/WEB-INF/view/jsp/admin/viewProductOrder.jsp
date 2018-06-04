<%@page import="com.bookstore.util.CustomerUtils"%>
<%@page import="com.bookstore.domain.OrderItem"%>
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
<style type="text/css">
.dl-horizontal dt, .dl-horizontal dd{
	padding: 5px;
}
</style>
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
                
                <dt><spring:message code="label.product.order.header.customer"/></dt>
                <dd><%= CustomerUtils.getCustomerNameWithEmail(productOrder.getRegistration()) %></dd>
                
                <dt><spring:message code="label.product.order.shipping.address"/></dt>
                <dd><%= productOrder.getShippingAddress()%></dd>
                
                <%
                	if(productOrder.getModifyDate() != null){
                		%>
			                <dt><spring:message code="label.product.order.header.modified"/></dt>
			                <dd><%= DateUtils.clientFullformat.format(productOrder.getModifyDate()) %></dd>
                		<%
                	}
                %>
                
                <dt><spring:message code="label.product.order.header.created"/></dt>
                <dd><%= DateUtils.clientFullformat.format(productOrder.getCreateDate()) %></dd>
                
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
                <dt><spring:message code="label.product.order.payment.status"/></dt>
                <dd><%= ProductOrderUtils.getPaymentStatus(productOrder.getPaymentStatus())%></dd>
                
                
                <dt><spring:message code="label.product.order.item.totalprice"/></dt>
                <dd><i class="fa fa-fw fa-rupee"></i><%= productOrder.getFinalPrice() %></dd>
                
                <dt><spring:message code="label.product.order.payment.mode"/></dt>
                <dd><%= ProductOrderUtils.getPaymentMode(productOrder.getPaymentMode()) %></dd>
                 
               
                
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
              <table class="table table-bordered table-striped text-center">
				   <thead>
				   <tr class="bg-primary">
				     <th><spring:message code="label.product.header.picture"/></th>
				     <th><spring:message code="label.product.header.product"/></th>
				     <th><spring:message code="label.product.header.price"/></th>
				     <th><spring:message code="label.product.order.item.quantity"/></th>
				     <th><spring:message code="label.product.order.item.totalprice"/></th>
				     <th><spring:message code="label.product.header.action"/></th>
				   </tr>
				   </thead>
				   <tbody>
				   <%
				    
				   	List<OrderItem> itemList = ProductOrderUtils.getSortedOrderItems(productOrder.getOrderItems());
				   	if(itemList != null && !itemList.isEmpty()){
				   		for(OrderItem item : itemList){
				   			%>
				   				<tr>
				   				 <td><img alt="<%= item.getProduct().getProductName() %>" src='<%= item.getProduct().getProductUrl() != null?  ProjectConfig.PUBLIC_PATH +item.getProduct().getProductUrl():"images/no-preview-available.png" %>' width="75px"></td>
						         <td style="text-align: left;"><%= item.getProduct().getProductName()%></td>
						         <td><i class="fa fa-fw fa-rupee"></i><%= item.getProduct().getProductPrice()%></td>
						         <td><%= item.getQuantity()%></td>
						         <td><i class="fa fa-fw fa-rupee"></i><%= item.getProduct().getProductPrice() * item.getQuantity()%></td>
						         <td>
						         	<a href="${pageContext.request.contextPath}/admin/products/edit/<%= item.getOrderItemId()%>"class="btn btn-flat btn-sm btn-primary"><i class="fa fa-fw fa-edit"></i> Edit</a>
						         </td>
						       </tr>
				   			<%
				   		}
				   	}else{
				   		%>
							<tr>
					  			<td colspan="6">No record founds !</td>
					     	</tr>
						<%
				   	}
				   %>
				   </tbody>
				 </table>
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