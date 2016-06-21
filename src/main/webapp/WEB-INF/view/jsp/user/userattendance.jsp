<%@page import="java.util.TimeZone"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.ems.config.Roles"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="java.util.Date"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Attendance"%>
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

</head>
<body>
	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
 <%
 		TimeZone timeZone = (TimeZone) request.getSession().getAttribute("timezone");

		Registration registration = (Registration)request.getSession().getAttribute("registration");
        List<Attendance> lm_atts = (List)request.getAttribute("attList");
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
			      <h1 class="page-header"> My Attendance
				      <small><%= registration.getName() %></small>
			      </h1>
			     </section>
			    
			    <!-- Main content -->
			    <section class="content">
				  <!-- Your Page Content Here -->
				  	<div class="row">
					  	<div class="col-xs-12 col-md-6">
					  		<div class="box box-info">
					  		    <div class="box-body">
							  		<p><label class="form-control">Name : <%= registration.getName() %></label></p>
							  		<p><label class="form-control">User Id : <%= registration.getUserid() %></label></p>
							  		<p><label class="form-control">Department : <%= registration.getDepartment().getDepartment() %></label></p>
							  		<p><label class="form-control">Designation : <%= registration.getDesignation().getDesignation()%></label></p>
					            </div>
					        </div>
					  	
					  	</div>
	
						<div class="col-xs-12 col-md-6">
							<div class="box box-info">
								<div class="box-header with-border">
					              <h3 class="box-title">Summary <small>For Month <%= DateFormats.MMMformat(timeZone).format(sdate) %> </small> </h3>
					            </div>
								<div class="box-body">
									<div class="form-group margin-bottom">
												<% 
											Calendar c_cal = Calendar.getInstance();
											Set<Date> set = new HashSet();
											int weekoffs = 0;
											int totaldays = 0;
											
											if(lm_atts != null && !lm_atts.isEmpty())
											{
												Calendar cals = Calendar.getInstance();
												for(Attendance at : lm_atts)
												{
													set.add(DateFormats.ddMMyyyy(timeZone).parse(DateFormats.ddMMyyyy(timeZone).format(at.getInTime())));
													
													cals.setTime(at.getInTime());
													
													
												}
												
												Date dt = lm_atts.get(0).getInTime();
												System.out.println("dt :"+dt);
												if(dt.getMonth() == new Date().getMonth() && dt.getYear() == new Date().getYear())
												{
													cals.setTime(dt);
													int month = cals.get(Calendar.MONTH);
													while(cals.before(c_cal) && month == cals.get(Calendar.MONTH))
													{
														totaldays++;
														if(cals.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)
														{
															weekoffs++;
														}
														cals.add(Calendar.DATE, -1);
													}
												}
												else
												{
													
													cals.setTime(dt);
													int month = cals.get(Calendar.MONTH);
													while(month == cals.get(Calendar.MONTH))
													{
														totaldays++;
														if(registration.getJoiningDate().after(cals.getTime()))
														{
															break;
														}
														if(cals.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)
														{
															weekoffs++;
														}
														cals.add(Calendar.DATE, -1);
													}
												}
												
												
												
													System.out.println("Total Days : "+totaldays);
											}
											%>
												<label class="form-label"> Total Present : </label> <%= set.size() %> Days<br>
												<label class="form-label"> Total Week Off's : </label> <%= weekoffs %> Days<br>
												<label class="form-label"> Total Absents : </label> <%= totaldays-(weekoffs + set.size()) %> Days

										<br>
	             					</div>
             						
								</div>
							</div>
						</div>
					</div>
					<div class="row">
					
						<div class="col-xs-12 col-md-12">
							<div class="box box-info">
								<div class="box-header with-border">
									<h3 class="box-title">Check In/Out <small>for <%= DateFormats.MMMformat(timeZone).format(sdate) %></small>
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
											  <li title='Previous month attendance'><a href="userAttendance?qm=<%= DateFormats.monthformat(timeZone).format(pdate)%>"><i class="fa fa-fw fa-backward"></i></a></li>
							       
							        		<%
							           	}
							           %>
							         
								        <li title='Current month attendance'><a href="userAttendance"><i class="fa fa-fw fa-home"></i></a></li>
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
									           <li title='Next month attendance'><a href="userAttendance?qm=<%= DateFormats.monthformat(timeZone).format(ndate)%>" ><i class="fa fa-fw fa-forward"></i></a></li>
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
								<div class="box-body no-padding">
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
											
											if(lm_atts != null && !lm_atts.isEmpty())
											{
												int i=1;
												for(Attendance at : lm_atts)
												{
													%>
														<tr>
														    <td style="font-weight: bold;"><%= i++ %></td>
															<td><%= DateFormats.ddMMMyyyy(timeZone).format(at.getInTime()) %> </td>
															<td><%= DateFormats.timeformat(timeZone).format(at.getInTime()) %> </td>
															<td><% if(at.getOutTime() != null){out.println(DateFormats.timeformat(timeZone).format(at.getOutTime()));}else{out.println("NA");} %></td>
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
														</tr>
													<%
												}
											}
										
										else
											{
												%>
													<tr>
													  <td colspan="3" align="center">No data in the data source.</td>
													</tr>
												<%
											}
										%>
										</tbody>
							</table>
								</div>
							</div>
							<img alt="" src="/ems_uploads/Koala.jpg"width="50px">
						</div>
						
					</div>
					
			    </section>
		   <!-- /.content -->
      </div>
 </body>