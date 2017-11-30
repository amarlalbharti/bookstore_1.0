<%@page import="com.bookstore.domain.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.model.ProductModel"%>
<%@page import="com.bookstore.config.DateUtils"%>
<%@page import="com.bookstore.domain.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
	<%
		ProductModel model = (ProductModel)request.getAttribute("productForm");
	%>
	
  <!-- Content Wrapper. Contains page content -->
  <form:form class="form-horizontal" role="form" method="POST" action="addProduct" commandName="productForm" autocomplete="off" id="form">
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header clearfix">
      <h1 class="pull-left">Product ${model.getPid() > 0 ? model.getProductName : '' } </h1>
      <div class="pull-right">
      	<button type="submit" class="btn btn-flat btn-primary" name="submit" value="save"><i class="fa fa-floppy-o"></i> Save</button>
      	<button type="submit" class="btn btn-flat btn-primary" name="submit" value="continue"><i class="fa fa-floppy-o"></i> Save & Continue</button>
      	<%
      		if(model!= null && model.getPid() > 0){
      			%>
      				<button type="submit" class="btn btn-flat btn-primary" name="submit" value="copy"><i class="fa fa-clone"></i> Copy Product</button>
      			<%
      		}
      	%>
      	<button type="button" class="btn btn-flat btn-danger" id="delete_category"><i class="fa fa-fw fa-close"></i> Delete</button>
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
	              <li class="active"><a href="#tab_1" data-toggle="tab" aria-expanded="true">Product</a></li>
	              	<li class=""><a href="#tab_2" data-toggle="tab" aria-expanded="false">Pictures</a></li>
	              	<li class=""><a href="#tab_3" data-toggle="tab" aria-expanded="false">Categories</a></li>
			    </ul>
	            <div class="tab-content">
	              <div class="tab-pane active" id="tab_1">
	              	<div class="box-body">
		            
		              <div class="col-md-7">
				          <div class="box box-default box-solid">
				            <div class="box-header with-border">
				            	<form:hidden path="pid" />
				              <h3 class="box-title">Generation Information</h3>
				            </div>
				            <!-- /.box-header -->
				            <div class="box-body" style="display: block;">
				               <div class="form-group">
				                  <label for="productName" class="col-sm-3 control-label">Product Name</label>
				                  <div class="col-sm-9">
				                      <form:input path="productName" class="form-control titleCase"  placeholder="Enter product name" tabindex="1"/>
					                  <span class="text-danger"><form:errors path="productName" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="shortDesc" class="col-sm-3 control-label">Product Detail</label>
				                  <div class="col-sm-9">
				                      <form:textarea path="shortDesc" class="form-control titleCase"  placeholder="Enter short description " tabindex="5" maxlength="100"></form:textarea>
					                  <span class="text-danger"><form:errors path="shortDesc" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="productSKU" class="col-sm-3 control-label">Product SKU</label>
				                  <div class="col-sm-9">
				                      <form:input path="productSKU" class="form-control titleCase"  placeholder="Enter product name" tabindex="1"/>
					                  <span class="text-danger"><form:errors path="productSKU" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="productMRP" class="col-sm-3 control-label">Product MRP</label>
				                  <div class="col-sm-9">
				                      <form:input path="productMRP" class="form-control number_only .number_pasitive" placeholder="Enter product mrp" tabindex="5" />
					                  <span class="text-danger"><form:errors path="productMRP" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="productPrice" class="col-sm-3 control-label">Product Price</label>
				                  <div class="col-sm-9">
				                      <form:input path="productPrice" class="form-control number_only number_pasitive" placeholder="Enter product price" tabindex="5" />
					                  <span class="text-danger"><form:errors path="productPrice" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="productTin" class="col-sm-3 control-label">Product Tin</label>
				                  <div class="col-sm-9">
				                      <form:input path="productTin" class="form-control titleCase"  placeholder="Enter product tin number" tabindex="1"/>
					                  <span class="text-danger"><form:errors path="productTin" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                	<label for="active" class="col-sm-3 control-label">Active</label>
				                  <div class="col-sm-9" style="padding-top: 7px;">
				                    <form:checkbox path="active" class="padding-top" tabindex="10"/>
				                  </div>
				                </div>
				                <div class="form-group">
				                	<label for="showOnHomePage" class="col-sm-3 control-label">Show On Home Page</label>
				                  <div class="col-sm-9" style="padding-top: 7px;">
				                    <form:checkbox path="showOnHomePage" class="padding-top" tabindex="10"/>
				                  </div>
				                </div>
				                <div class="form-group">
				                	<label for="disableBuyButton" class="col-sm-3 control-label">Disable Buy Button</label>
				                  <div class="col-sm-9" style="padding-top: 7px;">
				                    <form:checkbox path="disableBuyButton" class="padding-top" tabindex="10"/>
				                  </div>
				                </div>
				                <div class="form-group">
				                	<label for="customerReview" class="col-sm-3 control-label">Customer Review</label>
				                  <div class="col-sm-9" style="padding-top: 7px;">
				                    <form:checkbox path="customerReview" class="padding-top" tabindex="10"/>
				                  </div>
				                </div>
				                
				            </div>
				            <!-- /.box-body -->
				          </div>
				          <!-- /.box -->
				      </div>
      				  <div class="col-md-5">
				          <div class="box box-default box-solid">
				            <div class="box-header with-border">
				              <h3 class="box-title">Category Mapping</h3>
				            </div>
				            <div class="box-body" style="display: block;">
				            	<div class="form-group">
				                  <label for="categories" class="col-sm-3 control-label">Categories</label>
				                  <div class="col-sm-9">
				                      <form:select path="categories" class="form-control select2" multiple="multiple"  tabindex="5" >
			                      			<%
					                      		List<Category> categoryList = (List<Category>)request.getAttribute("categoryList");
					                      		if(categoryList != null && !categoryList.isEmpty()){
					                      			for(Category category : categoryList){
					                          			String catName = category.getCategoryName();
					                          			Category parent = category.getParent();
					                          			while(parent != null){
					                          				catName = parent.getCategoryName() + " >> "+ catName;
					                          				parent = parent.getParent();
					                          			}
					                          			if(model.getCategories().contains(category.getCid())){
					                          				%>
						                          				<form:option value="<%= category.getCid() %>"  selected="selected"><%=catName %></form:option>
						                          			<%
					                          			}else{
					                          				%>
						                          				<form:option value="<%= category.getCid() %>"  ><%=catName %></form:option>
						                          			<%
					                          			}
					                          			
					                          		}
					                      		}
					                      		
					                      	%>
				                      </form:select>
					                  <span class="text-danger"><form:errors path="categories" /></span>
				                  </div>
				                </div>
				            </div>
			              </div>
		              </div>
		            </div>		
	              </div>
	             
				  <!-- /.tab-pane -->
	              <div class="tab-pane" id="tab_2">
	                <div id = "product_images">Save product to upload pictures.</div>
	              </div>
	              <!-- /.tab-pane -->
	              <div class="tab-pane" id="tab_3">
	                
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
	<%
		if(model != null && model.getPid() > 0){
			%>
			getProductImages(<%= model.getPid() %>);
			<%
		}
	%>
	
	$(document).on("click","#refesh_images",function() {
		getProductImages(<%= model.getPid() %>);
	});
	
	// added by Amar, get all images inner page for current product
	function getProductImages(pid){
		$.ajax({
			type : "GET",
			url : "getProductImages",
			data : {"pid" : pid},
			success : function(data) {
					$("#product_images").html(data);        
			}
			
		});
		
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
	 		  url: "${pageContext.request.contextPath}/profileImageUpld",
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
	 			 getProductImages(<%= model.getPid() %>);
	 			$(window).scrollTop(0);
	 		  }
 		});
	});
	
	//added by amar, Delete product image
	$(document).on("click","#delete_product_image",function() {
		var imageid = $(this).attr("imageid");
		if(confirm("Are you sure to delete this ?")){
			$.ajax({
				type : "GET",
				url : "deleteProductImage",
				data : {"imageId" : imageid},
				success : function(response) {
					 var json = JSON.parse(response);
		 			 if(json.status == "success"){
		 				 alertify.success(json.msg);
		 			 }else{
		 				alertify.error(json.msg);
		 			 }
		 			 getProductImages(<%= model.getPid() %>);
		 			$(window).scrollTop(0);
				}
			});
		}
	});
	//added by amar, Update product image
	$(document).on("click","#edit_product_image",function() {
		var imageid = $(this).attr("imageid");
		var pid = <%= model.getPid() %>;
		
	});
	//added by amar, Update product image
	$(document).on("click","#copy_product",function() {
		var form = $('<form action="${pageContext.request.contextPath}/copyProduct" method="post">' +
			'<input type="hidden" name="pid" value="<%= model.getPid() %>" />' +
			'</form>');
		$('body').append(form);
		$(form).submit();
	});
	
	
}); 
</script>
<script language=javascript type='text/javascript'>
	// addded by amar, preview browsed image before upload
    $(document).ready(function(){
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    $('#previewHolder').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    	$(document).on("change","#filePhoto",function() {
            readURL(this);
        });
    });
	
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