<%@page import="com.bookstore.enums.PaymentStatus"%>
<%@page import="com.bookstore.util.ProductOrderUtils"%>
<%@page import="com.bookstore.enums.OrderStatus"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<title>aa</title>

</head>
<body>
	

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header clearfix" >
      <h1 class="pull-left"><spring:message code="label.admin.leftmenu.orders" /></h1>
    </section>

    <!-- Main content -->
    <section class="content order_search" style="min-height: 530px;">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-info">
            <!-- form start -->
            <form class="form-horizontal search_form">
              <div class="box-body">
              	 <div class="col-md-6">
              	 	<div class="form-group">
	                  <label for="startdate" class="col-sm-3 control-label"><spring:message code="label.search.startdate"/></label>
	                  <div class="col-sm-9">
	                    <div class="input-group date">
		                  <input type="text" class="form-control pull-right datepicker" id="search_start_date">
		                  <div class="input-group-addon">
		                    <i class="fa fa-calendar"></i>
		                  </div>
		                </div>
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="enddate" class="col-sm-3 control-label"><spring:message code="label.search.enddate"/></label>
	                  <div class="col-sm-9">
	                    <div class="input-group date">
		                  <input type="text" class="form-control pull-right datepicker" id="search_end_date">
		                  <div class="input-group-addon">
		                    <i class="fa fa-calendar"></i>
		                  </div>
		                </div>
	                  </div>
	                </div>
              	 </div>
              	 <div class="col-md-6">
              	 	<div class="form-group">
	                  <label for="orderstatus" class="col-sm-3 control-label">
	                  	<spring:message code="label.product.order.header.orderstatus"/>
	               	  </label>
	                  <div class="col-sm-9">
	                    <select class="form-control select2" multiple="multiple" id="search_order_status">
		                    <option value="-1" selected="selected"><spring:message code="label.all"/></option>
		                    <%
		                    	for(OrderStatus orderStatus : OrderStatus.values()){
		                    		%>
		                    			<option value="<%= orderStatus.ordinal()%>"><%= ProductOrderUtils.getProductOrderStatus(orderStatus.ordinal())%></option>
		                    		<%
		                    	}
		                    %>
	                    </select>
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="paymentstatus" class="col-sm-3 control-label">
	                  	<spring:message code="label.product.order.header.paymentstatus"/>
	               	  </label>
	                  <div class="col-sm-9">
	                    <select class="form-control select2" multiple="multiple" id="search_payment_status">
		                    <option value="-1" selected="selected"><spring:message code="label.all"/></option>
		                    <%
		                    	for(PaymentStatus paymentStatus : PaymentStatus.values()){
		                    		%>
		                    			<option value="<%= paymentStatus.ordinal()%>"><%= ProductOrderUtils.getPaymentStatus(paymentStatus.ordinal())%></option>
		                    		<%
		                    	}
		                    %>
	                    </select>
	                  </div>
	                </div>
	                <div class="form-group">
	                  <label for="enddate" class="col-sm-3 control-label"><spring:message code="label.search.goto"/> #</label>
	                  <div class="col-sm-9">
	                    <div class="input-group input-group-sm">
			            <input class="form-control" type="text">
		                    <span class="input-group-btn">
		                      <button type="button" class="btn btn-info btn-flat"><spring:message code="label.go"/>!</button>
		                    </span>
			            </div>
	                  </div>
	                </div>
              	 </div>
                
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <button type="button" class="btn btn-default"><spring:message code="label.reset"/></button>
                <button type="button" id="btn_search_order" class="btn btn-primary pull-right"><i class="fa fa-search"></i>  <spring:message code="label.datatable.search"/></button>
              </div>
              <!-- /.box-footer -->
            </form>
          </div>
        </div>
      </div>
      <!-- Main row -->
      <div class="row">
        <div class="col-md-12">
          <!-- Horizontal Form -->
          <div class="box box-primary orders">
            <div class="box-body" id="orders_list">
				<div class="row">
					<div class="col-sm-6">
						<div class="dataTables_length" id="example1_length">
							<label>Show 
							<select name="orders_rpp" id="orders_rpp" aria-controls="example1" class="form-control input-sm">
								<option value="10">10</option>
								<option value="25">25</option>
								<option value="50">50</option>
								<option value="100">100</option>
								</select>
								entries
							</label>
						</div>
					</div>
					<div class="col-sm-6">
						<button id="refresh_orders_table" class="btn btn-sm  pull-right"><i class="fa fa-refresh"></i> Reload</button>
					</div>
				</div>
				<table class="table table-bordered table-striped text-center" id="orders_table">
				   <thead>
					   <tr class="bg-primary">
					     <th><input type="checkbox" ></th>
					     <th><spring:message code="label.product.order.header.order"/></th>
					     <th><spring:message code="label.product.order.header.orderstatus"/></th>
					     <th><spring:message code="label.product.order.header.paymentstatus"/></th>
					     <th ><spring:message code="label.product.order.header.customer"/></th>
					     <th><spring:message code="label.product.order.header.store"/></th>
					     <th><spring:message code="label.product.order.header.created"/></th>
					     <th><spring:message code="label.product.order.header.ordertotal"/></th>
					     <th><spring:message code="label.product.order.header.view"/></th>
					   </tr>
				   </thead>
				   <tbody>
                  
                  </tbody>
			   </table>
			   <div class="row order_pagi">
			   	<div class="col-sm-5">
			   		<div class="dataTables_info" id="order_paginate_label" role="status" aria-live="polite"></div>
				</div>
				<div class="col-sm-7">
					<div class="dataTables_paginate paging_simple_numbers">
						<ul class="pagination">
							<li class="paginate_button previous disabled">
	  							<a href="javascript:void(0);" aria-controls="example2" data-dt-idx="1" tabindex="0"><spring:message code="label.datatable.pagination.previous"/></a>
							</li>
							<li class="paginate_button active ">
								<a href="#" aria-controls="example2" data-dt-idx="1" tabindex="0" class="curr_page">1</a>
							</li>
 							<li class="paginate_button next disabled" >
								<a href="javascript:void(0);" aria-controls="example2" data-dt-idx="1" tabindex="0"><spring:message code="label.datatable.pagination.next"/></a>
							</li>
						</ul>
					</div>
				</div>
			</div>
            </div>
            <div class="overlay">
              <i class="fa fa-refresh fa-spin"></i>
            </div>
          </div>
        </div>
        
      </div>
      <!-- /.row (main row) -->

    </section>
    <!-- /.content -->
  </div>

<script type="text/javascript">
 $(document).ready(function(){
	
	 $.getProductOrdersList();
    
	
	$('.datepicker').datepicker({
      autoclose: true
    })
	 $('.select2').select2();
	
	$(document).on("change","#search_order_status",function() {
		var status = $(this).val();
		if (status == null ) {
			$('#search_order_status').val("-1").trigger('change');
		}else {
			if(status.length > 1 && status.indexOf("-1") > -1){
				console.log("all & others ");
				$('#search_order_status').val(status.slice(1)).trigger('change');
			}
		}
	});
	

	$(document).on("change","#orders_rpp",function() {
		var rpp = $("#orders_list #orders_rpp").val();
		$.getProductOrdersList(1, rpp);
	});
	
});
</script>
  
</body>
</html>