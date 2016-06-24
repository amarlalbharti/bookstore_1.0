<%@page import="com.ems.service.PayrollService"%>
<%@page import="java.util.Date"%>
<%@page import="com.ems.config.DateFormats"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" href="css/select2.min.css"> -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
</head>
<body>
	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    
    <!-- Main content -->
    <section class="content">
	<!-- Your Page Content Here -->
		<div class="row">
 			<div class="col-xs-12 col-md-12">
 				<div class="box box-info">
 					<div class="box-header with-border">
 						<h3 class="box-title">Payroll Report
        					</h3>
        				</div>
 					<div class="box-body">
 						<label>Select fields for get report : </label><br/>
						<div class="col-xs-12 col-md-12">
						<div class="form-group col-xs-12 col-md-3">
								<input type="text" name="month" id="month" class="from-control col-xs-12 input-sm month" placeholder="Month : mm-yyyy">
						</div>
						<div class="form-group col-xs-12 col-md-8">
							<select name="eName" id="eName" multiple="multiple" class="from-control col-xs-12 select2">
							</select>
							<p id="errMsg" style="display: none; color: red;">*Please select any one value.</p>
						</div>
							<Button class="btn btn-primary submit_btn">Submit</Button>
						</div>
					</div>
					</div>
					
					
					<div class="box box-info reportData">
 					<div class="box-header with-border">
 						<h3 class="box-title">Payroll Report
        					</h3>
        				</div>
        				<div style="height: 25px; border : 1px #ccc solid;">
 							<p id="msg">No Data</p>
 						</div>
					</div>
 						<a href="#" onclick="PrintElem('.printDiv');"><button class="btn btn-primary btn-sm"><i class="fa fa-fw fa-print"></i> Print</button> </a>
				</div>
			</div>
		</section>
	</div>
<script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/jquery.datetimepicker.full.js"></script>
<script src="js/select2.full.min.js"></script>
<script type="text/javascript">
$(function () {
    $(".select2").select2();
});
</script>
<script type="text/javascript">
// $( ".select2" ).change(function() {
// 	var data = $(".select2").val();
//   	if(data == '1')
//   		{
//   			$("#eName").html("<option value='1' >Select All</option>");
//   		}
// 	alert(data);
// });
</script>
<script type="text/javascript">
$(document.body).on("change", "#month" ,function () {
    var month = $("#month").val();
    
    var valid = true;
	$('.error').removeClass("error");
	if(month == "" || !$("#month").val().match(/(0[1-9]|1[012])[-]((201)[6-9]|(202)[0-9])/))
	{
		$("#month").focus();
		$("#month").addClass("error")
		valid = false;
	}
    if(valid)
    {
		$.ajax({
			type : "GET",
			url : "getEmpName",
			data : {'month':month},
			contentType : "application/json",
			success : function(data) {
				var obj = jQuery.parseJSON(data);
				if(!obj.error)
					{
						var list = obj.empList;
						$("#eName").html("<option value='allValue' >Select All</option>");
						jQuery.each( list, function( i, val ) {
	   						  $("#eName").append("<option value='"+val.userId+"' > "+val.name+"</option>");
	   					});
						
					}
					if(obj.msg == "listEmpty")
					{
					$("#msg").html('*No data found.');
						$('#msg').css({'display':'block'});
						$("#eName").html('');
// 						setTimeout(function() {
// 						    $("#msg").css("display","none");
// 						}, 5000);
					}
			}
		});
	}
  });
</script>
<script type="text/javascript">
$(document.body).on("click", ".submit_btn" ,function () {
         var selectedName = $("#eName").val();
         var selectedMonth = $("#month").val();
         $("#errMsg").css("display","none");
         var names = null;
         var valid = true;
 		$('.has-error').removeClass("has-error");
 		
 		if(selectedName == "" || selectedName == null )
		{
 			$("#errMsg").css("display","block");
			valid = false;
		}
 		if(selectedMonth == "")
		{
			$("#month").addClass("error")
			valid = false;
		}
 		if(selectedName != null)
		{
 			if(selectedName.includes("allValue"))
 			{
	 			selectedName = "";
	 			$('select#eName').find('option').each(function() {
	 				if($(this).val() == 'allValue'){
	 					return true;}
	 				selectedName += $(this).val();
	 				selectedName += ",";
	 			});
 			}
		}
//  		alert(selectedName);
 		if(valid)
		{
 			$(".submit_btn").attr("disabled","disabled");
 			names = encodeURIComponent(selectedName);
 			$.ajax({
        		type : "GET",
        		url : "securePayrollReport",
        		data : {'E_Names':names,'month':selectedMonth},
        		contentType : "application/json",
        		success : function(data) {
        			$(".reportData").html(data);
        			$(".submit_btn").removeAttr("disabled");
        		}
        		
        	  });
		}
 		
       });
</script>
<script type="text/javascript">
function PrintElem(elem)
{
    Popup($(elem).html());
}

function Popup(data) 
{
	if(data != null)
	{
	    var mywindow = window.open('', 'my div', 'height=400,width=600');
	    mywindow.document.write('<html><head><title>Payslip</title>');
	    mywindow.document.write('</head><body><br/><br/><br/>');
	    mywindow.document.write(data);
	    mywindow.document.write('</body></html>');
	
	    mywindow.print();
	    mywindow.close();
	
	    return true;
	}
	else
	{
		alert('Data not available.')
	}
}
</script>
</body>
</html>