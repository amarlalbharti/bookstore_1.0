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
	<%
		Registration empReg = (Registration)request.getAttribute("empReg");
		if(empReg != null)
		{
			%>
			
			<div class="content-wrapper">
		    <!-- Content Header (Page header) -->
		    <section class="content-header">
		    	<%
		    		if(empReg.getUserDetail() != null)
		    		{
		    			%>
					      <h1 class="page-header">Update Other Info<small> for <%= empReg.getName() %> ( <%= empReg.getUserid() %> )</small> </h1>
		    			<%
		    		}
		    		else
		    		{
		    			%>
					      <h1 class="page-header">Add Other Info <small> for <%= empReg.getName() %> ( <%= empReg.getUserid() %> )</small> </h1>
   		    			<%
		    		}
		    	%>
		      <ol class="breadcrumb">
		        <li><a href="adminDashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
		        <li><a href="adminEmployees"><i class="fa fa-dashboard"></i> Employee List</a></li>
		        <li class="active">New Employee</li>
		      </ol>
		    </section>
		    
		    <!-- Main content -->
		    <section class="content">
		          	
				      	<!-- Your Page Content Here -->
						<div class="row">
							<div class="col-xs-12 col-md-12">
								<div class="box box-info">
									<div class="box-body no-padding">
										
		                				<form:form method="POST" role="form" action="adminAddOtherInfo" commandName="odForm" name="odForm" onsubmit="return validateForm()">
											<div class="box box-info">
												<div class="box-body">
											      <div class="form-group col-xs-12 col-md-6">
													<label>Permanent Address</label>
													<form:input path="parmanentAddress" cssClass="form-control titleCase" placeholder="Enter Permanent Address" tabindex="1" maxlength="100"/>
													<form:hidden path="userid"/>
													 <span class="text-danger"><form:errors path="parmanentAddress" /></span>
												  </div>
												 <div class="form-group col-xs-12 col-md-6">
													<label>Present Address</label>
													<form:input path="presentAddress" cssClass="form-control titleCase" placeholder="Enter Present Address" tabindex="5"  maxlength="100"/>
													<span class="text-danger"><form:errors path="presentAddress" /></span>
												  </div>
												  <div class="clearfix"></div>
												  <div class="form-group col-xs-12 col-md-6">
													<label>City</label>
													<form:input path="city" cssClass="form-control titleCase" placeholder="Enter city"  tabindex="10"  maxlength="20"/>
													<span class="text-danger"><form:errors path="city" /></span>
												  </div>
												  <div class="form-group col-xs-12 col-md-6">
													<label>State</label>
													<form:input path="state" cssClass="form-control titleCase" placeholder="Enter state"  tabindex="15"  maxlength="20"/>
													<span class="text-danger"><form:errors path="state" /></span>
												  </div>
												  <div class="clearfix"></div>
												  <div class="form-group col-xs-12 col-md-6">
													<label>country</label>
													<form:input path="country" cssClass="form-control titleCase" placeholder="Enter country"  tabindex="20"  maxlength="20"/>
													<span class="text-danger"><form:errors path="country" /></span>
												  </div>
												  
												  <div class="form-group col-xs-12 col-md-6">
										            <label >Mobile Number</label>
										            <form:input path="mobileNo" class="form-control number_only" placeholder="Enter Mobile Number"  tabindex="25"  maxlength="10"/>
										             <span class="text-danger"><form:errors path="mobileNo" /></span>
										           </div>
										          <div class="clearfix"></div>
												  <div class="form-group col-xs-12 col-md-6">
													<label>Emergency Contact Number</label>
													<form:input path="emergencyNo" cssClass="form-control number_only" placeholder="Enter Mobile Number" tabindex="30"  maxlength="10"/>
													 <span class="text-danger"><form:errors path="emergencyNo" /></span>
												  </div>
												   <div class="form-group col-xs-12 col-md-6">
													<label>Qualification</label>
													<form:input path="qualification" cssClass="form-control titleCase" placeholder="Enter Qualification"  tabindex="35"  maxlength="50"/>
													<span class="text-danger"><form:errors path="qualification" /></span>
												  </div>
												  <div class="clearfix"></div>
												  <div class="form-group col-xs-12 col-md-6">
										            <label >Blood Group</label>
										            <form:select path="bloodGroup" class="form-control" tabindex="40">
										            		<form:option value=''>Select blood group</form:option>
										                    <form:option value='A+'></form:option>
										                  	<form:option value='A-'></form:option>
										                  	<form:option value='B+'></form:option>
										                  	<form:option value='B-'></form:option>
										                    <form:option value='O+'></form:option>
										                  	<form:option value='O-'></form:option>
										                  	<form:option value='AB+'></form:option>
										                  	<form:option value='AB-'></form:option>
										             </form:select>
										             <span class="text-danger"><form:errors path="bloodGroup" /></span>
										           </div>
										           
										           <div class="form-group col-xs-12 col-md-6">
										            <label >Marital Status</label>
										            <form:select path="maritalStatus" class="form-control" tabindex="45">
										            		<form:option value=''>Select marital status</form:option>
										                  	<form:option value='Single/Unmarried'></form:option>
										                  	<form:option value='Married'></form:option>
										                  	<form:option value='Divorced'></form:option>
										                  	<form:option value='Widow/Widower'></form:option>
										                  </form:select>
										             <span class="text-danger"><form:errors path="maritalStatus" /></span>
										           </div>
										          <div class="clearfix"></div>
												  <div class="form-group col-xs-12 col-md-6">
													<label>Alernate EmailId</label>
													<form:input path="altEmailId" cssClass="form-control" placeholder="Enter Alernate EmailId" tabindex="50"  maxlength="50"/>
													<span class="text-danger"><form:errors path="altEmailId" /></span>
												  </div>
												  
												  <div class="form-group col-xs-12 col-md-6">
										            <label>Passport Number</label>
										            <form:input path="passportNo" class="form-control upperCase" placeholder="Enter Passport Number" tabindex="55"  maxlength="25"/>
										             <span class="text-danger"><form:errors path="passportNo" /></span>
										           </div>
										           
										         
										           <div class="box-footer col-xs-12 col-md-12">
										           		<form:errors></form:errors>
										           </div>
										          <div class="clearfix"></div>
												  <div class="box-footer col-xs-12 col-md-12">
										                <%
												    		if(empReg.getUserDetail() != null)
												    		{
												    			%>
															      <button type="submit" class="btn btn-primary submit_btn" tabindex="60">Update</button>
												    			<%
												    		}
												    		else
												    		{
												    			%>
															      <button type="submit" class="btn btn-primary submit_btn" tabindex="60">Save</button>
										   		    			<%
												    		}
												    	%>
										           </div>
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
  	<%
	}
%>
<script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">
$('#dob').datetimepicker({
	timepicker:false,
	format:'d-m-Y'
});
$('#joiningDate').datetimepicker({
	timepicker:false,
	format:'d-m-Y'
});
</script>	
<script type="text/javascript">
	function validateForm()
	{
		var parmanentAddress = $("#parmanentAddress").val();
		var presentAddress = $("#presentAddress").val();
		var city = $("#city").val();
		var state = $("#state").val();
		var country = $("#country").val();
		var mobileNo = $("#mobileNo").val();
		var emergencyNo = $("#emergencyNo").val();
		var qualification = $("#qualification").val();
		var bloodGroup = $("#bloodGroup").val();
		var maritalStatus = $("#maritalStatus").val();
		var altEmailId=$("#altEmailId").val();
		
		var valid = true;
		$('.has-error').removeClass("has-error");
		
		
		if(parmanentAddress == "")
		{
			$("#parmanentAddress").parent().addClass("has-error")
			valid = false;
		}
		if(presentAddress == "")
		{
			$("#presentAddress").parent().addClass("has-error")
			valid = false;
		}
		if(city == "")
		{
			$("#city").parent().addClass("has-error")
			valid = false;
		}
		if(state == "")
		{
			$("#state").parent().addClass("has-error")
			valid = false;
		}
		if(country == "")
		{
			$("#country").parent().addClass("has-error")
			valid = false;
			
		}
// 		if(mobileNo == "" || !ContactNo(mobileNo))
// 		{
// 			$("#mobileNo").parent().addClass("has-error")
// 			valid = false;
// 		}
		
		if(qualification == "")
		{
			$("#qualification").parent().addClass("has-error")
			valid = false;
		}
		if(bloodGroup == "")
		{
			$("#bloodGroup").parent().addClass("has-error")
			valid = false;
		}
		
		if(maritalStatus == "")
		{
			$("#maritalStatus").parent().addClass("has-error")
			valid = false;
		}
		
		if(bloodGroup == "")
		{
			$("#bloodGroup").parent().addClass("has-error")
			valid = false;
		}
		
		
		if(!valid)
		{
			return false;		
		}
		$(".submit_btn").attr("disabled","disabled");
		$(".submit_btn").text("Sending ...");
		
	}

</script>
  
 </body>