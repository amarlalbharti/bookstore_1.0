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
	
    <!-- Content Header (Page header) -->
 <%
		Registration registration = (Registration)request.getSession().getAttribute("registration");
	System.out.println("Regi : " + registration);
	%>
			    <section class="content-header">
			    
			    
			  
			      <h1 class="page-header"> My Leaves
				      <small><%= registration.getName() %></small>
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
						
						 
      <%
				String status = (String)request.getParameter("status");
			    if(status != null)
				{
					if(status.equalsIgnoreCase("success"))
					{
						%>
							<div class="alert alert-success alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Success !
								</h4>
								Leave Applied successfully !
							</div>
						<%
					}
					else if(status.equalsIgnoreCase("error"))
					{
						%>
							<div class="alert alert-danger alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Failed !
								</h4>
								Oops, Some error occurs !
							</div>
						<%
					}
				}
					%>
   
	
							<div class="box box-info">
								<div class="box-header with-border">
									<h3 class="box-title">My Leaves <small>for <%= DateFormats.MMMformat().format(sdate) %></small>
			       					</h3>
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
											     <li><a href="userleavedetail?qm=<%= DateFormats.monthformat().format(pdate)%>"><i class="fa fa-fw fa-backward"></i></a></li>
							      
							        		<%
							           	}
							           %>
							         
							           <li><a href="userleavedetail"><i class="fa fa-fw fa-home"></i></a></li>
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
									           <li><a href="userleavedetail?qm=<%= DateFormats.monthformat().format(ndate)%>" ><i class="fa fa-fw fa-forward"></i></a></li>
											<%
							           	}
							           %>
							         </ul>
							         <div class="pull-right " style="padding-left: 20px;">
							         	   
								          <a href="userleaveapplication" class="btn btn-primary xs btn-xs">Add Leave</a>
							         </div>
							       </div>
								</div>
								<div class="box-body no-padding">
									<table class="table">
										<thead>
											<tr>
											    <th style="width: 5%;">S.No.</th>
												<th style="width: 10%;">Applied Date</th>
												<th style="width: 12%;">Leave Type</th>
												<th style="width: 10%;">From</th>
												<th style="width: 10%;">To</th>
												<th style="width: 8%;">Status</th>
												<th style="width: 30%;">Subject</th>
												<th style="width: 15%;" class="text-center">Action</th>
												
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
															<td><%= ld.getStatus() %></td>
															<td><%= ld.getSubject() %></td>
															
															<td class="text-center">
													  <a class="btn btn-primary btn-xs" href="userviewleave?leaveId=<%= ld.getLeaveId()%>" ><i class="fa fa-fw fa-clock-o"></i>View</a>
												<%
													    if(ld.getStatus().equalsIgnoreCase("pending")){
													    
													    %>
														    <a class="btn btn-primary btn-xs"  href="usereditleave?leaveId=<%= ld.getLeaveId()%>" ><i class="fa fa-fw fa-edit"></i>Edit</a>
													    <% 	
													    }
													    else{%>
											          <a class="btn btn-primary btn-xs disabled"  href="usereditleave?leaveId=<%= ld.getLeaveId()%>" ><i class="fa fa-fw fa-edit"></i>Edit</a>
										               <% 	
										              }
													
													%>
												</td>
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