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
 
	$(document).on("click","#addrressModal .save_customer_address",function() {
		var submitButton = $(this);
		submitButton.addClass("disabled");
		var address = $(".address_form #shipping_address").val();
		var landmark = $(".address_form #shipping_landmark").val();
		var street = $(".address_form #shipping_street").val();
		var city = $(".address_form #shipping_city").val();
		var state = $(".address_form #shipping_state").val();
		var country = $(".address_form #shipping_country").val();
		var pin = $(".address_form #shipping_pin").val();
		var contact = $(".address_form #shipping_contact").val();
		var action = $(".address_form #customer_action").val();
		var caid = $(".address_form #customer_address_id").val();
		var isValid = true;
		$(".address_form .has-error").removeClass("has-error");
		if($.trim(address) == ""){
		 	$(".address_form #shipping_address").parent().addClass("has-error");
			isValid = false;
		}
		if($.trim(landmark) == ""){
			$(".address_form #shipping_landmark").parent().addClass("has-error");
			isValid = false;
		}
		if($.trim(city) == ""){
			$(".address_form #shipping_city").parent().addClass("has-error");
			isValid = false;
		}
		if($.trim(pin) == ""){
			$(".address_form #shipping_pin").parent().addClass("has-error");
			isValid = false;
		}
		if($.trim(contact) == "" || !ContactNo(contact)){
			$(".address_form #shipping_contact").parent().addClass("has-error");
			isValid = false;
		}
		if(isValid){
			$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/secure/customeraddress/add",
				data : {address: address, landmark: landmark, street: street, city: city, state: state, country: country, pin: pin, contact: contact,action:action, caid:caid},
				success : function(response) {
					var json = JSON.parse(response);
					if(json.status == "loggedout"){
						$.redirectToLoginPage();
					}else if(json.status == "success"){
		 				alertify.success(json.msg);
		 				setTimeout(function(){ location.reload(); }, 3000);
		 			 }else{
		 				alertify.error(json.msg);
		 				submitButton.addClass("disabled");
		 			 }

				}
			});
		}else{
			submitButton.removeClass("disabled");
		}
	});
	
	$(document).on("click","#add_addrress_popup",function() {
	 	$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/secure/customeraddress/addnew",
			data : {action:"add"},
			statusCode: {
		        401: function(request, status, error) {
		        	alertify.error("Your session has been expired !");
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
		        	alertify.error("Your session has been expired !");
		        	$.redirectToLoginPage();
		        },
		        400: function(request, status, error) {
		        	alertify.error("Request with bad data!");
		        	setTimeout(function(){ location.reload(); }, 3000);
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