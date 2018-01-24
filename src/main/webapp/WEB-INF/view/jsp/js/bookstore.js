$(document).ready(function(){
	var path = $("#root_path").val();
	jQuery.getCustomerCartHeader = function(){
	    $.ajax({
			type : "GET",
			url : path+"/customer/cart/header",
			data : {},
			success : function(response, status, code) {
				alert(code);
				$("#customer_cart_header").html(response);
				$(".top-header .count").text($("#basket_size").val());
			}
		});
	};
	
	$(document).on("click",".products .product .add-cart",function() {
		var pid=$(this).attr("pid");
		$.ajax({
			type : "GET",
			url : path+"/customer/cart/add/"+pid,
			data : {},
			success : function(response) {
				var json = JSON.parse(response);
	 			 if(json.status == "success"){
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
			url : path+"/customer/cart/remove/"+basketId,
			data : {},
			success : function(response) {
				var json = JSON.parse(response);
	 			 if(json.status == "success"){
	 				 alertify.success(json.msg);
	 				 $.getCustomerCartHeader();
	 			 }else{
	 				alertify.error(json.msg);
	 			 }
			}
		});
	});
	
	
}); 
