<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Attendance"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="css/bootstrap.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="css/AdminLTE.css">
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect.
  -->
  <link rel="stylesheet" href="css/bootstrap3-wysihtml5.min.css">
  <link rel="stylesheet" href="css/skin-blue.css">
</head>
<body>
	<div class="content-wrapper">
    <%
    TimeZone timeZone = (TimeZone) request.getSession().getAttribute("timezone");
    %>
    
    
    
    <!-- Main content -->
    <section class="content">
		<div class=" row bottom-padding">
			<div class="col-xs-12">
				<div class="box box-info">
					<div class="box-body">
						<%
							List<Attendance> attsList = (List)request.getAttribute("attsList");
					  		if(attsList!= null && !attsList.isEmpty())
					  		{
					  			Attendance att = attsList.get(0);
					  			%>
					  				Login Time : <%= DateFormats.fullformat(timeZone).format(att.getInTime()) %>
									<br><br>
					  			<%
					  			
					  			
					  			Attendance attendance = attsList.get(0);
					  			if(attendance != null && attendance.getOutTime() == null)
				  				{
				  					%>
				  					<form action="empCheckOut" method="post" onsubmit="return validate()">
				  					<div class="form-group col-xs-12 col-md-12">
				  					 <label>Enter Task</label><span class="text-danger">*</span>
						                  <textarea rows="3" cols="50" name="task" id="task" class="form-control textarea" style="resize:none;" placeholder="Enter Task Here"></textarea>
						                <div class="error-messages text-danger" style="display:none;"></div>
						                </div>
						                <div class="clearfix"></div>
						                <div class="form-group col-xs-12 col-md-12">
						           			 <button type="submit" class="btn btn-primary" id="submit_btn">Check Out</button>
						           		</div>
									</form>
				  					<%
				  				}
					  			else
					  			{
				  					%>
										<a href="empCheckIn"><button class="btn btn-primary ">Check In</button></a>
				  					<%
					  			}
					  		}
					  		else
					  		{
			  					%>
									<a href="empCheckIn"><button class="btn btn-primary ">Check In</button></a>
			  					<%
					  		}
						%>
					</div>
				</div>
			</div>
		</div>
      <!-- Your Page Content Here -->
		<div class="row">
			<div class="col-xs-12 col-md-12">
				<h2>Check In/Out for this month</h2>
				
				<div class="box box-info">
					<div class="box-body  table-responsive" >
						<table class="table">
							<thead>
								<tr>
								    <th style="width: 6%;">S.No.</th>
									<th style="width: 10%;">Date</th>
									<th style="width: 15%;">Check In Time</th>
									<th style="width: 15%;">Check Out Time</th>
									<th style="width: 15%;">Working Hours</th>
									<th style="width: 40%;">Task</th>
								</tr>
							</thead>
								<tbody>
							<%
								List<Attendance> lm_atts = (List)request.getAttribute("lm_atts");
								if(lm_atts != null && !lm_atts.isEmpty())
								{ 
									int i=1;
									for(Attendance at : lm_atts)
									{
										%>
											<tr id="id">
											    <td style="font-weight: bold;"><%= i++ %></td>
												<td><%= DateFormats.ddMMMyyyy(timeZone).format(at.getInTime()) %> </td>
												<td><%= DateFormats.timeformat(timeZone).format(at.getInTime()) %> </td>
												<td><% if(at.getOutTime() != null){out.println( DateFormats.timeformat(timeZone).format(at.getOutTime()));} %></td>
											    <td><% if(at.getOutTime() != null){out.println(DateFormats.getWorkingHours(at.getInTime(),at.getOutTime()));} else{out.println("NA");} %> </td>
											<%
																if(at.getTask() != null)
																{
																	%>
																		<td><%= at.getTask() %></td>
																	<%
																}
																else
																{
																	%>
																		<td>NA</td>
																	<%
																}
															%>
															
														<!-- 	<td><button class="getLeave btn btn-primary btn-xs btn-flat" title="Click to View Leaves">Get Leaves</button> </td>
											 -->
											</tr>
										<%
									}
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
 <script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/bootstrap3-wysihtml5.all.min.js"></script>
<script>
  $(function () {
    //bootstrap WYSIHTML5 - text editor
    $(".textarea").wysihtml5();
  });
</script>

<script type="text/javascript">

function validate(){
	
 var task=$("#task").val();
 
 var valid = true;
 $(".error-messages").text("").fadeIn();

 if(task==''){
	$(".error-messages").text("Task cannot be empty").fadeIn();
	valid=false;
	}


	if(!valid)
 {
     return false;        
 }
 
$('.bodyCoverWait').show();
$("#submit_btn").attr("disabled","disabled");

$("#submit_btn").text("Sending...");

}


/* jQuery(document).ready(function() {

	$(document.body).on("click", ".getLeave", function() {
		alert('hi');
		$.ajax({
			type : "GET",
			url : "demo",
			data : {},
			contentType : "application/json",
			success : function(data) {
					$("#id").html(data);
					
				},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
		});
	});
}); */

</script>

 </body>