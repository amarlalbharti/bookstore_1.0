<%@page import="com.bookstore.util.CheckoutSteps"%>
<%@page import="com.bookstore.util.CustomerUtils"%>
<%@page import="com.bookstore.domain.CustomerAddress"%>
<%@page import="com.bookstore.domain.Registration"%>
<%@page import="com.bookstore.domain.Basket"%>
<%@page import="com.bookstore.util.ProductUtils"%>
<%@page import="com.bookstore.domain.Product"%>
<%@page import="com.bookstore.domain.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <meta charset="utf-8">
  <meta class="viewport" name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>
<body>
<%
	CustomerAddress editAddress = (CustomerAddress)request.getAttribute("editAddress");
	if(editAddress != null){
		%>
			<form class="row no-margin address_form">
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Address: <span class="required">*</span></label>
				<input class="form-control" id="shipping_address" type="text" value="<%= editAddress.getAddress() %>">
			  </div>
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Landmark: <span class="required">*</span></label>
				<input class="form-control" id="shipping_landmark" type="text" value="<%= editAddress.getLandmark() %>">
			  </div>
			  
			  <div class="clearfix"></div>
			  
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Street:</label>
				<input class="form-control" id="shipping_street" type="text" value="<%= editAddress.getCustomerStreet()%>">
			  </div>
			  <div class="col-sm-6 col-md-6 form-group">
				<label>City: <span class="required">*</span>
					<input type="hidden" id="customer_address_id" value="<%= editAddress.getCustomerAddressId()%>">
				</label>
				<select class="form-control "  id="shipping_city">
					<option value="<%= editAddress.getCustomerCity().getCityId() %>" selected="selected"><%= editAddress.getCustomerCity().getCityName() %></option>
				</select>
			  </div>
			  
			  <div class="clearfix"></div>
			  
			  <div class="col-sm-6 col-md-6 form-group">
				<label>State: <span class="required">*</span></label>
				<select class="form-control" id="shipping_state">
				  <option value="<%= editAddress.getCustomerCity().getState().getStateId() %>"><%= editAddress.getCustomerCity().getState().getStateName() %></option>
				</select>
			  </div>
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Country: <span class="required">*</span></label>
				<select class="form-control" id="shipping_country">
				  <option value="<%= editAddress.getCustomerCity().getState().getCountry().getCountryId() %>"><%= editAddress.getCustomerCity().getState().getCountry().getCountryName() %></option>
				</select>
			  </div>
			  <div class="clearfix"></div>
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Zip/Postal Code: <span class="required">*</span></label>
				<input class="form-control number_only" id="shipping_pin" type="text" value="<%= editAddress.getCustomerPinCode()%>">
			  </div>
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Contact: <span class="required">*</span></label>
				<input class="form-control number_only" id="shipping_contact" type="text" maxlength="10" value="<%= editAddress.getCustomerPhone()%>">
			  </div>
			  
			  <div class="clearfix"></div>
			</form>
		<%
	}else{
		%>
			<form class="row no-margin address_form">
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Address: <span class="required">*</span></label>
				<input class="form-control" id="shipping_address" type="text">
			  </div>
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Landmark: <span class="required">*</span></label>
				<input class="form-control" id="shipping_landmark" type="text">
			  </div>
			  
			  <div class="clearfix"></div>
			  
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Street:</label>
				<input class="form-control" id="shipping_street" type="text">
			  </div>
			  <div class="col-sm-6 col-md-6 form-group">
				<label>City: <span class="required">*</span></label>
				<select class="form-control "  id="shipping_city">
				</select>
			  </div>
			  
			  <div class="clearfix"></div>
			  
			  <div class="col-sm-6 col-md-6 form-group">
				<label>State: <span class="required">*</span></label>
				<select class="form-control" id="shipping_state">
				  <option value="0">Select State</option>
				</select>
			  </div>
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Country: <span class="required">*</span></label>
				<select class="form-control" id="shipping_country">
				  <option value="0" >Select Country</option>
				</select>
			  </div>
			  <div class="clearfix"></div>
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Zip/Postal Code: <span class="required">*</span></label>
				<input class="form-control number_only" id="shipping_pin" type="text">
			  </div>
			  <div class="col-sm-6 col-md-6 form-group">
				<label>Contact: <span class="required">*</span></label>
				<input class="form-control number_only" id="shipping_contact" type="text" maxlength="10">
			  </div>
			  
			  <div class="clearfix"></div>
			</form>
		<%
	}
%>

</body>
<script type="text/javascript">
$(document).ready(function(){
	 $('#shipping_city').select2({
	    dropdownParent: $("#addrressModal"),
		ajax : {
				url : "${pageContext.request.contextPath}/search/ceties",
				delay: 250,
				dataType: 'json',
				placeholder: 'Search city',
			    minimumInputLength: 1,
				data: function (params) {
			      var query = {
			        search: params.term
			      }
			      return query;
			    },
			    processResults: function (data) {
			    	return {
			          results: data.results
			        };
		        }
				
				
			}
		});

	 $(document).on("change","#shipping_city",function() {
		 	$(this).parent().removeClass("has-error");
			var cityid=$(this).val();
			$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/get/statecountry/"+cityid,
				data : {},
				success : function(response) {
					var json = JSON.parse(response);
					$('#shipping_state')
					    .find('option')
					    .remove()
					    .end()
					    .append('<option value="'+json.stateid+'">'+json.state+'</option>')
					    .val(json.stateid);
					
					$('#shipping_country')
				    .find('option')
				    .remove()
				    .end()
				    .append('<option value="'+json.countryid+'">'+json.country+'</option>')
				    .val(json.countryid);


				}
			});
		});
	 
});
</script>
</html>