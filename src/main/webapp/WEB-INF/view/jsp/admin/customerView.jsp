<%@page import="com.bookstore.model.CustomerModel"%>
<%@page import="com.bookstore.domain.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.model.ProductModel"%>
<%@page import="com.bookstore.config.DateUtils"%>
<%@page import="com.bookstore.domain.Product"%>

<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.thumbnail {
  position: relative;
  width: 160px;
  height: 120px;
  overflow: hidden;
  background-color: black;
}
.thumbnail img {
  position: absolute;
  left: 50%;
  top: 50%;
  height: 100%;
  width: auto;
  -webkit-transform: translate(-50%,-50%);
      -ms-transform: translate(-50%,-50%);
          transform: translate(-50%,-50%);
}
.thumbnail img.portrait {
  width: 100%;
  height: auto;
}
</style>
</head>
<body>
  <!-- Content Wrapper. Contains page content -->
  <form:form class="form-horizontal" role="form" method="POST" action="${pageContext.request.contextPath}/admin/customers/add" commandName="customerForm" autocomplete="off" id="form">
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header clearfix">
    	<%
    		CustomerModel model = (CustomerModel)request.getAttribute("customerForm");
			if(model != null && model.getRid() > 0){
				%>
					<h1 class="pull-left"><spring:message code="label.customers.editcustomer"/> - <%= model.getFirstName() + " " + model.getLastName()%>
				<%
			}else{
				%>
				<h1 class="pull-left"><spring:message code="label.customers.addnewcustomer"/>
				<%
			}
		%>
      <a href="${pageContext.request.contextPath}/admin/customers"><small class="text-primary"><i class="fa fa-arrow-left" aria-hidden="true"></i> <spring:message code="label.customers.backtocustomers"/></small></a>
      </h1>
      <div class="pull-right">
      	<button type="submit" class="btn btn-flat btn-primary" name="submit" value="save"><i class="fa fa-floppy-o"></i> <spring:message code="label.save"/></button>
      	<button type="submit" class="btn btn-flat btn-primary" name="submit" value="continue"><i class="fa fa-floppy-o"></i> <spring:message code="label.continue"/></button>
      	<button type="button" class="btn btn-flat btn-danger" id="delete_category"><i class="fa fa-fw fa-close"></i> <spring:message code="label.delete"/></button>
      </div>
    </section>

    <!-- Main content -->
    <section class="content">
      
      <!-- Main row -->
      <div class="row">
      	<div class="col-md-12">
          <!-- Horizontal Form -->
          <div>
            <div class="nav-tabs-custom">
	            <ul class="nav nav-tabs">
	              <li class="active"><a href="#custmerinfo" data-toggle="tab" aria-expanded="true"><spring:message code="label.customers.tab.detail"/></a></li>
	              	<li class="" id="refesh_customer_orders"><a href="#orders" data-toggle="tab" aria-expanded="false"><spring:message code="label.customers.tab.orders"/></a></li>
	              	<li class="" id="refesh_customer_basket"><a href="#basket" data-toggle="tab" aria-expanded="false"><spring:message code="label.customers.tab.basket"/></a></li>
			    </ul>
	            <div class="tab-content">
	              <div class="tab-pane active" id="ustmerinfo">
	              	<div class="box-body">
		            
		              <div class="col-md-7">
				          <div class="box box-default box-solid">
				            <div class="box-header with-border">
				            	<form:hidden path="rid" />
				              <h3 class="box-title"><spring:message code="label.customers.custinfo"/></h3>
				            </div>
				            <!-- /.box-header -->
				            <div class="box-body" style="display: block;">
				               <%
						    		if(model.getRid() > 0){
						    			%>
						    				<div class="form-group">
							                  <label for="firstName" class="col-sm-3 control-label"><spring:message code="label.customers.userid"/></label>
							                  <div class="col-sm-9">
							                      <label class="form-control titleCase" ><%=model.getUserid() %></label>
							                  </div>
							                </div>
						    			<%
						    		}else{
						    			%>
						    				<div class="form-group">
							                  <label for="userid" class="col-sm-3 control-label"><spring:message code="label.customers.userid"/></label>
							                  <div class="col-sm-9">
							                      <form:input path="userid" class="form-control"  placeholder="Enter email id" tabindex="1"/>
								                  <span class="text-danger"><form:errors path="userid" /></span>
							                  </div>
							                </div>
						    			
						    			<%
						    		}
								%>
				               
				               <div class="form-group">
				                  <label for="firstName" class="col-sm-3 control-label"><spring:message code="label.customers.firstname"/></label>
				                  <div class="col-sm-9">
				                      <form:input path="firstName" class="form-control titleCase"  placeholder="Enter first name" tabindex="2"/>
					                  <span class="text-danger"><form:errors path="firstName" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="lastName" class="col-sm-3 control-label"><spring:message code="label.customers.lastname"/></label>
				                  <div class="col-sm-9">
				                      <form:input path="lastName" class="form-control titleCase"  placeholder="Enter last name" tabindex="5"></form:input>
					                  <span class="text-danger"><form:errors path="lastName" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="contactno" class="col-sm-3 control-label"><spring:message code="label.customers.contactno"/></label>
				                  <div class="col-sm-9">
				                      <form:input path="contactno" class="form-control titleCase"  placeholder="Enter contact number" tabindex="10"/>
					                  <span class="text-danger"><form:errors path="contactno" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="dob" class="col-sm-3 control-label"><spring:message code="label.customers.dob"/></label>
				                  <div class="col-sm-9">
<%-- 				                      <form:input path="dob" class="form-control" placeholder="Enter date of birth" /> --%>
				                      <div class="input-group date">
						                  <div class="input-group-addon">
						                    <i class="fa fa-calendar"></i>
						                  </div>
						                  <form:input path="dob" class="form-control pull-right datepicker " disabled="disabled" placeholder="Enter date of birth" tabindex="15" />
						                </div>
					                  <span class="text-danger"><form:errors path="dob" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="gender" class="col-sm-3 control-label"><spring:message code="label.customers.gender"/></label>
				                  <div class="col-sm-9">
				                      <div class="col-sm-9" style="padding-top: 7px;">
					                    <form:radiobutton path="gender" value="Male" class="padding-top" tabindex="20"/> <spring:message code="label.customers.gender.male"/>
					                    <form:radiobutton path="gender" value="Female" class="padding-top" tabindex="25"/> <spring:message code="label.customers.gender.female"/>
					                  </div>
					                  <span class="text-danger"><form:errors path="gender" /></span>
				                  </div>
				                </div>
				                
				                <% 
				                	if(model.getModifyDate() != null){
				                		%>
				                		<div class="form-group">
						                	<label for="CreateDate" class="col-sm-3 control-label"><spring:message code="label.customers.modifydate"/></label>
						                  <div class="col-sm-9" >
						                    <label class="control-label"><%= DateUtils.clientFullformat.format(model.getModifyDate()) %></label>
						                  </div>
						                </div>
				                		<%
				                	}
				                	if(model.getCreateDate() != null){
				                		%>
				                		<div class="form-group">
						                	<label for="CreateDate" class="col-sm-3 control-label"><spring:message code="label.customers.createdate"/></label>
						                  <div class="col-sm-9" >
						                    <label class="control-label"><%=DateUtils.clientFullformat.format(model.getCreateDate()) %></label>
						                  </div>
						                </div>
				                		<%
				                	}
				                %>
				                
				                
				            </div>
				            <!-- /.box-body -->
				          </div>
				          <!-- /.box -->
				      </div>
      				  <div class="col-md-5">
				          <div class="box box-default box-solid">
				            <div class="box-header with-border">
				              <h3 class="box-title"><spring:message code="label.customers.customerroles"/></h3>
				            </div>
				            <div class="box-body" style="display: block;">
				            	<div class="form-group">
				                  <label for="roles" class="col-sm-3 control-label"><spring:message code="label.customers.roles"/></label>
				                  <div class="col-sm-9">
				                      <form:select path="roles" class="form-control select2" multiple="multiple"  tabindex="15" >
				                      	<form:option value="ROLE_USER"><spring:message code="label.customers.role.user"/></form:option>
				                      	<form:option value="ROLE_MANAGER"><spring:message code="label.customers.role.manager"/></form:option>
				                      	<form:option value="ROLE_ADMIN"><spring:message code="label.customers.role.admin"/></form:option>
				                      	
				                      </form:select>
					                  <span class="text-danger"><form:errors path="dob" /></span>
				                  </div>
				                </div>
				            </div>
			              </div>
		              </div>
		              <div class="col-md-5">
				          <div class="box box-default box-solid">
				            <div class="box-header with-border">
				              <h3 class="box-title"><spring:message code="label.customers.customerpassword"/></h3>
				            </div>
				            <div class="box-body" style="display: block;">
				            	<div class="form-group">
				                  <label for="pwd" class="col-sm-3 control-label"><spring:message code="label.customers.password"/></label>
				                  <div class="col-sm-9">
				                      <form:password path="pwd" class="form-control" placeholder="Enter customer password" tabindex="30" />
					                  <span class="text-danger"><form:errors path="pwd" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                	<div class="col-sm-12 margin-top">
				                  		<button type="button" class="btn btn-flat btn-primary pull-right" name="changepassword"><i class="fa fa-floppy-o"></i> <spring:message code="label.customers.changepassword"/></button>
		                  			</div>
				                </div>
				                
				            </div>
			              </div>
		              </div>
		            </div>		
	              </div>
	             
				  <!-- /.tab-pane -->
	              <div class="tab-pane" id="orders">
	                <div id = "product_images">Save product to upload pictures.</div>
	              </div>
	              <!-- /.tab-pane -->
	              <div class="tab-pane" id="basket">
                	<div id="product_attributes">Save product to map product attributes.</div>
	              </div>
	              <!-- /.tab-pane -->
							
	            </div>
	            <!-- /.tab-content -->
	          </div>
          </div>
        </div>
        
      </div>
      <!-- /.row (main row) -->
		
    </section>
    <!-- /.content -->
  </div>
  </form:form>
  
<script type="text/javascript">
$(document).ready(function(){
	
	
	$(document).on("click","#refesh_product_images",function() {
		getProductImages(1);
	});
	$(document).on("click","#refesh_product_attributes",function() {
		getProductAttributes(1);
	});
	
	// added by Amar, get all images inner page for current product
	function getProductImages(pid){
		if(pid > 0){
			$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/admin/getProductImages",
				data : {"pid" : pid},
				success : function(data) {
					$("#product_images").html(data);  
				}
			});
		}
	}
	
	// added by Amar, get all images inner page for current product
	function getProductAttributes(pid){
		if(pid > 0){
			$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/admin/getProductAttributes",
				data : {"pid" : pid},
				success : function(data) {
					$("#product_attributes").html(data);     
				}
			});
		}
	}
	
	// added by Amar, Upload product image
	$(document).on("click","#upload_product_picture",function() {
		var image;
		if(document.getElementById("filePhoto") != null){
			image=document.getElementById("filePhoto").files[0];
		}
		var pid = $("#productid").val();
		var imageName = $("#imageName").val();
		var imageAlt = $("#imageAlt").val();
		var imageDetail = $("#imageDetail").val();
		var imageOrder = $("#imageOrder").val();
		if(pid == "" || pid == "0"){
			alertify.error("Product Not Saved !");
			return;
		}
		if(imageName == ""){
			alertify.error("Picture name is required !");
			return;
		}
		var imageId = $("#imageId").val();
		var senddata=new FormData();
	 	senddata.append("image", image);
	 	senddata.append("imageName", imageName);
	 	senddata.append("imageAlt", imageAlt);
	 	senddata.append("imageDetail", imageDetail);
	 	senddata.append("imageOrder", imageOrder);
	 	senddata.append("pid", pid);
	 	senddata.append("imageId", imageId);
		$.ajax({
	 		  url: "${pageContext.request.contextPath}/admin/profileImageUpld",
	 		  type: "POST",
	 		  async: "false",
	 		  data: senddata,
	 		  processData: false,  // tell jQuery not to process the data
	 		  contentType: false,   // tell jQuery not to set contentType
	 		  success:function(response){
	 			 var json = JSON.parse(response);
	 			 if(json.status == "success"){
	 				 alertify.success("Product image uploaded successfully !");
	 			 }else{
	 				alertify.error(json.msg);
	 			 }
	 			 
	 		  }
 		});
	});
	
	//added by amar, Delete product image
	$(document).on("click","#delete_product_image",function() {
		var imageid = $(this).attr("imageid");
		if(confirm("Are you sure to delete this ?")){
			$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/admin/deleteProductImage",
				data : {"imageId" : imageid},
				success : function(response) {
					 var json = JSON.parse(response);
		 			 if(json.status == "success"){
		 				 alertify.success(json.msg);
		 			 }else{
		 				alertify.error(json.msg);
		 			 }
		 			 
				}
			});
		}
	});

	$(document).on("click","#save_product_attribute",function() {
		$("#save_product_attribute").prop('disabled', true);
		
		var submitType=$(this).val();
		var pid = $("#pid").val();
		var product_attribute = $("#product_attribute").val();
		var attribute_type = $("#attribute_type").val();
		var attribute = $("#attribute").val(); 
		var product_attribute_option = $("#product_attribute_option").val();
		var product_attribute_value = $("#product_attribute_value").val();
		var allow_filter = $('#allow_filter').is(':checked'); 
		var show_on_product_page =  $("#show_on_product_page").is(':checked'); 
		var attribute_order = $("#attribute_order").val();
		var valid = true;
		if(attribute == null || attribute == ""){
			$("#attribute_error").text("Attribute is required");
			valid = false;
		}
		if(attribute_type !="OPTIONS"){
			if($.trim(product_attribute_value)== ""){
				$("#product_attribute_value_error").text("Attribute value is required");
				valid = false;
			}
		}else{
			if(product_attribute_option == null || $.trim(product_attribute_option)== ""){
				$("#product_attribute_option_error").text("Attribute option is required");
				valid = false;
			}
		}
		if($.trim(attribute_order)== ""){
			$("#attribute_order_error").text("Display order is required");
			valid = false;
		}
		if(!valid){
			return false;
		}else{
			$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/admin/saveProductAttribute",
				data : {"pid" : pid,
					"submitType" : submitType,
					"product_attribute":product_attribute,
					"attribute_type" : attribute_type,
					"attribute" : attribute,
					"product_attribute_option" : product_attribute_option,
					"product_attribute_value" : product_attribute_value,
					"allow_filter" : allow_filter,
					"show_on_product_page" : show_on_product_page,
					"attribute_order" : attribute_order
					},
				success : function(response) {
					var json = JSON.parse(response);
					if(json.status==200){
						alertify.success(json.msg);
					}else{
						alertify.error(json.msg);
					}
				}
			});
		}
	});
	
	//added by amar, Update product image
	$(document).on("click","#edit_product_attribute",function() {
		var product_attribute_id = $(this).attr("product_attribute_id");
		var pid = 1;
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/admin/getProductAttributes",
			data : {"pid" : pid, "productAttributeId" : product_attribute_id},
			success : function(data) {
				$("#product_attributes").html(data);     
			}
			
		});
	});
}); 
</script>
<script language=javascript type='text/javascript'>
	// addded by amar, preview browsed image before upload
    $('#form').on('keyup keypress', function(e) {
    	  var keyCode = e.keyCode || e.which;
    	  if (keyCode === 13) { 
    	    e.preventDefault();
    	    return false;
    	  }
    	});
</script>

</body>
</html>