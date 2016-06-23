<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="com.ems.domain.UserDetail"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="css/bootstrap.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="css/AdminLTE.css">
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect.
  -->
  <link rel="stylesheet" href="css/skin-blue.css">
  <style type="text/css">
  .error{color: red;}
  .success{color: #00C0EF;}
  </style>
</head>
<body>

<%
		Registration registration = (Registration)request.getAttribute("registration");
        UserDetail userDetail = (UserDetail)request.getAttribute("userDetail");
	    System.out.println("Regi : " + registration);
	    System.out.println("UserDetail : " + userDetail);
		if(registration != null)
		{
			%>
				<div class="content-wrapper">
				    
				    <!-- Main content -->
				    <section class="content">
						      <!-- Your Page Content Here -->
						<div class="row">
						  <div class="col-xs-6 col-md-6">
								<h2>Basic Info</h2>
								<div class="box box-info">
									<div class="box-body  table-responsive">
										<table class="table">
											<thead>
												<tr>
												<td>Name</td>
												<td><%= registration.getName() %> </td>
												</tr>
												<tr>
												<td>User ID</td>
												<td><%= registration.getUserid() %></td>
												</tr>
												<tr>
												<td>Date of Birth</td>
												<td><%= registration.getDob() %></td>
												</tr>
												<tr>
												<td>Gender</td>
												<td><%= registration.getName() %></td>
												</tr>
											    <tr>
												<td>Joining Date</td>
												<td><%= DateFormats.ddMMMyyyy().format(registration.getJoiningDate()) %></td>
												</tr>
												<tr>
												<td>Registration Date</td>
												<td><%= DateFormats.ddMMMyyyy().format(registration.getRegdate()) %></td>
												</tr>
												<tr>
												<td>Country</td>
												<td><%= registration.getName() %></td>
												</tr>
												<tr>
												<td>Branch</td>
												<td><%= registration.getName() %></td>
												</tr>
												<tr>
												<td>Designation</td>
												<td><%= registration.getDesignation().getDesignation() %></td>
												</tr>
												<tr>
												<td>Department</td>
												<td><%= registration.getDepartment().getDepartment() %></td>
												</tr>
												
											</thead>
										</table>
									</div>
								</div>
							</div><%
		}
		if(userDetail != null)
		{
			%>				
							<div class="col-xs-6 col-md-6">
							<h2>Other Info</h2>
							 <form action="updateUserDetail" method="get">		
								<div class="box box-info">
									<div class="box-body  table-responsive">
										<table class="table">
											<thead>
											     <tr>
												 <td></td>
											     <td style="padding: 8px 0px;" class ="text-right">
											     <a href="userEditDetail?id=<%= userDetail.getUserId() %>" class="btn btn-primary btn-xs">Edit_Info</a>
										         </td></tr>
												<tr>
												<td>Permanent Address</td>
												<td><%= userDetail.getParmanentAddress() %></td>
												</tr>
												<tr>
												<td>Present Address</td>
												<td><%= userDetail.getPresentAddress() %></td>
												</tr>
												<tr>
												<td>Mobile Number</td>
												<td><%= userDetail.getMobileNo() %></td>
												</tr>
												<tr>
												<td>Emergency Mobile Number</td>
												<td><%= userDetail.getEmergencyNo() %></td>
												</tr>
												<tr>
												<td>Qualification</td>
												<td><%= userDetail.getQualification() %></td>
												</tr>
												<tr>
												<td>Blood Group</td>
												<td><%= userDetail.getBloodGroup() %></td>
												</tr>
												<tr>
												<td>Marital Status </td>
												<td><%= userDetail.getMaritalStatus() %></td>
												</tr>
												
				                            </thead>
										</table>
									</div>
								</div>
								</form>
							</div>	
							
							 <%
		} else{
	%>
	<div class="col-xs-6 col-md-6">
	
	 <h2>Other Info</h2>
	 <div class="box box-info">
	<div class="box-body">
	<div class="box-footer col-xs-12 col-md-12">
    <a href="userOtherDetail" class="btn btn-primary">Add Other Details</a>
    </div></div></div></div>
	<%
		}
	%>
							
						</div>
						
				    </section>
				    
				   
				    <!-- /.content -->
				  </div>
			
 </body>