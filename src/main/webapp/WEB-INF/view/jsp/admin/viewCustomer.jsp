<%@page import="com.bookstore.domain.Basket"%>
<%@page import="com.bookstore.domain.CustomerAddress"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="com.bookstore.config.DateUtils"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.bookstore.domain.Customer"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
 
</head>
<body>
<%
Customer customer = (Customer)request.getAttribute("customer");
	%>

	<div class="content-wrapper">
    <section class="content-header clearfix" >
      <h1 class="pull-left">Customers</h1>
      <ol class="breadcrumb">
        <li><a href="dashboard"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="customers"><i class="fa fa-dashboard"></i> Customers</a></li>
        <li class="active">View Customer</li>
      </ol>
     </section>
    <!-- Main content -->
    <section class="content">
		      <!-- Your Page Content Here -->
		<div class="row">
			<div class="col-md-12">
				<div class="nav-tabs-custom">
			            <ul class="nav nav-tabs">
			              <li class="active"><a href="#tab_1" data-toggle="tab">Customer Info</a></li>
			              <li><a href="#tab_2" data-toggle="tab">Customer Basket</a></li>
			              <li><a href="#tab_3" data-toggle="tab">Customer Orders</a></li>
			            </ul>
			            <div class="tab-content">
			              <div class="tab-pane active" id="tab_1">
							<div class="box-body">
							  <div class="col-md-7">
								<div class="box box-default box-solid">
								<div class="box-header with-border">
					              <h3 class="box-title">General Information</h3>
					            </div>
					              <div class="box-body">
                                     
		                           <div class="form-group">
					                  <label class="col-sm-4 control-label" style="text-align: right;">Name</label>
					                  <div class="col-sm-8">
					                    <label class="form-control label-text"><%=customer.getFirstName()+' '+customer.getLastName() %></label>
					                  </div>
					                </div>
					                <div class="form-group">
					                  <label class="col-sm-4 control-label"  style="text-align: right;">Email ID</label>
					                  <div class="col-sm-8">
					                    <label class="form-control label-text"><%=customer.getEmail()%></label>
					                  </div>
					                </div>
					                <div class="form-group ">
					                  <label class="col-sm-4 control-label"  style="text-align: right;">Gender</label>
					                  <div class="col-sm-8">
					                    <label class="form-control"><%=customer.getGender()%></label>
					                  </div>
					                </div>
					                
					                <div class="form-group">
					                  <label class="col-sm-4 control-label"  style="text-align: right;">Contact Number</label>
					                  <div class="col-sm-8">
					                    <label class="form-control"><%=customer.getContact()%></label>
					                  </div>
					                </div>
					                
					                <div class="form-group">
					                  <label class="col-sm-4 control-label"  style="text-align: right;">DOB</label>
					                  <div class="col-sm-8">
					                    <label class="form-control"><%=DateUtils.clientDateFormat.format(customer.getDob())%></label>
					                  </div>
					                </div>
				             	 </div>
				              </div>
				            </div>
				            
				            <div class="col-md-5">
								<div class="box box-default box-solid">
								<div class="box-header with-border">
					              <h3 class="box-title">Address Info</h3>
					            </div>
								<%
					                int  count = 0; 
					              	List<CustomerAddress> custAddList = (List)request.getAttribute("custAddress");
					              	if(custAddList != null && !custAddList.isEmpty()){
				              		for(CustomerAddress customerAddress : custAddList){
			              		%>
								
					              <div class="box-body">
                                     
		                           <div class="form-group">
					                  <!-- <label class="col-sm-4 control-label" style="text-align: right;">Address</label> -->
					                  <div class="col-sm-12">
					                    <label class="form-control label-text"><%=customerAddress.getCustomerStreet() +", "+ customerAddress.getCustomerCity() +" "+customerAddress.getCustomerPinCode() %></label>
					                  </div>
					                </div>
					          	 </div>
				             	 <%
					                	}
						              	}else{
					                		%>
						        				<div class="form-group">
						        				  No record founds !
								                </div>
						        			<%
					                	}
					                %>
				              </div>
				              
				              
				            </div>
				            
						</div>
					</div>
						
					   <div class="tab-pane" id="tab_2">
						  <div class="box-body">
							<div class="col-md-7">
							  <div class="box box-default box-solid">
								<div class="box-header with-border">
					              <h3 class="box-title">Basket Info</h3>
					            </div>
					            
					            <%
					                int  count1 = 0; 
					              	List<Basket> basketList = (List)request.getAttribute("custBasket");
					              	if(basketList != null && !basketList.isEmpty()){
				              		for(Basket customerBasket : basketList){
			              		%>
					              <div class="box-body">
                                     
		                           <div class="form-group">
					                  <label class="col-sm-4 control-label" style="text-align: right;">Product Name</label>
					                  <div class="col-sm-8">
					                    <label class="form-control label-text"><%=customerBasket.getProduct().getProductName() %></label>
					                  </div>
					                </div>
					                <div class="form-group">
					                  <label class="col-sm-4 control-label"  style="text-align: right;">Quantity</label>
					                  <div class="col-sm-8">
					                    <label class="form-control label-text"><%=customerBasket.getQuantity()%></label>
					                  </div>
					                </div>
					                <div class="form-group ">
					                  <label class="col-sm-4 control-label"  style="text-align: right;">Price</label>
					                  <div class="col-sm-8">
					                    <label class="form-control"><%=customerBasket.getFinalPrice()%></label>
					                  </div>
					                </div>
				             	 </div>
				             	 
				             	 <%
		                 }
			              }else{
	                		%>
		        				<div class="form-group">
		        				  No record founds !
				                </div>
		        			<%
		                 }
		                %>
				              </div>
				            </div>
   						</div>
						
					</div>
					
					<div class="tab-pane" id="tab_3">
							<div class="box-body">
							  <div class="col-md-12">
								<div class="box box-default box-solid">
								<div class="box-header with-border">
					              <h3 class="box-title">Orders Info</h3>
					            </div>
					              <div class="box-body">
                                     
		                           
				             	 </div>
				              </div>
				            </div>
						</div>
					</div>
				</div>
			</div>
		  </div>
		</div>
    </section>
<script type="text/javascript">

	$(document).ready(function()
	{
		$("#changePwd").trigger('reset');
	});

	
</script>  
   
    <!-- /.content -->
  </div>
 </body>