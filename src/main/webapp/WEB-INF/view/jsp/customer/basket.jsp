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
<div id="main" class="page">
  <header class="page-header">
    <div class="container">
      <h1 class="title">Shopping Cart</h1>
    </div>	
  </header>
  
  <div class="container">
    <div class="row">
      <article class="content col-sm-12 col-md-12">
		<div class="table-box">
		  <table id="shopping-cart-table" class="shopping-cart-table table table-bordered table-striped">
			<thead>
			  <tr>
				<th>Picture</th>
				<th class="td-name">Product Name</th>
				<th class="td-price">Unit Price</th>
				<th class="td-qty">Qty</th>
				<th class="td-total">Subtotal</th>
				<th class="td-remove"></th>
			  </tr>
			</thead>
			<tbody>
			<%
				double subtotel = 0;
				double totel = 0;
				
				List<Basket> basketList = (List)request.getAttribute("basketList");
				if(basketList != null && !basketList.isEmpty()){
					for(Basket basket : basketList){
						subtotel += (basket.getQuantity() * basket.getProduct().getProductPrice());
						totel += (basket.getQuantity() * basket.getProduct().getProductPrice());
						String productImage = basket.getProduct().getProductUrl() != null ? ProductUtils.getProductImageUrl(basket.getProduct()) : "";
						%>
							<tr>
								<td class="td-images">
								  <a href="shop-product-view.html" class="product-image">
									<img class="replace-2x" src="<%= productImage %>" alt="" title="" width="70" height="70">
								  </a>
								</td>
								<td class="td-name">
								  <h2 class="product-name">
									<a href="shop-product-view.html"><%= basket.getProduct().getProductName() %></a>
								  </h2>
								</td>
								<td class="td-price">
								  <div class="price"><i class="fa fa-inr" aria-hidden="true"></i><%= basket.getProduct().getProductPrice() %></div>
								</td>
								<td class="td-qty">
								  <input class="form-control natural_numbers_only basket-quantity " bid="<%= basket.getBasketId() %>" type="text" value="<%= basket.getQuantity() %>">
								</td>
								<td class="td-total">
								  <div class="price"><i class="fa fa-inr" aria-hidden="true"></i> <span class="<%= basket.getBasketId() %>"> <%= basket.getQuantity() * basket.getProduct().getProductPrice() %></span></div>
								</td>
								<td class="td-remove">
								  <a href="javascript:void(0);" class="product-remove" bid="<%= basket.getBasketId() %>">
									<svg x="0" y="0" width="16px" height="16px" viewBox="0 0 16 16" enable-background="new 0 0 16 16" xml:space="preserve">
									  <g>
										<path fill="#7f7f7f" d="M6,13c0.553,0,1-0.447,1-1V7c0-0.553-0.447-1-1-1S5,6.447,5,7v5C5,12.553,5.447,13,6,13z"></path>
										<path fill="#7f7f7f" d="M10,13c0.553,0,1-0.447,1-1V7c0-0.553-0.447-1-1-1S9,6.447,9,7v5C9,12.553,9.447,13,10,13z"></path>
										<path fill="#7f7f7f" d="M14,3h-1V1c0-0.552-0.447-1-1-1H4C3.448,0,3,0.448,3,1v2H2C1.447,3,1,3.447,1,4s0.447,1,1,1
										c0,0.273,0,8.727,0,9c0,1.104,0.896,2,2,2h8c1.104,0,2-0.896,2-2c0-0.273,0-8.727,0-9c0.553,0,1-0.447,1-1S14.553,3,14,3z M5,2h6v1
										H5V2z M12,14H4V5h8V14z"></path>
									  </g>
									</svg>
								  </a><!-- .product-remove -->
								</td>
							  </tr>
						<%
					}
				}else{
					%>
						<tr>
							<td colspan="6">No products in you cart !</td>
						</tr>
					<%
				}
				%>
				
			  
			</tbody>
		  </table><!-- .shopping-cart-table -->
		</div>
		<table class="shopping-cart-table shopping-cart-table-button table">
		  <tbody>
			<tr>
			  <td class="action no-border">
				<a href="#"><i class="fa fa-angle-left"></i> Continue Shopping</a>
				<a href="#" class="update"><i class="fa fa-rotate-right"></i> Update Shopping Cart</a>
			  </td>
			</tr>
		  </tbody>
		</table>
	
		<div id="car-bottom" class="row">
		  <div class="col-sm-12 col-md-4">
			<div class="car-bottom-box bg">
			  <h5>Estimate Shipping and Tax</h5>
			  <p>Enter your destination to get a shipping estimate.</p>
			  <label>Country: <span class="required">*</span></label>
			  <select name="" class="form-control">
				<option value="">United States</option>
				<option value="">United States</option>
				<option value="">United States</option>
			  </select>
			  <label>State/Province: <span class="required">*</span></label>
			  <select name="" class="form-control">
				<option value="">Please select region, state or province</option>
				<option value="">Please select region, state or province</option>
				<option value="">Please select region, state or province</option>
			  </select>
			  <label>Zip/Postal Code: <span class="required">*</span></label>
			  <input class="form-control" type="text">
			  <button class="btn btn-default">Get a Quote</button>
			</div>
		  </div>
		  
		  <div class="col-sm-12 col-md-4">
			<div class="car-bottom-box bg">
			  <h5>Discount Codes</h5>
			  <p>Enter your coupon code if you have one.</p>
			  <input class="form-control" type="text" placeholder="Please select region, state or province">
			  <button class="btn btn-default">Apply Coupon</button>
			</div>
		  </div>
		  
		  <div class="col-sm-12 col-md-4">
			<div class="car-bottom-box bg total">
			  <table>
				<tbody>
				  <tr>
					<td>Subtotal</td>
					<td><span class="price"><i class="fa fa-inr" aria-hidden="true"></i> <span id="cart_subtotal"><%= subtotel %></span></span></td>
				  </tr>
				  <tr class="tr-total">
					<td>Grand Total</td>
					<td><span class="price"><i class="fa fa-inr" aria-hidden="true"></i> <span id="cart_total"><%= subtotel %></span> </span></td>
				  </tr>
				</tbody>
			  </table>
			  <div>
				<a href="${pageContext.request.contextPath}/customer/checkout" class="btn checkout btn-default btn-lg">Proceed to Checkout</a>
			  </div>
			</div>
		  </div>
		</div>
		
      </article><!-- .content -->
    </div>
  </div>
</div><!-- #main -->

</div><!-- .page-box-content -->
</div><!-- .page-box -->

</body>
</html>