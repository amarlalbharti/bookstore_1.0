$(document).ready(function(){
	
	jQuery.getCustomerCartHeader = function(path){
	    alert("Hello from JS call");
	    $.ajax({
			type : "GET",
			url : path+"/customer/cart/header",
			data : {},
			success : function(response) {
				alert(response);
				 $("#customer_cart_header").html(response);
			}
		});
	};
}); 
