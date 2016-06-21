<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Payroll"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    
    <!-- Main content -->
    <section class="content">
		
      <!-- Your Page Content Here -->
		<div class="row">
				<div class="col-xs-12 col-md-12">
				<%
					String status = (String)request.getParameter("status");
					String dStatus = (String)request.getParameter("dStatus");
				
				    if(status != null)
				    {
				    	if(status.equals("success"))
						{
				    	%>
				    		<div class="alert alert-success alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Success !
								</h4>
								New Payroll add successfully !
							</div>
				    	<%
						}
				    	else if(status.equals("edit"))
						{
				    	%>
				    		<div class="alert alert-success alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Success !
								</h4>
								Payroll Update successfully !
							</div>
				    	<%
						}
				    	else if(status.equals("failed"))
						{
				    	%>
				    		<div class="alert alert-danger alert-dismissible">
									<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
									<h4>
										<i class="icon fa  fa-remove"></i> Failed !
									</h4>
									Oops, Opration failed ! Invalid values.
								</div>
				    	<%
						} else if(status.equals("exists")){
				    	%>
				    		<div class="alert alert-danger alert-dismissible">
									<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
									<h4>
										<i class="icon fa  fa-remove"></i> Failed !
									</h4>
									Payroll for this month is already exist !
								</div>
				    	<%
						} else if(status.equals("reg_error")) {
				    	%>
				    		<div class="alert alert-danger alert-dismissible">
									<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
									<h4>
										<i class="icon fa  fa-remove"></i> Failed !
									</h4>
									Oops, Opration failed ! Registration data not available.
								</div>
				    	<%
						}
				    }
			    	%>
	    		<div id="dlt" style="display: none" class="alert alert-success alert-dismissible">
					<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
					<h4>
						<i class="icon fa fa-check"></i> Success !
					</h4>
					Payroll delete successfully !
				</div>
			</div>
			<div class="col-xs-12 col-md-12">
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Payroll List</small>
       					</h3>
       					<div class="box-tools pull-right">
				         <div class="pull-right " style="padding-left: 20px;">
				         	<button class="btn btn-primary btn-sm adPay"><i class="fa fa-fw fa-user-plus"></i> Add Payroll</button>
				         	&nbsp;
				         	<a href="viewPayrollReport"><button class="btn btn-primary btn-sm"><i class="fa fa-book"></i>  View Report</button></a>
				         </div>
				       </div>
					</div>
					<div class="box-body table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th width="2%">S.n.</th>
									<th width="15%">Employee Name</th>
									<th width="6%">Basic Sal</th>
									<th width="10%">Designation</th>
									<th width="10%">Pay Month</th>
									<th width="5%">Earning</th>
									<th width="5%">Deduction</th>
									<th width="5%">Net Pay</th>
									<th width="10%" class="text-center">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
								List<Payroll> pList = (List)request.getAttribute("pList");
								if(pList != null && !pList.isEmpty())
								{
									int i = 1;
									for(Payroll pr : pList)
									{
										%>
											<tr>
												<td><%= i++ %></td>
												<td><%= pr.getRegistration().getName() %> </td>
												<td><%= pr.getBasicSal() %> </td>
												<td><%= pr.getRegistration().getDesignation().getDesignation() %> </td>
												<td><%= DateFormats.MMMformat().format(pr.getPayMonth()) %></td>
												<td><%= pr.getTotelEarning() %> </td>
												<td><%= pr.getTotelDeduction() %> </td>
												<td><%= pr.getNetPay() %></td>
												<td class="text-center"> 
												<a id="<%=pr.getPid() %>" class="btn btn-primary btn-xs edit" href="#" ><i class="fa fa-fw fa-edit"></i> Edit</a>
												&nbsp;
												<a id="<%=pr.getPid() %>" class="btn btn-danger btn-xs dlt" href="#" ><i class="fa fa-fw fa-remove"></i> Delete</a>
												</td>
											</tr>
										<%
									}
								}
								else
								{
									%>
										<tr>
											<td colspan="9">No data in the data source.</td>
										</tr>
									<%
								}
							%>
							</tbody>
						</table>
					</div>
				</div>
				
			</div>
		</div>
		
    </section>
    <!-- /.content -->
  </div>
  <script type="text/javascript">
	function validateForm()
	{
// 		alert('Add Payroll clicked');
		var pId = $("#pId").val();
		var eId = $("#eId").val();
		var bSal = $("#bSal").val();
		var hrAlwnc = $("#hrAlwnc").val();
		var trnspAlwnc = $("#trnspAlwnc").val();
		var lveTrvlAlwnc = $("#lveTrvlAlwnc").val();
		var splAlwnc = $("#splAlwnc").val();
		
		var salAdv = $("#salAdv").val();
		var pf = $("#pf").val();
		var tds = $("#tds").val();
		var otDed = $("#otDed").val();
		var food = $("#food").val();
		var rent = $("#rent").val();
		
		
		var tlEr = $("#tlEr").val();
		var tlDd = $("#tlDd").val();
		var ntPay = $("#ntPay").val();
		var payMonth = $("#payMonth").val();
		

		var valid = true;
		$('.has-error').removeClass("has-error");
		
		if(eId == "")
		{
			$("#eId").parent().addClass("has-error")
			valid = false;
		}
		
		if(bSal == "")
		{
			$("#bSal").parent().addClass("has-error")
			valid = false;
		}
		if(hrAlwnc == "" || !$("#hrAlwnc").val().match((/[0-9 -()+]+$/) || (/^[-+]?[0-9]+\.[0-9]+$/)))
		{
			$("#hrAlwnc").parent().addClass("has-error")
			valid = false;
		}
		if(trnspAlwnc == "" || !$("#trnspAlwnc").val().match((/[0-9 -()+]+$/) || (/^[-+]?[0-9]+\.[0-9]+$/)))
		{
			$("#trnspAlwnc").parent().addClass("has-error")
			valid = false;
		}
		if(lveTrvlAlwnc == "" || !$("#lveTrvlAlwnc").val().match((/[0-9 -()+]+$/) || (/^[-+]?[0-9]+\.[0-9]+$/)))
		{
			$("#lveTrvlAlwnc").parent().addClass("has-error")
			valid = false;
		}
		if(splAlwnc == "" || !$("#splAlwnc").val().match((/[0-9 -()+]+$/) || (/^[-+]?[0-9]+\.[0-9]+$/)))
		{
			$("#splAlwnc").parent().addClass("has-error")
			valid = false;
		}
		if(salAdv == "" || !$("#salAdv").val().match((/[0-9 -()+]+$/) || (/^[-+]?[0-9]+\.[0-9]+$/)))
		{
			$("#salAdv").parent().addClass("has-error")
			valid = false;
		}
		if(pf == "" || !$("#pf").val().match((/[0-9 -()+]+$/) || (/^[-+]?[0-9]+\.[0-9]+$/)))
		{
			$("#pf").parent().addClass("has-error")
			valid = false;
		}
		if(tds == "" || !$("#tds").val().match((/[0-9 -()+]+$/) || (/^[-+]?[0-9]+\.[0-9]+$/)))
		{
			$("#tds").parent().addClass("has-error")
			valid = false;
		}
		if(otDed == "" || !$("#otDed").val().match((/[0-9 -()+]+$/) || (/^[-+]?[0-9]+\.[0-9]+$/)))
		{
			$("#otDed").parent().addClass("has-error")
			valid = false;
		}
		if(tlEr == "")
		{
			$("#tlEr").parent().addClass("has-error")
			valid = false;
		}
		if(tlDd == "")
		{
			$("#tlDd").parent().addClass("has-error")
			valid = false;
		}
		if(ntPay == "")
		{
			$("#ntPay").parent().addClass("has-error")
			valid = false;
		}
		if(payMonth == "" || !$("#payMonth").val().match(/(0[1-9]|1[012])[-]((201)[6-9]|(202)[0-9])/))
		{
			$("#payMonth").parent().addClass("has-error")
			valid = false;
		}
		
		if(food == "")
		{
			$("#food").parent().addClass("has-error")
			valid = false;
		}
		
		if(rent == "")
		{
			$("#rent").parent().addClass("has-error")
			valid = false;
		}
		
		if(valid)
		{
			$(".submit_btn").attr("disabled","disabled");
			$(".submit_btn").text("Sending...");
			$.ajax({
				type : "GET",
				url : "addPayrollSubmit",
				data : {'pId':pId,'eId':eId,'bSal':bSal,'hrAlwnc':hrAlwnc,'trnspAlwnc':trnspAlwnc,'lveTrvlAlwnc':lveTrvlAlwnc,'splAlwnc':splAlwnc,'salAdv':salAdv,'pf':pf,'tds':tds,'otDed':otDed,'tlEr':tlEr,'tlDd':tlDd,'ntPay':ntPay,'payMonth':payMonth,'food':food,'rent':rent},
				contentType : "application/json",
				success : function(data) {
// 						alert(data);
					var obj = jQuery.parseJSON(data);
					if(!obj.error)
					{
						if(obj.msg == "edit")
						{
							window.location ='getPayrollList?status=edit';
						}
						else
						{
							window.location ='getPayrollList?status=success';
						}
					}
					else if(obj.error)
					{
						if(obj.msg == "val_exists")
						{
							window.location ='getPayrollList?status=exists';
						}
						else if(obj.msg == "val_error")
						{
							window.location ='getPayrollList?status=failed';
						}
						else
						{
							window.location ='getPayrollList?status=reg_error';
						}
					}
					
				},
				error: function (xhr, ajaxOptions, thrownError) {
			        alert(xhr.status);
			      }
			});
		}
	}
</script>

<script type="text/javascript">
$(document.body).on("click", ".edit", function(){
	var pid = $(this).attr("id");
	var btn =$(this);
	var r = confirm("Are you sure to edit this payroll ?");
	if (r) 
	{
		$.ajax({
			type : "GET",
			url : "addPayroll",
			data : {'pid': pid },
			contentType : "application/json",
			success : function(data) {
				$(".box-info").html(data);
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
		  });
	}
});

$(document.body).on("click", ".adPay", function() {
// alert('Add Button Clicked');
$.ajax({
	type : "GET",
	url : "addPayroll",
	data : {'id':''},
	contentType : "application/json",
	success : function(data) {
		$(".box-info").html(data);
	},
	error: function (xhr, ajaxOptions, thrownError) {
        alert(xhr.status);
      }
  });
  
});

$(document.body).on("change", "#eId" ,function () {
		$("#msg").css("display","none");
        var eId = $("#eId").val();
   		$.ajax({
   			type : "GET",
   			url : "getEmpData",
   			data : {'eId':eId},
   			contentType : "application/json",
   			success : function(data) {
   				var obj = jQuery.parseJSON(data);
   				if(!obj.error)
  					{
  						var list = obj.reg;
  						$("#name").val(list.name);
  						$("#designation").val(list.desg);
  						$("#bSal").val(list.bSal);
  						clearAll();
  					}
   					if(obj.msg == "NA")
					{
						$("#msg").html('*Bank detail not available, Please add bank detail first.');
   						$('#msg').css({'display':'block'});
   						$("#name").val('');
   						$("#designation").val('');
   						$("#bSal").val('');
   						clearAll();
					}
   					if(obj.msg == "regNull")
					{
   						
   						$("#msg").html('*Invalid Registraion Id, Please try with valid Id.');
   						$('#msg').css({'display':'block'});
   						$("#name").val('');
   						$("#designation").val('');
   						$("#bSal").val('');
   						clearAll();
					}
   			},
   			error: function (xhr, ajaxOptions, thrownError) {
   		        alert(xhr.status);
   		      }
   		});
       });
       
function clearAll()
{
  	$("#hrAlwnc").val('');
	$("#trnspAlwnc").val('');
	$("#lveTrvlAlwnc").val('');
	$("#splAlwnc").val('');
	$("#salAdv").val('');
	$("#pf").val('');
	$("#tds").val('');
	$("#otDed").val('');
	$("#food").val('');
	$("#rent").val('');
	$("#tlEr").val(0);
	$("#tlDd").val(0);
	$("#ntPay").val(0);
	$("#payMonth").val('');
}
       
$(document.body).on("click", ".dlt", function(){
	var pid = $(this).attr("id");
	var btn =$(this);
	var row = $(this).parent().parent();
	var r = confirm("Are you sure to delete this payroll ?");
	if (r) 
	{
		$.ajax({
			type : "GET",
			url : "adminDeletePayroll",
			data : {'pid':pid},
			contentType : "application/json",
			success : function(data) {
				var obj = jQuery.parseJSON(data);
				if(!obj.error)
				{
					row.remove();
					$('#dlt').css({'display':'block'});
					setTimeout(function() {
					      $("#dlt").css("display","none");
					}, 5000);
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
		});
	}
});

</script>
</body>