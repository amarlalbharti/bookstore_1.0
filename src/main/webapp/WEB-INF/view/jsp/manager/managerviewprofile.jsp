<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.domain.BankDetail"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="com.ems.domain.UserDetail"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
 <script src="js/jQuery-2.2.0.min.js"></script>
</head>
<body>

<%
TimeZone timeZone = (TimeZone) request.getSession().getAttribute("timezone");
	
	Registration empReg = (Registration)request.getAttribute("registration");
	UserDetail userDetail = empReg.getUserDetail();
	System.out.println("Regi : " + empReg);
	%>
	<div class="content-wrapper">
    
    <!-- Main content -->
    <section class="content">
		      <!-- Your Page Content Here -->
		<div class="row">
			<div id="msg" class="col-xs-12 col-md-12">
				
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
				              <li><a href="#tab_3"  data-toggle="tab">Account Details</a></li>
				              <li><a href="#tab_4" data-toggle="tab">Change Password</a></li>
				              
				            </ul>
				            <div class="tab-content">
				              <div class="tab-pane active" id="tab_1">
									<div class="form-horizontal">
								              <div class="box-body">
								              <div class="form-group col-md-6" align="center">
								                  <%	
			 						                if(empReg.getProfileImage() != null && !empReg.getProfileImage().isEmpty())
			 						                {
			 						                	String path = "/ems_uploads/"+empReg.getUserid()+"/Profile_Photo/" + empReg.getProfileImage();
									            %>
														<img alt="Error" src="<%=path %>" style="max-height: 150px; max-width: 100px" />
												<% } else { %>
														<img alt="Image" src="images/User_Avatar.png" style="max-height: 150px; max-width: 100px" />
												<% } %>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label" style="text-align: left;">Name</label>
								
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= empReg.getName() %></label>
								                  </div>
								                
								                  <label class="col-sm-4 control-label"  style="text-align: left;">User ID</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= empReg.getUserid() %></label>
								                  </div>
								                
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Gender</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= empReg.getGender()%></label>
								                  </div>
								                </div>
								                
								                <div class="clearfix"></div>
								                <div class="form-group col-md-6">
								                <label class="col-sm-4 control-label"  style="text-align: left;">DOB</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= empReg.getDob() %></label>
								                  </div>
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Join Date</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= DateFormats.ddMMMyyyy(timeZone).format(empReg.getJoiningDate()) %></label>
								                  </div>
								                
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Registration</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= DateFormats.ddMMMyyyy(timeZone).format(empReg.getRegdate()) %></label>
								                  </div>
								               </div>
								               <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Department</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= empReg.getDepartment().getDepartment() %></label>
								                  </div>
								                
								                
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Designation</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= empReg.getDesignation().getDesignation() %></label>
								                  </div>
								                  
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Branch</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= empReg.getBranch().getBranchName() %></label>
								                  </div>
								                  
								                </div>
								              </div>
						                <a href="managerEditEmployee?empid=<%= empReg.getUserid()%>"><button class="btn btn-primary"><i class="fa fa-fw fa-edit"></i>Edit Info</button></a>
						            </div>
							</div>
							<div class="tab-pane" id="tab_2">
									<div class="form-horizontal">
						              <div class="box-body">
						               <%							
									     if(userDetail != null)
											{
												%>	
												
								                <div class="form-group col-md-6">
								                   <label class="col-sm-4 control-label" style="text-align: left;">Permanent Address</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getParmanentAddress() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Present Address</label>
								                  <div class="col-sm-8">
								                    <label class="form-control label-text"><%= userDetail.getPresentAddress() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">City</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= userDetail.getCity() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">State</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= userDetail.getState() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Country</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= userDetail.getCountry() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Mobile Number</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= userDetail.getMobileNo()%></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Other Number</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= userDetail.getEmergencyNo() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Qualification</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= userDetail.getQualification() %></label>
								                  </div>
								                </div>
								                
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Blood Group</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= userDetail.getBloodGroup() %></label>
								                  </div>
								                </div>
								                <div class="form-group col-md-6">
								                  <label class="col-sm-4 control-label"  style="text-align: left;">Marital Status</label>
								                  <div class="col-sm-8">
								                    <label class="form-control"><%= userDetail.getMaritalStatus() %></label>
								                  </div>
								                </div>
								                
								                <div class="form-group col-md-6">
								                <a href="managerAddOtherInfo?empid=<%= empReg.getUserid() %>&pg=edit"><button class="btn btn-primary "><i class="fa fa-fw fa-edit"></i>Edit Other Info</button></a>
								                </div>
								                <%
											}else{
												%>
												<div class="col-xs-6 col-md-6">
												<div class="box-body">
												<div class="box-footer col-xs-12 col-md-12">
											    <a href="managerAddOtherInfo" class="btn btn-primary">Add Other Details</a>
											    </div></div></div>
												<%
													}
												%>
						             
						              </div>
						            </div>
							</div>
							<div class="tab-pane no-margin" id="tab_3">
				                	<div class="form-horizontal">
									<div class="box-body">
				                	<%
				                		if(empReg.getBankDetail() != null)
				                		{
				                			BankDetail bd = empReg.getBankDetail();
				                			%>
					                			
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
				                			<%
				                		}
				                		else
				                		{
				                			%>
										              <div class="form-group has-feedback col-md-6">
															<a href="empBankDetail?empid=<%= empReg.getUserid() %>" class="btn btn-primary btn-flat">Add Bank Info</a>
														</div>
				                			<%
				                		}
				                	%>
				                	</div>
				                	</div>
				              </div>
						   <div class="tab-pane" id="tab_4">
						    <form action="managerchangepassword" method="get">		
									<div class="form-horizontal">
										<div class="box-body">
											<div class="form-group has-feedback col-md-6">
												<label class="col-sm-4 control-label" style="text-align: left;">Current Password</label>
												<div class="col-sm-8">
													<input type="password" class="form-control" placeholder="Current Password" name="j_password1" id="j_password1" required="required">
													<input type="hidden" name="userid" value="<%= empReg.getUserid()%>">
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
												<button type="submit" class="btn btn-primary btn-flat">Submit</button>
											</div>
										</div>
									</div>
							</form>
						</div>
				</div></div>
			</div>
		   </div>
		  </div>
		</div>
    </section>
    
   
    <!-- /.content -->
  </div>
 </body>