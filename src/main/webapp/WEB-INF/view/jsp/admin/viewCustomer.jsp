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
			            </ul>
			            <div class="tab-content">
			              <div class="tab-pane active" id="tab_1">
							<div class="box-body">
							  <div class="col-md-12">
								<div class="box box-default box-solid">
								<div class="box-header with-border">
					              <h3 class="box-title">General Information</h3>
					            </div>
					              <div class="box-body">
                                     
		                           <div class="form-group">
					                  <label class="col-sm-4 control-label" style="text-align: left;">Name</label>
					                  <div class="col-sm-8">
					                    <label class="form-control label-text"><%=customer.getFirstName()+' '+customer.getLastName() %></label>
					                  </div>
					                </div>
					                <div class="form-group">
					                  <label class="col-sm-4 control-label"  style="text-align: left;">Email ID</label>
					                  <div class="col-sm-8">
					                    <label class="form-control label-text"><%=customer.getEmail()%></label>
					                  </div>
					                </div>
					                <div class="form-group ">
					                  <label class="col-sm-4 control-label"  style="text-align: left;">Gender</label>
					                  <div class="col-sm-8">
					                    <label class="form-control"><%=customer.getGender()%></label>
					                  </div>
					                </div>
					                
					                <div class="form-group">
					                  <label class="col-sm-4 control-label"  style="text-align: left;">Contact Number</label>
					                  <div class="col-sm-8">
					                    <label class="form-control"><%=customer.getContact()%></label>
					                  </div>
					                </div>
					                
					                <div class="form-group">
					                  <label class="col-sm-4 control-label"  style="text-align: left;">DOB</label>
					                  <div class="col-sm-8">
					                    <label class="form-control"><%=DateUtils.clientDateFormat.format(customer.getDob())%></label>
					                  </div>
					                </div>
				             	 </div>
				              </div>
				            </div>
						</div>
					</div>
						
					   <div class="tab-pane" id="tab_2">
					    <form action="appUserResetPassword" method="POST" id="changePsw">		
							<div class="box-body">
								<div class="form-horizontal">
									<div class="box-body">
										
										<div class="form-group has-feedback col-md-6">
											<label class="col-sm-4 control-label" style="text-align: left;">New Password</label>
											<div class="col-sm-8">
												<input type="password" class="form-control" placeholder="New Password" name="newPassword"  required="required">
												<input type="hidden" name="empid" value="">
				        						<span class="fa fa-lock  form-control-feedback"></span>
											</div>
										</div>
										<div class="clearfix"></div>
										<div class="form-group has-feedback col-md-6">
											<label class="col-sm-4 control-label" style="text-align: left;">Confirm Password</label>
											<div class="col-sm-8">
												<input type="password" class="form-control" placeholder="Confirm Password" name="confPassword"  required="required">
	        									<span class="fa fa-lock  form-control-feedback"></span>
											</div>
										</div>
										<div class="clearfix"></div>
										<div class="form-group has-feedback col-md-6">
											<button type="submit" class="btn btn-primary btn-flat pull-right" style="margin-right: 15px;">Change Password</button>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div></div>
			
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