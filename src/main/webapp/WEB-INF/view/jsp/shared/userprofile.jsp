<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.domain.UserRole"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="com.ems.domain.UserDetail"%>
<%@page import="com.ems.domain.BankDetail"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
 
</head>
<body>

<%
	TimeZone timeZone = (TimeZone) request.getSession().getAttribute("timezone");
	
	Registration registration = (Registration)request.getAttribute("registration");
	List<UserRole> roles = (List)request.getAttribute("roles");
	UserDetail userDetail = registration.getUserDetail();
	BankDetail bankDetail = registration.getBankDetail();
	System.out.println("Regi : " + registration);
	%>
	<div class="content-wrapper">
    <section class="content-header">
      <h1 class="page-header">View Profile<small><%= registration.getName() %> (<%= registration.getUserid() %>)</small> </h1>
      
    </section>
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
			
				
			<%
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
					
					
					else if(pwdstatus.equalsIgnoreCase("notvalid"))
					{
						%>
							<div class="alert alert-danger alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Failed !
								</h4>
								Oops, Password is not valid. Use alphanumeric password !
							</div>
						<%
					}
					else if(pwdstatus.equalsIgnoreCase("notmatch"))
					{
						%>
							<div class="alert alert-danger alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Failed !
								</h4>
								Oops, Old Password not matched !
							</div>
						<%
					}
					else if(pwdstatus.equalsIgnoreCase("notsame"))
					{
						%>
							<div class="alert alert-danger alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Failed !
								</h4>
								Oops, confirm password not matched !
							</div>
						<%
					}
					else
					{
						%>
							<div class="alert alert-danger alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Failed !
								</h4>
								Oops, Something wrong !
							</div>
						<%
					}
					
				}
				
			%>
			</div>
			
			<div class="col-xs-12 col-md-12">
				<div class="box box-info">
					<div class="box-body no-padding">
						<div class="nav-tabs-custom no-margin">
				            <ul class="nav nav-tabs">
				              <li class="active"><a href="#tab_1" data-toggle="tab">Profile Summary</a></li>
				              <li><a href="#tab_2" data-toggle="tab">Other Detail</a></li>
				               <li><a href="#tab_3" data-toggle="tab">Bank Detail</a></li>
				              <li><a href="#tab_4" data-toggle="tab">Change Password</a></li>
				              
				              </ul>
				            <div class="tab-content">
				              <div class="tab-pane active" id="tab_1">
								<div class="box-body">
									<div class="form-horizontal">
						              <div class="box-body">
		                                     <div class="form-group col-md-6 no-margin">
								                	 <div class="form-group col-md-12 no-margin" >
									                	<%
									                		if(registration.getProfileImage() != null)
									                		{
									                			String path = "/ems_uploads/"+registration.getUserid()+"/Profile_Photo/" + registration.getProfileImage();
												                %>
												                	<a class="col-md-12" href="<%= path %>"><img alt="<%= registration.getName() %>" src="<%=path %>" style="max-height: 150px; max-width: 100px" class="profile_image"/></a>
												                <%
									                		}
									                		else
									                		{
									                			%>
									                				<img alt="<%= registration.getName() %>" src="images/Camera_Icon.png" style="max-height: 150px; max-width: 100px" />
									                			<%
									                		}
									                	
									                	%>
								                	 </div>
								                	 
								                </div>
								                <div class="form-group col-md-6 no-padding no-margin">
									                <div class="form-group col-md-12 no-margin">
									                  <label class="col-sm-4 control-label" style="text-align: left;">Employee Id</label>
									                  <div class="col-sm-8">
									                    <label class="form-control label-text"><%= registration.geteId() %></label>
									                  </div>
									                </div>
									                <div class="form-group col-md-12 no-margin">
									                  <label class="col-sm-4 control-label" style="text-align: left;">Name</label>
									                  <div class="col-sm-8">
									                    <label class="form-control label-text"><%= registration.getName() %></label>
									                  </div>
									                </div>
									                <div class="form-group col-md-12 no-margin">
									                  <label class="col-sm-4 control-label"  style="text-align: left;">User ID</label>
									                  <div class="col-sm-8">
									                    <label class="form-control label-text"><%= registration.getUserid() %></label>
									                  </div>
									                </div>
									                
								                </div>
								                
								                <div class="form-group col-md-6 no-margin">
									                  <label class="col-sm-4 control-label"  style="text-align: left;">Gender</label>
									                  <div class="col-sm-8">
									                    <label class="form-control"><%= registration.getGender()%></label>
									                  </div>
									                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">DOB</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= registration.getDob() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Join Date</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= DateFormats.ddMMMyyyy(timeZone).format(registration.getJoiningDate()) %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Registration</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= DateFormats.ddMMMyyyy(timeZone).format(registration.getRegdate()) %></label>
								                  </div>
								                </div>
								                <%	
													if( registration.getDepartment().getDepartment() != null && ! registration.getDepartment().getDepartment().isEmpty())
								 					{
										 						
												%>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Department</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= registration.getDepartment().getDepartment() %></label>
								                  </div>
								                </div>
								                <%
								 					}
								                %>
								                <%	
													if( registration.getDesignation().getDesignation() != null && ! registration.getDesignation().getDesignation().isEmpty())
								 					{
										 						
												%>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Designation</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= registration.getDesignation().getDesignation() %></label>
								                  </div>
								                </div>
								             <%
								 					}
								             %>
								             <%	
													if( registration.getBranch().getBranchName() != null && ! registration.getBranch().getBranchName().isEmpty())
								 					{
										 						
												%>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Branch</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= registration.getBranch().getBranchName() %></label>
								                  </div>
								                </div>
								                
								                <%
								 					}
								                %>
								                
								                
								                <%	
													if( registration.getBranch().getCountry().getCountryName() != null && ! registration.getBranch().getCountry().getCountryName().isEmpty())
								 					{
										 						
												%>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Country</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= registration.getBranch().getCountry().getCountryName() %></label>
								                  </div>
								                </div>
								                
								                <%
								 					}
								                %>
								                
								                
								                
								                <%
								                	
								                	if(roles != null && !roles.isEmpty())
								                	{
								                		%>
								                			<div class="form-group col-md-6 no-margin">
											                  <label class="col-sm-4 control-label"  style="text-align: left;">User Role</label>
											                  <div class="col-sm-8">
											                    <label class="form-control"><%= roles.get(0).getUserrole() %></label>
											                  </div>
											                </div>
								                		<%
								                	}
								                
								                %>
								                
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Week Off</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= DateFormats.getDayName(registration.getWeekOff()) %></label>
								                  </div>
								                </div>
						                
						              </div>
						            </div>
								</div>
							</div>
							<div class="tab-pane" id="tab_2">
								<div class="box-body">
									<div class="form-horizontal">
						              <div class="box-body">
						               <%							
									     if(userDetail != null)
											{
												%>	
								                <div class="form-group col-md-6 no-margin">
								                   <label class="col-sm-4 control-label" style="text-align: left;">Permanent Addr</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getParmanentAddress() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Present Addr</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getPresentAddress() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">City</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getCity() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">State</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getState() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Country</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getCountry() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Mobile Number</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getMobileNo()%></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Alter. Mobile</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getEmergencyNo() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Qualification</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getQualification() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Blood Group</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text "><%= userDetail.getBloodGroup() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Marital Status</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getMaritalStatus() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Alter. MailId</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getAltEmailId() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Passport Number</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getPassportNo() %></label>
								                  </div>
								                  </div>
								                
								                <div class="clearfix"></div>
								                <sec:authorize access="hasRole('ROLE_USER')">
									                <a href="userEditDetail?id=<%= userDetail.getUserId() %>" class="btn btn-primary btn-flat">Edit Info</a>
								                </sec:authorize>
												
								                <%
											}else{
												%>
												<div class="col-xs-6 col-md-6 no-margin">
													<div class="box-body">
														<div class="box-footer col-xs-12 col-md-12">
													    <a href="userOtherDetail" class="btn btn-primary btn-flat">Add Other Details</a>
												    	</div>
												    </div>
											    </div>
												<%
													}
												%>
						             
						              </div>
						            </div>
								</div>
							</div>
						   <div class="tab-pane" id="tab_4">
						    <form action="userchangepassword" method="POST" id="changePwd">		
								<div class="box-body">
									<div class="form-horizontal">
										<div class="box-body">
											<div class="form-group has-feedback col-md-6">
												<label class="col-sm-4 control-label" style="text-align: left;">Current Password</label>
												
												<div class="col-sm-8">
													<input type="password" class="form-control" placeholder="Current Password" name="j_password1" id="j_password1" required="required">
													<input type="hidden" name="userid" value="<%= registration.getUserid()%>">
			        								<span class="fa fa-lock  form-control-feedback"></span>
												</div>
											</div>
											<div class="clearfix"></div>
											<div class="form-group has-feedback col-md-6">
												<label class="col-sm-4 control-label" style="text-align: left;">New Password</label>
												
												<div class="col-sm-8">
													<input type="password" class="form-control" placeholder="Change Password" name="j_password2" id="j_password2" required="required">
					        						<span class="fa fa-lock  form-control-feedback"></span>
												</div>
											</div>
											<div class="clearfix"></div>
											<div class="form-group has-feedback col-md-6">
												<label class="col-sm-4 control-label" style="text-align: left;">Confirm Password</label>
												
												<div class="col-sm-8">
													<input type="password" class="form-control" placeholder="Confirm Password" name="j_password3" id="j_password3" required="required">
		        									<span class="fa fa-lock  form-control-feedback"></span>
												</div>
											</div>
											<div class="clearfix"></div>
											<div class="form-group has-feedback col-md-6">
												<button type="submit" class="btn btn-primary btn-flat" id="submit_btn">Submit</button>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
						
						
						
						<div class="tab-pane" id="tab_3">
								<div class="box-body">
									<div class="form-horizontal">
						              <div class="box-body">
						               <%							
									     if(bankDetail != null)
											{
												%>	
								                <div class="form-group col-md-6 no-margin">
								                   <label class="col-sm-4 control-label" style="text-align: left;">Bank Name</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= bankDetail.getBankName()%></label>
								                  </div>
								                 </div>
								               
									             <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">PAN Number</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= bankDetail.getPanNo() %></label>
								                  </div>
								                 </div>
								                
								                 <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">IFSC Code</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= bankDetail.getIfscCode() %></label>
								                  </div>
								                 </div>
								                
								                 <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Basic Salary</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= bankDetail.getBasicSalary() %></label>
								                  </div>
								                 </div>
								                 
								                 <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Account Number</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= bankDetail.getAccountNo() %></label>
								                  </div>
								                 </div>
								                 <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">PLI</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= bankDetail.getPli() %></label>
								                  </div>
								                 </div>
								                 <div class="form-group col-md-6 no-margin">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Name As Per Bank Record</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= bankDetail.getNameAsBankRecord() %></label>
								                  </div>
								                 </div>
								                 
								                <div class="clearfix"></div>
								                <sec:authorize access="hasRole('ROLE_MANAGER') or hasRole('ROLE_ADMIN')">
									                <a href="userEditBankDetail?Mode=edit" class="btn btn-primary btn-flat">Edit Info</a>
								                </sec:authorize>
												
								                <%
											}else{
												%>
												<div class="col-xs-6 col-md-6 no-margin">
													<div class="box-body">
														<div class="box-footer col-xs-12 col-md-12">
														<%
														out.println("Bank Details not available yet");
														%>
													   <!--  <a href="userBankDetail?Mode=add" class="btn btn-primary">Add Bank Details</a> -->
													    </div>
												    </div>
											    </div>
												<%
													}
												%>
						             
						              </div>
						            </div>
								</div>
							</div>
						   
						
						
						
						
				</div></div>
			</div>
		   </div>
		  </div>
		</div>
    </section>
<script type="text/javascript">
	$(document).ready(function()
	{
		$("#changePwd").trigger('reset');
	});

	
</script>  
   
    <!-- /.content -->
  </div>
 </body>