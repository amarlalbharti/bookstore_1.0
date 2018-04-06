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
List<Basket> baskets = (List)request.getAttribute("baskets");
%>
<div id="main" class="page">
  <div class="container checkout">
    <div class="row">
      <div id="checkout-steps">
      	<article class="content col-sm-9 col-md-9">
      		<%
      			if(baskets == null || baskets.isEmpty()){
      				%>
      					<p>No Items available in Cart. Please add in cart to continue.</p>
      					<a href="${pageContext.request.contextPath}/index" class ="btn btn-info ">Continue Shopping</a>
      				<%
      			}
      		%>
      	</article>
	  </div>
	  <%
		if(baskets != null && !baskets.isEmpty()){
			%>
			
		      <div id="sidebar" class="col-sm-3 col-md-3 sidebar checkout-progress">
				<aside class="widget">
				  <header>
					<h3 class="title">Price Details</h3>
				  </header>
				  <%
				  	if(baskets != null && !baskets.isEmpty()){
				  		Double total = 0.0;
				  		int itemCount = 0;
				  		for(Basket basket : baskets){
				  			itemCount++;
				  			total += basket.getQuantity() * basket.getProduct().getProductPrice();
				  		}
				  		%>
				  		  <ul class="progress-list">
							<li>Price (<%=itemCount%> Items) <span class="pull-right"><i class="fa fa-inr" aria-hidden="true"></i> <%=total%></span></li>
							<li>Shipping Charge <span class="pull-right"><i class="fa fa-inr" aria-hidden="true"></i> 0</span></li>
							<li style="font-weight: bold;">Amount Payable<span class="pull-right"><i class="fa fa-inr" aria-hidden="true"></i> <%=total%></span></li>
						  </ul>
				  		<%
				  	}
				  %>
				  
				</aside>
		      </div><!-- .sidebar -->
      		<%
		}
	%>
    </div>
  </div>
</div><!-- #main -->

</div><!-- .page-box-content -->
</div><!-- .page-box -->
<script src="${pageContext.request.contextPath}/js/common_js.js"></script>
<script type="text/javascript">
 $(document).ready(function(){
	 <%
		if(baskets != null && !baskets.isEmpty()){
			%>
			$.getCustomerCheckoutSteps();
			<%
		}
	%>
	 
});
</script>
</body>
</html>