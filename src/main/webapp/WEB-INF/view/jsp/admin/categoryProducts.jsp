<%@page import="com.bookstore.config.ProjectConfig"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.domain.ProductImage"%>
<%@page import="com.bookstore.domain.Product"%>
<div class="row">
  <table class="table table-bordered table-hover table-striped">
    <thead>
    <tr class="bg-primary">
      <th width="50px" style="text-align: center;">#</th>
      <th width="100px" style="text-align: center;">Picture</th>
      <th width="40%">Product Name</th>
      <th width="10%">Price</th>
      <th width="10%">Product SKU</th>
      <th width="20%" style="text-align: center;">Action</th>
    </tr>
    </thead>
    <tbody>
    <%	
	    int pn = (Integer)request.getAttribute("pn");
	    int rpp = (Integer)request.getAttribute("rpp");
	    long countProducts = (Long)request.getAttribute("countProducts");
	    List<Product> products = (List)request.getAttribute("productList");
	    int start = 0;
	    int count = 0;
	    if(products != null && !products.isEmpty()){
	    	start = (pn-1)*rpp;
	    	count = start; 
	    	start++;
	   		for(Product product : products){
	  				%>
	   				<tr>
	   				  <td style="text-align: center;"><%= ++count %></td>
	   				  <td style="text-align: center;"><img alt="<%= product.getProductName() %>" src="<%=ProjectConfig.PUBLIC_PATH %><%= product.getProductUrl() %>" width="75px"></td>
			          <td><%= product.getProductName() %></td>
			          <td><%= product.getProductPrice()%></td>
			          <td><%= product.getProductSKU()%></td>
			          <td style="text-align: center;">
			          	<button type="button" class="btn btn-flat btn-sm btn-primary" imageid="<%= product.getPid() %>" id="edit_product_image"><i class="fa fa-fw fa-edit"></i> Edit</button>
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
<div class="row">
	<div class="col-sm-5">
		<div class="dataTables_info" id="example1_info" role="status"
			aria-live="polite">Showing <%= start %> to <%= count %> of <%=countProducts %> entries</div>
	</div>
	<div class="col-sm-7">
		<div class="dataTables_paginate paging_simple_numbers"
			id="example1_paginate">
			<ul class="pagination">
				<li class="paginate_button previous <% if(pn > 1){out.print("previous_category_product");}else{out.print("disabled");} %>" pn="${pn-1}">
					<a href="#" aria-controls="example1" data-dt-idx="0" tabindex="0">Previous</a>
				</li>
				<li class="paginate_button active">
					<a href="#" aria-controls="example1" data-dt-idx="1" tabindex="0">${pn}</a>
				</li>
				<li class="paginate_button next <% if(count < countProducts){out.print("next_category_product");}else{out.print("disabled");} %>" pn="${pn+1}">
					<a href="#" aria-controls="example1" data-dt-idx="2" tabindex="0">Next</a>
				</li>
			</ul>
		</div>
	</div>
</div>