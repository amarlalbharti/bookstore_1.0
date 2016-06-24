<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
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
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

<link rel="stylesheet" href="css/fullcalendar.css">
<link rel="stylesheet" href="css/fullcalendar.print.css" media="print">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
</head>
<body>
	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <%
    	TimeZone timeZone = (TimeZone) request.getSession().getAttribute("timezone");
   	
    	Registration empReg = (Registration)request.getAttribute("empReg");
    	List<Attendance> lm_atts = (List)request.getAttribute("attList");
    	if(empReg != null)
    	{
    		%>
			    <section class="content-header">
			      <h1 class="page-header"> Employee Attendance
				      <small><%= empReg.getName() %></small>
			      </h1>
			      <ol class="breadcrumb">
			        <li><a href="managerDashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
			        <li><a href="manageremployees"><i class="fa fa-dashboard"></i> Employee List</a></li>
			        <li class="active"><%= empReg.getUserid() %></li>
			      </ol>
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
				  	
					  	<div class="col-xs-12 col-md-7">
					  		<div class="box box-solid">
					            <div class="box-body">
							  		<p><label class="form-control">Name : <%= empReg.getName() %></label></p>
							  		<p><label class="form-control">User Id : <%= empReg.getUserid() %></label></p>
							  		<p><label class="form-control">Department : <%= empReg.getDepartment().getDepartment() %></label></p>
							  		<p><label class="form-control">Designation : <%= empReg.getDesignation().getDesignation()%></label></p>
					            </div>
					            <!-- /.box-body -->
					          </div>
					  	</div>
	
						<div class="col-xs-12 col-md-5 pull-right">
							<div class="box box-info">
								<div class="box-header with-border">
					              <h3 class="box-title">Summary For this Month</h3>
					            </div>
								<div class="box-body">
									<div class="form-group">
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
                                            set.add(DateFormats.ddMMyyyy().parse(DateFormats.ddMMyyyy().format(at.getInTime())));
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
                                                if(empReg.getJoiningDate().after(cals.getTime()))
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
	                                
	                                 %>
	                                 <label class="form-label"> Total Present : </label> <%= set.size() %> Days<br>
                                     <label class="form-label"> Total Week Off's : </label> <%= weekoffs %> Days<br>
                                     <label class="form-label"> Total Absents : </label> <%= totaldays-(weekoffs + set.size()) %> Days
			             			<%
			             			}
			             			else
			             			{
			             				%>
			             				<label class="form-label"> Not Available</label>
			             				<%
			             			}
			             			%>
			             					</div>
			             					<div>
			       						 <a class="btn btn-primary btn-flat"  href="adminEmpAttendanceExport?empid=<%= empReg.getUserid() %>&qm=<%= DateFormats.monthformat(timeZone).format(sdate)%>" title="Click to export excel sheet" target="_blank"><i class="fa fa-fw fa-file-excel-o"></i> Export</a> 
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
							           <li><a href="managerViewEmpAttendence?empid=<%= empReg.getUserid() %>&qm=<%= DateFormats.monthformat(timeZone).format(pdate)%>"><i class="fa fa-fw fa-backward"></i></a></li>
							           <li><a href="managerViewEmpAttendence?empid=<%= empReg.getUserid() %>"><i class="fa fa-fw fa-home"></i></a></li>
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
									           <li><a href="managerViewEmpAttendence?empid=<%= empReg.getUserid() %>&qm=<%= DateFormats.monthformat(timeZone).format(ndate)%>" ><i class="fa fa-fw fa-forward"></i></a></li>
											<%
							           	}
							           %>
							         </ul>
			       					
							         <div class="pull-right " style="padding-left: 20px;">
							         	<form>
							         		<input type="hidden" name="empid" value="<%= empReg.getUserid()%>">
								           <input type="text" name="qm" id="qm" class="from-control" placeholder="mm-yyyy" value="">
								           <button>Go</button> 
							           </form>
							         </div>
							       </div>
								</div>
								<div class="box-body  table-responsive no-padding">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>Date</th>
												<th>Check In Time</th>
												<th>Check Out Time</th>
												<th class="text-center">Working Hours</th>
												<th>Task</th>
											</tr>
										</thead>
										<tbody>
										<%
											
											if(lm_atts != null && !lm_atts.isEmpty())
											{
												for(Attendance at : lm_atts)
												{
													%>
														<tr>
															<td><%= DateFormats.ddMMMyyyy(timeZone).format(at.getInTime()) %> </td>
															<td><%= DateFormats.timeformat(timeZone).format(at.getInTime()) %> </td>
															<td><% if(at.getOutTime() != null){out.println( DateFormats.timeformat(timeZone).format(at.getOutTime()));} else{out.println("NA");} %></td>
															<td class="text-center"><%= DateFormats.getWorkingHours(at.getInTime(), at.getOutTime()) %></td>
															<td class="text-left"><% if(at.getTask() != null){out.println(at.getTask());} else{out.println("NA");}%></td>
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
    		<%
    	}
    %>
  </div>
 
<script type="text/javascript">
  $('.select2').select2();
</script>
 </body>