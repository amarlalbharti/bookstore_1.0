<%@page import="com.bookstore.model.AttributeModel"%>
<%@page import="com.bookstore.domain.Category"%>
<%@page import="java.util.List"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <a href="${pageContext.request.contextPath}/admin/attributes"><small class="text-primary"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back to attributes</small></a>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/dashboard"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/attributes"><i class="fa fa-dashboard"></i> attributes</a></li>
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
	              		<form:form class="form-horizontal" role="form" method="POST" action="${pageContext.request.contextPath}/admin/attributes/add" commandName="attributeForm" autocomplete="off" id="form">
				            
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
			                <a href="${pageContext.request.contextPath}/admin/attributes"><button type="button" class="btn btn-default">Cancel</button></a>
			                <div class="btn-group  pull-right" style="padding-left: 10px;">
			                	<button type="submit" class="btn btn-primary" name="submit" value="continue"><i class="fa fa-floppy-o"></i>&nbsp;<spring:message code="label.continue"/></button>
			                </div>
			                <div class="btn-group  pull-right">
			                	<button type="submit" class="btn btn-primary" name="submit" value="save"><i class="fa fa-floppy-o"></i>&nbsp;<spring:message code="label.save"/></button>
			                </div>
			                
			                
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

<script type="text/javascript">
$(document).ready(function(){
	<%
		if(model != null && model.getAttributeId() > 0){
			%>
			getAttributeValues(<%= model.getAttributeId() %>);
			<%
		}
	%>
	
	$(document).on("click","#refesh_attribute_value",function() {
		getAttributeValues(<%= model.getAttributeId() %>);
	});
	
	// added by Amar, get all attribute values inner page for current attribute
	function getAttributeValues(attributeId){
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/admin/getAttributeValues",
			data : {"attributeId" : attributeId},
			success : function(data) {
					$("#attribute_values").html(data);
			}
		});
	}
	// added by Amar, add or update attrbute value
	$(document).on("click","#save_attribute_value",function() {
		var attribute_value_id = $("#attribute_value_id").val();
		var attribute_value = $("#attribute_value").val();
		var attributeId = $("#attributeId").val();
		var display_order = $("#display_order").val();
		if(attributeId == "" || attributeId == "0"){
			alertify.error("Attribute Not Saved !");
			return;
		}
		if(attribute_value == ""){
			alertify.error("Attribute value is required !");
			return;
		}
		var senddata=new FormData();
	 	senddata.append("attributeValueId", attribute_value_id);
	 	senddata.append("attributeValue", attribute_value);
	 	senddata.append("attributeId", attributeId);
	 	senddata.append("displayOrder", display_order);
	 	
		$.ajax({
	 		  url: "${pageContext.request.contextPath}/admin/saveAttributeValue",
	 		  type: "POST",
	 		  async: "false",
	 		  data: senddata,
	 		  processData: false,  // tell jQuery not to process the data
	 		  contentType: false,   // tell jQuery not to set contentType
	 		  success:function(response){
	 			 var json = JSON.parse(response);
	 			 if(json.status == "success"){
	 				 alertify.success(json.msg);
	 			 }else{
	 				alertify.error(json.msg);
	 			 }
	 			getAttributeValues(<%= model.getAttributeId() %>);
	 		  }
 		});
	});
	
	//added by amar, Delete product image
	$(document).on("click","#delete_attribute_value",function() {
		var attributeValueId = $(this).attr("attributeValueId");
		if(confirm("Are you sure to delete this ?")){
			$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/deleteAttributeValue",
				data : {"attributeValueId" : attributeValueId},
				success : function(response) {
					 var json = JSON.parse(response);
		 			 if(json.status == "success"){
		 				 alertify.success(json.msg);
		 			 }else{
		 				alertify.error(json.msg);
		 			 }
		 			getAttributeValues(<%= model.getAttributeId() %>);
				}
			});
		}
	});
	//added by amar, Update product image
	$(document).on("click","#edit_attribute_value",function() {
		var attributeValueId = $(this).attr("attributeValueId");
		var attributeId = $("#attributeId").val();
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/getAttributeValues",
			data : {"attributeId" : attributeId, "attributeValueId" : attributeValueId},
			success : function(data) {
				$("#attribute_values").html(data);
			}
			
		});
	});
}); 

</script>
</body>
</html>