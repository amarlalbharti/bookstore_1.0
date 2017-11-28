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
        Attribute
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="attributes"><i class="fa fa-dashboard"></i> attributes</a></li>
        <li class="active">New Attribute</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      
      <!-- Main row -->
      <div class="row">
        <div class="col-md-12">
          <!-- Horizontal Form -->
          <div class="box box-primary">
            
            <!-- form start -->
            <form:form class="form-horizontal" role="form" method="POST" action="addAttribute" commandName="attributeForm" autocomplete="off" id="form">
              <div class="box-body">
                <div class="form-group">
                  <label for="categoryName" class="col-sm-3 control-label">Attribute Name</label>
                  <div class="col-sm-9">
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
              <!-- /.box-body -->
              <div class="box-footer">
                <a href="attributes"><button type="button" class="btn btn-default">Cancel</button></a>
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