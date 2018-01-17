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

<section id="main">
  <div class="container">
    <div class="carousel-box bottom-padding bottom-padding-mini load overflow" data-autoplay-disable="true">
	  <div class="title-box no-margin">
		<a class="next" href="#">
		  <svg x="0" y="0" width="9px" height="32px" viewBox="0 0 9 16" enable-background="new 0 0 9 16" xml:space="preserve">
			<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#fcfcfc" points="1,0.001 0,1.001 7,8 0,14.999 1,15.999 9,8 "></polygon>
		  </svg>
		</a>
		<a class="prev" href="#">
		  <svg x="0" y="0" width="9px" height="32px" viewBox="0 0 9 16" enable-background="new 0 0 9 16" xml:space="preserve">
			<polygon fill-rule="evenodd" clip-rule="evenodd" fill="#fcfcfc" points="8,15.999 9,14.999 2,8 9,1.001 8,0.001 0,8 "></polygon>
		  </svg>
		</a>
		<h2 class="title">Recommended Product</h2>
	  </div>
	  
	  <div class="clearfix"></div>
	  <div class="row">
	  	<div class="carousel products">
	  <%
	  	List<Product> productlist = (List<Product>)request.getAttribute("productlist");
	  	if(productlist != null && !productlist.isEmpty()){
	  		for(Product product : productlist){
	  			String productImage = product.getProductUrl() != null ? ProductUtils.getProductImageUrl(product) : ""; 
	  			%>
	  				
						
						  <div class="col-sm-3 col-md-3 double-product">
							<div class="product rotation">
							  <div class="default">
								<a href="${pageContext.request.contextPath}/<%= ProductUtils.getFriendlyUrl(product)%>" class="product-image">
								  <img src="<%= productImage%>" alt="<%= product.getProductName()%>" title="" width="270" height="270">
								</a>
								<div class="product-description">
								  <div class="vertical">
									<h3 class="product-name">
									  <a href="${pageContext.request.contextPath}/<%= ProductUtils.getFriendlyUrl(product)%>"><%= product.getProductName()%></a>
									</h3>
									<div class="price"><%= product.getProductPrice()%></div>	
								  </div>
								</div>
							  </div>
							  <div class="product-hover">
								<h3 class="product-name">
								  <a href="${pageContext.request.contextPath}/<%= ProductUtils.getFriendlyUrl(product)%>"><%= product.getProductName()%></a>
								</h3>
								<div class="price"><%= product.getProductPrice()%></div>
								<a href="${pageContext.request.contextPath}/<%= ProductUtils.getFriendlyUrl(product)%>" class="product-image">
								  <img class="replace-2x" src="<%= productImage%>" alt="<%= product.getProductName()%>" title="" width="70" height="70">
								</a>
								<ul>
								  <li>117 cm / 46"LCD TV</li>
								  <li>Full HD 3D &amp; 2D</li>
								  <li>Sony Internet TV</li>
								  <li>Dynamic Edge LED</li>
								  <li>1X-Reality PRO</li>
								</ul>
								<div class="actions">
								  <a href="${pageContext.request.contextPath}/<%= ProductUtils.getFriendlyUrl(product)%>" class="add-cart">
									<svg x="0" y="0" width="16px" height="16px" viewBox="0 0 16 16" enable-background="new 0 0 16 16" xml:space="preserve">
									  <g>
										<path fill="#1e1e1e" d="M15.001,4h-0.57l-3.707-3.707c-0.391-0.391-1.023-0.391-1.414,0c-0.391,0.391-0.391,1.023,0,1.414L11.603,4
										H4.43l2.293-2.293c0.391-0.391,0.391-1.023,0-1.414s-1.023-0.391-1.414,0L1.602,4H1C0.448,4,0,4.448,0,5s0.448,1,1,1
										c0,2.69,0,7.23,0,8c0,1.104,0.896,2,2,2h10c1.104,0,2-0.896,2-2c0-0.77,0-5.31,0-8c0.553,0,1-0.448,1-1S15.554,4,15.001,4z
										M13.001,14H3V6h10V14z"></path>
										<path fill="#1e1e1e" d="M11.001,13c0.553,0,1-0.447,1-1V8c0-0.553-0.447-1-1-1s-1,0.447-1,1v4C10.001,12.553,10.448,13,11.001,13z"></path>
										<path fill="#1e1e1e" d="M8,13c0.553,0,1-0.447,1-1V8c0-0.553-0.448-1-1-1S7,7.447,7,8v4C7,12.553,7.448,13,8,13z"></path>
										<path fill="#1e1e1e" d="M5,13c0.553,0,1-0.447,1-1V8c0-0.553-0.447-1-1-1S4,7.447,4,8v4C4,12.553,4.448,13,5,13z"></path>
									  </g>
									</svg>
								  </a>
								  <a href="#" class="add-wishlist">
									<svg x="0" y="0" width="16px" height="16px" viewBox="0 0 16 16" enable-background="new 0 0 16 16" xml:space="preserve">
									  <path fill="#1e1e1e" d="M11.335,0C10.026,0,8.848,0.541,8,1.407C7.153,0.541,5.975,0,4.667,0C2.088,0,0,2.09,0,4.667C0,12,8,16,8,16
									  s8-4,8-11.333C16.001,2.09,13.913,0,11.335,0z M8,13.684C6.134,12.49,2,9.321,2,4.667C2,3.196,3.197,2,4.667,2C6,2,8,4,8,4
									  s2-2,3.334-2c1.47,0,2.666,1.196,2.666,2.667C14.001,9.321,9.867,12.49,8,13.684z"></path>
									</svg>
								  </a>
								  <a href="#" class="add-compare">
									<svg x="0" y="0" width="16px" height="16px" viewBox="0 0 16 16" enable-background="new 0 0 16 16" xml:space="preserve">
									  <path fill="#1e1e1e" d="M16,3.063L13,0v2H1C0.447,2,0,2.447,0,3s0.447,1,1,1h12v2L16,3.063z"></path>
									  <path fill="#1e1e1e" d="M16,13.063L13,10v2H1c-0.553,0-1,0.447-1,1s0.447,1,1,1h12v2L16,13.063z"></path>
									  <path fill="#1e1e1e" d="M15,7H3V5L0,7.938L3,11V9h12c0.553,0,1-0.447,1-1S15.553,7,15,7z"></path>
									</svg>
								  </a>
								</div><!-- .actions -->
							  </div><!-- .product-hover -->
							</div><!-- .product -->
						  </div>
						  
						
					  
	  			<%
	  		}
	  	}
	  
	  %>
	  	</div>
	  </div>
	</div><!-- .carousel-box -->
    
    <div class="products-tab bottom-padding bottom-padding-mini">
	  <ul class="nav nav-tabs">
		<li class="active"><a href="#best-sellers2">Best Sellers</a></li>
		<li><a href="#new-products2">New Products</a></li>
		<li><a href="#related-products2">Related Products</a></li>
	  </ul>
	  
	  <div class="tab-content">
		<div class="tab-pane active row fade in text-center" id="best-sellers2">
		  <div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Network Media Player</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Head Mounted Display</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Smart TV 3D</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Network Media Player</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Smart TV 3D</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product

		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Head Mounted Display</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product -->
		</div>
		
		<div class="tab-pane row fade in text-center" id="new-products2">
		  <div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Network Media Player</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Head Mounted Display</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Smart TV 3D</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Network Media Player</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Smart TV 3D</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product

		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Head Mounted Display</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product -->
		</div>
		
		<div class="tab-pane row fade in text-center" id="related-products2">
		  <div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Network Media Player</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Head Mounted Display</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Smart TV 3D</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Network Media Player</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product
		  
		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Smart TV 3D</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product

		  --><div class="product product-mini col-sm-2 col-md-2">
			<div class="default">
			  <a href="shop-product-view.html" class="product-image">
				<img class="replace-2x" src="images/product_preview.png" alt="" title="" width="270" height="270">
			  </a>
			  <div class="product-description">
				<div class="vertical">
				  <h3 class="product-name">
					<a href="shop-product-view.html">Head Mounted Display</a>
				  </h3>
				  <div class="price">$1, 449.00</div>	
				</div>
			  </div>
			</div>
		  </div><!-- .product -->
		</div>
	  </div>
	</div><!-- .products-tab -->
    
  </div>
</section><!-- #main -->





</div><!-- .page-box-content -->
</div><!-- .page-box -->

</body>
</html>