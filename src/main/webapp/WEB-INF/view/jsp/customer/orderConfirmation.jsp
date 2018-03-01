<%@page import="com.bookstore.util.CustomerUtils"%>
<%@page import="com.bookstore.domain.OrderItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.bookstore.util.DateUtils"%>
<%@page import="com.bookstore.domain.ProductOrder"%>
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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <meta charset="utf-8">
  <meta class="viewport" name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>
<body>
<%
ProductOrder productOrder = (ProductOrder)request.getAttribute("productOrder");
%>
<div id="main" class="page">
  <div class="container">
    <div class="row">
    <%
    	if(productOrder != null){
    		%>
    			<article class="col-sm-12 col-md-12 content">
					<div class="my-account">
					  <div class="bottom-padding">
						<p>Thank you. Your order has been received.</p>
						<div class="alert alert-info">
						  <ul class="list-unstyled">
							<li>Order: <strong>#<%= productOrder.getProductOrderId() %></strong></li>
							<li>Date: <strong><%= DateUtils.clientFullformat.format(productOrder.getCreateDate()) %></strong></li>
							<li>Total: <strong><span class="amount"><i class="fa fa-inr" aria-hidden="true"></i> <%= productOrder.getFinalPrice() %></span></strong></li>
							<li>Payment method: <strong>COD</strong></li>
						  </ul>
						</div>
					  </div>
					  
					  <div class="bottom-padding">
						<div class="title-box">
						  <h2 class="title">Our Details</h2>
						</div>
						<div class="table-responsive">
						  <table class="table table-striped text-left order-details">
							<thead>
							  <tr>
								<th class="product-name">Product</th>
								<th class="product-total">Total</th>
							  </tr>
							</thead>
							<tbody>
								<%
									if(productOrder.getOrderItems() != null && !productOrder.getOrderItems().isEmpty()){
										Iterator it = productOrder.getOrderItems().iterator();
										while(it.hasNext()){
											OrderItem item = (OrderItem)it.next();
											%>
												<tr>
													<td class="product-name">
													  <a href="#"><%= item.getProduct().getProductName() %></a> <strong class="product-quantity">× <%= item.getQuantity() %></strong>
													</td>
													<td class="product-total"><span class="amount"><i class="fa fa-inr" aria-hidden="true"></i> <%=item.getProductPrice() * item.getQuantity()  %> </span></td>
												  </tr>
											<%
										}
										
									}
								
								%>
							  
							</tbody>
							<tfoot>
							  <tr>
								  <th>Cart Subtotal:</th>
								  <td><i class="fa fa-inr" aria-hidden="true"></i> <%= productOrder.getFinalPrice() %></td>
								</tr>
								<tr>
								  <th>Shipping:</th>
								  <td>Free Shipping</td>
								</tr>
								<tr>
								  <th>Order Total:</th>
								  <td><i class="fa fa-inr" aria-hidden="true"></i> <%= productOrder.getFinalPrice() %></td>
								</tr>
							</tfoot>
							
						  </table>
						</div>
					  </div>
					  
					  <div class="title-box">
						<h2 class="title">Customer Details</h2>
					  </div>
					  <p><strong>Email:</strong> <sec:authentication property="name"/></p>
					  <p><strong>Telephone:</strong> <%= productOrder.getCustomerPhone() %></p>
					  <div class="row">
						<div class="col-sm-6 col-md-6">
						  <h3 class="subtitle">Billing Address</h3>
						  <address>
							<%= productOrder.getShippingAddress() %>
						  </address>
						</div>
						
					  </div>
					</div>
			      </article>
    		<%
    	}else{
    		%>
    			<p>Sorry, Order Data not available</p>
    		<%
    	}
    %>
      
    </div>
  </div>
</div><!-- #main -->

</div><!-- .page-box-content -->
</div><!-- .page-box -->
<script type="text/javascript">
 $(document).ready(function(){
// 	 $.getCustomerCheckoutSteps();
	 
});
</script>
</body>
</html>