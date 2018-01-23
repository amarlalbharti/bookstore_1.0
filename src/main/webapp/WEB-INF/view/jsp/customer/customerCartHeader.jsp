<%@page import="com.bookstore.util.ProductUtils"%>
<%@page import="com.bookstore.domain.Basket"%>
<%@page import="com.bookstore.model.AttributeModel"%>
<%@page import="com.bookstore.domain.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
<%
	List<Basket> basketList = (List)request.getAttribute("basketList");
	int totalPrice = 0;
	int cartSize = 0;
	if(basketList != null && !basketList.isEmpty()){
		  cartSize = basketList.size();
		  for(Basket basket : basketList){
			  totalPrice += basket.getQuantity()*basket.getProduct().getProductPrice();
		  }
	}
%>
<a href="#" class="dropdown-toggle" data-toggle="dropdown">
  <div class="icon">
	<svg x="0" y="0" width="16px" height="16px" viewBox="0 0 16 16" enable-background="new 0 0 16 16" xml:space="preserve">
	  <g>
		<path d="M15.001,4h-0.57l-3.707-3.707c-0.391-0.391-1.023-0.391-1.414,0c-0.391,0.391-0.391,1.023,0,1.414L11.603,4
		H4.43l2.293-2.293c0.391-0.391,0.391-1.023,0-1.414s-1.023-0.391-1.414,0L1.602,4H1C0.448,4,0,4.448,0,5s0.448,1,1,1
		c0,2.69,0,7.23,0,8c0,1.104,0.896,2,2,2h10c1.104,0,2-0.896,2-2c0-0.77,0-5.31,0-8c0.553,0,1-0.448,1-1S15.554,4,15.001,4z
		M13.001,14H3V6h10V14z"></path>
		<path d="M11.001,13c0.553,0,1-0.447,1-1V8c0-0.553-0.447-1-1-1s-1,0.447-1,1v4C10.001,12.553,10.448,13,11.001,13z"></path>
		<path d="M8,13c0.553,0,1-0.447,1-1V8c0-0.553-0.448-1-1-1S7,7.447,7,8v4C7,12.553,7.448,13,8,13z"></path>
		<path d="M5,13c0.553,0,1-0.447,1-1V8c0-0.553-0.447-1-1-1S4,7.447,4,8v4C4,12.553,4.448,13,5,13z"></path>
	 </g>
	</svg>
	<input type="hidden" id="basket_size" value="<%=cartSize%>">
  </div>
  
  Cart <i class="fa fa-inr" aria-hidden="true"></i> <%= totalPrice %></span>
</a>
<div class="dropdown-menu">
	<%
		if(basketList != null && !basketList.isEmpty()){
			%>
				<strong>Recently added item(s)</strong>
				<ul class="list-unstyled cart-items" style="max-height: 200px;overflow:auto;">
					<%
						for(Basket basket : basketList){
							String productImage = basket.getProduct().getProductUrl() != null ? ProductUtils.getProductImageUrl(basket.getProduct()) : ""; 
							%>
								<li>
								  <a href="shop-product-view.html" class="product-image"><img class="replace-2x" src="<%= productImage %>" width="70" height="70" alt=""></a>
								  <a href="javascript:void(0);" class="product-remove" bid="<%= basket.getBasketId() %>">
									<svg x="0" y="0" width="16px" height="16px" viewBox="0 0 16 16" enable-background="new 0 0 16 16" xml:space="preserve">
									  <g>
										<path d="M6,13c0.553,0,1-0.447,1-1V7c0-0.553-0.447-1-1-1S5,6.447,5,7v5C5,12.553,5.447,13,6,13z"></path>
										<path d="M10,13c0.553,0,1-0.447,1-1V7c0-0.553-0.447-1-1-1S9,6.447,9,7v5C9,12.553,9.447,13,10,13z"></path>
										<path d="M14,3h-1V1c0-0.552-0.447-1-1-1H4C3.448,0,3,0.448,3,1v2H2C1.447,3,1,3.447,1,4s0.447,1,1,1
										c0,0.273,0,8.727,0,9c0,1.104,0.896,2,2,2h8c1.104,0,2-0.896,2-2c0-0.273,0-8.727,0-9c0.553,0,1-0.447,1-1S14.553,3,14,3z M5,2h6v1
										H5V2z M12,14H4V5h8V14z"></path>
									  </g>
									</svg>
								  </a><!-- .product-remove -->
								  <h4 class="product-name"><a href="#" title=""><%= basket.getProduct().getProductName() %></a></h4>
								  <div class="product-price"><%= basket.getQuantity() %> x <span class="price"><%= basket.getProduct().getProductPrice() %></span></div>
								  <div class="clearfix"></div>
								</li>
							<%
						}
					%>
					</ul>
					<div class="cart-button">
						<button class="btn btn-default">View Cart</button>
						<button class="btn checkout btn-default">Checkout</button>
					</div>
		<%
		}else{
			%>
				<strong>No Items Available in cart.</strong>
			<%
		}
	%>
	  
	  
	</div>
</body>
</html>