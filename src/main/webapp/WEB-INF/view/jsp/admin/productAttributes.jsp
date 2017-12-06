<%@page import="com.bookstore.domain.ProductAttribute"%>
<%@page import="com.bookstore.config.ProjectConfig"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.domain.ProductImage"%>
<%@page import="com.bookstore.domain.Product"%>
<div>
  <table class="table table-bordered table-hover table-striped">
    <thead>
    <tr class="bg-primary">
      <th width="10%" style="text-align: center;">Attribute</th>
      <th width="20%">Value</th>
      <th width="20%">Allow Filter</th>
      <th width="20%">Show on product page</th>
      <th width="10%" style="text-align: center;">Display Order</th>
      <th width="20%" style="text-align: center;">Action</th>
    </tr>
    </thead>
    <tbody>
    <%	Product product = (Product)request.getAttribute("product");
    	ProductImage editImage = (ProductImage)request.getAttribute("editImage");
    	if(product != null){
    		List<ProductAttribute> productAttributes = (List)request.getAttribute("productAttributes");
	    	if(productAttributes != null && !productAttributes.isEmpty()){
	    		for(ProductAttribute productAttribute : productAttributes){
    				%>
	    				<tr>
				          <td><%= productAttribute.getAttributeValue().getAttribute().getAttributeName() %></td>
				          <td><%= productAttribute.getAttributeValue().getAttributeValue() %></td>
				          <td style="text-align: center;"><%= productAttribute.isAllowFilter()%></td>
				          <td style="text-align: center;"><%= productAttribute.isShowOnProductPage()%></td>
				          <td><%= productAttribute.getDisplayOrder() %></td>
				          <td style="text-align: center;">
				          	<button type="button" class="btn btn-flat btn-sm btn-primary" imageid="" id="edit_product_image"><i class="fa fa-fw fa-edit"></i> Edit</button>
				          	<button type="button" class="btn btn-flat btn-sm btn-danger" imageid="" id="delete_product_image"><i class="fa fa-fw fa-close"></i> Delete</button>
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
				<td colspan="6">Product Not Saved !</td>
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
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
		          <h3 class="box-title">Add Product Picture</h3>
		        </div>
				<div class="box-body">
					<div>
						<div class="form-group">
			               <label for="imageName" class="col-sm-3 control-label">Picture</label>
			               <div class="col-sm-9">
			                   <!-- <input type="file" name="filePhoto" value="" id="filePhoto" class="required borrowerImageFile" data-errormsg="PhotoUploadErrorMsg">
							    -->
							   <div class="thumbnail">
									<img id="previewHolder" alt="Uploaded Image Preview Holder" src="http://pjcgroundworks.co.uk/wp-content/uploads/2015/04/no-image-available.png" />
							   </div>
								<label class="btn btn-primary btn-flat btn-xs"> 
									<input name="productid" id="productid" type="hidden" value="<%= product.getPid()%>" >
									<input name="filePhoto" id="filePhoto" type="file" class="required borrowerImageFile" accept="image/jpg,image/png,image/jpeg,image/gif" tabindex="75"  /> 
									<i class="fa fa-fw fa-cloud-upload"></i> Browse
								</label>
							</div>
			            </div>
						<div class="form-group">
			               <label for="imageName" class="col-sm-3 control-label">Picture Title</label>
			               <div class="col-sm-9">
			                   <input name="imageName" id = "imageName" class="form-control titleCase"  placeholder="Enter image title" tabindex="5" maxlength="100"/>
			                	<span class="text-danger"></span>
			               </div>
			            </div>
			            <div class="form-group">
			               <label for="imageAlt" class="col-sm-3 control-label">Picture Alt</label>
			               <div class="col-sm-9">
			                   <input name="imageAlt" id = "imageAlt" class="form-control titleCase"  placeholder="Enter image alt" tabindex="5" maxlength="100"/>
			                	<span class="text-danger"></span>
			               </div>
			            </div>
			            <div class="form-group">
			               <label for="imageDetail" class="col-sm-3 control-label">Picture Detail</label>
			               <div class="col-sm-9">
			                   <textarea name="imageDetail" id = "imageDetail"  class="form-control titleCase"  placeholder="Enter image detail" tabindex="5" maxlength="100"></textarea>
			                	<span class="text-danger"></span>
			               </div>
			            </div>
			            <div class="form-group">
			               <label for="imageOrder" class="col-sm-3 control-label">Display Order</label>
			               <div class="col-sm-9">
			                   <input name="imageOrder" id = "imageOrder"  class="form-control number_only" type="number" min="0"  placeholder="Enter image order" value="0" tabindex="5" maxlength="100"/>
			                	<span class="text-danger"></span>
			               </div>
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
				<div class="box box-primary box-solid" id ="updateImageDiv">
					<div class="box-header with-border">
			          <h3 class="box-title">Update Product Picture</h3>
			        </div>
					<div class="box-body">
						<div>
							<div class="form-group">
				               <label for="imageName" class="col-sm-3 control-label">Picture</label>
				               <div class="col-sm-9">
				                   <div class="thumbnail">
										<img id="previewHolder" alt="Uploaded Image Preview Holder" src="<%= ProjectConfig.PUBLIC_PATH + editImage.getImageURL()%>" />
										<input type="hidden" id="imageId" value="<%= editImage.getImageId()%>">
										<input name="productid" id="productid" type="hidden" value="<%= product.getPid()%>" >
								   </div>
								</div>
				            </div>
							<div class="form-group">
				               <label for="imageName" class="col-sm-3 control-label">Picture Title</label>
				               <div class="col-sm-9">
				                   <input name="imageName" id = "imageName" class="form-control titleCase" value="<%= editImage.getImageName()%>"  placeholder="Enter image title" tabindex="5" maxlength="100"/>
				                	<span class="text-danger"></span>
				               </div>
				            </div>
				            <div class="form-group">
				               <label for="imageAlt" class="col-sm-3 control-label">Picture Alt</label>
				               <div class="col-sm-9">
				                   <input name="imageAlt" id = "imageAlt" class="form-control titleCase" value="<%= editImage.getImageAlt()%>" placeholder="Enter image alt" tabindex="5" maxlength="100"/>
				                	<span class="text-danger"></span>
				               </div>
				            </div>
				            <div class="form-group">
				               <label for="imageDetail" class="col-sm-3 control-label">Picture Detail</label>
				               <div class="col-sm-9">
				                   <textarea name="imageDetail" id = "imageDetail"  class="form-control titleCase" placeholder="Enter image detail" tabindex="5" maxlength="100"><%= editImage.getImageDesc()%></textarea>
				                	<span class="text-danger"></span>
				               </div>
				            </div>
				            <div class="form-group">
				               <label for="imageOrder" class="col-sm-3 control-label">Display Order</label>
				               <div class="col-sm-9">
				                   <input name="imageOrder" id = "imageOrder"  class="form-control number_only" type="number" min="0"  placeholder="Enter image order" value="<%= editImage.getImageOrder()%>" tabindex="5" maxlength="100"/>
				                	<span class="text-danger"></span>
				               </div>
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