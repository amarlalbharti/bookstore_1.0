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
	

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Category
        <small>Add Category</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboad"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="categories"><i class="fa fa-dashboard"></i> Category</a></li>
        <li class="active">New Category</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      
      <!-- Main row -->
      <div class="row">
        <div class="col-md-12">
          <!-- Horizontal Form -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Add Category</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form:form class="form-horizontal" role="form" method="POST" action="addCategory" commandName="categoryForm" autocomplete="off" id="form">
              <div class="box-body">
                <div class="form-group">
                  <label for="categoryName" class="col-sm-3 control-label">Parent Category</label>
                  <div class="col-sm-9">
                      <form:select path="parent.cid" class="form-control titleCase select2"  placeholder="Enter category name" tabindex="1" maxlength="100">
                      	<form:option value="0">[None]</form:option>
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
                          			%>
                          				<form:option value="<%= category.getCid() %>"><%=catName %></form:option>
                          			<%
                          		}
                      		}
                      		
                      	%>
                      	
                      </form:select>
	                  <span class="text-danger"><form:errors path="parent" /></span>
                  </div>
                </div>
                <div class="form-group">
                  <label for="categoryName" class="col-sm-3 control-label">Category Name</label>
                  <div class="col-sm-9">
                      <form:input path="categoryName" class="form-control titleCase"  placeholder="Enter category name" tabindex="5" maxlength="100"/>
	                  <span class="text-danger"><form:errors path="categoryName" /></span>
                  </div>
                </div>
                <div class="form-group">
                  <label for="categoryDetail" class="col-sm-3 control-label">Category Detail</label>
                  <div class="col-sm-9">
                      <form:textarea path="categoryDetail" class="form-control titleCase"  placeholder="Enter category detail" tabindex="10" maxlength="100"/>
	                  <span class="text-danger"><form:errors path="categoryDetail" /></span>
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
                  <label for="categoryDetail" class="col-sm-3 control-label">Active</label>
                  <div class="col-sm-9">
                      <form:checkbox path="active" tabindex="20" style="margin-top: 10px;"/>
	              </div>
                </div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <a href="categories"><button type="button" class="btn btn-default">Cancel</button></a>
                <button type="submit" class="btn btn-primary pull-right"><i class="fa fa-floppy-o"></i>&nbsp;&nbsp;Save</button>
              </div>
              <!-- /.box-footer -->
            </form:form>
          </div>
        </div>
        
      </div>
      <!-- /.row (main row) -->

    </section>
    <!-- /.content -->
  </div>
</body>
</html>