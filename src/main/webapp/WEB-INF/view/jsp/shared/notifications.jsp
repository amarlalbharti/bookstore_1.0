<%@page import="com.ems.domain.Notification"%>
<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Notification"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.ems.domain.Registration"%>
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

		  Registration registration = (Registration)request.getSession().getAttribute("registration");
	      
	        Date sdate = (Date)request.getAttribute("sdate");
		  	if(sdate == null)
		  	{
		  		sdate = new Date();
		  	}
		  	Calendar cal = Calendar.getInstance();
		  	cal.setTime(sdate);
		  	cal.add(Calendar.MONTH, -1);
		  	Date pdate = cal.getTime();
		  	
		  	cal.setTime(sdate);
		  	cal.add(Calendar.MONTH, 1);
		  	Date ndate = cal.getTime();
    %>
   <section class="content-header">
      <h1 class="page-header"> My Notifications 
	     <small><%= registration.getName() %></small> 
      </h1>
   </section>
    <!-- Main content -->
    <section class="content">
      <!-- Your Page Content Here -->
		<div class="row">
		<div id="dlt" style="display: none" class="alert alert-success alert-dismissible">
					<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
					<h4>
						<i class="icon fa fa-check"></i> Success !
					</h4>
					Country delete successfully !
				</div>
			<div class="col-xs-12 col-md-12">
				<!-- <h2>Notifications for this month</h2>
				
			 -->	<div class="box box-info">
			               <div class="box-header with-border">
							  <h3 class="box-title">Notification <small>for <%= DateFormats.MMMformat(timeZone).format(sdate) %></small></h3>
			 	       		     <div class="box-tools pull-right">
							         <ul class="pagination pagination-sm inline">
							         
							         <%    
								            Calendar joinDate = Calendar.getInstance();
											joinDate.setTime(registration.getJoiningDate());
											
											Calendar sd = Calendar.getInstance();
											sd.setTime(sdate);
										  	
									 	if(joinDate.get(Calendar.MONTH) >= sd.get(Calendar.MONTH) && joinDate.get(Calendar.YEAR) >= sd.get(Calendar.YEAR))
									          {
										%>
									           <li class="disabled"><a href="#" ><i class="fa fa-fw fa-backward"></i></a></li>
											<%
										}
							           	else
							           	{
											%> 
											  <li title='Previous month notifications'><a href="notifications?qm=<%= DateFormats.monthformat(timeZone).format(pdate)%>"><i class="fa fa-fw fa-backward"></i></a></li>
							       
							        	 	<%
							           	}
							           %>
							          
								        <li title='Current month notifications'><a href="notifications"><i class="fa fa-fw fa-home"></i></a></li>
							           <%
							           	if(ndate.after(new Date()))
										{
											%>
									           <li class="disabled"><a href="#" ><i class="fa fa-fw fa-forward"></i></a></li>
											<%
										}
							           	else
							           	{
											%>
									           <li title='Next month notification'><a href="notifications?qm=<%= DateFormats.monthformat(timeZone).format(ndate)%>" ><i class="fa fa-fw fa-forward"></i></a></li>
											<%
							           	}
							           %>
							         </ul>
							         <div class="pull-right " style="padding-left: 20px;">
							         	<form>
							         	   <input type="text" name="qm" id="qm" class="from-control" placeholder="mm-yyyy" title="Enter month in mm-yyyy format">
								           <button>Go</button> 
							           </form>
							         </div>
							       </div>
							     </div>
					<div class="box-body  table-responsive" >
						<table class="table">
							<thead>
								<tr>
								    <th style="width: 6%;">S.No.</th>
									<th style="width: 10%;">Date</th>
									<th style="width: 30%;">Notification</th>
									<th style="width: 10%;" class="text-center">Action</th>
								</tr>
							</thead>
								<tbody>
							<%
								List<Notification> nt_list = (List)request.getAttribute("nt_list");
								if(nt_list != null && !nt_list.isEmpty())
								{ 
									int i=1;
									for(Notification nt : nt_list)
									{
										%>
											<tr id="id">
											    <td style="font-weight: bold;"><%= i++ %></td>
												<td><%= DateFormats.ddMMMyyyy(timeZone).format(nt.getCreateDate()) %> </td>
												<td><%= nt.getNotiMsg() %></td>
											    <td class="text-center">
												<a id=<%= nt.getnId()%> class="btn btn-danger btn-xs delete" href="#"><i class="fa fa-fw fa-remove"></i>Delete</a>
							                    </td>
											</tr>
										<%
									}
								}
								else
								{
									%>
										<tr>
										  <td colspan="3">No data in the data source.</td>
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
 <script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/bootstrap3-wysihtml5.all.min.js"></script>

<script type="text/javascript">

$(document.body).on("click", ".delete", function(){
	var nId = $(this).attr("id");
	var btn =$(this);
	var row = $(this).parent().parent();
	
	var r = confirm("Are you sure to delete notification ?");
	if (r) 
	{
		$.ajax({
			type : "GET",
			url : "deleteNotification",
			data : {'nId':nId},
			contentType : "application/json",
			success : function(data) {
				var obj = jQuery.parseJSON(data);
				if(!obj.error)
				{
					row.remove();
					$('#dlt').css({'display':'block'});
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