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
	
	
	
	
	jQuery.getProductOrdersList = function(pn, rpp){
		$.ajax({
			type : "GET",
			url : path+"/admin/sales/orders/list",
			data : {pn:pn, rpp:rpp},
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
				$(".orders .overlay").show();
				$("#orders_list #orders_rpp").val(json.rpp);
				$(".orders #order_paginate_label").html("Showing page "+ json.pn + " of "+ json.total_pages);
				$(".orders .order_pagi .curr_page").html(json.pn);
				if(json.pn > 1){
					$(".orders .order_pagi .previous").attr("data-dt-idx", json.pn-1);
					$(".orders .order_pagi .previous").removeClass("disabled");
				}else{
					$(".orders .order_pagi .previous").addClass("disabled");
				}
				if(json.pn < json.total_pages){
					$(".orders .order_pagi .next").attr("data-dt-idx", json.pn+1);
					$(".orders .order_pagi .next").removeClass("disabled");
				}else{
					$(".orders .order_pagi .next").addClass("disabled");
				}
				
				
				var table = $(".orders #orders_table");
				table.find("tr:gt(0)").remove();
				if(json.product_orders != undefined){
					 var jsonArray = json.product_orders;
					 
					 
					 $.each( json.product_orders, function(i, obj) {
				          var row = $("<tr />");
				          var checkbox = $("<td />").html("<input type='checkbox' >");
				          row.append(checkbox);
				          var productOrderId = $("<td />").html(obj.transaction_id);
				          row.append(productOrderId);
				          
				          var statusclass= $("<span class='label'/>");
				          statusclass.addClass(obj.order_status_label);
				          statusclass.html(obj.order_status);
				          
				          var order_status = $("<td />").html(statusclass);
				          row.append(order_status);
				          var payment_status = $("<td />").html(obj.payment_status);
				          row.append(payment_status);
				          var customer = $("<td />").html(obj.customer);
				          row.append(customer);
				          
				          
				          var store = $("<td />").html(store);
				          row.append(store);
				          var create_date = $("<td />").html(obj.create_date);
				          row.append(create_date);
				          var total_order = $("<td />").html(obj.total_order);
				          row.append(total_order);
				          var actions = $("<td />").html("<a class='btn btn-xs btn-primary' href='"+path+"/admin/order/"+obj.transaction_id+"'>View </a>");
				          row.append(actions);
				          
				          table.append(row);
					 });
				}
				$(".orders .overlay").hide();
			}
		});
	};
	
	$(document).on("click",".orders .order_pagi .next",function() {
		var pn = $(this).attr("data-dt-idx");
		var rpp = $("#orders_list #orders_rpp").val();
		$.getProductOrdersList(pn, rpp);
	});
	
	$(document).on("click",".orders .order_pagi .previous",function() {
		var pn = $(this).attr("data-dt-idx");
		var rpp = $("#orders_list #orders_rpp").val();
		$.getProductOrdersList(pn, rpp);
	});
	
	$(document).on("click",".orders #refresh_orders_table",function() {
		var pn = $(".orders .order_pagi .curr_page").html();
		var rpp = $("#orders_list #orders_rpp").val();
		$.getProductOrdersList(pn, rpp);
	});
	
	
	
}); 
