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
</head>
<body>
	<%
		String viewmode = request.getAttribute("viewmode") != null?request.getAttribute("viewmode").toString():"add"; 
		Product product = (Product)request.getAttribute("product");
	%>
	
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Product
        <small><%= viewmode == null || viewmode.equals("add")?"New":"View" %></small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboad"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="products"><i class="fa fa-dashboard"></i> Products</a></li>
        <li class="active">New Product</li>
      </ol>
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
	              	<li class=""><a href="#tab_2" data-toggle="tab" aria-expanded="false">Images</a></li>
	              	<li class=""><a href="#tab_3" data-toggle="tab" aria-expanded="false">Categories</a></li>
			    </ul>
	            <div class="tab-content">
	              <div class="tab-pane active" id="tab_1">
	              	<div class="box-body">
		            <form:form class="form-horizontal" role="form" method="POST" action="addProduct" commandName="productForm" autocomplete="off" id="form">
		              <div class="col-md-7">
				          <div class="box box-default">
				            <div class="box-header with-border">
				              <h3 class="box-title">Generation Information</h3>
				            </div>
				            <!-- /.box-header -->
				            <div class="box-body" style="display: block;">
				              <div class="form-group">
				                  <label for="categoryName" class="col-sm-3 control-label">Product Name</label>
				                  <div class="col-sm-9">
				                      <form:input path="productName" class="form-control titleCase"  placeholder="Enter product name" tabindex="1"/>
					                  <span class="text-danger"><form:errors path="productName" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="shortDesc" class="col-sm-3 control-label">Product Detail</label>
				                  <div class="col-sm-9">
				                      <form:input path="shortDesc" class="form-control titleCase"  placeholder="Enter short description " tabindex="5" maxlength="100"/>
					                  <span class="text-danger"><form:errors path="shortDesc" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="productPrice" class="col-sm-3 control-label">Product Price</label>
				                  <div class="col-sm-9">
				                      <form:input path="productPrice" class="form-control number_only"  placeholder="Enter product price" tabindex="5" />
					                  <span class="text-danger"><form:errors path="productPrice" /></span>
				                  </div>
				                </div>
				                <div class="form-group">
				                	<label for="shortDesc" class="col-sm-3 control-label">Active</label>
				                  <div class="col-sm-9" style="padding-top: 7px;">
				                    <form:checkbox path="active" class="padding-top" tabindex="10"/>
				                  </div>
				                </div>
				            </div>
				            <!-- /.box-body -->
				          </div>
				          <!-- /.box -->
				      </div>
      				  
		            </form:form>
					</div>		
	              </div>
	              <%
						if(viewmode != null && !viewmode.equals("add")){
							%>
							  <!-- /.tab-pane -->
				              <div class="tab-pane" id="tab_2">
				                The European languages are members of the same family.
				              </div>
				              <!-- /.tab-pane -->
				              <div class="tab-pane" id="tab_3">
				                Lorem Ipsum is simply dummy text of the printing and typesetting industry.
				              </div>
				              <!-- /.tab-pane -->
							<%
						}
				  %>
	              
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
</body>
</html>