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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="css/AdminLTE.css">
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect.
  -->
  <link rel="stylesheet" href="css/skin-blue.css">
</head>
<body>
<input type="hidden" id=Mode name="Mode" value="${Mode}">
  <div class="content-wrapper">
	<%
		Registration empReg = (Registration)request.getAttribute("empReg");
	 	String Mode = (String)request.getAttribute("Mode");
	    if(Mode!=null &&  Mode.equals("add"))
	    {
	
	%>
	<section class="content-header">
      <h1 class="page-header">Add Bank Info<small> for <%= empReg.getName() %> (<%= empReg.getUserid() %>)</small> </h1>
      
    </section>
    <!-- Main content -->
    <section class="content">
		      <!-- Your Page Content Here -->
		      
		   
		<div class="row">
			<div class="col-xs-12 col-md-12">
				<form:form method="POST" role="form" action="empBankDetail" commandName="bdForm" onsubmit="return validate()">
				<div class="box box-info">
					<div class="box-body">
				       <div class="form-group col-xs-12 col-md-6">
						<label>Bank Name</label><span class="text-danger">*</span>
						<form:input path="bankName" cssClass="form-control" placeholder="Enter Bank Name" autofocus="autofocus" tabindex="1" maxlength="50"/>
						<input type="hidden" name="empid" value="<%=  empReg.getUserid() %>">
						 <span class="text-danger"><form:errors path="bankName" /></span>
					   </div>
					   
					    <div class="form-group col-xs-12 col-md-6">
			            <label>Account Number</label>
			            <form:input path="accountNo" class="form-control" placeholder="Enter Account Number" tabindex="5" maxlength="25"/>
			            <span class="text-danger"><form:errors path="accountNo" /></span>
			           </div>
			           
			            <div class="clearfix"></div>
					   <div class="form-group col-xs-12 col-md-6">
						<label>IFSC Code</label><span class="text-danger">*</span>
						<form:input path="ifscCode" cssClass="form-control" placeholder="Enter IFSC Code" tabindex="10" maxlength="11"/>
						<span class="text-danger"><form:errors path="ifscCode" /></span>
					   </div>
					 
					 				 
					   <div class="form-group col-xs-12 col-md-6">
					    <label>Name As Per Bank Record</label><span class="text-danger">*</span>
						<form:input path="nameAsBankRecord" cssClass="form-control" placeholder="Enter Name As Per Bank Record" tabindex="15" maxlength="50"/>
						<span class="text-danger"><form:errors path="nameAsBankRecord" /></span>
					   </div>
					   
					  <div class="clearfix"></div>
					  <div class="form-group col-xs-12 col-md-6">
					    <label>Basic Salary</label><span class="text-danger">*</span>
						<form:input path="basicSalary" cssClass="form-control number_only" placeholder="Enter Basic Salary" tabindex="15" maxlength="50"/>
						<span class="text-danger"><form:errors path="basicSalary" /></span>
					   </div>
					   
					   <div class="form-group col-xs-12 col-md-6">
					    <label>PLI</label><span class="text-danger">*</span>
						<form:input path="pli" cssClass="form-control number_only" placeholder="Enter PLI" tabindex="15" maxlength="50"/>
						<span class="text-danger"><form:errors path="pli" /></span>
					   </div>
					 	<div class="clearfix"></div>
					  	<div class="form-group col-xs-12 col-md-6">
					    <label>PAN Number</label><span class="text-danger">*</span>
						<form:input path="panNo" cssClass="form-control" placeholder="Enter PAN Number" tabindex="15" maxlength="50"/>
						<span class="text-danger"><form:errors path="panNo" /></span>
					   </div>				  
			           <div class="clearfix"></div>
			           <div class="box-footer col-xs-12 col-md-12">
			                <button type="submit" class="btn btn-primary" id="submit_btn">Save</button>
			           </div>
					</div>
				</div>	
			</form:form>
		</div>
	
	</div>
	</section>
	<%
	
    }
    else if(Mode!=null && Mode.equals("edit")){
	
	%>	
	<section class="content-header">
      <h1 class="page-header">Update Bank Info<small> for <%= empReg.getName() %> (<%= empReg.getUserid() %>)</small> </h1>
    </section>
    <!-- Main content -->
    <section class="content">
		<div class="row">
			<div class="col-xs-12 col-md-12">
				<form:form method="POST" role="form" action="empEditBankDetail" commandName="bdForm" onsubmit="return validate()">
				<div class="box box-info">
					<div class="box-body">
					
					   <div class="form-group">
						<form:hidden path="userid" cssClass="form-control" />
					   </div>
					
				       <div class="form-group col-xs-12 col-md-6">
						<label>Bank Name</label><span class="text-danger">*</span>
						<form:input path="bankName" cssClass="form-control" placeholder="Enter Bank Name" autofocus="autofocus" tabindex="1" maxlength="50"/>
						<input type="hidden" name="empid" value="<%=  empReg.getUserid() %>">
						 <span class="text-danger"><form:errors path="bankName" /></span>
					   </div>
					   
					    <div class="form-group col-xs-12 col-md-6">
			            <label>Account Number</label>
			            <form:input path="accountNo" class="form-control" placeholder="Enter Account Number" tabindex="5" maxlength="25"/>
			            <span class="text-danger"><form:errors path="accountNo" /></span>
			           </div>
			           
			            <div class="clearfix"></div>
					   <div class="form-group col-xs-12 col-md-6">
						<label>IFSC Code</label><span class="text-danger">*</span>
						<form:input path="ifscCode" cssClass="form-control" placeholder="Enter IFSC Code" tabindex="10" maxlength="11"/>
						<span class="text-danger"><form:errors path="ifscCode" /></span>
					   </div>
					 
					   <div class="form-group col-xs-12 col-md-6">
					    <label>Name As Per Bank Record</label><span class="text-danger">*</span>
						<form:input path="nameAsBankRecord" cssClass="form-control" placeholder="Enter Name As Per Bank Record" tabindex="15" maxlength="50"/>
						<span class="text-danger"><form:errors path="nameAsBankRecord" /></span>
					   </div>
					 <div class="clearfix"></div>
					  <div class="form-group col-xs-12 col-md-6">
					    <label>Basic Salary</label><span class="text-danger">*</span>
						<form:input path="basicSalary" cssClass="form-control number_only" placeholder="Enter Basic Salary" tabindex="20" maxlength="50"/>
						<span class="text-danger"><form:errors path="basicSalary" /></span>
					   </div>
					  <div class="form-group col-xs-12 col-md-6">
					    <label>PLI</label><span class="text-danger">*</span>
						<form:input path="pli" cssClass="form-control number_only" placeholder="Enter PLI" tabindex="25" maxlength="50"/>
						<span class="text-danger"><form:errors path="pli" /></span>
					   </div>
					  <div class="clearfix"></div>
					  <div class="form-group col-xs-12 col-md-6">
					    <label>PAN Number</label><span class="text-danger">*</span>
						<form:input path="panNo" cssClass="form-control" placeholder="Enter PAN Number" tabindex="30" maxlength="50"/>
						<span class="text-danger"><form:errors path="panNo" /></span>
					   </div>
			           <div class="clearfix"></div>
			           <div class="box-footer col-xs-12 col-md-12">
			                <button type="submit" class="btn btn-primary" id="submit_btn">Update</button>
			           </div>
					</div>
				</div>	
			</form:form>
		</div>
	
	</div>
	</section>
	
	<%
	
    }
	
	%>	
    
      <!-- /.content -->
  </div>
  
<script src="js/jQuery-2.2.0.min.js"></script>
<script type="text/javascript">
  
  
  function validate()
{
	
	var bankName=$("#bankName").val();
	var accountNo=$("#accountNo").val();
	var ifscCode=$("#ifscCode").val();
	var nameAsBankRecord=$("#nameAsBankRecord").val();
	
	
	var valid = true;
    $('.has-error').removeClass("has-error");
    
	
	
	if(bankName==''){
		$("#bankName").parent().addClass("has-error")
		valid=false;
		}
	
	if(accountNo==''){
		$("#accountNo").parent().addClass("has-error")
		valid=false;
		}
	
	if(ifscCode==''){
		$("#ifscCode").parent().addClass("has-error")
		valid=false;
		}
	
	if(nameAsBankRecord==''){
		$("#nameAsBankRecord").parent().addClass("has-error")
		valid=false;
		}
	
	
	if(!valid)
    {
        return false;        
    }
	
    $("#submit_btn").attr("disabled","disabled");
    if(($("#Mode").val())=='add')
    {
        $("#submit_btn").text("Saving...");
    }
        
    if(($("#Mode").val())=='edit'){
            $("#submit_btn").text("Updating...");
    }
  
}
  </script>
  
  
 </body>