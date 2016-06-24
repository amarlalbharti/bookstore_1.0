<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Set"%>
<%@page import="com.ems.domain.UserRole"%>
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
<script src="js/jQuery-2.2.0.min.js"></script>
</head>
<body>
	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <!-- Main content -->
    <section class="content">
		
      <!-- Your Page Content Here -->
		<div class="row">
			<div class="col-xs-12 col-md-12">
			<div id="msg">
    <%
    TimeZone timeZone = (TimeZone) request.getSession().getAttribute("timezone");
   	
			String status = (String) request.getParameter("status");
    		String mail = (String) request.getParameter("mail");
			if (status != null) {
				if(status.equalsIgnoreCase("success"))
				{
				%>
    			<div class="alert alert-success alert-dismissible">
						<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
						<h4>
							<i class="icon fa fa-check"></i> Success !
						</h4>
						New employee registered successfully !
					</div>		
				<%
				}
			}
			if (mail != null) {
				if(mail.equalsIgnoreCase("success"))
				{
				%>
    			<div class="alert alert-success alert-dismissible">
						<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
						<h4>
							<i class="icon fa fa-check"></i> Success !
						</h4>
						Message send successfully !
					</div>		
				<%
				}
				else
					if(mail.equalsIgnoreCase("excp"))
					{
					%>
	    			<div class="alert alert-danger alert-dismissible">
						<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
						<h4>
							<i class="icon fa  fa-remove"></i> Failed !
						</h4>
						Oops, Exception occured !
						</div>	
					<%
					}
					else if(mail.equalsIgnoreCase("blank"))
					{
						%>
		    			<div class="alert alert-danger alert-dismissible">
						<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
						<h4>
							<i class="icon fa  fa-remove"></i> Failed !
						</h4>
						Please provide subject and message !
						</div>	
						<%
						}
			}
		%>
    </div>
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Employees List</small>
       					</h3>
       					<div class="box-tools pull-right">
       					
       						<div class="pull-right " style="padding-left: 20px;">
				         	<a href="managerAddEmployee" ><button class="btn btn-primary btn-sm"><i class="fa fa-fw fa-user-plus"></i> Add Employee</button> </a>
				         	&nbsp;
				         	<a href="adminEmpListExport" ><button class="btn btn-primary btn-sm"><i class="fa fa-fw fa-cloud-upload"></i> Export List</button> </a>
				         </div>
				       </div>
					</div>
					<div class="box-body  table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th><input id="sel_all_emp" type="checkbox"></th>
									<th>S.No.</th>
									<th>Image</th>
									<th>Employee Name</th>
									<th>User Id</th>
									<th>Role</th>
									<th>Joining Date</th>
									<th>Date of Birth</th>
									<th>Status</th>
									<th  class="text-center">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
								List<Registration> regList = (List)request.getAttribute("regList");
								Map<String, List<UserRole>> roleList = (HashMap)request.getAttribute("roleList");
							
								if(regList != null && !regList.isEmpty())
								{
									int i = 1;
									for(Registration reg : regList)
									{
										String role = roleList.get(reg.getUserid()).get(0).getUserrole();
										
										if(role.equals("ROLE_ADMIN"))
										{
											role = "ADMIN";
										}
										else if(role.equals("ROLE_MANAGER"))
										{
											role = "MANAGER";
										}
										else if(role.equals("ROLE_USER"))
										{
											role = "EMPLOYEE";
										}
										
										%>
											<tr>
												<td><input class="sel_one" type="checkbox" name="newpostselector[]" value="<%=reg.getUserid() %>"/></td>
												<td><%= i++ %></td>
												<%
													if(reg.getProfileImage() != null)
													{
														String img_path = "/ems_uploads/"+reg.getUserid()+"/Profile_Photo/"+reg.getProfileImage();
														%>
															<td title="click to view profile image"><a href="<%=img_path %>" target="_blank"><img class="direct-chat-img bg-info" alt="" src="<%= img_path%>" style="width: 25px;height: 25px;"></a></td>
														<%
													}
													else
													{
														%>
															<td><img class="direct-chat-img" alt="" src="images/User_Avatar.png" style="width: 25px;height: 25px;"></td>
														<%
													}
												%>
												<td title="click to view user detail"><a href="managerViewEmployee?empid=<%= reg.getUserid()%>" ><%= reg.getName() %></a> </td>
												<td><%= reg.getUserid() %> </td>
												<td><%= role %> </td>
												<td><%= DateFormats.ddMMMyyyy(timeZone).format(reg.getJoiningDate()) %> </td>
												<td><%= reg.getDob() %> </td>
												<%
													if(reg.getLog() != null && reg.getLog().getIsactive().equals("true"))
													{
														%>
															<td title="User enabled" class="text-aqua">Active</td>
														<%
													}else
														
													{
														%>
															<td  title="User disabled " class="text-red">Inactive</td>
														<%

													}
												%>
												<td class="text-center">
													<a class="btn btn-primary btn-xs" href="managerEditEmployee?empid=<%= reg.getUserid()%>" title="Click to edit basic detail" >
													<i class="fa fa-fw fa-edit"></i> Edit</a>
													<a class="btn btn-primary btn-xs" href="managerViewEmpAttendence?empid=<%= reg.getUserid()%>" title="Click to view attendance">
													<i class="fa fa-fw fa-clock-o" ></i> Attendance</a>
													<a href="empDocuments?empid=<%= reg.getUserid() %>" class="btn btn-info btn-xs" title="Click to view user documents"><i class="fa fa-book"></i> Docs</a>
												</td>
											</tr>
										<%
									}
								}
							%>
							</tbody>
						</table>
					</div>
				<div class="box-footer clearfix">
					<a class="btn btn-primary" href="#" onclick="send();" style="margin-left: 2px;"><i class="fa fa-envelope" style="margin-right: 2px;"></i>Message</a>
            </div>
				</div>
			</div>
		</div>
		
    </section>
    <!-- /.content -->
  </div>
  <script type="text/javascript">
jQuery(document).ready(function() {
	$(document.body).on('change', '.sel_one' ,function(){
	  var val = [];
	  if($('.sel_one:checkbox').length > $('.sel_one:checkbox:checked').length)
	  {
		  $('#sel_all_emp').removeAttr("checked");
	  }
	  else
	  {
	  	$('#sel_all_emp').prop("checked","checked");
	  }
    });
	
	$(document.body).on('change', '#sel_all_emp' ,function(){
// 		alert($('#sel_all_emp').prop('checked'))
		if($('#sel_all_emp').prop('checked'))
		{
			$('.sel_one:checkbox').prop('checked','checked')
		}
		else
		{
			$('.sel_one:checkbox').removeAttr('checked')
		}
		
	});
	
	
	
  });
	
</script>
  <script type="text/javascript">
  function send()
  {
	  $(this).attr("disabled","disabled");
	  var val = [];
	  $('.sel_one:checkbox:checked').each(function(i){
	  val[i] = $(this).val();
	  });
	  //val[0] != null && val[0] != ''
	  if(val.length > 0){
	  window.location = 'managerSendMessage?var='+val;
	  }
	  else{
		  $(this).removeAttr("disabled");
		  alert('Please select any employee to send message.');
	  }
  }
  </script>
 </body>
 </html>