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
		        403: function(request, status, error) {
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
	
	jQuery.getAdminDashboardLatestOrders = function(){
		$(".latest_orders_box .overlay").show();
	    $.ajax({
			type : "GET",
			url : path+"/admin/dashboard/latest/order",
			data : {},
			statusCode: {
		        401: function(request, status, error) {
		        	alertify.alert("Your session has been expired !");
		        	$.redirectToLoginPage();
		        },
		        403: function(request, status, error) {
		        	alertify.alert("Your session has been expired !");
		        	$.redirectToLoginPage();
		        },
		    },
			success : function(response, textStatus, xhr) {
				var json = JSON.parse(response);
				var table = $("#latest_orders_table");
				table.find("tr:gt(0)").remove();
				if(json.ordersList != undefined){
					 var jsonArray = json.ordersList;
					 $.each( json.ordersList, function(i, obj) {
				          var row = $("<tr />");
				          var productOrderId = $("<td />").html(obj.productOrderId);
				          row.append(productOrderId);
				          var customerName = $("<td />").html(obj.customerName);
				          row.append(customerName);
				          var totalItems = $("<td />").html(obj.totalItems);
				          row.append(totalItems);
				          var finalPrice = $("<td />").html(obj.finalPrice);
				          row.append(finalPrice);
				          var statusclass= $("<span class='label'/>");
				          statusclass.addClass(obj.orderStatusClass);
				          statusclass.html(obj.orderStatus);
				          var orderStatus = $("<td />").html(statusclass);
				          row.append(orderStatus);
				          var createDate = $("<td />").html(obj.createDate);
				          row.append(createDate);
				          
				          table.append(row);
					 });
				}
				$(".latest_orders_box .overlay").hide();
			}
		});
	};
	
	
	$(document).on("click","#refresh_latest_orders_table",function() {
		$.getAdminDashboardLatestOrders();
	});
	
	
	jQuery.getAdminDashboardSales = function(active_tab){
		$(".sales_chart_box .overlay").show();
	    $.ajax({
			type : "GET",
			url : path+"/admin/dashboard/sales",
			data : {tab : active_tab},
			statusCode: {
		        401: function(request, status, error) {
		        	alertify.alert("Your session has been expired !");
		        	$.redirectToLoginPage();
		        },
		        403: function(request, status, error) {
		        	alertify.alert("Your session has been expired !");
		        	$.redirectToLoginPage();
		        },
		    },
			success : function(response, textStatus, xhr) {
				var json = JSON.parse(response);
				
			    $.plot('#bar-chart', [json.data_array], {
			      grid  : {
			        borderWidth: 1,
			        borderColor: '#f3f3f3',
			        tickColor  : '#f3f3f3'
			      },
			      series: {
			        bars: {
			          show    : true,
			          barWidth: 0.5,
			          align   : 'center'
			        }
			      },
			      xaxis : {
			        mode      : 'categories',
			        tickLength: 0
			      }
			    })
			    
				$(".sales_chart_box .overlay").hide();
			}
		});
	};
	
	$(document).on("click","#refresh_sales_charts",function() {
		var active_sales_chart = $(".sales_chart_box #active_sales_chart").val();
		$.getAdminDashboardSales(active_sales_chart);
	});
	
	
	$(document).on("click",".sales_chart_box .sales_btns .btn",function() {
		$(".sales_chart_box .sales_btns .btn").removeClass("btn-info");
		$(this).addClass("btn-info");
		
		var sel_btn = $(this).attr("data-sales");
		$(".sales_chart_box #active_sales_chart").val(sel_btn);
		$.getAdminDashboardSales(sel_btn);
	});
	
	
	
	
	jQuery.getProductOrdersList = function(){
		$.ajax({
			type : "GET",
			url : path+"/admin/sales/orders/list",
			data : {},
			statusCode: {
		        401: function(request, status, error) {
		        	alertify.alert("Your session has been expired !");
		        	$.redirectToLoginPage();
		        },
		        403: function(request, status, error) {
		        	alertify.alert("Your session has been expired !");
		        	$.redirectToLoginPage();
		        },
		    },
			success : function(response, textStatus, xhr) {
				var json = JSON.parse(response);
				
			    
			}
		});
	};
	
	
	
}); 
