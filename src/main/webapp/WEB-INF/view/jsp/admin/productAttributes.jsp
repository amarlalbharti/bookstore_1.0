<%@page import="com.bookstore.domain.Attribute"%>
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
    	ProductAttribute editProductAttribute = (ProductAttribute)request.getAttribute("editProductAttribute");
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
			if(editProductAttribute == null){
			%>
			<div class="box box-primary box-solid">
				<div class="box-header with-border">
		          <h3 class="box-title">Add new product attribute</h3>
		        </div>
				<div class="box-body">
					<div>
						<div class="form-group">
			               <label for="attribute_type" class="col-sm-3 control-label">Attribute Type</label>
			               <div class="col-sm-9">
			                    <select class="form-control col-md-12 select2" name="attribute_type" id="attribute_type">
			                    	<option value="OPTIONS">Options</option>
			                    	<option value="CUSTOM_TEXT">Custom Text</option>
			                    	<option value="CUSTOM_HTML_TEXT">Custom HTML Text</option>
			                    	<option value="HYPERLINK">Hyperlink</option>
			                    </select>
			                	<span class="text-danger" id="attribute_type_error"></span>
			               </div>
			            </div>
			            <div class="form-group" >
			               <label for="attribute" class="col-sm-3 control-label">Attribute</label>
			               <div class="col-sm-9">
			                   <select class="form-control select2" name="attribute" id="attribute">
			                   <%
			                   	List<Attribute> attributeList = (List)request.getAttribute("attributeList");
			            		if(attributeList != null && !attributeList.isEmpty()){
			            			for(Attribute attribute : attributeList){
			            				%>
			            					<option value="<%= attribute.getAttributeId()%>"><%= attribute.getAttributeName()%></option>
			            				<%
			            			}
			            		}
								%>
			                   </select>
			                   <span class="text-danger" id="attribute_error"></span>
			               </div>
			            </div>
			            <div class="form-group" id="div_attribute_option">
			               <label for="attributeOption" class="col-sm-3 control-label">Attribute Option</label>
			               <div class="col-sm-9">
			                   <select class="form-control select2" name="product_attribute_option" id="product_attribute_option">
			                   </select> 
			                   <span class="text-danger" id="product_attribute_option_error"></span>
			               </div>
			            </div>
			            <div class="form-group" style="display: none;" id="div_attribute_value">
			               <label for="attribute_value" class="col-sm-3 control-label">Attribute Value</label>
			               <div class="col-sm-9">
			                   <input name="product_attribute_value" id = "product_attribute_value" class="form-control titleCase"  placeholder="Enter attribute value" tabindex="5"/>
			                	<span class="text-danger" id = "product_attribute_value_error"></span>
			               </div>
			            </div>
			            <div class="form-group">
		                	<label for="active" class="col-sm-3 control-label">Allow Filter</label>
		                  <div class="col-sm-9" style="padding-top: 7px;">
		                    <input type="checkbox" name="allow_filter" id="allow_filter" class="padding-top" tabindex="10">
		                  </div>
		                </div>
		                <div class="form-group">
		                	<label for="active" class="col-sm-3 control-label">Show on product page</label>
		                  <div class="col-sm-9" style="padding-top: 7px;">
		                    <input type="checkbox" name="show_on_product_page" id="show_on_product_page" class="padding-top" tabindex="10">
		                  </div>
		                </div>
			            <div class="form-group">
			               <label for="imageOrder" class="col-sm-3 control-label">Display Order</label>
			               <div class="col-sm-9">
			                   <input name="attribute_order" id = "attribute_order"  class="form-control number_only" type="number" placeholder="Enter attribute order" value="0" tabindex="5" />
			                	<span class="text-danger" id = "attribute_order_error" ></span>
			               </div>
			            </div>
					</div>
				</div>
				<div class="box-footer">
		            <button type="button" id="save_product_attribute" value="save" class="btn btn-primary pull-right "><i class="fa fa-floppy-o"></i> Save</button>
		          </div>
			</div>
			<%
			}else{
				%>
				<div class="box box-primary box-solid">
					<div class="box-header with-border">
			          <h3 class="box-title">Add new product attribute</h3>
			        </div>
					<div class="box-body">
						<div>
							<div class="form-group">
				               <label for="imageName" class="col-sm-3 control-label">Attribute Type</label>
				               <div class="col-sm-9">
				                    <select class="form-control select2" id="">
				                    	<option value="OPTIONS">Options</option>
				                    	<option value="CUSTOM_TEXT">Custom Text</option>
				                    	<option value="CUSTOM_HTML_TEXT">Custom HTML Text</option>
				                    	<option value="HYPERLINK">Hyperlink</option>
				                    </select>
				                	<span class="text-danger"></span>
				               </div>
				            </div>
				            <div class="form-group">
				               <label for="imageAlt" class="col-sm-3 control-label">Attribute</label>
				               <div class="col-sm-9">
				                   <input name="imageAlt" id = "imageAlt" class="form-control titleCase"  placeholder="Enter image alt" tabindex="5" maxlength="100"/>
				                	<span class="text-danger"></span>
				               </div>
				            </div>
				            <div class="form-group">
				               <label for="imageDetail" class="col-sm-3 control-label">Options</label>
				               <div class="col-sm-9">
				                   <textarea name="imageDetail" id = "imageDetail"  class="form-control titleCase"  placeholder="Enter image detail" tabindex="5" maxlength="100"></textarea>
				                	<span class="text-danger"></span>
				               </div>
				            </div>
				            <div class="form-group" style="display: none;">
				               <label for="imageDetail" class="col-sm-3 control-label">Options</label>
				               <div class="col-sm-9">
				                   <textarea name="imageDetail" id = "imageDetail"  class="form-control titleCase"  placeholder="Enter image detail" tabindex="5" maxlength="100"></textarea>
				                	<span class="text-danger"></span>
				               </div>
				            </div>
				            <div class="form-group">
			                	<label for="active" class="col-sm-3 control-label">Allow Filter</label>
			                  <div class="col-sm-9" style="padding-top: 7px;">
			                    <input type="checkbox" name="allowfilter" class="padding-top" tabindex="10">
			                  </div>
			                </div>
			                <div class="form-group">
			                	<label for="active" class="col-sm-3 control-label">Show on product page</label>
			                  <div class="col-sm-9" style="padding-top: 7px;">
			                    <input type="checkbox" name="showonproductpage" class="padding-top" tabindex="10">
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
			            <button type="button" class="btn btn-default">Cancel</button>
			            <button type="button" id = "upload_product_picture" class="btn btn-primary pull-right "><i class="fa fa-floppy-o"></i> Update</button>
			        </div>
				</div>
				<%
			}
		}
	%>
</div>
<script src="js/common_js.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	// added by Amar, on load get attributes for this product
	getProductAttributeValues($("#attribute").val());
	
	// added by Amar, get attribute values on change attribute
	$(document).on("change","#attribute",function() {
		getProductAttributeValues($("#attribute").val());
	});
	
	// added by Amar, get attribute values for this attribute.
	function getProductAttributeValues(attributeId){
		if(attributeId != null && attributeId != ""){
			$.ajax({
				type : "GET",
				url : "getProductAttributeValues",
				data : {"attributeId" : attributeId},
				success : function(response) {
					$('#product_attribute_option option').remove();
					var json = JSON.parse(response);
					if(json.status==200){
						$.each(json.values, function(key,value) {
						  $('#product_attribute_option').append($('<option>', { 
						        value: value.attributeValueId,
						        text : value.attributeValue 
						  }));
						}); 
					}else{
						alertify.error(json.msg);
					}
				}
			});
		}
	}
	
	// added by amar, toggle attribute option and value on attribute change
	$(document).on("change","#attribute_type",function() {
		var value = $(this).val();
		if(value == "OPTIONS"){
			$("#div_attribute_option").show();
			$("#div_attribute_value").hide();
		}else{
			$("#div_attribute_option").hide();
			$("#div_attribute_value").show();
		}
	});
	
	
});
</script>