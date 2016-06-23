<%@page import="java.util.Calendar"%>
<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.config.Roles"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="java.util.Date"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Attendance"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
</head>
<body>
	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
    
    <%
    String branchId =request.getParameter("branchId");
    if(branchId != null)
    {
    %>
      
      <h1 class="page-header"> Update Branch </h1>
      <ol class="breadcrumb">
        <li><a href="adminDashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="adminViewBranch"><i class="fa fa-dashboard"></i>Branch</a></li>
        <li class="active">Update Branch</li>
      </ol>
    <%
    }
    else
    {
    %>
    <h1 class="page-header"> New Branch </h1>
      <ol class="breadcrumb">
        <li><a href="adminDashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="adminViewBranch"><i class="fa fa-dashboard"></i>Branch</a></li>
        <li class="active">New Branch</li>
      </ol>
    <%} %>
    </section>
    
    <!-- Main content -->
    <section class="content">
		
      <!-- Your Page Content Here -->
		<div class="row">
			<div class="col-xs-12 col-md-12">
				<div class="box box-info">
					<div class="box-body no-padding">
				            
	                	<form:form role="form" method="POST" action="adminAddBranch" commandName="branchForm" autocomplete="off" enctype="multipart/form-data" id="form" onsubmit="return validateForm()">
			              <div class="box-body">
			                <div class="form-group col-xs-12 col-md-6">
			                  <label >Branch Name</label>
			                  <form:input path="branchName" class="form-control titleCase character_only"  placeholder="Enter branch name" tabindex="1" maxlength="50"/>
			                  <form:hidden path="branchId"/>
			                  <span class="text-danger"><form:errors path="branchName" /></span>
			                </div>
			                <div class="form-group col-xs-12 col-md-6">
			                  <label >Phone No.</label>
			                  <form:input autocomplete="off" path="phoneNo" type="text" class="form-control number_only" placeholder="Enter Phone No" tabindex="5"  maxlength="10" />
			                   <span class="text-danger"><form:errors path="phoneNo" /></span>
			                </div>
			                <div class="clearfix"></div>
			                <div class="form-group col-xs-12 col-md-6">
			                  <label >Address</label>
			                  <form:input autocomplete="off" path="address" type="text" class="form-control titleCase" placeholder="Enter Address" tabindex="10"  maxlength="50" />
			                   <span class="text-danger"><form:errors path="address" /></span>
			                </div>
			                <div class="form-group col-xs-12 col-md-6">
			                  <label >Pin/Zip Code</label>
			                  <form:input autocomplete="off" path="pinCode" type="text" class="form-control" placeholder="Enter Pin Code" tabindex="15"  maxlength="10" />
			                   <span class="text-danger"><form:errors path="pinCode" /></span>
			                </div>
			                <div class="clearfix"></div>
			                <div class="form-group col-xs-12 col-md-6">
			                  <label >Country</label>
			                  <form:select path="country.countryId" class="form-control" id="countryId" tabindex="20">
			                  		<form:option value='0'>---Select Country---</form:option>
			                  		<c:forEach var="itam" items="${cList}">
										<form:option value='${itam.countryId }'>${itam.countryName }</form:option>
									</c:forEach>
			                  </form:select>
			                  <span class="text-danger"><form:errors path="country" /></span>
			                </div>
			                <div class="form-group col-xs-12 col-md-6">
			                  <label >TIme Zone</label>
			                  <form:select path="timeZone" class="form-control" id="timeZone" tabindex="25">
			                  		<form:option value='0'>---Select TimeZone---</form:option>
			                  		<%
										TimeZone ctz = (TimeZone)request.getSession().getAttribute("timezone");
										TimeZone timeZone = Calendar.getInstance().getTimeZone();
										String ids[] = timeZone.getAvailableIDs();
										for(String id : ids)
										{
											if(ctz.getID().equals(id))
											{
												%>
									            	<option value="<%= id %>" selected="selected"><%= id %></option>
												<%
											}
											else
											{
												%>
									            	<option value="<%= id %>"><%= id %></option>
												<%
											}
										}
									%>
			                  		
			                  		<c:forEach var="itam" items="${timeZoneList}">
										<form:option value='${itam.id }'>${itam.id}</form:option>
									</c:forEach>
			                  </form:select>
			                  <span class="text-danger"><form:errors path="timeZone" /></span>
			                </div>
			              </div>
			              <!-- /.box-body -->
			              <div class="box-footer col-xs-12 col-md-6">
			              	<div class="form-group col-xs-12 col-md-6">
			                	<button type="submit" class="btn btn-primary submit_btn" tabindex="55">Submit</button>
			                </div>
			              </div>
			            </form:form>
					</div>
				</div>
				
			</div>
		</div>
		
    </section>
    <!-- /.content -->
  </div>
<script src="js/jQuery-2.2.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function()
{
	$("#form").trigger('reset');
});

</script>
<script type="text/javascript">
	function validateForm()
	{
		var branchName = $("#branchName").val();
		var phoneNo = $("#phoneNo").val();
		var address = $("#address").val();
		var countryId = $("#countryId").val();
		
		var valid = true;
		$('.has-error').removeClass("has-error");
		
		
		if(branchName == "")
		{
			$("#branchName").parent().addClass("has-error")
			valid = false;
		}
		if(phoneNo == "")
		{
			$("#phoneNo").parent().addClass("has-error")
			valid = false;
		}
		if(address == "")
		{
			$("#address").parent().addClass("has-error")
			valid = false;
		}
		if(countryId == "0")
		{
			$("#countryId").parent().addClass("has-error")
			valid = false;
		}
		
		if(!valid)
		{
			return false;		
		}
		$(".submit_btn").attr("disabled","disabled");
		$(".submit_btn").text("Saving...");
	}

</script>
 </body> 