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
        <div class="col-md-12">
          <!-- Horizontal Form -->
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#tab-info" data-toggle="tab">Order Info</a></li>
              <li><a href="#tab-shipping" data-toggle="tab">Shipping Info</a></li>
              <li><a href="#tab-products" data-toggle="tab">Product Info</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="tab-info">
               	<div class="panel-group form-horizontal">
               		<div class="panel panel-default">
               			<div class="panel-body">
               				<div class="form-group">
								<div class="col-md-3">
									<div class="label-wrapper">
										<label class="control-label" for="CustomOrderNumber">
											<spring:message code="label.product.order.header.orderstatus"/>
										</label>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-text-row"><%= ProductOrderUtils.getProductOrderStatus(productOrder.getOrderStatus()) %></div>
								</div>
							</div>
               				<div class="form-group">
								<div class="col-md-3">
									<div class="label-wrapper">
										<label class="control-label" for="CustomOrderNumber">
											<spring:message code="label.product.order.header.order"/>
										</label>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-text-row"><%= productOrder.getTransactionId() %></div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-3">
									<div class="label-wrapper">
										<label class="control-label" for="CustomOrderNumber">
											<spring:message code="label.product.order.header.created"/>
										</label>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-text-row"><%= DateUtils.clientFullformat.format(productOrder.getCreateDate()) %></div>
								</div>
							</div>
               			</div>
               		</div>
               	</div>
              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="tab-shipping">
                
              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="tab-products">
                
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
        </div>
        
      </div>
      <!-- /.row (main row) -->
			<%
     	}
     %>
    </section>
    <!-- /.content -->
  </div>
	
</body>
</html>