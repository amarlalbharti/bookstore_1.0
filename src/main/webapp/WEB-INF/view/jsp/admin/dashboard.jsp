<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dashboard
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <!-- Small boxes (Stat box) -->
      <div class="row dashboard_widgets">
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3 class="new_orders">0</h3>

              <p>New Orders</p>
            </div>
            <div class="icon">
              <i class="ion ion-bag"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-green">
            <div class="inner">
              <h3 class="pending_orders">0</h3>

              <p>Pending Orders</p>
            </div>
            <div class="icon">
              <i class="ion ion-ios-stopwatch"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3 class="registered_users">0</h3>

              <p>Registered Users</p>
            </div>
            <div class="icon">
              <i class="ion ion-person-add"></i>
            </div>
            <a href="${pageContext.request.contextPath}/admin/customers" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-red">
            <div class="inner">
              <h3 class="avail_products">0</h3>
              <p>Products</p>
            </div>
            <div class="icon">
              <i class="ion ion-pie-graph"></i>
            </div>
            <a href="${pageContext.request.contextPath}/admin/products" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
      </div>
      <!-- /.row -->
      <!-- Main row -->
      <div class="row">
        <!-- Left col -->
        <section class="col-lg-7 connectedSortable">
          <div class="box box-info latest_orders_box">
            <div class="box-header with-border">
              <h3 class="box-title">Latest Orders</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="table-responsive">
                <table class="table no-margin" id="latest_orders_table">
                  <thead>
                  <tr>
                    <th>Order ID</th>
                    <th>Customer Name</th>
                    <th>Items</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Order Time</th>
                  </tr>
                  </thead>
                  <tbody>
                  
                  </tbody>
                </table>
              </div>
              <!-- /.table-responsive -->
            </div>
            <div class="overlay">
              <i class="fa fa-refresh fa-spin"></i>
            </div>
            <!-- /.box-body -->
            <div class="box-footer clearfix">
              <button id="refresh_latest_orders_table" class="btn btn-sm  pull-right"><i class="fa fa-refresh"></i> Reload</button>
              <a href="javascript:void(0)" class="btn btn-sm btn-primary btn-flat pull-left">View All Orders</a>
            </div>
          </div>
        </section>
        <!-- /.Left col -->
        <!-- right col (We are only adding the ID to make the widgets sortable)-->
        <section class="col-lg-5 connectedSortable">

          <!-- Map box -->
          <div class="box box-info sales_chart_box">
            <div class="box-header with-border">
              <i class="fa fa-bar-chart-o"></i>

              <h3 class="box-title">Sales</h3>

              <div class="box-tools pull-right">
              	<div class="btn-group sales_btns">
              		<input type="hidden" id="active_sales_chart" value="WEEK">
	              	<button class="btn btn-xs btn-info" data-sales="WEEK">Week</button>
	              	<button class="btn btn-xs" data-sales="MONTH">Month</button>
	              	<button class="btn btn-xs" data-sales="YEAR">Year</button>
              	</div>
              </div>
            </div>
            <div class="box-body">
              <div id="bar-chart" style="height: 300px;"></div>
            </div>
            <div class="overlay">
              <i class="fa fa-refresh fa-spin"></i>
            </div>
            <div class="box-footer clearfix">
              <button id="refresh_sales_charts" class="btn btn-sm  pull-right"><i class="fa fa-refresh"></i> Reload</button>
              <a href="javascript:void(0)" class="btn btn-sm btn-primary btn-flat pull-left">View All Orders</a>
            </div>
            <!-- /.box-body-->
          </div>
        </section>
        <!-- right col -->
      </div>
      <!-- /.row (main row) -->

    </section>
    <!-- /.content -->
  </div>
</body>
<!-- FLOT CHARTS -->
<script src="${pageContext.request.contextPath}/js/flot/jquery.flot.min.js"></script>
<!-- FLOT RESIZE PLUGIN - allows the chart to redraw when the window is resized -->
<script src="${pageContext.request.contextPath}/js/flot/jquery.flot.resize.min.js"></script>
<script src="${pageContext.request.contextPath}/js/flot/jquery.flot.pie.min.js"></script>
<script src="${pageContext.request.contextPath}/js/flot/jquery.flot.categories.min.js"></script>
<script language=javascript type='text/javascript'>
	$(document).ready(function(){
		$.getAdminDashboardWidgets();
		$.getAdminDashboardLatestOrders();
		$.getAdminDashboardSales();
    });
	
</script>
</html>