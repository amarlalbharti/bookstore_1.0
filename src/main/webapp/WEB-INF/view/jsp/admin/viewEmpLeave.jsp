<%@page import="java.util.Calendar"%>
<%@page import="com.ems.config.Roles"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="java.util.Date"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.LeaveDetail"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

<link rel="stylesheet" href="css/fullcalendar.css">
<link rel="stylesheet" href="css/fullcalendar.print.css" media="print">
 <script src="js/jQuery-2.2.0.min.js"></script>

</head>
<body>
	<div class="content-wrapper">
	<%
   	Registration empReg = (Registration)request.getAttribute("empReg");
   	if(empReg != null)
   	{
   		%>
    <!-- Content Header (Page header) -->
 	    <section class="content-header">
			      <h1 class="page-header"> Employee Leaves
				      <small><%= empReg.getName() %></small>
			      </h1>
			     </section>
			    
			    <!-- Main content -->
			    <section class="content">
				  <!-- Your Page Content Here -->
					<div class="row">
											<%
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
						<div class="col-xs-12 col-md-12">
							<div class="box box-info">
								<div class="box-header with-border">
									<h3 class="box-title">Employee Leaves <small>for <%= DateFormats.MMMformat().format(sdate) %></small>
			       					</h3>
			       					<div class="box-tools pull-right">
							         <ul class="pagination pagination-sm inline">
							         
							         
								      <li><a href="adminViewLeave?empid=<%= empReg.getUserid() %>&qm=<%= DateFormats.monthformat().format(pdate)%>"><i class="fa fa-fw fa-backward"></i></a></li>
							      
							           <li><a href="adminViewLeave"><i class="fa fa-fw fa-home"></i></a></li>
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
									           <li><a href="adminViewLeave?empid=<%= empReg.getUserid() %>&qm=<%= DateFormats.monthformat().format(ndate)%>" ><i class="fa fa-fw fa-forward"></i></a></li>
											<%
							           	}
							           %>
							         </ul>
							        
							       </div>
								</div>
								<div class="box-body no-padding">
									<table class="table">
										<thead>
											<tr>
											    <th>S.No.</th>
												<th>Applied Date</th>
												<th>Leave Type</th>
												<th>From</th>
												<th>To</th>
												<th>Subject</th>
												<th>Status</th>
												
											</tr>
										</thead>
										<tbody>
										<%
										 List<LeaveDetail> leave = (List)request.getAttribute("leaveList");
											if(leave != null && !leave.isEmpty())
											{
												int i=1;
												for(LeaveDetail ld : leave)
												{
													%>
														<tr>
														    <td><%= i++ %></td>
															<td><%= DateFormats.ddMMMyyyy().format(ld.getRequestDate()) %></td>
															<td><%= ld.getLeaveType() %></td>
															<td><%= DateFormats.ddMMMyyyy().format(ld.getFromDate()) %></td>
															<td><%= DateFormats.ddMMMyyyy().format(ld.getToDate()) %></td>
															<td><%= ld.getSubject() %></td>
															<td><%= ld.getStatus() %></td>
											
														</tr>
													<%
												}
											}
										else
											{
												%>
													<tr>
													<td></td><td colspan="3" align="center">No data in the data source.</td>
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
    </div>
 </body>