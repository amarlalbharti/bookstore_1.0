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
			  <h6 class="text-uppercase">LogIn <%= passedSteps != null && passedSteps.contains(CheckoutSteps.LOGIN) ? "<i class=\"fa fa-check text-info \"></i>" : "" %></h6>
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
			  <h6 class="text-uppercase">Shipping Information <%= passedSteps != null && passedSteps.contains(CheckoutSteps.SHIPPINGINFO) ? "<i class=\"fa fa-check text-info\"></i>" : "" %></h6>
			</a>
			
			<div id="step-2" class="collapse <%= step.equalsIgnoreCase(CheckoutSteps.SHIPPINGINFO.name()) ? "in" : "" %>">
			  <div class="step-content shippinginfo">
				<%
					if(step.equalsIgnoreCase(CheckoutSteps.SHIPPINGINFO.name())){
						if(customerAddresses != null && !customerAddresses.isEmpty()){
							%>
								<form class="row no-margin form-horizontal">
							<%
							for(CustomerAddress address : customerAddresses){
								%>
									<div class="radio">
									  <label>
										<input type="radio" name="customer_address" value="<%= address.getCustomerAddressId()%>"  <%= address.isActive() ? "checked" : ""%>>
										<%= CustomerUtils.getCustomerAddressValue(address)%>
									  </label>
									</div>
								<%
							}
							%>
							  <div class="clearfix"></div>
							  <div class="col-sm-12 buttons-box text-right" style="margin-top: 30px;">
								<button class="btn btn-primary text-uppercase select_customer_address" type="button">Continue Checkout</button>
							  </div>
							</form>
						<%
							
						}else{
							%>
								<form class="row no-margin">
								  <div class="col-sm-6 col-md-6">
									<label>Address: <span class="required">*</span></label>
									<input class="form-control" type="text">
								  </div>
								  <div class="col-sm-6 col-md-6">
									<label>Landmark: <span class="required">*</span></label>
									<input class="form-control" type="text">
								  </div>
								  
								  <div class="clearfix"></div>
								  
								  <div class="col-sm-6 col-md-6">
									<label>Street:</label>
									<input class="form-control" type="text">
								  </div>
								  <div class="col-sm-6 col-md-6">
									<label>City: <span class="required">*</span></label>
									<select class="form-control " id="select2_city">
									</select>
								  </div>
								  
								  <div class="clearfix"></div>
								  
								  <div class="col-sm-6 col-md-6">
									<label>Zip/Postal Code: <span class="required">*</span></label>
									<input class="form-control" type="text">
								  </div>
								  <div class="col-sm-6 col-md-6">
									<label>Country</label>
									<select class="form-control">
									  <option>India</option>
									</select>
								  </div>
								  
								  <div class="clearfix"></div>
								  
								  <div class="col-sm-12 buttons-box text-right">
									<button class="btn btn-primary text-uppercase save_customer_address" type="button">Save & Continue Checkout</button>
									<span class="required"><b>*</b> Required Field</span>
								  </div>
								</form>
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
			  <h6 class="text-uppercase">Order Review <%= passedSteps != null && passedSteps.contains(CheckoutSteps.PRODUCTREVIEW) ? "<i class=\"fa fa-check text-info\"></i>" : "" %></h6>
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

</div><!-- .page-box-content -->
</div><!-- .page-box -->
<script type="text/javascript">
$(document).ready(function(){
	 $('#select2_city').select2({
		ajax : {
				url : "${pageContext.request.contextPath}/search/ceties",
				delay: 250,
				dataType: 'json',
				placeholder: 'Search for a repository',
			    minimumInputLength: 1,
				data: function (params) {
			      var query = {
			        search: params.term,
			        page: params.page || 1
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
	
});
</script>
</body>
</html>