<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.config.ProjectConfig"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Map"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="java.util.Date"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.LeaveDetail"%>
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
    <%
    	TimeZone timeZone = (TimeZone) request.getSession().getAttribute("timezone");
	
    %>
    <!-- Main content -->
    <section class="content">
		
      <!-- Your Page Content Here -->
		<div class="row">
				<div class="col-xs-12 col-md-12">
				<%
					String status = (String)request.getParameter("status");
				    if(status != null && status.equals("success"))
					{
				    	%>
				    		<div class="alert alert-success alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Success !
								</h4>
								Changes saved successfully !
							</div>
				    	<%
					}
				    else if(status != null && status.equals("failed"))
					{
				    	%>
				    		<div class="alert alert-danger alert-dismissible">
									<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
									<h4>
										<i class="icon fa  fa-remove"></i> Failed !
									</h4>
									Oops, Changes failed !
								</div>
				    	<%
					}
				%>
			</div>
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
						<h3 class="box-title">Employees Leaves List</h3>
       					<div class="box-tools pull-right">
							         <ul class="pagination pagination-sm inline">
							         
							         
								      <li><a href="secureleavesdash?qm=<%= DateFormats.monthformat(timeZone).format(pdate)%>"><i class="fa fa-fw fa-backward"></i></a></li>
							      
							           <li><a href="secureleavesdash"><i class="fa fa-fw fa-home"></i></a></li>
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
									           <li><a href="secureleavesdash?qm=<%= DateFormats.monthformat(timeZone).format(ndate)%>" ><i class="fa fa-fw fa-forward"></i></a></li>
											<%
							           	}
							           %>
							         </ul>
							        
							       </div>
       					
					</div>
					<form action="adminApproveLeave" id="form" method="get">
					<div class="box-body table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>S.n.</th>
									<th>Image</th>
									<th>Employee Name</th>
									<th>From</th>
									<th>To</th>
									<th>Subject</th>
									<th>Status</th>
									<th class="text-center">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
							List<LeaveDetail> leaveList=(List)request.getAttribute("leaveList");
								
								if(leaveList != null && !leaveList.isEmpty())
								{
									int i = 1;
									for(LeaveDetail leave : leaveList)
									{
										%>
											<tr>
												<td><a href="secureViewLeave?empid=<%=leave.getRegistration().getUserid() %>"><%= i++ %> </a></td>
												<%
													if(leave.getRegistration().getProfileImage() != null)
													{
														String img_path = "/ems_uploads/"+leave.getRegistration().getUserid()+"/Profile_Photo/"+leave.getRegistration().getProfileImage();
														%>
															<td><a href="<%=img_path %>"><img class="direct-chat-img bg-info" alt="" src="<%= img_path%>" style="width: 25px;height: 25px;"></a></td>
														<%
													}
													else
													{
														%>
															<td><img class="direct-chat-img" alt="" src="images/User_Avatar.png" style="width: 25px;height: 25px;"></td>
														<%
													}
												%>
												<td><a href="secureViewEmployee?empid=<%= leave.getRegistration().getUserid()%>"><%= leave.getRegistration().getName() %> </a></td>
												
												<td><%= DateFormats.ddMMMyyyy(timeZone).format(leave.getFromDate()) %> </td>
												<td><%= DateFormats.ddMMMyyyy(timeZone).format(leave.getToDate()) %> </td>
												<td><%= leave.getSubject() %> </td>
												<td><%= leave.getStatus() %> </td>
												
												
												<td class="text-center">
													<a class="btn btn-primary btn-xs" href="viewleave?leaveId=<%= leave.getLeaveId()%>" ><i class="fa fa-fw fa-clock-o"></i>View</a>
													<%
														if(leave.getStatus() != null)
														{
															if(leave.getStatus().equalsIgnoreCase("pending"))
															{
																%>
																	<a class="btn btn-primary btn-xs" href="secureApproveLeave?leaveId=<%= leave.getLeaveId()%>" ><i class="fa fa-fw fa-check"></i>Approved</a>
													            	<a class="btn btn-danger btn-xs" href="secureDisapproveLeave?leaveId=<%= leave.getLeaveId()%>" ><i class="fa fa-fw fa-remove"></i>Disapproved</a>
																<%
															}
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
											<td colspan="9">No data in the data source.</td>
										</tr>
									<%	
								}
							%>
							</tbody>
						</table>
					</div>
					</form>
				</div>
				
			</div>
		</div>
		
    </section>
    <!-- /.content -->
  </div>
  
<script type="text/javascript">
	
</script>
 </body>