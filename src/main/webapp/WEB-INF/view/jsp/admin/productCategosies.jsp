<%@page import="java.util.List"%>
<%@page import="com.bookstore.domain.ProductImage"%>
<%@page import="com.bookstore.domain.Product"%>
<div>
  <table class="table table-bordered table-hover table-striped">
    <thead>
    <tr class="bg-primary">
      <th width="10%" style="text-align: center;">Picture</th>
      <th width="30%">Image Title</th>
      <th width="30%">Image Alt</th>
      <th width="30%">Image Detail</th>
      <th width="10%" style="text-align: center;">Display Order</th>
      <th width="10%" style="text-align: center;">Action</th>
    </tr>
    </thead>
    <tbody>
    <%
    	List<ProductImage> productImages = (List)request.getAttribute("productImages");
    	if(productImages != null && !productImages.isEmpty()){
    		for(ProductImage image : productImages){
    			%>
    				<tr>
    				  <td style="text-align: center;"><img alt="<%= image.getImageAlt() %>" src="images/no-preview-available.png" width="100px"></td>
			          <td><%= image.getImageName() %></td>
			          <td><%= image.getImageAlt() %></td>
			          <td><%= image.getImageDesc() %></td>
			          <td style="text-align: center;"><%= image.getImageOrder()%></td>
			          <td style="text-align: center;">
			          	<button href="editCategory?cid=<%= image.getImageId()%>" class="btn btn-flat btn-sm btn-primary"><i class="fa fa-fw fa-edit"></i> Edit</button>
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

	<div class="box box-info box-solid">
		<div class="box-header with-border">
          <h3 class="box-title">Add Product Picture</h3>
        </div>
		<div class="box-body">
			<div>
				<div class="form-group">
	               <label for="imageName" class="col-sm-3 control-label">Picture Title</label>
	               <div class="col-sm-9">
	                   <input name="imageName" class="form-control titleCase"  placeholder="Enter image title" tabindex="5" maxlength="100"/>
	                	<span class="text-danger"></span>
	               </div>
	            </div>
	            <div class="form-group">
	               <label for="imageAlt" class="col-sm-3 control-label">Picture Alt</label>
	               <div class="col-sm-9">
	                   <input name="imageAlt" class="form-control titleCase"  placeholder="Enter image alt" tabindex="5" maxlength="100"/>
	                	<span class="text-danger"></span>
	               </div>
	            </div>
	            <div class="form-group">
	               <label for="imageDetail" class="col-sm-3 control-label">Picture Detail</label>
	               <div class="col-sm-9">
	                   <textarea name="imageDetail" class="form-control titleCase"  placeholder="Enter image detail" tabindex="5" maxlength="100"></textarea>
	                	<span class="text-danger"></span>
	               </div>
	            </div>
	            <div class="form-group">
	               <label for="imageOrder" class="col-sm-3 control-label">Display Order</label>
	               <div class="col-sm-9">
	                   <input name="imageOrder" class="form-control number_only" type="number" min="0"  placeholder="Enter image order" tabindex="5" maxlength="100"/>
	                	<span class="text-danger"></span>
	               </div>
	            </div>
			</div>
		</div>
		<div class="box-footer">
            <a href="products"><button type="button" class="btn btn-default">Cancel</button></a>
            <button type="button" class="btn btn-primary pull-right"><i class="fa fa-upload"></i>&nbsp;&nbsp;Upload</button>
          </div>
	</div>
</div>