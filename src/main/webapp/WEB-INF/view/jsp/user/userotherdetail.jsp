<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Registration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	<div class="content-wrapper">
	<%
	Registration registration = (Registration)request.getSession().getAttribute("registration");
	%>
	<section class="content-header">
      <h1 class="page-header">Add Other Info<small> for <%= registration.getName() %> (<%= registration.getUserid() %>)</small> </h1>
    </section>
    <!-- Main content -->
    <section class="content">
		      <!-- Your Page Content Here -->
		<div class="row">
			<div class="col-xs-12 col-md-12">
				<form:form method="POST" role="form" action="userOtherDetail" commandName="odForm" onsubmit="return validate()">
				<div class="box box-info">
					<div class="box-body other-Form">
				       <div class="form-group col-xs-12 col-md-6">
						<label>Permanent Address</label><span class="text-danger">*</span>
						<form:input path="parmanentAddress" cssClass="form-control titleCase" placeholder="Enter Permanent Address" autofocus="autofocus" tabindex="1" maxlength="150"/>
						 <span class="text-danger"><form:errors path="parmanentAddress" /></span>
					   </div>
					   <div class="form-group col-xs-12 col-md-6">
						<label>Present Address</label><span class="text-danger">*</span>
						<form:input path="presentAddress" cssClass="form-control titleCase" placeholder="Enter Present Address" tabindex="5" maxlength="150"/>
						<span class="text-danger"><form:errors path="presentAddress" /></span>
					   </div>
					   <div class="clearfix"></div>
					   <div class="form-group col-xs-12 col-md-6">
					    <label>City</label><span class="text-danger">*</span>
						<form:input path="city" cssClass="form-control titleCase character_only" placeholder="Enter city" tabindex="10" maxlength="50"/>
						<span class="text-danger"><form:errors path="city" /></span>
					   </div>
					   <div class="form-group col-xs-12 col-md-6">
						<label>State</label><span class="text-danger">*</span>
						<form:input path="state" cssClass="form-control titleCase character_only" placeholder="Enter state" tabindex="15" maxlength="50"/>
						<span class="text-danger"><form:errors path="state" /></span>
					   </div>
					   <div class="clearfix"></div>
					   <div class="form-group col-xs-12 col-md-6">
						<label>country</label><span class="text-danger">*</span>
						<form:input path="country" cssClass="form-control titleCase character_only" placeholder="Enter country" tabindex="20" maxlength="50"/>
						<span class="text-danger"><form:errors path="country" /></span>
					   </div>
					   <div class="form-group col-xs-12 col-md-6">
			            <label >Mobile Number</label><span class="text-danger">*</span>
			            <form:input path="mobileNo" class="form-control number_only" placeholder="Enter Mobile Number" tabindex="25" maxlength="10"/>
			             <span class="text-danger"><form:errors path="mobileNo" /></span>
			           </div>
			           <div class="clearfix"></div>
			           <div class="form-group col-xs-12 col-md-6">
						<label>Emergency Contact Number</label><span class="text-danger">*</span>
						<form:input path="emergencyNo" cssClass="form-control number_only" placeholder="Enter Mobile Number" tabindex="30" maxlength="10"/>
						 <span class="text-danger"><form:errors path="emergencyNo" /></span>
					   </div>
					   <div class="form-group col-xs-12 col-md-6">
						<label>Qualification</label><span class="text-danger">*</span>
						<form:input path="qualification" cssClass="form-control titleCase" placeholder="Enter Qualification" tabindex="35" maxlength="50"/>
						<span class="text-danger"><form:errors path="qualification" /></span>
					   </div>
					  <div class="clearfix"></div>
					   <div class="form-group col-xs-12 col-md-6">
			            <label >Blood Group</label><span class="text-danger">*</span>
			            <form:select path="bloodGroup" class="form-control" tabindex="40">
			                    <form:option value='Select Blood Group'></form:option>
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
			            <label >Marital Status</label><span class="text-danger">*</span>
			            
			            <form:select path="maritalStatus" class="form-control" tabindex="45">
			                    <form:option value='Select Marital Status'></form:option>
			                  	<form:option value='Single/Unmarried'></form:option>
			                  	<form:option value='Married'></form:option>
			                  	<form:option value='Divorced'></form:option>
			                  	<form:option value='Widow/Widower'></form:option>
			                  </form:select>
			             <span class="text-danger"><form:errors path="maritalStatus" /></span>
			           </div>
			           <div class="clearfix"></div>
			           <div class="form-group col-xs-12 col-md-6">
						<label>Alternate Email Id</label>
						<form:input path="altEmailId" cssClass="form-control" placeholder="Enter Email Id" tabindex="50" maxlength="50"/>
						<span class="text-danger"><form:errors path="altEmailId" /></span>
					   </div>
					  
					   <div class="form-group col-xs-12 col-md-6">
			            <label>Passport Number</label>
			            <form:input path="passportNo" class="form-control upperCase" placeholder="Enter Passport Number" tabindex="55" maxlength="25"/>
			            <span class="text-danger"><form:errors path="passportNo" /></span>
			           </div>
			           			           
			           <div class="clearfix"></div>
			           <div class="box-footer col-xs-12 col-md-12">
			                <button type="submit" class="btn btn-primary" id="submit_btn">Submit</button>
			           </div>
					</div>
				</div>	
			</form:form>
		</div>
	
	</div>
		
    </section>
      <!-- /.content -->
  </div>
  
   <script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">
  
  
  function validate()
{
	
	var parmanentAddress=$(".other-Form #parmanentAddress").val();
	var presentAddress=$(".other-Form #presentAddress").val();
	var city=$(".other-Form #city").val();
	var state=$(".other-Form #state").val();
	var country=$(".other-Form #country").val();
	var bloodGroup=$(".other-Form #bloodGroup").val();
	var maritalStatus=$(".other-Form #maritalStatus").val();
	var qualification=$(".other-Form #qualification").val();
	var mobileNo=$(".other-Form #mobileNo").val();
	var altEmailId=$(".other-Form #altEmailId").val();
	
	var valid = true;
    $('.has-error').removeClass("has-error");
    
	
	
	if(parmanentAddress==''){
		$(".other-Form #parmanentAddress").parent().addClass("has-error")
		valid=false;
		}
	
	if(presentAddress==''){
		$(".other-Form #presentAddress").parent().addClass("has-error")
		valid=false;
		}
	
	if(city==''){
		$(".other-Form #city").parent().addClass("has-error")
		valid=false;
		}
	
	if(state==''){
		$(".other-Form #state").parent().addClass("has-error")
		valid=false;
		}
	
	if(country==''){
		$(".other-Form #country").parent().addClass("has-error")
		valid=false;
		}
	
	if(mobileNo==''||!ContactNo(mobileNo)){
		$(".other-Form #mobileNo").parent().addClass("has-error")
		valid=false;
		}
	
		
	if(qualification==''){
		$(".other-Form #qualification").parent().addClass("has-error")
		valid=false;
		}
	
	if(bloodGroup==''||bloodGroup=='Select Blood Group'){
		$(".other-Form #bloodGroup").parent().addClass("has-error")
		valid=false;
		}
	
	if(maritalStatus==''||maritalStatus=='Select Marital Status'){
		$(".other-Form #maritalStatus").parent().addClass("has-error")
		valid=false;
		}
		
		
	if(altEmailId==''||!isEmail(altEmailId)){
		$(".other-Form #altEmailId").parent().addClass("has-error")
		valid=false;
		}
	
	if(!valid)
    {
        return false;        
    }
	
    $(".other-Form #submit_btn").attr("disabled","disabled");
    $(".other-Form #submit_btn").text("Saving...");
  
}
  </script>
  
  
 </body>