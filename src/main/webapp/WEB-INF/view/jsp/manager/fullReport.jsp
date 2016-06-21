<%@page import="com.ems.config.DateFormats"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<!-- <script src="js/jQuery-2.2.0.min.js"></script> -->
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
</head>
<body>
	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <!-- Main content -->
    <section class="content">
		
      <!-- Your Page Content Here -->
		<div class="row">
		<%
		String empid = (String) request.getParameter("empid");
    	Date qdate = (Date)request.getAttribute("qdate");
		if(qdate == null)
		{
			qdate = new Date();
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(qdate);
		cal.add(Calendar.DATE, -1);
		Date pdate = cal.getTime();
		
		cal.setTime(qdate);
		cal.add(Calendar.DATE, 1);
		Date ndate = cal.getTime();
		
		%>
			<div class="col-xs-12 col-md-12">
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Full Report 
						<small>for  <%= empid %></small>
       					</h3>
       					<div class="box-tools pull-right">
       						<div class="pull-right " style="padding-left: 20px;">
<!-- 				         	<a href="managerFullReportPrint" ><button class="btn btn-primary btn-sm"><i class="fa fa-fw fa-print"></i>Print</button> </a> -->
				         </div>
				       </div>
					</div>
					<div class="box-body">
					<form action="managerFullReport" method="post" target="_blank" onsubmit="return validateForm()">
					<label>Select fields for get report : </label><br/>
					<div class="input-group col-lg-3  no-padding">
						<span class="input-group-addon">
						<input type="checkbox" id="basic" name="basic" class="sel_one" value="basic" />
						<input type="hidden" name="empid" id="empid" value="<%=empid%>"/>
						</span>
						<label class="form-control">Basic Info</label>
					</div>
					<div class="input-group col-lg-3  no-padding">
						<span class="input-group-addon">
						<input type="checkbox" id="other" name="other" class="sel_one" value="other" />
						</span>
						<label class="form-control">Other Info</label>
					</div>
					<div class="input-group col-lg-3  no-padding">
						<span class="input-group-addon">
						<input type="checkbox" id="doc" name="doc" class="sel_one" value="doc" />
						</span>
						<label class="form-control">Document</label>
					</div>
					<div class="input-group col-lg-3  no-padding" style="height:auto">
						<span class="input-group-addon">
						<input type="checkbox" id="attdn" name="attdn" class="sel_one" value="attdn" />
						</span>
						<label class="form-control" style="height:30px">Attendance</label>
						
						<div class="input-group">
	                        <span class="input-group-addon">
	                         <input type="radio" id="attdnA" name="attdns" class="sel_one" value="all" />
	                        </span>
	                    <label class="form-control">All</label>
	                  </div>
						<div class="input-group">
	                        <span class="input-group-addon">
	                          <input type="radio" id="attdnF" name="attdns" class="sel_one" value="filter" />
	                        </span>
	                    <label class="form-control" style="height: auto">
	                    To :&nbsp;<input type="text" name="sdate" id="sdate" class="from-control qdate" placeholder="dd-mm-yyyy">
	                    From :&nbsp;<input type="text" name="edate" id="edate" class="from-control qdate" placeholder="dd-mm-yyyy">
	                    </label>
	                  </div>
					</div>
					<div class="clear-fix"></div>
					 <button type="submit" class="btn btn-primary">Submit</button>
					</form>
					</div>
<!-- 					<a href="managerFullReportPrint" style="margin-left: 10px; margin-bottom: 10px;" ><button class="btn btn-primary btn-sm"><i class="fa fa-fw fa-print"></i>Print</button> </a> -->
<!-- 					<a class="btn btn-primary" href="managerFullReport" onclick="send();" style="margin-left: 2px;"><i class="fa fa-envelope" style="margin-right: 2px;"></i>Show</a> -->
            </div>
				</div>
			</div>
		
    </section>
    <!-- /.content -->
  </div>
<!--   <script src="js/jQuery-2.2.0.min.js"></script> -->
  <script src="js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">
$('.qdate').datetimepicker({
	timepicker:false,
	format:'d-m-Y'
});

$(document.body).on('change', '#attdn' ,function(){
	if(!$('#attdn').prop('checked'))
	{
		$('#attdnF').removeAttr('checked');
		$('#attdnA').removeAttr('checked');
	}
	else
		{
		$("#attdnA").prop('checked', 'checked');
		$("#sdate").attr('disabled', 'disabled');
		$("#edate").attr('disabled', 'disabled');
		}
});

$(document.body).on('change', '#attdnF' ,function(){
	$("#attdn").prop('checked', 'checked');
	if($('#attdnF').prop('checked'))
	{
		$('#sdate').removeAttr('disabled');
		$('#edate').removeAttr('disabled');
	}
});
$(document.body).on('change', '#attdnA' ,function(){
	$("#attdn").prop('checked', 'checked');
	if($('#attdnA').prop('checked'))
	{
		$("#sdate").attr('disabled', 'disabled');
		$("#edate").attr('disabled', 'disabled');
	}
});
</script>

  <script type="text/javascript">
  function validateForm()
	{
		var basic = $("input[name='basic']:checked").val(); //$("#basic").val(); 
		var other = $("input[name='other']:checked").val(); // $("#other").val();	
		var doc = $("input[name='doc']:checked").val(); //$("#doc").val();	
		var attdn = $("input[name='attdn']:checked").val(); //$("#attdn").val();	
		var attdnA = $("input[name='attdns']:checked").val(); // $("#attdnA").val();
		var attdnF = 	$("input[name='attdnF']:checked").val(); //$("#attdnF").val();
		var sdate = $("#sdate").val();//	$("input[name='gender']:checked").val();
		var edate = $("#edate").val();//	$("input[name='gender']:checked").val();
		
		
		var valid = true;
		$('.has-error').removeClass("has-error");
		
		if(basic == undefined && other == undefined && doc == undefined && attdn == undefined)
		{
			valid = false;
		}
		
		if(attdnF != undefined)
		{
			if(sdate == "" || edate =="")
			{
				valid = false;
			}
		}
				
		if(!valid)
		{
			alert('Please select atleast one field.');
			return false;		
		}
		$(".submit_btn").attr("disabled","disabled");
		$(".submit_btn").text("Sending...");
	}
  
//   function send()
//   {
// 	  var val = [];
// 	  $('.sel_one:checkbox:checked').each(function(i){
// 	  val[i] = $(this).val();
// 	  });
// 	  //val[0] != null && val[0] != ''
// 	  if(val.length > 0){
// 	  window.location = 'managerSendMessage?var='+val;
// 	  }
// 	  else{
// 		  alert('Please select any employee to send message.');
// 	  }
//   }

</script>
 </body>
 </html>