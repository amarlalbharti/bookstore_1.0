<%@page import="com.bookstore.config.ProjectConfig"%>
<%@page import="com.bookstore.domain.Product"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="com.bookstore.config.DateUtils"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.bookstore.domain.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
    <section class="content-header clearfix" >
      <h1 class="pull-left">Products</h1>
      <div class="pull-right">
      	<a href="${pageContext.request.contextPath}/admin/products/add" class="btn btn-flat btn-primary pull-right"><i class="fa fa-fw fa-plus-square"></i> Add New</a>
      </div>
    </section>

    <!-- Main content -->
    <section class="content" style="min-height: 530px;">
      
      <!-- Main row -->
      <div class="row">
        <div class="col-md-12">
          <!-- Horizontal Form -->
          <div class="box box-info">
            <div class="box-body" id="products_list">
				
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
	 
	//added by amar, load list of product for first page 
	 getproductslist(1);
	 
	
	$(document).on("change","#products_rpp",function() {
		var rpp = $("#products_rpp").val();
		getproductslist(1, rpp);
	});
	
	$(document).on("click","#products_paginate #products_previous",function() {
		var rpp = $("#products_rpp").val();
		var pn=$(this).attr("pn");
		getproductslist(pn, rpp);
	});
	
	$(document).on("click","#products_paginate #products_next",function() {
		var rpp = $("#products_rpp").val();
		var pn=$(this).attr("pn");
		getproductslist(pn, rpp);
	});
	
	
	
	
	function getproductslist(pn, rpp){
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/admin/products/list/"+pn,
			data : {"rpp":rpp},
			success : function(response) {
				 $("#products_list").html(response);
			}
		});
	}
});
</script>
  
</body>
</html>