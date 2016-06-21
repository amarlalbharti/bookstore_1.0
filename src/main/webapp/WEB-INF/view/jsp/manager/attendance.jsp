<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
</head>
<body>
	<div class="content-wrapper">
    <%
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
    <!-- Main content -->
    <section class="content">
      <!-- Your Page Content Here -->
		<div class="row">
			<div class="col-xs-12 col-md-12">
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Check In/Out
        					<small>for  <%= DateFormats.ddMMMyyyy().format(qdate) %></small>
       					</h3>
       					<div class="box-tools pull-right">
							<ul class="pagination pagination-sm inline">
				           <li><a href="managerCheckInOut?qdate=<%= DateFormats.ddMMyyyy().format(pdate)  %>"><i class="fa fa-fw fa-backward"></i></a></li>
				           <li><a href="managerCheckInOut"><i class="fa fa-fw fa-home"></i></a></li>
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
						           <li><a href="managerCheckInOut?qdate=<%= DateFormats.ddMMyyyy().format(ndate)  %>" ><i class="fa fa-fw fa-forward"></i></a></li>
								<%
				            }
				           %>
				         </ul>
				         
				         <div class="pull-right " style="padding-left: 20px;">
				         	<form>
					           <input type="text" name="qdate" id="qdate" class="from-control" placeholder="dd-mm-yyyy" value="<%= DateFormats.ddMMyyyy().format(qdate)%>">
					           <button>Go</button> 
				           </form>
				         </div>
				       </div>
					</div>
					<div class="box-body  table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>S.No.</th>
									<th>Image</th>
									<th>Employee Name</th>
									<th>Date</th>
									<th>Check In Time</th>
									<th>Check Out Time</th>
									<th class="text-center">Working Hours</th>
									<th class="text-left">Task</th>
									<th class="text-center">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
								List<Attendance> lm_atts = (List)request.getAttribute("attsList");
								if(lm_atts != null && !lm_atts.isEmpty())
								{
									int i = 1;
									for(Attendance at : lm_atts)
									{
										%>
											<tr>
												<td><%= i++ %></td>
												<%
													if(at.getRegistration().getProfileImage() != null)
													{
														String img_path = "/ems_uploads/"+at.getRegistration().getUserid()+"/Profile_Photo/"+at.getRegistration().getProfileImage();
														%>
															<td><a href="<%=img_path %>" target="_blank"><img class="direct-chat-img bg-info" alt="" src="<%= img_path%>" style="width: 25px;height: 25px;"></a></td>
														<%
													}
													else
													{
														%>
															<td><img class="direct-chat-img" alt="" src="images/User_Avatar.png" style="width: 25px;height: 25px;"></td>
														<%
													}
												%>
												<td><%= at.getRegistration().getName() %> </td>
												<td><%= DateFormats.ddMMMyyyy().format(at.getInTime()) %> </td>
												<td><%= DateFormats.timeformat().format(at.getInTime()) %> </td>
												<td><% if(at.getOutTime() != null){out.println( DateFormats.timeformat().format(at.getOutTime()));}else{out.println("NA");} %></td>
												<td class="text-center"><%= DateFormats.getWorkingHours(at.getInTime(), at.getOutTime()) %></td>
												<td class="text-left"><% if(at.getTask() != null && !at.getTask().isEmpty()){out.println(at.getTask());} else{out.println("NA");}%></td>
												<td class="text-center"><a class="btn btn-primary btn-xs" href="managerViewEmpAttendence?empid=<%= at.getRegistration().getUserid() %>">
													<i class="fa fa-fw fa-clock-o" style="margin-bottom: 2px;"></i>
													View</a></td>
											</tr>
										<%
									}
								}
							%>
							</tbody>
						</table>
					</div>
					<!-- /.box-body -->
				</div>


				
			</div>
		</div>
		
    </section>
    <!-- /.content -->
  </div>
<script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">
$('#qdate').datetimepicker({
	timepicker:false,
	format:'d-m-Y'
});

</script>
 </body>