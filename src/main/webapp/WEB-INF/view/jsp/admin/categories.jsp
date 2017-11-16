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
      <h1 class="pull-left">View Category</h1>
      <div class="pull-right">
      	<a href="addCategory" class="btn btn-flat btn-primary pull-right"><i class="fa fa-fw fa-plus-square"></i> Add New</a>
      </div>
    </section>

    <!-- Main content -->
    <section class="content" style="min-height: 530px;">
      
      <!-- Main row -->
      <div class="row">
        <div class="col-md-12">
          <!-- Horizontal Form -->
          <div class="box box-info">
            <div class="box-body">
			<div class="">
              <table id="example1"  class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th style="text-align: center;">#</th>
                  <th>Category Name</th>
                  <th style="text-align: center;">Active</th>
                  <th style="text-align: center;">Display Order</th>
                  <th style="text-align: center;">Action</th>
                </tr>
                </thead>
                <tbody>
                <%
	                int  count = 0; 
                	List<Category> categoryList = (List)request.getAttribute("categoryList");
                	if(categoryList != null && !categoryList.isEmpty()){
                		for(Category category : categoryList){
                			String catName = category.getCategoryName();
                			Category cat = category;
                			while(cat.getParent() != null){
                				cat = cat.getParent();
                				catName = cat.getCategoryName() + " >> "+ catName;
                			}
                			%>
                				<tr>
                				  <td style="text-align: center;"><%= ++count%></td>
				                  <td><%= catName %></td>
				                  <td style="text-align: center;"><span id="active<%= category.getCid()%>"><%= category.isActive()? "Yes" : "No" %></span></td>
				                  <td style="text-align: center;"><%= category.getDisplayOrder()%></td>
				                  <td style="text-align: center;">
				                  	<a href="editCategory?cid=<%= category.getCid()%>" class="btn btn-flat btn-sm btn-primary"><i class="fa fa-fw fa-edit"></i> Edit</a>
				                  </td>
				                </tr>
                			<%
                		}
                	}else{
                		%>
	        				<tr>
	        				  <td colspan="6">No record founds !</td>
			                </tr>
	        			<%
                	}
                %>
                
                </tbody>
              </table>
              </div>
              
              
            </div>
          </div>
        </div>
        
      </div>
      <!-- /.row (main row) -->

    </section>
    <!-- /.content -->
  </div>
<script src="js/jquery.dataTables.js"></script>
<script src="js/dataTables.bootstrap.js"></script>
<script>
  $(function () {
    $('#example1').DataTable({
      "paging": true,
      "lengthChange": true,
      "searching": true,
      "ordering": false,
      "info": true,
      "autoWidth": false
    });
  });
</script>
<script type="text/javascript">
 $(document).ready(function(){
	
	
	
});
</script>
  
</body>
</html>