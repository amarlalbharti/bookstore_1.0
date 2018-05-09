$(document).ready(function(){
	var path = $("#root_path").val();
	
	jQuery.getAdminDashboardWidgets = function(){
	    $.ajax({
			type : "GET",
			url : path+"/admin/dashboard/widgets",
			data : {},
			statusCode: {
		        401: function(request, status, error) {
		        	alertify.alert("Your session has been expired !");
		        	$.redirectToLoginPage();
		        },
		    },
			success : function(response, textStatus, xhr) {
				var json = JSON.parse(response);
				if(json.hasOwnProperty('new_orders')){
					$(".dashboard_widgets .new_orders").html(json.new_orders);
				}
				if(json.hasOwnProperty('pending_orders')){
					$(".dashboard_widgets .pending_orders").html(json.pending_orders);
				}
				if(json.hasOwnProperty('registered_users')){
					$(".dashboard_widgets .registered_users").html(json.registered_users);
				}
				if(json.hasOwnProperty('avail_products')){
					$(".dashboard_widgets .avail_products").html(json.avail_products);
				}
			}
		});
	};
	
	
	
}); 
