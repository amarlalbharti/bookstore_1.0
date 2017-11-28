<%@page import="com.bookstore.model.AttributeModel"%>
<%@page import="com.bookstore.domain.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
<%
	AttributeModel model = (AttributeModel)request.getAttribute("attributeForm");
%>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Attribute
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="attributes"><i class="fa fa-dashboard"></i> attributes</a></li>
        <li class="active">${model.attributeId > 0 ? 'Update Attribute': 'Add Attribute'}</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      
      <!-- Main row -->
      <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
	            <ul class="nav nav-tabs">
	              <li class="active"><a href="#tab_1" data-toggle="tab" aria-expanded="true">Attribute Info</a></li>
	              <li class=""><a href="#tab_2" data-toggle="tab" aria-expanded="false">Attribute Values</a></li>
			    </ul>
	            <div class="tab-content">
	              <div class="tab-pane active" id="tab_1">
	              	<div class="">
	              		<form:form class="form-horizontal" role="form" method="POST" action="addAttribute" commandName="attributeForm" autocomplete="off" id="form">
				            
		              		<div class="box-body" style="min-height: 300px">
			            	<!-- form start -->
				              <div class="box-body">
				                <div class="form-group">
				                  <label for="categoryName" class="col-sm-3 control-label">Attribute Name</label>
				                  <div class="col-sm-9">
				                      <form:hidden path="attributeId" />
				                      <form:input path="attributeName" class="form-control titleCase"  placeholder="Enter attribute name" tabindex="5" maxlength="100"/>
					                  <span class="text-danger"><form:errors path="attributeName" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="active" class="col-sm-3 control-label">Active</label>
				                  <div class="col-sm-9">
				                      <form:checkbox path="active" tabindex="20" style="margin-top: 10px;"/>
					              </div>
				                </div>
				              </div>
			              </div>
			              <div class="box-footer">
			                <a href="attributes"><button type="button" class="btn btn-default">Cancel</button></a>
			                <button type="submit" class="btn btn-primary pull-right"><i class="fa fa-floppy-o"></i>&nbsp;&nbsp;Save</button>
			              </div>
			              </form:form>
			          </div>
	              </div>
	             
				  <!-- /.tab-pane -->
	              <div class="tab-pane" id="tab_2">
	                <div id = "attribute_values" style="min-height: 300px">Save attribute name first !</div>
	              </div>
	              		
	            </div>
	            <!-- /.tab-content -->
	          </div>
            
        </div>
        
      </div>
      <!-- /.row (main row) -->

    </section>
    <!-- /.content -->
  </div>
</body>

</html>