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
    <section class="content-header" >
      <h1>
        <small>View Category</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboad"><i class="fa fa-dashboard"></i> Home</a></li>
        <%
        	List<Category> parentHierarchy = (List)request.getAttribute("parentHierarchy");
        	if(parentHierarchy != null && !parentHierarchy.isEmpty()){
        		%>
	    			<li><a href="categories">Categories</a></li>
	    		<%	
        		while(!parentHierarchy.isEmpty()){
					Category patent =parentHierarchy.remove(0);
					if(!parentHierarchy.isEmpty()){
						%>
		        			<li><a href="categories?cid=<%= patent.getCid()%>"><%= patent.getCategoryName()%></a></li>
		        		<%
					}else{
		        		%>
		        			<li class="active"><%= patent.getCategoryName()%></li>
		        		<%	
					}
        		}
        	}else{
        		%>
        			<li class="active">Categories</li>
        		<%	
        	}
        %>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content" style="min-height: 530px;">
      
      <!-- Main row -->
      <div class="row">
        <div class="col-md-12">
          <!-- Horizontal Form -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">View Category</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
				<div class="row">
					<div class="col-sm-6">
						<div class="dataTables_length" id="example1_length">
							<label>Show 
							<select name="rpp" id="rpp" aria-controls="example1" class="form-control input-sm">
								<option value="10" ${rpp==10 ? 'selected': '' }>10</option>
								<option value="25" ${rpp==25 ? 'selected': ''}>25</option>
								<option value="50" ${rpp==50 ? 'selected': ''}>50</option>
								<option value="100"  ${rpp==100 ? 'selected': ''}>100</option>
								</select>
								entries
							</label>
						</div>
					</div>
					<div class="col-sm-6">
						<div id="example1_filter" class="dataTables_filter">
							<label>Search:<input class="form-control input-sm"
								placeholder="" aria-controls="example1" type="search"></label>
						</div>
					</div>
				</div>
			<div class="">
              <table class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th style="text-align: center;">#</th>
                  <th>Category Name</th>
                  <th>Parent Category </th>
                  <th style="text-align: center;">Active</th>
                  <th style="text-align: center;">Create Date</th>
                  <th style="text-align: center;">Action</th>
                </tr>
                </thead>
                <tbody>
                <%
	                int rpp = (Integer)request.getAttribute("rpp");
	              	int pn = (Integer)request.getAttribute("pn");
	              	int start = ((pn-1)*rpp);
	              	int  count = start; 
                	List<Product> productList = (List)request.getAttribute("productList");
                	if(productList != null && !productList.isEmpty()){
                		for(Product product : productList){
                			%>
                				<tr>
                				  <td style="text-align: center;"><%= ++count%></td>
				                  <td><a href="viewProduct?pid=<%= product.getPid()%>"><%= product.getProductName()%></a></td>
				                  <td><%= product.getProductUrl()!=null ? product.getProductUrl():'-' %></td>
				                  <td style="text-align: center;"><span id="active<%= product.getPid()%>"><%= product.isActive()? "Yes" : "No" %></span></td>
				                  <td style="text-align: center;"><%= DateUtils.clientDateFormat.format(product.getCreateDate())%></td>
				                  <td style="text-align: center;">
				                  	<a href="editProduct?pid=<%= product.getPid()%>"><i class="fa fa-fw fa-edit"></i></a>
				                  	<%
				                  		if( product.isActive()){
				                  			%>
						        				<span class="category_status">
						        					<a href="javascript:void(0);" class="deactivate" catid="<%= product.getPid()%>"><i class="fa fa-fw fa-close"></i></a>
						        				</span>	
						        			<%
				                  		}else{
				                  			%>
				                  				<span class="category_status">
						        					<a href="javascript:void(0);" class="activate" catid="<%= product.getPid()%>" ><i class="fa fa-fw fa-check"></i></a>
						        				</span>
						        			<%
				                  		}
				                  	%>
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
              <%
              	long listcount = (Long)request.getAttribute("listcount");
              	int lastpage = ((int)listcount)/rpp;
              	if(listcount%rpp > 0){
              		lastpage = lastpage + 1; 
              	}
              		  
              %>
              <div class="row">
              	<div class="col-sm-5">
              		<div class="dataTables_info" id="example2_info" role="status" aria-live="polite">Showing <%= listcount>0?start+1:0 %> to <%= count %> of <%= listcount %> entries</div>
          		</div>
          		<div class="col-sm-7">
          			<div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
          				<ul class="pagination">
          					<%
          						if(pn>1){
          							%>
	          							<li class="paginate_button previous" id="example2_previous">
			          						<a href="categories?pn=<%= pn-1 %>&rpp=<%= rpp %>" aria-controls="example2" data-dt-idx="0" tabindex="0">Previous</a>
			       						</li>
      								<%	
          						}else{
          							%>
	          							<li class="paginate_button previous disabled" id="example2_previous">
			          						<a href="javascript:void(0);" aria-controls="example2" data-dt-idx="0" tabindex="0">Previous</a>
			       						</li>
	  								<%	
          							
          						}
				            %>
          					<li class="paginate_button active">
      							<a href="#" aria-controls="example2" data-dt-idx="1" tabindex="0"><%= pn %></a>
   							</li>
   							<%
          						if(pn<lastpage){
          							%>
	          							<li class="paginate_button next" id="example2_next">
											<a href="categories?pn=<%= pn+1 %>&rpp=<%= rpp %>" aria-controls="example2" data-dt-idx="7" tabindex="0">Next</a>
										</li>
      								<%	
          						}else{
          							%>
	          							<li class="paginate_button next disabled" id="example2_next">
											<a href="javascript:void(0);" aria-controls="example2" data-dt-idx="7" tabindex="0">Next</a>
										</li>
	  								<%	
          							
          						}
				            %>
          					
						</ul>
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
	$(document).on("change","#rpp",function() {
		 window.location = "categories?pn=1&rpp="+this.value;
	});
	
	$(document).on("click",".deactivate",function() {
		if(confirm("Are you sure to de-activate  category ?"))
		{
			var sel_element = $(this); 
			var cid = $(this).attr("catid");
			$.ajax({
			  type: "GET",
			  url: "changeStatus",
			  data: {cid: cid,catStatus: 'deactivate'},
			  success: function(data){
				  var json = $.parseJSON(data);
				  if(json.status == "success"){
					  var check = "<i class='fa fa-fw fa-check'></i>";
					  sel_element.html(check);
					  var catrow = "#active"+cid;
					  $(catrow).html("No");
					  sel_element.addClass("activate");
					  sel_element.removeClass("deactivate");
					  alertify.success(json.msg);
				  }else{
					  alertify.error(json.msg);
				  }
			  }
			});
		}
	});
	
	$(document).on("click",".activate",function() {
		if(confirm("Are you sure to activate  category ?"))
		{
			var sel_element = $(this); 
			var cid = $(this).attr("catid");
			$.ajax({
			  type: "GET",
			  url: "changeStatus",
			  data: {cid: cid,catStatus: 'activate'},
			  success: function(data){
				  var json = $.parseJSON(data);
				  if(json.status == "success"){
					  var check = "<i class='fa fa-fw fa-close'></i>";
					  sel_element.html(check);
					  var catrow = "#active"+cid;
					  $(catrow).html("Yes");
					  sel_element.addClass("deactivate");
					  sel_element.removeClass("activate");
					  alertify.success(json.msg);
				  }else{
					  alertify.error(json.msg);
				  }
			  }
			});
		}
	});
	
});
</script>
  
</body>
</html>