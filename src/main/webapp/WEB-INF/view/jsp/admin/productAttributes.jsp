<%@page import="com.bookstore.enums.AttributeType"%>
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
      <th width="30px" style="text-align: center;">#</th>
      <th width="20%" >Attribute Name</th>
      <th width="20%">Attribute Value</th>
      <th width="10%" style="text-align: center;">Allow Filter</th>
      <th width="15%" style="text-align: center;">Show on product page</th>
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
	    		int count=0;
	    		for(ProductAttribute productAttribute : productAttributes){
	    			String attrValue = "";
	    			if(productAttribute.getAttributeValue()!= null && productAttribute.getAttributeType().equals(AttributeType.OPTIONS.name())){
	    				attrValue = productAttribute.getAttributeValue().getAttributeValue() ;
	    			}else if(productAttribute.getAttributeCustomValue() != null){
	    				attrValue = productAttribute.getAttributeCustomValue();
	    			}else{
	    				continue;
	    			}
    				%>
	    				<tr>
	    				  <td style="text-align: center;"><%= ++count %></td>
				          <td><%= productAttribute.getAttribute().getAttributeName() %></td>
				          <td><%= attrValue %></td>
				          <td style="text-align: center;"><%= productAttribute.isAllowFilter()  ? "<i class=\"fa fa-check text-primary\"></i>" : "<i class=\"fa fa-close text-danger\"></i>"%></td>
				          <td style="text-align: center;"><%= productAttribute.isShowOnProductPage() ? "<i class=\"fa fa-check text-primary\"></i>" : "<i class=\"fa fa-close text-danger\"></i>" %></td>
				          <td style="text-align: center;"><%= productAttribute.getDisplayOrder() %></td>
				          <td style="text-align: center;">
				          	<button type="button" class="btn btn-flat btn-sm btn-primary" product_attribute_id="<%= productAttribute.getProductAttributeId() %>" id="edit_product_attribute"><i class="fa fa-fw fa-edit"></i> Edit</button>
				          	<button type="button" class="btn btn-flat btn-sm btn-danger" product_attribute_id="<%= productAttribute.getProductAttributeId() %>" id="delete_product_attribute"><i class="fa fa-fw fa-close"></i> Delete</button>
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
			            <div class="form-group" id="div_allow_filter">
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
			          <input type="hidden" id="product_attribute" value="<%= editProductAttribute.getProductAttributeId()%>">
			        </div>
					<div class="box-body">
						<div>
							<div class="form-group">
				               <label for="attribute_type" class="col-sm-3 control-label">Attribute Type</label>
				               <div class="col-sm-9">
				                    <select class="form-control col-md-12 select2" name="attribute_type" id="attribute_type">
				                    	<option value="OPTIONS" ${editProductAttribute.attributeType == "OPTIONS" ? 'selected':''}>Options</option>
				                    	<option value="CUSTOM_TEXT" ${editProductAttribute.attributeType == "CUSTOM_TEXT" ? 'selected':''}>Custom Text</option>
				                    	<option value="CUSTOM_HTML_TEXT" ${editProductAttribute.attributeType == "CUSTOM_HTML_TEXT" ? 'selected':''}>Custom HTML Text</option>
				                    	<option value="HYPERLINK" ${editProductAttribute.attributeType == "HYPERLINK" ? 'selected':''}>Hyperlink</option>
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
				            				if(attribute.getAttributeId() == editProductAttribute.getAttribute().getAttributeId()){
					            				%>
					            					<option value="<%= attribute.getAttributeId()%>" selected><%= attribute.getAttributeName()%></option>
					            				<%
				            				}else{
					            				%>
					            					<option value="<%= attribute.getAttributeId()%>"><%= attribute.getAttributeName()%></option>
					            				<%
				            				}
				            			}
				            		}
									%>
				                   </select>
				                   <span class="text-danger" id="attribute_error"></span>
				               </div>
				            </div>
				            <div class="form-group" id="div_attribute_option" style="display:<% if(editProductAttribute.getAttributeType().equals(AttributeType.OPTIONS.name())){out.print("block");}else{out.print("none"); }%>" >
				               <label for="attributeOption" class="col-sm-3 control-label">Attribute Option</label>
				               <div class="col-sm-9">
				                   <select class="form-control select2" name="product_attribute_option" id="product_attribute_option" sel_option="<% if(editProductAttribute.getAttributeValue()!= null){out.print(editProductAttribute.getAttributeValue().getAttributeValueId());}else{out.print(""); }%>">
				                   </select> 
				                   <span class="text-danger" id="product_attribute_option_error"></span>
				               </div>
				            </div>
				            <div class="form-group" id="div_attribute_value" style="display:<% if(!editProductAttribute.getAttributeType().equals(AttributeType.OPTIONS.name())){out.print("block");}else{out.print("none"); }%>" >
				               <label for="attribute_value" class="col-sm-3 control-label">Attribute Value</label>
				               <div class="col-sm-9">
				                   <input name="product_attribute_value" id = "product_attribute_value" value="${editProductAttribute.attributeCustomValue}" class="form-control titleCase"  placeholder="Enter attribute value" tabindex="5"/>
				                	<span class="text-danger" id = "product_attribute_value_error"></span>
				               </div>
				            </div>
				            <div class="form-group"  id="div_allow_filter" style="display:<% if(editProductAttribute.getAttributeType().equals(AttributeType.OPTIONS.name())){out.print("block");}else{out.print("none"); }%>" >
			                	<label for="active" class="col-sm-3 control-label">Allow Filter</label>
			                  <div class="col-sm-9" style="padding-top: 7px;">
			                    <input type="checkbox" ${editProductAttribute.allowFilter ? 'checked':'' } name="allow_filter" id="allow_filter" class="padding-top" tabindex="10">
			                  </div>
			                </div>
			                <div class="form-group">
			                	<label for="active" class="col-sm-3 control-label">Show on product page</label>
			                  <div class="col-sm-9" style="padding-top: 7px;">
			                    <input type="checkbox" ${editProductAttribute.showOnProductPage ? 'checked':'' } name="show_on_product_page" id="show_on_product_page" class="padding-top" tabindex="10">
			                  </div>
			                </div>
				            <div class="form-group">
				               <label for="imageOrder" class="col-sm-3 control-label">Display Order</label>
				               <div class="col-sm-9">
				                   <input name="attribute_order" id = "attribute_order"  class="form-control number_only" type="number" placeholder="Enter attribute order" value="<%= editProductAttribute.getDisplayOrder() %>" tabindex="5" />
				                	<span class="text-danger" id = "attribute_order_error" ></span>
				               </div>
				            </div>
						</div>
					</div>
					<div class="box-footer">
			            <button type="button" id="save_product_attribute" value="update" class="btn btn-primary pull-right "><i class="fa fa-floppy-o"></i> Update</button>
			          </div>
				</div>
				<%
			}
		}
	%>
</div>
<script src="${pageContext.request.contextPath}/js/common_js.js"></script>
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
			var sel_option = $("#product_attribute_option").attr("sel_option");
			$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/admin/getProductAttributeValues",
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
						if(sel_option != undefined && sel_option != ""){
							$("#product_attribute_option").val(sel_option);
						}
// 						$('#product_attribute_option option[value=sel_option]').attr('selected','selected');
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
			$("#div_allow_filter").show();
			$("#div_attribute_value").hide();
		}else{
			$("#div_attribute_option").hide();
			$("#div_allow_filter").hide();
			$("#div_attribute_value").show();
		}
	});
	
	
});
</script>