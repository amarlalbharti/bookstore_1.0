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
    String pg = (String) request.getParameter("pg");
    String userid = (String) request.getParameter("empid");
    String eStatus = (String) request.getParameter("eStatus");
    
    if(pg != null && userid != null)
    {
    	if(pg.equalsIgnoreCase("edit"))
    	{
    		%>
    		<h1 class="page-header">Update Other Details <small>for <%=userid %></small></h1>
    		<%
    	}
    } else {
    %>
      <h1 class="page-header">Add Other Details <small>for <%=userid %></small></h1>
      <% } %>
      
      <ol class="breadcrumb">
        <li><a href="managerDashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="manageremployees"><i class="fa fa-dashboard"></i> Employee List</a></li>
        <li class="active">New Employee</li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
          	
		      	<!-- Your Page Content Here -->
				<div class="row">
					<div class="col-xs-12 col-md-12">
					<%
					if(eStatus != null && !eStatus.isEmpty())
					{
					if(eStatus.equalsIgnoreCase("failed"))
					{
						%>
							<div class="alert alert-danger alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa  fa-remove"></i> Failed !
								</h4>
								Oops, Something wrong ! Update failed
							</div>
						<%
					}
					}
					%>
						<div class="box box-info">
							<div class="box-body no-padding">
                				<form:form method="POST" role="form" action="managerAddOtherInfo" onsubmit="return validateForm()" commandName="odForm">
									<div class="box box-info">
										<div class="box-body">
									      <div class="form-group col-xs-12 col-md-6">
											<label>Permanent Address<span class="text-danger">*</span></label>
											<form:input path="parmanentAddress" maxlength="250" cssClass="form-control titleCase" placeholder="Enter Permanent Address" />
											<form:hidden path="userid"/>
											 <span class="text-danger"><form:errors path="parmanentAddress" /></span>
										  </div>
										 <div class="form-group col-xs-12 col-md-6">
											<label>Present Address<span class="text-danger">*</span></label>
											<form:input path="presentAddress" maxlength="250" cssClass="form-control titleCase" placeholder="Enter Present Address" />
											<span class="text-danger"><form:errors path="presentAddress" /></span>
										  </div>
										  <div class="form-group col-xs-12 col-md-6">
											<label>City<span class="text-danger">*</span></label>
											<form:input path="city" cssClass="form-control titleCase" maxlength="50" placeholder="Enter city" />
											<span class="text-danger"><form:errors path="city" /></span>
										  </div>
										  <div class="form-group col-xs-12 col-md-6">
											<label>State<span class="text-danger">*</span></label>
											<form:input path="state" cssClass="form-control titleCase" maxlength="50" placeholder="Enter state" />
											<span class="text-danger"><form:errors path="state" /></span>
										  </div>
										  <div class="form-group col-xs-12 col-md-6">
											<label>Country<span class="text-danger">*</span></label>
											<form:input path="country" cssClass="form-control titleCase" maxlength="50" placeholder="Enter state" />
											<span class="text-danger"><form:errors path="country" /></span>
										  </div>
										  
										  <div class="form-group col-xs-12 col-md-6">
											<label>Alt. Email Address<span class="text-danger">*</span></label>
											<form:input path="altEmailId" cssClass="form-control" maxlength="50" placeholder="Enter Alternate Email" />
											<span class="text-danger"><form:errors path="altEmailId" /></span>
										  </div>
										  
										  <div class="form-group col-xs-12 col-md-6">
								            <label >Mobile Number</label>
								            <form:input path="mobileNo" class="form-control number_only" maxlength="15" placeholder="Enter Mobile Number" />
								             <span class="text-danger"><form:errors path="mobileNo" /></span>
								           </div>
								            <div class="form-group col-xs-12 col-md-6">
											<label>Emergency Contact Number</label>
											<form:input path="emergencyNo" cssClass="form-control number_only" maxlength="15" placeholder="Enter Mobile Number"/>
											 <span class="text-danger"><form:errors path="emergencyNo" /></span>
										  </div>
										   <div class="form-group col-xs-12 col-md-6">
											<label>Qualification<span class="text-danger">*</span></label>
											<form:input path="qualification" cssClass="form-control titleCase" maxlength="50" placeholder="Enter Qualification" />
											<span class="text-danger"><form:errors path="qualification" /></span>
										  </div>
										  
										  <div class="form-group col-xs-12 col-md-6">
								            <label >Blood Group</label>
								            <form:select path="bloodGroup" id="bloodGroup" class="form-control" >
								            	<form:option value='0'>---Select---</form:option>
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
								            <form:select path="maritalStatus" id="maritalStatus" class="form-control">
								            		<form:option value='0'>---Select---</form:option>
								                  	<form:option value='Single/Unmarried'></form:option>
								                  	<form:option value='Married'></form:option>
								                  	<form:option value='Divorced'></form:option>
								                  	<form:option value='Widow/Widower'></form:option>
								                  </form:select>
								             <span class="text-danger"><form:errors path="maritalStatus" /></span>
								           </div>
								          <div class="form-group col-xs-12 col-md-6">
											<label>Passport Number<span class="text-danger">*</span></label>
											<form:input path="passportNo" cssClass="form-control" maxlength="50" placeholder="Enter Passport No" />
											<span class="text-danger"><form:errors path="passportNo" /></span>
										  </div>
								           
								           <div class="box-footer col-xs-12 col-md-12">
								                <button type="submit" class="btn btn-primary">Update</button>
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
		var qualification = $("#qualification").val();
		var bloodGroup = $("#bloodGroup").val();
		var maritalStatus = $("#maritalStatus").val();
		var altEmailId = $("#altEmailId").val();
		
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
		if(mobileNo == "")
		{
			$("#mobileNo").parent().addClass("has-error")
			valid = false;
		}
		if(qualification == "")
		{
			$("#qualification").parent().addClass("has-error")
			valid = false;
		}
		if(bloodGroup == "0")
		{
			$("#bloodGroup").parent().addClass("has-error")
			valid = false;
		}
		if(maritalStatus == "0")
		{
			$("#maritalStatus").parent().addClass("has-error")
			valid = false;
		}
		if(altEmailId != "")
		{
			if(!isEmail(altEmailId))
			{
				$("#altEmailId").parent().addClass("has-error")
				valid = false;
			}
		}
		
		if(!valid)
		{
			return false;		
		}
		$(".submit_btn").attr("disabled","disabled");
		$(".submit_btn").text("Sending...");
	}

</script>
 </body>