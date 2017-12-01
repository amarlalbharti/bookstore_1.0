<%@page import="com.bookstore.domain.Attribute"%>
<%@page import="com.bookstore.domain.AttributeValue"%>
<%@page import="com.bookstore.config.ProjectConfig"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.domain.ProductImage"%>
<%@page import="com.bookstore.domain.Product"%>
<div>
<%
Attribute attribute = (Attribute)request.getAttribute("attribute");
if(attribute != null){
%>
<div class="col-md-8">
  <table class="table table-bordered table-hover table-striped">
    <thead>
    <tr class="bg-primary">
      <th width="45%">Attribute Value</th>
      <th width="15%">Display Order</th>
      <th width="40%" style="text-align: center;">Action</th>
    </tr>
    </thead>
    <tbody>
    <%	AttributeValue editAttributeValue = (AttributeValue)request.getAttribute("editAttributeValue");
    	
	    	List<AttributeValue> attributeValues = (List)request.getAttribute("attributeValueList");
	    	if(attributeValues != null && !attributeValues.isEmpty()){
	    		for(AttributeValue attributeValue : attributeValues){
    				%>
	    				<tr>
	    				  <td><%= attributeValue.getAttributeValue() %></td>
				          <td><%= attributeValue.getDisplayOrder()%></td>
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
    	
    %>
    
    </tbody>
  </table>
  </div>
  <div class="col-sm-4">
	<%
		if(editAttributeValue == null){
	%>
			<div class="box box-primary box-solid form-horizontal">
				<div class="box-header with-border">
		          <h3 class="box-title">Add Attribute Value</h3>
		        </div>
				<div class="box-body">
					<div class="form-group">
		               <label for="attribute_value" class="col-sm-3 control-label"><%= attribute.getAttributeName() %></label>
		               <div class="col-sm-9">
		                   <input name="attribute_value" id = "attribute_value" class="form-control titleCase"  placeholder="Enter attribute value" tabindex="5"/>
		                	<span class="text-danger"></span>
		               </div>
		            </div>
		            <div class="form-group">
		               <label for="display_order" class="col-sm-3 control-label">Display Order</label>
		               <div class="col-sm-9">
		                   <input name="display_order" id = "display_order" class="form-control number_only" type="number" value="0" placeholder="Enter display order" tabindex="10"/>
		                	<span class="text-danger"></span>
		               </div>
		            </div>
				</div>
				<div class="box-footer">
		            <button type="button" id="save_attribute_value" class="btn btn-primary pull-right "><i class="fa fa-floppy-o"></i> Save</button>
		          </div>
			</div>
			<%
			}else{
				%>
				<div class="box box-primary box-solid form-horizontal" >
					<div class="box-header with-border">
			          <h3 class="box-title">Update Attribute Value</h3>
			        </div>
					<div class="box-body">
						<div class="form-group">
			               <label for="attribute_value" class="col-sm-3 control-label">Attribute Value</label>
			               <div class="col-sm-9">
			               		<input type="hidden" name="attribute_value_id" id="attribute_value_id" value="<%= editAttributeValue.getAttributeValueId()%>"/>
			                   <input name="attribute_value" id = "attribute_value" class="form-control titleCase" value="<%=editAttributeValue.getAttributeValue() %>"  placeholder="Enter attribute value" tabindex="5"/>
			                   <span class="text-danger"></span>
			               </div>
			            </div>
			            <div class="form-group">
			               <label for="display_order" class="col-sm-3 control-label">Display Order</label>
			               <div class="col-sm-9">
			                   <input name="display_order" id = "display_order" class="form-control number_only" type="number" value="<%= editAttributeValue.getDisplayOrder() %>" placeholder="Enter display order" tabindex="10"/>
			                	<span class="text-danger"></span>
			               </div>
			            </div>
					</div>
					<div class="box-footer">
			            <button type="button" id="refesh_attribute_value" class="btn btn-default"><i class="fa fa-undo" aria-hidden="true"></i> Reset</button>
			            <button type="button" id = "save_attribute_value" class="btn btn-primary pull-right"><i class="fa fa-floppy-o"></i> Update</button>
			        </div>
				</div>
				<%
			}
		%>
		</div>
		<%
		}else{
    		%>
			Attribute not saved !
			<%
    	}
	%>
</div>