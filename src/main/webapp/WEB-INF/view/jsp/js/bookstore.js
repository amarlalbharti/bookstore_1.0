$(document).ready(function(){
	var path = $("#root_path").val();
	
	jQuery.getCustomerCartHeader = function(){
	    $.ajax({
			type : "GET",
			url : path+"/secure/cart/header",
			data : {},
			statusCode: {
		        401: function(request, status, error) {
		        	alertify.alert("Your session has been expired !");
		        	$.redirectToLoginPage();
		        },
		    },
			success : function(response, textStatus, xhr) {
				$("#customer_cart_header").html(response);
				$(".top-header .count").text($("#basket_size").val());
			}
		});
	};
	
	jQuery.getCustomerCheckoutSteps = function(step){
	    $.ajax({
			type : "GET",
			url : path+"/secure/checkout/steps",
			data : {step:step},
			success : function(response, textStatus, xhr) {
				$(".checkout #checkout-steps").html(response);
			}
		});
	};
	
	jQuery.redirectToLoginPage = function(){
		window.location.replace(path+"/login");
	};
	
	
	
	
	
	$(document).on("click",".products .product .add-cart",function() {
		var pid=$(this).attr("pid");
		$.ajax({
			type : "GET",
			url : path+"/secure/cart/add/"+pid,
			data : {},
			success : function(response) {
				
				var json = JSON.parse(response);
				if(json.status == "loggedout"){
					$.redirectToLoginPage();
				}else if(json.status == "success"){
	 				 alertify.success(json.msg);
	 				 $.getCustomerCartHeader();
	 			 }else{
	 				alertify.error(json.msg);
	 			 }
			}
		});
	});
	
	$(document).on("click",".cart-items li .product-remove",function() {
		var basketId=$(this).attr("bid");
		$.ajax({
			type : "GET",
			url : path+"/secure/cart/remove/"+basketId,
			data : {},
			success : function(response) {
				var json = JSON.parse(response);
				if(json.status == "loggedout"){
					$.redirectToLoginPage();
				}else if(json.status == "success"){
	 				 alertify.success(json.msg);
	 				 $.getCustomerCartHeader();
	 			 }else{
	 				alertify.error(json.msg);
	 			 }
			}
		});
	});
	
	
	$(document).on("change","#shopping-cart-table .basket-quantity",function() {
		var basket_quantity=$(this).val();
		var bid=$(this).attr("bid");
		if($.isNumeric(basket_quantity) && basket_quantity > 0 && $.isNumeric(bid) && bid > 0){
			$.ajax({
			type : "GET",
			url : path+"/secure/cart/update/"+bid,
			data : {basket_quantity : basket_quantity},
			success : function(response) {
				var json = JSON.parse(response);
				if(json.status == "loggedout"){
					$.redirectToLoginPage();
				}else if(json.status == "success"){
	 				 alertify.success(json.msg);
	 				 $(".td-total ."+bid).text(json.total_price);
	 				 $(".total #cart_subtotal").text(json.subtotal);
	 				 $(".total #cart_total").text(json.total);
	 				 $.getCustomerCartHeader();
	 			 }else{
	 				alertify.error(json.msg);
	 			 }
				}
			});
		}
	});
	
	$(document).on("click","#shopping-cart-table .td-remove .product-remove",function() {
		var basketRow = $(this);
		var basketId=$(this).attr("bid");
		$.ajax({
			type : "GET",
			url : path+"/secure/cart/remove/"+basketId,
			data : {},
			success : function(response) {
				var json = JSON.parse(response);
				if(json.status == "loggedout"){
					$.redirectToLoginPage();
				}else if(json.status == "success"){
	 				 alertify.success(json.msg);
	 				 basketRow.closest("tr").remove();
	 				 $(".total #cart_subtotal").text(json.subtotal);
	 				 $(".total #cart_total").text(json.total);
	 				 $.getCustomerCartHeader();
	 			 }else{
	 				alertify.error(json.msg);
	 			 }
			}
		});
	});
	
	// checout steps
	$(document).on("click","#checkoutsteps  .checkoutstep_login",function() {
		$.getCustomerCheckoutSteps("SHIPPINGINFO");
	});
	
	$(document).on("click","#checkoutsteps .select_customer_address",function() {
		var addr_id = $('input[name=customer_address]:checked').val();
		if(addr_id != undefined){
			$.ajax({
				type : "GET",
				url : path+"/secure/customeraddress/update/"+addr_id,
				data : {},
				success : function(response) {
					var json = JSON.parse(response);
					if(json.status == "loggedout"){
						$.redirectToLoginPage();
					}else if(json.status == "success"){
						$.getCustomerCheckoutSteps("PRODUCTREVIEW");
		 			 }else{
		 				alertify.error(json.msg);
		 			 }
				}
			});
		}
	});
	
	$(document).on("click","#checkoutsteps .continue_product_review",function() {
		$.getCustomerCheckoutSteps("PAYMENTINFO");
	});
	$(document).on("click","#checkoutsteps .change_login_user",function() {
		$.getCustomerCheckoutSteps("LOGIN");
	});
	$(document).on("click","#checkoutsteps .change_shipping_info",function() {
		$.getCustomerCheckoutSteps("SHIPPINGINFO");
	});
	$(document).on("click","#checkoutsteps .check_product_view",function() {
		$.getCustomerCheckoutSteps("PRODUCTREVIEW");
	});
	
	
	
	
}); 
