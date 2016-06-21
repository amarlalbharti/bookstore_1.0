<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.config.ProjectConfig"%>
<%@page import="com.ems.domain.UserRole"%>
<%@page import="java.util.Map"%>
<%@page import="com.ems.domain.Registration"%>
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
			<div class="col-xs-12 col-md-12">
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Employees List</small>
       					</h3>
       					<div class="box-tools pull-right">
				         <div class="pull-right " style="padding-left: 20px;">
				         	
				         	<a href="adminAddEmployee" ><button class="btn btn-primary btn-sm"><i class="fa fa-fw fa-user-plus"></i> Add Employee</button> </a>
				         	&nbsp;
				         	<a href="adminEmpListExport" ><button class="btn btn-primary btn-sm"><i class="fa fa-fw fa-cloud-upload"></i> Export List</button> </a>
				         	
				         </div>
				       </div>
					</div>
					<div class="box-body table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th width="2%">S.n.</th>
									<th width="3%">Image</th>
									<th width="10%">Emp.Name</th>
									<th width="15%">User Id</th>
									<th width="5%">User Roles</th>
									<th width="5%">Gender</th>
									<th width="14%">Joining Date</th>
									<th width="5%">DOB</th>
									<th width="5%">Status</th>
									<th width="40%" class="text-center">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
								List<Registration> regList = (List)request.getAttribute("regList");
								Map<String, UserRole> roles = (Map)request.getAttribute("roles");
								if(regList != null && !regList.isEmpty() && roles != null && !roles.isEmpty())
								{
									int i = 1;
									for(Registration reg : regList)
									{
										%>
											<tr>
												<td><%= i++ %></td>
												<%
													if(reg.getProfileImage() != null)
													{
														String img_path = "/ems_uploads/"+reg.getUserid()+"/Profile_Photo/"+reg.getProfileImage();
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
												<td><a href="adminViewEmployee?empid=<%= reg.getUserid()%>"><%= reg.getName() %> </a></td>
												<td><%= reg.getUserid() %> </td>
												<td><%= roles.get(reg.getUserid()).getUserrole() %> </td>
												<td><%= reg.getGender() %> </td>
												<td><%= DateFormats.ddMMMyyyy(timeZone).format(reg.getJoiningDate()) %> </td>
												<td><%= reg.getDob() %> </td>
												<%
													if(reg.getLog() != null && reg.getLog().getIsactive().equals("true"))
													{
														%>
															<td>Active</td>
														<%
													}else
														
													{
														%>
															<td>Inactive</td>
														<%

													}
												%>
												<td class="text-center">
													<a class="btn btn-primary btn-xs" href="adminEditEmployee?empid=<%= reg.getUserid()%>" ><i class="fa fa-fw fa-edit"></i> Edit</a>
													<a class="btn btn-primary btn-xs" href="adminViewEmpAttendence?empid=<%= reg.getUserid()%>" ><i class="fa fa-fw fa-clock-o"></i> Attendance</a>
													<a href="empDocuments?empid=<%= reg.getUserid() %>" class="btn btn-info btn-xs"><i class="fa fa-book"></i> Docs</a>
													
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
				</div>
				
			</div>
		</div>
		
    </section>
    <!-- /.content -->
  </div>
  
<!-- <script type="text/javascript">
	$(document.body).on("click", ".emp_disable", function(){
		var empid = $(this).attr("id");
		var btn =$(this);
		
		var r = confirm("Are you sure to disable user ?");
		if (r) 
		{
			$.ajax({
				type : "GET",
				url : "disableUser",
				data : {'empid':empid},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.success)
					{
						btn.removeClass("emp_disable btn-danger");
						btn.addClass("emp_enable btn-primary");
						btn.html("<i class='fa fa-fw fa-check'></i> Enable");
						btn.attr("title","click to enable user");
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
			        alert(xhr.status);
			      }
			});
			
		    
		}
		
	});
	
	$(document.body).on("click", ".emp_enable", function(){
		var empid = $(this).attr("id");
		var btn =$(this);
		var r = confirm("Are you sure to enable user ?");
		if (r) 
		{
			$.ajax({
				type : "GET",
				url : "enableUser",
				data : {'empid':empid},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.success)
					{
						btn.removeClass("emp_enable btn-primary");
						btn.addClass("emp_disable btn-danger");
						btn.html("<i class='fa fa-fw fa-remove'></i> Disable");
						btn.attr("title","click to disable user");
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
			        alert(xhr.status);
			      }
			});
			
		}
		
		
	});
	

</script> -->
 </body>