<%@page import="com.ems.config.Roles"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="java.util.Date"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Attendance"%>
<%@page import="com.ems.domain.Department"%>
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
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
</head>
<body>
<input type="hidden" id=mode name="mode" value="${mode}">
	<div class="content-wrapper">
       
    <!-- Main content -->
    <section class="content">
		
      <!-- Your Page Content Here -->
		<div class="row">
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
								Record Saved successfully !
							</div>
						<%
					}
					else if(status.equalsIgnoreCase("updated"))
					{
						%>
							<div class="alert alert-success alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Success !
								</h4>
								Record Updated successfully !
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
					
				<div id="dlt" style="display: none" class="alert alert-success alert-dismissible">
					<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
					<h4>
						<i class="icon fa fa-check"></i> Success !
					</h4>
					Department delete successfully !
				</div>
					
			<div class="col-xs-12 col-md-7">
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Department List</h3>
 					</div>
					<div class="box-body table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th width="2%">S.n.</th>
									<th width="10%">Department Name</th>
									
									<th width="10%" class="text-center">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
								List<Department> dList = (List)request.getAttribute("dList");
								if(dList != null && !dList.isEmpty())
								{
									int i = 1;
									for(Department dep : dList)
									{
										%>
											<tr>
												<td><%= i++ %></td>
												
												<td><%= dep.getDepartment() %> </td>
												
												<td class="text-center"> 
												<a class="btn btn-primary btn-xs" href="adminViewDepartment?departmentId=<%= dep.getDepartmentId() %>" ><i class="fa fa-fw fa-edit"></i> Edit</a>
												&nbsp;
												<a id="<%= dep.getDepartmentId()%>" class="btn btn-danger btn-xs delete" href="#" ><i class="fa fa-fw fa-remove"></i> Delete</a>
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
			
			
			  <div class="col-xs-12 col-md-5">
				<div class="box box-info">
					<%
				String mode=(String)request.getAttribute("mode");
				if(mode!=null){
				if ((mode).equalsIgnoreCase("add"))
				{
				
				%>
					<div class="box-header with-border">
						<h3 class="box-title">Add Department</h3>
						</div>
						
						<%
				}
				else if ((mode).equalsIgnoreCase("edit"))
				{
						%>
						<div class="box-header with-border">
						<h3 class="box-title">Edit Department</h3>
						</div>
						<%
				}
				}
						%>
					  <div class="box-body table-responsive">
				            
	                	<form:form role="form" method="POST" action="adminAddDepartment" commandName="depForm" autocomplete="off" enctype="multipart/form-data" id="form" onsubmit="return validateForm()">
			              <div class="box-body">
			                <div class="form-group col-xs-12 col-md-9">
			                  <label >Department Name</label><span class="text-danger">*</span>
			                  
			                  <form:input path="department" class="form-control"  placeholder="Enter department name" tabindex="1" maxlength="35"/>
			                  <form:hidden path="departmentId"/>
			                  <span class="text-danger"><form:errors path="department" /></span>
			                  <div class="error-messages text-danger" style="display:none;"></div>
			                </div>

			              </div>
			              <!-- /.box-body -->
			              <div class="box-footer col-xs-12 col-md-6">
			              	<div class="form-group col-xs-12 col-md-6">
			                	<button type="submit" class="btn btn-primary submit_btn" tabindex="5">Submit</button>
			                </div>
			              </div>
			            </form:form>
					</div>
				</div>
				
			</div>
			
	
		</div>
	</div>
 </section>
    <!-- /.content -->
  </div>
<script src="js/jQuery-2.2.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function()
{
	$("#form").trigger('reset');
});

</script>
<script type="text/javascript">

$(document.body).on("click", ".delete", function(){
	var departmentId = $(this).attr("id");
	var btn =$(this);
	var row = $(this).parent().parent();
	
	var r = confirm("Are you sure to delete department ?");
	if (r) 
	{
		$.ajax({
			type : "GET",
			url : "adminDeleteDepartment",
			data : {'departmentId':departmentId},
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



	
	function validateForm() {
		var department = $("#department").val();

		var valid = true;
		$('.has-error').removeClass("has-error");
		$(".error-messages").text("").fadeIn();
		if (department == "" || !isName(department)) {
			$("#department").parent().addClass("has-error")
			$(".error-messages").text("Please enter alphabets only").fadeIn();
			valid = false;
		}

		if (!valid) {
			return false;
		}
		$(".submit_btn").attr("disabled", "disabled");
		if (($("#mode").val()) == 'add') {
			$("#submit_btn").text("Saving...");
		}

		if (($("#mode").val()) == 'edit') {
			$("#submit_btn").text("Updating...");
		}
	}
</script>
 </body> 