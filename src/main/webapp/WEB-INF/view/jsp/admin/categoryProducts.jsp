<%@page import="com.bookstore.config.ProjectConfig"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.domain.ProductImage"%>
<%@page import="com.bookstore.domain.Product"%>
<div>
  <table class="table table-bordered table-hover table-striped">
    <thead>
    <tr class="bg-primary">
      <th width="20%" style="text-align: center;">Picture</th>
      <th width="30%">Product Name</th>
      <th width="10%">Price</th>
      <th width="20%">Product SKU</th>
      <th width="20%" style="text-align: center;">Action</th>
    </tr>
    </thead>
    <tbody>
    <%	
    	List<Product> products = (List)request.getAttribute("productList");
	   	if(products != null && !products.isEmpty()){
	   		for(Product product : products){
	  				%>
	   				<tr>
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