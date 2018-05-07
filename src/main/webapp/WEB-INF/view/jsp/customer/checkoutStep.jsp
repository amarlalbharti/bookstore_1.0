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
Registration registration = (Registration)request.getAttribute("registration");
List<CustomerAddress> customerAddresses = (List) request.getAttribute("customerAddresses");
String step = (String)request.getAttribute("step");
if(!CustomerUtils.isValidCheckoutStep(step)){
	response.sendRedirect(request.getContextPath()+"/customer/checkout");
}
List<CheckoutSteps> passedSteps = (List)request.getAttribute("passedSteps");
%>

      <article class="content col-sm-9 col-md-9">
		<ul id="checkoutsteps" class="clearfix panel-group">
		  <li class="panel">
			<a href="#step" class="step-title <%= passedSteps != null && passedSteps.contains(CheckoutSteps.LOGIN) ? "collapsed" : "" %>" data-parent="#checkoutsteps" >
			  <div class="number">1</div>
			  <h6 class="text-uppercase">LogIn <%= passedSteps != null && passedSteps.contains(CheckoutSteps.LOGIN) ? "<i class=\"fa fa-check text-info \"></i>" : "" %>
			  	<small><%= passedSteps != null && passedSteps.contains(CheckoutSteps.LOGIN) ? registration.getFirstName() +" " + registration.getLastName() : "" %></small>
			  	<%
			  		if(!step.equalsIgnoreCase(CheckoutSteps.LOGIN.name()) && passedSteps.contains(CheckoutSteps.LOGIN)){
			  			%>
			  				<button class="btn btn-primary btn-sm pull-right change_login_user" style="margin-top: 10px">Change</button>
			  			<%
			  		}
			  	%>
			  </h6>
			</a>
			<div id="step-1" class="collapse <%= step.equalsIgnoreCase(CheckoutSteps.LOGIN.name()) ? "in" : "" %> ">
			  <div class="step-content">
				<div class="row">
				  <div class="col-sm-6 col-md-6 bottom-padding-mobile">
					<%
						if(registration != null){
							%>
								<form class="row margin-bottom">
								  <div class="col-sm-12 col-md-12">
									<label>Name: <%= registration.getFirstName() +" " + registration.getLastName()%></label>
								  </div>
								  <div class="col-sm-12 col-md-12">
									<label>Email: <%= registration.getLoginInfo().getUserid()%></label>
								  </div>
								  <div class="col-sm-12 col-md-12">
									<label>
										<a href="#" onclick="getLogOut();" class="margin-top">Logout and login with another account</a>
									</label>
								  </div>
								 </form>
								 <button class="btn btn-primary text-uppercase checkoutstep_login" type="button">Continue Checkout</button>
								 
							<%
						}
					%>
					
				  </div>
				  <div class="col-sm-6 col-md-6">
					
				  </div>
				</div>
			  </div>
			</div>
		  </li>
		  <li class="panel">
			<a href="#step" class="step-title <%= passedSteps != null && passedSteps.contains(CheckoutSteps.SHIPPINGINFO) ? "collapsed" : "" %>" data-parent="#checkoutsteps" >
			  <div class="number">2</div>
			  <h6 class="text-uppercase">Shipping Information <%= passedSteps != null && passedSteps.contains(CheckoutSteps.SHIPPINGINFO) ? "<i class=\"fa fa-check text-info\"></i>" : "" %>
			  	<%
			  		if(!step.equalsIgnoreCase(CheckoutSteps.SHIPPINGINFO.name())  && passedSteps.contains(CheckoutSteps.SHIPPINGINFO)){
			  			%>
			  				<button class="btn btn-primary btn-sm pull-right change_shipping_info" style="margin-top: 10px">Change</button>
			  			<%
			  		}
			  	%>
			  </h6>
			</a>
			
			<div id="step-2" class="collapse <%= step.equalsIgnoreCase(CheckoutSteps.SHIPPINGINFO.name()) ? "in" : "" %>">
			  <div class="step-content shippinginfo">
				<%
					if(step.equalsIgnoreCase(CheckoutSteps.SHIPPINGINFO.name())){
						if(customerAddresses != null && !customerAddresses.isEmpty()){
							%>
							<form class="row no-margin form-horizontal">
								<table class="table table-bordered table-striped">
									<thead>
										<tr>
											<th>Customer Address</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
									<%
									for(CustomerAddress address : customerAddresses) {
										%>
											<tr>
												<td class="text-left">
													<div class="radio">
													  <label>
														<input type="radio" name="customer_address" value="<%= address.getCustomerAddressId()%>"  <%= address.isActive() ? "checked" : ""%>>
														<%= CustomerUtils.getShippingAddressValue(address)%>
													  </label>
													</div>
												</td>
												<td>
													<button class="btn btn-sm btn-default" type="button" id="edit_addrress_popup" data-caid="<%= address.getCustomerAddressId()%>">Edit</button>
												</td>
											</tr>
										<%
									}
									%>
									</tbody>
								</table>
							  <div class="clearfix"></div>
							  <div class="col-sm-12 buttons-box text-right" style="margin-top: 30px;">
								<button class="btn btn-primary text-uppercase select_customer_address" type="button">Continue Checkout</button>
								<button class="btn btn-info" type="button"  id="add_addrress_popup">Add New</button>
							  </div>
							</form>
						<%
							
						}else{
							%>
								<button class="btn btn-sm btn-info" type="button" id="add_addrress_popup">Add New</button>
							<%
						}
					}
					
				%>
			  </div>
			</div>
		  </li>
		  <li class="panel">
			<a href="#step" class="step-title <%= passedSteps != null && passedSteps.contains(CheckoutSteps.PRODUCTREVIEW) ? "collapsed" : "" %>" data-parent="#checkoutsteps" >
			  <div class="number">3</div>
			  <h6 class="text-uppercase">Order Review <%= passedSteps != null && passedSteps.contains(CheckoutSteps.PRODUCTREVIEW) ? "<i class=\"fa fa-check text-info\"></i>" : "" %>
			  <%
			  		if(!step.equalsIgnoreCase(CheckoutSteps.PRODUCTREVIEW.name()) && passedSteps.contains(CheckoutSteps.PRODUCTREVIEW)){
			  			%>
			  				<button class="btn btn-primary btn-sm pull-right check_product_view" style="margin-top: 10px">Check</button>
			  			<%
			  		}
			  	%>
			  </h6>
			</a>
			
			<div id="step-5" class="collapse <%= step.equalsIgnoreCase(CheckoutSteps.PRODUCTREVIEW.name()) ? "in" : "" %>">
			  <div class="step-content">
				<div class="table-responsive">
				  <table class="table table-bordered table-striped">
					<thead>
					  <tr>
						<th>Product Name</th>
						<th>Price</th>
						<th>Qty</th>
						<th>Subtotal</th>
					  </tr>
					</thead>
					<tbody>
					<%
						List<Basket> baskets = (List)request.getAttribute("baskets");
						double subtotal = 0;
						if(baskets != null && !baskets.isEmpty()){
							for(Basket basket : baskets){
								subtotal+= (basket.getQuantity() * basket.getProduct().getProductPrice());
								%>
									<tr>
										<td><%= basket.getProduct().getProductName() %></td>
										<td><i class="fa fa-inr" aria-hidden="true"></i> <%= basket.getProduct().getProductPrice() %></td>
										<td><%= basket.getQuantity() %></td>
										<td><i class="fa fa-inr" aria-hidden="true"></i> <%= basket.getQuantity() * basket.getProduct().getProductPrice() %></td>
									</tr>
								<%
							}
						}
					%>
					
 					  <tr>
						<td colspan="3">Subtotal</td>
						<td><i class="fa fa-inr" aria-hidden="true"></i> <%= subtotal %></td>
					  </tr>
					  <tr>
						<td colspan="3">Shipping & Handling (Flat Rate - Fixed)</td>
						<td><i class="fa fa-inr" aria-hidden="true"></i> 0.0</td>
					  </tr>
					  <tr>
						<td colspan="3">Grand Total</td>
						<td><i class="fa fa-inr" aria-hidden="true"></i> <%= subtotal %></td>
					  </tr>
					</tbody>
				  </table>
				</div>
				
				<button class="btn btn-primary text-uppercase continue_product_review" type="button">Continue Checkout</button>
			  </div>
			</div>
		  </li>
		  <li class="panel">
			<a href="#step" class="step-title <%= passedSteps != null && passedSteps.contains(CheckoutSteps.PAYMENTINFO) ? "collapsed" : "" %>" data-parent="#checkoutsteps" >
			  <div class="number">4</div>
			  <h6 class="text-uppercase">Payment Information <%= passedSteps != null && passedSteps.contains(CheckoutSteps.PAYMENTINFO) ? "<i class=\"fa fa-check text-info\"></i>" : "" %></h6>
			</a>
			
			<div id="step-4" class="collapse  <%= step.equalsIgnoreCase(CheckoutSteps.PAYMENTINFO.name()) ? "in" : "" %>">
			  <div class="step-content">
				<form>
				  <div>
					<label class="radio"><input type="radio" name="register" checked="checked"> COD</label>
				  </div>
				</form>
				
				<div class="buttons-box text-right">
				  <a href="${pageContext.request.contextPath}/customer/placeorder" class="btn btn-default">Place Order</a>
				  <span class="required"><b>*</b> Required Field</span>
				</div>
			  </div>
			</div>
		  </li>
		  
		</ul><!-- #checkoutsteps -->
      </article><!-- .content -->
<div class="modal fade" id="addrressModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="popup_header_label">Add Customer Address</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="popup_button">Save changes</button>
      </div>
    </div>
  </div>
</div>
</div><!-- .page-box-content -->
</div><!-- .page-box -->
<script type="text/javascript">
$(document).ready(function(){
	 $('#shipping_city').select2({
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
	 
	 $(document).on("click",".shippinginfo .addnew_customer_address",function() {
		 	$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/secure/customeraddress/addnew",
				data : {},
				statusCode: {
			        401: function(request, status, error) {
			        	alert("Your session has been expired !");
			        	$.redirectToLoginPage();
			        },
			    },
				success : function(response) {
					$("#checkoutsteps .shippinginfo").html(response);
					
				}
			});
		});
	 
	 $(document).on("click","#add_addrress_popup",function() {
		 	$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/secure/customeraddress/addnew",
				data : {action:"add"},
				statusCode: {
			        401: function(request, status, error) {
			        	alert("Your session has been expired !");
			        	$.redirectToLoginPage();
			        },
			    },
				success : function(response) {
					$("#addrressModal .modal-body").html(response);
					$("#addrressModal #popup_header_label").html("Add Customer Address");
					$('#addrressModal .select2-container ').css('width', '100%');
					$("#addrressModal .modal-footer #popup_button").addClass("save_customer_address");
					$('#addrressModal').modal('show');
					
				}
			});
		});
	 
	 $(document).on("click","#edit_addrress_popup",function() {
		 	var addressid = $(this).attr("data-caid"); 
		 	$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/secure/customeraddress/addnew",
				data : {action:"edit",addressId:addressid},
				statusCode: {
			        401: function(request, status, error) {
			        	alert("Your session has been expired !");
			        	$.redirectToLoginPage();
			        },
			    },
				success : function(response) {
					$("#addrressModal .modal-body").html(response);
					$("#addrressModal #popup_header_label").html("Update  Customer Address");
					$('#addrressModal .select2-container ').css('width', '100%');
					$("#addrressModal .modal-footer #popup_button").addClass("save_customer_address");
					$('#addrressModal').modal('show');
					
				}
			});
		});
	 
	 
	 
	 
	 
	 
});
</script>
</body>
</html>