<%@page import="com.bookstore.domain.AttributeValue"%>
<%@page import="com.bookstore.config.ProjectConfig"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.domain.ProductImage"%>
<%@page import="com.bookstore.domain.Product"%>
<div>
  <table class="table table-bordered table-hover table-striped">
    <thead>
    <tr class="bg-primary">
      <th width="30%">Attribute Name</th>
      <th width="30%">Attribute Value</th>
      <th width="20%" style="text-align: center;">Create Date</th>
      <th width="20%" style="text-align: center;">Action</th>
    </tr>
    </thead>
    <tbody>
    <%	Product product = (Product)request.getAttribute("product");
    	ProductImage editImage = (ProductImage)request.getAttribute("editImage");
    	if(product != null){
	    	List<AttributeValue> attributeValues = (List)request.getAttribute("attributeValues");
	    	if(attributeValues != null && !attributeValues.isEmpty()){
	    		for(AttributeValue attributeValue : attributeValues){
    				%>
	    				<tr>
	    				  <td><%= attributeValue.getAttribute().getAttributeName() %></td>
				          <td><%= attributeValue.getAttributeValue() %></td>
				          <td><%= attributeValue.getCreateDate() %></td>
				          <td style="text-align: center;">
				          	<button type="button" class="btn btn-flat btn-sm btn-primary" attributeValueId="<%= attributeValue.getAttributeValueId() %>" id="edit_attribute_value"><i class="fa fa-fw fa-edit"></i> Edit</button>
				          	<button type="button" class="btn btn-flat btn-sm btn-danger" attributeValueId="<%= attributeValue.getAttributeValueId() %>" id="delete_attribute_value"><i class="fa fa-fw fa-close"></i> Delete</button>
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
    	}else{
    		%>
			<tr>
				<td colspan="6">Attribute Not Saved !</td>
			</tr>
			<%
    	}
    %>
    
    </tbody>
  </table>
	<%
		if(product != null){
			if(editImage == null){
	%>
			<div class="box box-info box-solid">
				<div class="box-header with-border">
		          <h3 class="box-title">Add Attribute Value</h3>
		        </div>
				<div class="box-body">
					<div class="form-group">
		               <label for="imageName" class="col-sm-3 control-label">Attribute Value</label>
		               <div class="col-sm-9">
		                   <input name="imageName" id = "imageName" class="form-control titleCase"  placeholder="Enter image title" tabindex="5" maxlength="100"/>
		                	<span class="text-danger"></span>
		               </div>
		            </div>
		            <div class="form-group">
	                  <label for="active" class="col-sm-3 control-label">Active</label>
	                  <div class="col-sm-9">
	                      <input type="checkbox" name="active" tabindex="20" style="margin-top: 10px;"/>
		              </div>
	                </div>
				</div>
				<div class="box-footer">
		            <a href="products"><button type="button" class="btn btn-default">Cancel</button></a>
		            <button type="button" id = "upload_product_picture" class="btn btn-primary pull-right "><i class="fa fa-upload"></i>&nbsp;&nbsp;Upload</button>
		          </div>
			</div>
			<%
			}else{
				%>
				<div class="box box-info box-solid" id ="updateImageDiv">
					<div class="box-header with-border">
			          <h3 class="box-title">Update Product Picture</h3>
			        </div>
					<div class="box-body">
						<div class="form-group">
			               <label for="imageName" class="col-sm-3 control-label">Attribute Value</label>
			               <div class="col-sm-9">
			                   <input name="imageName" id = "imageName" class="form-control titleCase"  placeholder="Enter image title" tabindex="5" maxlength="100"/>
			                	<span class="text-danger"></span>
			               </div>
			            </div>
			            <div class="form-group">
		                  <label for="active" class="col-sm-3 control-label">Active</label>
		                  <div class="col-sm-9">
		                      <form:checkbox path="active" tabindex="20" style="margin-top: 10px;"/>
			              </div>
		                </div>
					</div>
					<div class="box-footer">
			            <button type="button" id="refesh_images" class="btn btn-default"><i class="fa fa-undo" aria-hidden="true"></i> Reset</button>
			            <button type="button" id = "upload_product_picture" class="btn btn-primary pull-right"><i class="fa fa-upload"></i>&nbsp;&nbsp;Upload</button>
			        </div>
				</div>
				<%
			}
		}
	%>
</div>