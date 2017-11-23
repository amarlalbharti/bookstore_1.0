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
	               <label for="imageName" class="col-sm-3 control-label">Picture</label>
	               <div class="col-sm-9">
	                   <!-- <input type="file" name="filePhoto" value="" id="filePhoto" class="required borrowerImageFile" data-errormsg="PhotoUploadErrorMsg">
					    -->
					   <div class="thumbnail">
							<img id="previewHolder" alt="Uploaded Image Preview Holder" src="http://pjcgroundworks.co.uk/wp-content/uploads/2015/04/no-image-available.png" />
					   </div>

						<label class="btn btn-primary btn-flat btn-xs"> 
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
	                   <input name="imageOrder" id = "imageOrder"  class="form-control number_only" type="number" min="0"  placeholder="Enter image order" tabindex="5" maxlength="100"/>
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
</div>