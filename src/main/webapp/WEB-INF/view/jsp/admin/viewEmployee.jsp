<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.domain.UserRole"%>
<%@page import="com.ems.domain.UserDetail"%>
<%@page import="com.ems.config.Roles"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="java.util.Date"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Attendance"%>
<%@page import="java.util.List"%>
<%@page import="com.ems.domain.BankDetail"%>
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
	<div class="content-wrapper">
<%
	TimeZone timeZone = (TimeZone) request.getSession().getAttribute("timezone");
   	Registration empReg = (Registration)request.getAttribute("empReg");
   	if(empReg != null)
   	{
   		%>
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="page-header">View Employee <small>for <%= empReg.getUserid() %></small> </h1>
      <ol class="breadcrumb">
        <li><a href="adminDashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="adminEmployees"><i class="fa fa-dashboard"></i> Employee List</a></li>
        <li class="active">update Employee</li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
          		
		      <!-- Your Page Content Here -->
				<div class="row">
					<div class="col-xs-12 col-md-12">
				
						<%
						String oif_success = request.getParameter("oif_success");
    		  			if(oif_success != null)
    		  			{
    		  				if(oif_success.equalsIgnoreCase("added"))
    		  				{
    		  					%>
    		  						<div class="alert alert-success alert-dismissible">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
											<h4>
												<i class="icon fa fa-check"></i> Success !
											</h4>
											Other Info added successfully !
									</div>
    		  					<%
    		  				}
    		  				else if(oif_success.equalsIgnoreCase("updated"))
    		  				{
    		  					%>
    		  						<div class="alert alert-success alert-dismissible">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
											<h4>
												<i class="icon fa fa-check"></i> Success !
											</h4>
											Other Info updated successfully !
									</div>
    		  					<%
    		  				}
    		  				else if(oif_success.equalsIgnoreCase("failed"))
    		  				{
    		  					%>
    		  						<div class="alert alert-danger alert-dismissible">
										<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
										<h4>
											<i class="icon fa  fa-remove"></i> Failed !
										</h4>
										Oops, Something wrong, other info not saved !
									</div>
    		  					<%
    		  				}
    		  				
    		  			}
						
						
							String pwdstatus = (String)request.getAttribute("pwdstatus");
						    if(pwdstatus != null)
							{
								if(pwdstatus.equalsIgnoreCase("success"))
								{
									%>
										<div class="alert alert-success alert-dismissible">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
											<h4>
												<i class="icon fa fa-check"></i> Success !
											</h4>
											Password Changed successfully !
										</div>
									<%
								}
								else if(pwdstatus.equalsIgnoreCase("notfound"))
								{
									%>
										<div class="alert alert-danger alert-dismissible">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
											<h4>
												<i class="icon fa  fa-remove"></i> Failed !
											</h4>
											Oops, User not found !
										</div>
									<%
								}
								else if(pwdstatus.equalsIgnoreCase("notsame"))
								{
									%>
										<div class="alert alert-danger alert-dismissible">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
											<h4>
												<i class="icon fa  fa-remove"></i> Failed !
											</h4>
											Oops, confirm password not matched or valid !
										</div>
									<%
								}
								else
								{
									%>
										<div class="alert alert-danger alert-dismissible">
											<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
											<h4>
												<i class="icon fa  fa-remove"></i> Failed !
											</h4>
											Oops, Something wrong !
										</div>
									<%
								}
								
							}
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
							<div class="box-body no-padding">
								<div class="nav-tabs-custom no-margin">
						            <ul class="nav nav-tabs">
						              <li class="active"><a href="#tab_1" data-toggle="tab">Basic Info</a></li>
						              <li><a href="#tab_2"  data-toggle="tab">Other Info</a></li>
						              <li><a href="#tab_3"  data-toggle="tab">Account Details</a></li>
						              <li><a href="#tab_4"  data-toggle="tab">Reset Password</a></li>
						              <li class="pull-right">
						              <div class="box-tools pull-right">
			       						<div class="pull-right " style="padding-left: 20px;">
							         		<a href="managerPrint?empid=<%= empReg.getUserid()%>" target="_blank"><button class="btn btn-primary btn-sm"><i class="fa fa-fw fa-print"></i>Print</button></a>
							         		&nbsp;
							         		<a href="managerFullReport?empid=<%= empReg.getUserid()%>"><button class="btn btn-primary btn-sm"><i class="fa fa-fw fa-print"></i> Full Report</button></a>
							         	</div>
							      	  </div>
							     	  </li>
						            </ul>
						            <div class="tab-content">
						              <div class="tab-pane active" id="tab_1">
						                	<div class="form-horizontal">
								              <div class="box-body">
								                
								                <div class="form-group col-md-6 ">
								                	 <div class="form-group col-md-12" >
									                	<%
									                		if(empReg.getProfileImage() != null)
									                		{
									                			String path = "/ems_uploads/"+empReg.getUserid()+"/Profile_Photo/" + empReg.getProfileImage();
												                %>
												                	<a class="col-md-12" href="<%= path %>"><img alt="<%= empReg.getName() %>" src="<%=path %>" style="max-height: 150px; max-width: 100px" /></a>
												                <%
									                		}
									                		else
									                		{
									                			%>
									                				<img alt="<%= empReg.getName() %>" src="images/Camera_Icon.png" style="max-height: 150px; max-width: 100px" />
									                			<%
									                		}
									                	
									                	%>
								                	 </div>
								                	 
								                </div>
								                <div class="form-group col-md-6 no-padding no-margin">
								                	<div class="form-group col-md-12">
									                  <label class="col-sm-4 control-label" style="text-align: left;">Employee Id</label>
									                  <div class="col-sm-8">
									                    <label class="form-control label-text"><%= empReg.geteId() %></label>
									                  </div>
									                </div>
									                <div class="form-group col-md-12">
									                  <label class="col-sm-4 control-label" style="text-align: left;">Name</label>
									                  <div class="col-sm-8">
									                    <label class="form-control label-text"><%= empReg.getName() %></label>
									                  </div>
									                </div>
									                <div class="form-group col-md-12">
									                  <label class="col-sm-4 control-label"  style="text-align: left;">User ID</label>
									                  <div class="col-sm-8">
									                    <label class="form-control label-text"><%= empReg.getUserid() %></label>
									                  </div>
									                </div>
								                </div>
								                
								                <div class="clearfix"></div>
								                <div class="form-group col-md-6">
									                  <label class="col-sm-4 control-label"  style="text-align: left;">Gender</label>
									                  <div class="col-sm-8">
									                    <label class="form-control label-text"><%= empReg.getGender()%></label>
									                  </div>
									                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">DOB</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= empReg.getDob() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Join Date</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= DateFormats.ddMMMyyyy(timeZone).format(empReg.getJoiningDate()) %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Registration</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= DateFormats.ddMMMyyyy(timeZone).format(empReg.getRegdate()) %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Department</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= empReg.getDepartment().getDepartment() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Designation</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= empReg.getDesignation().getDesignation() %></label>
								                  </div>
								                </div>
								                <%
								                	if(empReg.getBranch() != null)
								                	{
								                		%>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">Branch</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= empReg.getBranch().getBranchName() %></label>
											                  </div>
											                </div>
								                		<%
								                	}
								                %>
								                <%
								                	List<UserRole> roles = (List)request.getAttribute("roles");
								                	if(roles != null && !roles.isEmpty())
								                	{
								                		%>
								                			<div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">User Role</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= roles.get(0).getUserrole() %></label>
											                  </div>
											                </div>
								                		<%
								                	}
								                
								                %>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Week Off</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= DateFormats.getDayName(empReg.getWeekOff()) %></label>
								                  </div>
								                </div>
								                
								                <div class="clearfix"></div>
								                <div class="form-group  col-md-6">
													<a href="adminEditEmployee?empid=<%= empReg.getUserid() %>" class="btn btn-primary btn-flat">Edit Basic Info</a>
													<%
														if(empReg.getLog() != null && empReg.getLog().getIsactive().equals("true"))
														{
															%>
																<button class="btn btn-danger  btn-flat emp_disable" id="<%= empReg.getUserid() %>" title="click to disable user"><i class="fa fa-fw fa-remove"></i> Disable</button>
															<%
														}
														else
														{
															%>
																<button class="btn btn-primary btn-flat emp_enable" id="<%= empReg.getUserid() %>" title="click to enable user"><i class="fa fa-fw fa-check"></i> Enable</button>
															<%
														}
													
													%>
												</div>
								              </div>
								            </div>
						              </div>
						              <!-- /.tab-pane -->
						              <div class="tab-pane no-margin" id="tab_2">
						                	<%
						                		if(empReg.getUserDetail() != null)
						                		{
						                			UserDetail ud = empReg.getUserDetail();
						                			%>
							                			<div class="form-horizontal">
											              <div class="box-body">
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label" style="text-align: left;">Permanent Addr.</label>
											
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= ud.getParmanentAddress() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">Present Address</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= ud.getPresentAddress() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">City</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= ud.getCity() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">State</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= ud.getState() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">Country</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= ud.getCountry() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">Mobile No</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= ud.getMobileNo() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">Alter. Mobile</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= ud.getEmergencyNo() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">Qualification</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= ud.getQualification() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">Marital Status</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= ud.getMaritalStatus() %></label>
											                  </div>
											                </div>
											                
											                <%
											                	if(ud.getAltEmailId() != null && ud.getAltEmailId().trim().length() > 0)
											                	{
											                		%>
														                <div class="form-group col-md-6">
														                  <label class="col-sm-4 control-label"  style="text-align: left;">Alter.EmailId</label>
														                  <div class="col-sm-8">
														                    <label class="form-control label-text"><%= ud.getAltEmailId() %></label>
														                  </div>
														                </div>
											                		<%
											                	}
											                	else
											                	{
											                		%>
														                <div class="form-group col-md-6">
														                  <label class="col-sm-4 control-label"  style="text-align: left;">Alter.EmailId</label>
														                  <div class="col-sm-8">
														                    <label class="form-control label-text">NA</label>
														                  </div>
														                </div>
											                		<%
											                	}
												                if(ud.getAltEmailId() != null && ud.getAltEmailId().trim().length() > 0)
											                	{
												                	%>
														                <div class="form-group col-md-6">
														                  <label class="col-sm-4 control-label"  style="text-align: left;">Passport Number</label>
														                  <div class="col-sm-8">
														                    <label class="form-control label-text"><%= ud.getPassportNo() %></label>
														                  </div>
														                </div>
												                	<%
											                	}
												                else
												                {
												                	%>
														                <div class="form-group col-md-6">
														                  <label class="col-sm-4 control-label"  style="text-align: left;">Passport Number</label>
														                  <div class="col-sm-8">
														                    <label class="form-control label-text">NA</label>
														                  </div>
														                </div>
													                <%
												                }
											                %>
											                <div class="clearfix"></div>
											                <div class="form-group has-feedback col-md-6">
																<a href="adminAddOtherInfo?empid=<%= empReg.getUserid() %>" class="btn btn-primary btn-flat">Edit Other Info</a>
															</div>
											              </div>
											              
											            </div>
						                			<%
						                		}
						                		else
						                		{
						                			%>
						                				<div class="form-horizontal">
											              <div class="box-body">
												              <div class="form-group has-feedback col-md-6">
																	<a href="adminAddOtherInfo?empid=<%= empReg.getUserid() %>" class="btn btn-primary btn-flat">Add Other Info</a>
																</div>
											              </div>
										                </div>
						                			<%
						                		}
						                	%>
						                	
						              </div>
						              <!-- /.tab-pane -->
						                       <div class="tab-pane no-margin" id="tab_3">
						                	<%
						                		if(empReg.getBankDetail() != null)
						                		{
						                			BankDetail bd = empReg.getBankDetail();
						                			%>
							                			<div class="form-horizontal">
											              <div class="box-body">
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label" style="text-align: left;">Bank Name</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= bd.getBankName() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">Account Number</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= bd.getAccountNo() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">IFSC Code</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= bd.getIfscCode() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">Name As Per Bank Record</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= bd.getNameAsBankRecord() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">Basic Salary</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= bd.getBasicSalary() %></label>
											                  </div>
											                </div>
											                <div class="form-group col-md-6">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">PLI</label>
											                  <div class="col-sm-8">
											                    <label class="form-control label-text"><%= bd.getPli()%></label>
											                  </div>
											                </div>
											                <%
											                	if(bd.getPanNo() != null && bd.getPanNo().trim().length() > 0)
											                	{
											                		%>
														                <div class="form-group col-md-6">
														                  <label class="col-sm-4 control-label"  style="text-align: left;">Pan Card No</label>
														                  <div class="col-sm-8">
														                    <label class="form-control label-text"><%= bd.getPanNo()%></label>
														                  </div>
														                </div>
											                		<%
											                	}
											                	else
												                {
											                		%>
														                <div class="form-group col-md-6">
														                  <label class="col-sm-4 control-label"  style="text-align: left;">Pan Card No</label>
														                  <div class="col-sm-8">
														                    <label class="form-control label-text">NA</label>
														                  </div>
														                </div>
											                		<%
												                }
											                %>
											                
											                <div class="clearfix"></div>
											                <div class="form-group has-feedback col-md-6">
																<a href="empEditBankDetail?empid=<%= empReg.getUserid() %>" class="btn btn-primary btn-flat">Edit Bank Info</a>
															</div>
											              </div>
											              
											            </div>
						                			<%
						                		}
						                		else
						                		{
						                			%>
						                				<div class="form-horizontal">
											              <div class="box-body">
												              <div class="form-group has-feedback col-md-6">
																	<a href="empBankDetail?empid=<%= empReg.getUserid() %>" class="btn btn-primary btn-flat">Add Bank Info</a>
																</div>
											              </div>
										                </div>
						                			<%
						                		}
						                	%>
						                	
						              </div>
						             <!-- /.tab-pane -->   
						              <div class="tab-pane no-margin" id="tab_4">
						              	<form action="adminEmpChangePassword" method="POST" id="changePsw">		
											<div class="box-body">
												<div class="form-horizontal">
													<div class="box-body">
														
														<div class="form-group has-feedback col-md-6">
															<label class="col-sm-4 control-label" style="text-align: left;">New Password</label>
															<div class="col-sm-8">
																<input type="password" class="form-control" placeholder="New Password" name="newPassword"  required="required">
																<input type="hidden" name="empid" value="<%= empReg.getUserid()%>">
								        						<span class="fa fa-lock  form-control-feedback"></span>
															</div>
														</div>
														<div class="clearfix"></div>
														<div class="form-group has-feedback col-md-6">
															<label class="col-sm-4 control-label" style="text-align: left;">Confirm Password</label>
															<div class="col-sm-8">
																<input type="password" class="form-control" placeholder="Confirm Password" name="confPassword"  required="required">
					        									<span class="fa fa-lock  form-control-feedback"></span>
															</div>
														</div>
														<div class="clearfix"></div>
														<div class="form-group has-feedback col-md-6">
															<button type="submit" class="btn btn-primary btn-flat pull-right" style="margin-right: 15px;">Change Password</button>
														</div>
													</div>
												</div>
											</div>
										</form>
						              </div>
						              <!-- /.tab-pane -->
						              
						            </div>
						            <!-- /.tab-content -->
						          </div>
							</div>
						</div>
						
					</div>
				</div>
    </section>
	<%
	}
%>
    <!-- /.content -->
</div>
<script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">
$('#dob').datetimepicker({
	timepicker:false,
	format:'d-m-Y'
});
$('#joiningDate').datetimepicker({
	timepicker:false,
	format:'d-m-Y'
});

$(document).ready(function()
{
	$("#changePsw").trigger('reset');
});

</script>	
<script type="text/javascript">
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
	

</script>  
 </body>