<%@page import="com.bookstore.config.ProjectConfig"%>
<%@page import="com.bookstore.model.CategoryModel"%>
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
<style>
.thumbnail {
  position: relative;
  width: 80px;
  height: 60px;
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
	CategoryModel edit = (CategoryModel) request.getAttribute("categoryForm");
if(edit != null){
%>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header clearfix">
      <h1 class="pull-left">Edit category - <%= edit.getCategoryName()%>
      <a href="${pageContext.request.contextPath}/admin/category"><small class="text-primary"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back to categories</small></a>
      </h1>
      <div class="pull-right">
      	<button class="btn btn-flat btn-danger pull-right " id="delete_category"><i class="fa fa-fw fa-close"></i> Delete</button>
      </div>
    </section>

    <!-- Main content -->
    <section class="content">
      
      <!-- Main row -->
      <div class="row">
        <div class="col-md-12">
          <!-- Horizontal Form -->
          <div >
            <div class="nav-tabs-custom">
	            <ul class="nav nav-tabs">
	              <li class="active"><a href="#tab_1" data-toggle="tab" aria-expanded="true">Category Info</a></li>
	              <li class=""><a href="#tab_2" id="refesh_category_product" data-toggle="tab" aria-expanded="false">Products</a></li>
			    </ul>
	            <div class="tab-content">
	              <div class="tab-pane active" id="tab_1">
	              	<div class="box-body">
            			<form:form class="form-horizontal" role="form" method="POST" action="${pageContext.request.contextPath}/admin/category/update" commandName="categoryForm" enctype="multipart/form-data" autocomplete="off" id="form">
			              <div class="box-body">
			              	<div class="form-group">
			                  <label for="categoryName" class="col-sm-3 control-label">Parent Category</label>
			                  <div class="col-sm-9">
			                      <form:select path="parent.cid" class="form-control titleCase select2"  placeholder="Enter category name" tabindex="1" maxlength="100">
			                      	<form:option value="0">[None]</form:option>
			                      	<%
			                      		List<Category> categoryList = (List<Category>)request.getAttribute("categoryList");
			                      		for(Category category : categoryList){
			                      			String catName = category.getCategoryName();
			                      			Category parent = category.getParent();
			                      			while(parent != null){
			                      				catName = parent.getCategoryName() + " >> "+ catName;
			                      				parent = parent.getParent();
			                      			}
			                      			if(edit.getCid()!=category.getCid()){
			                      				if(edit.getParent() != null && edit.getParent().getCid() == category.getCid()){
			                              			%>
			    	                      				<form:option value="<%= category.getCid() %>" selected="selected"><%= catName %></form:option>
			    	                      			<%
			                          			}else{
			                              			%>
			    	                      				<form:option value="<%= category.getCid() %>"><%=catName %></form:option>
			    	                      			<%
			                          			}
			                      			}
			                      			
			                      		}
			                      	%>
			                      	
			                      </form:select>
				                  <span class="text-danger"><form:errors path="categoryName" /></span>
			                  </div>
			                </div>
			                <div class="form-group">
			                  <label for="categoryName" class="col-sm-3 control-label">Category Name</label>
			                  <div class="col-sm-9">
			                 		<form:hidden path="cid" class="form-control titleCase"/>
			                      <form:input path="categoryName" class="form-control titleCase"  placeholder="Enter category name" tabindex="1" maxlength="100"/>
				                  <span class="text-danger"><form:errors path="categoryName" /></span>
			                  </div>
			                </div>
			                <div class="form-group">
			                  <label for="categoryDetail" class="col-sm-3 control-label">Category Detail</label>
			                  <div class="col-sm-9">
			                      <form:textarea path="categoryDetail" class="form-control titleCase"  placeholder="Enter category detail" tabindex="5" maxlength="100"/>
				                  <span class="text-danger"><form:errors path="categoryDetail" /></span>
			                  </div>
			                </div>
			                <div class="form-group">
			                  <label for="categoryImage" class="col-sm-3 control-label">Picture</label>
			                  <div class="col-sm-9">
			                  	<%
			                  		if(edit.getCategoryImageUrl() != null && !edit.getCategoryImageUrl().isEmpty() ){
			                  			%>
			                  			   <div class="thumbnail">
												<img id="previewHolder" alt="Uploaded Image Preview Holder" src="<%= ProjectConfig.PUBLIC_PATH+edit.getCategoryImageUrl() %>" />
										   </div>
			                  			<%
			                  		}else{
			                  			%>
			                  			   <div class="thumbnail">
												<img id="previewHolder" alt="Uploaded Image Preview Holder" src="${pageContext.request.contextPath}/images/no-preview-available.png" />
										   </div>
			                  			<%
			                  		}
			                  	%>
			                  	
			                    <label class="btn btn-primary btn-flat btn-xs">
									<input name="categoryImage" id="categoryImage" type="file" accept="image/jpg,image/png,image/jpeg,image/gif" tabindex="75" onchange="categoryImage();" />
									<i class="fa fa-fw fa-cloud-upload"></i>
									Browse
								</label>
								<form:hidden path="categoryImageUrl"/>
								<span class="text-danger"><form:label path="" id="userImgErr" class="image_error" /></span>
			                  </div>
			                </div>
			                <div class="form-group">
			                  <label for="categoryDetail" class="col-sm-3 control-label">Display Order</label>
			                  <div class="col-sm-9">
			                      <form:input path="displayOrder" class="form-control"  placeholder="Enter display order." type="number" tabindex="15" maxlength="100"/>
				                  <span class="text-danger"><form:errors path="displayOrder" /></span>
			                  </div>
			                </div>
			                <div class="form-group">
			                  <label for="Active" class="col-sm-3 control-label">Active</label>
			                  <div class="col-sm-9">
			                      <form:checkbox path="active" tabindex="10" maxlength="100" style="margin-top: 10px;"/>
				              </div>
			                </div>
			              </div>
			              <!-- /.box-body -->
			              <div class="box-footer">
			                <a href="${pageContext.request.contextPath}/admin/category"><button type="button" class="btn btn-default">Cancel</button></a>
			                <button type="submit" class="btn btn-primary pull-right"><i class="fa fa-floppy-o"></i>&nbsp;&nbsp;Save</button>
			              </div>
			              <!-- /.box-footer -->
			            </form:form>
            		</div>
           		  </div>
           		  <div class="tab-pane" id="tab_2">
	              	<div class="box-body">
	              		<div id="category_products" style="min-height: 300px"></div>
	              	</div>
	              </div>
           		</div>
         	</div>
            
          </div>
        </div>
        
      </div>
      <!-- /.row (main row) -->

    </section>
    <!-- /.content -->
  </div>
  <script type="text/javascript">
$(document).ready(function(){
	$(document).on("click","#refesh_category_product",function() {
		getCategoryProducts(<%=edit.getCid()%>,1);
	});
	// added by Amar, get all images inner page for current product
	function getCategoryProducts(pid,pn){
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/admin/getCategoryProducts",
			data : {"cid" : <%=edit.getCid()%>,'pn':pn},
			success : function(data) {
					$("#category_products").html(data);        
			}
			
		});
		
	}
	
	$(document).on("click",".pagination .previous_category_product",function() {
		var pn = $(this).attr("pn");
		getCategoryProducts(<%=edit.getCid()%>, pn);
	});
	$(document).on("click",".pagination .next_category_product",function() {
		var pn = $(this).attr("pn");
		getCategoryProducts(<%=edit.getCid()%>, pn);
	});
	
	
	
});	
$(document).ready(function(){
	$(document).on("click","#delete_category",function() {
		var r = confirm("Do you want to delete this ?"); 
		if(r){
			window.location = "${pageContext.request.contextPath}/admin/category/delete/<%= edit.getCid() %>";	
		}
		 
	});
 });
</script>	
<%
}
%>
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
    	$(document).on("change","#categoryImage",function() {
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