<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.domain.Documents"%>
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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
   	
    	Registration reg = (Registration)request.getSession().getAttribute("registration");
    
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
				    String uf_status = (String)request.getParameter("uf_status");
				    if(uf_status != null && uf_status.equals("success"))
					{
				    	%>
				    		<div class="alert alert-success alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Success !
								</h4>
								File Uploaded successfully  !
							</div>
				    	<%
					}
				    else if(uf_status != null && uf_status.equals("failed"))
					{
				    	%>
				    		<div class="alert alert-danger alert-dismissible">
									<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
									<h4>
										<i class="icon fa  fa-remove"></i> Failed !
									</h4>
									Oops, something wrong, file not saved !
								</div>
				    	<%
					}
				    
				    
				%>
			</div>
			<%
			Registration empReg = (Registration)request.getAttribute("empReg");
			%>
			<div class="col-xs-12 col-md-6">
					  		
		  		<div class="box box-info">
		  			<div class="box-header with-border">
						<h3 class="box-title">Employee Detail</h3>
					</div>
		            <div class="box-body">
				  		<p><label class="form-control">Name : <%= empReg.getName() %></label></p>
				  		<p><label class="form-control">User Id : <%= empReg.getUserid() %></label></p>
				  		<p><label class="form-control">Department : <%= empReg.getDepartment().getDepartment() %></label></p>
				  		<p><label class="form-control">Designation : <%= empReg.getDesignation().getDesignation()%></label></p>
		            </div>
		            <!-- /.box-body -->
		          </div>
		  		
		  		
		  	</div>
			<div class="col-xs-12 col-md-6">
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Upload New Documents</h3>
					</div>
					<div class="box-body table-responsive">
						
						<sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_MANAGER')">
							<form role="form" action="empDocuments" method="POST" enctype="multipart/form-data"  onsubmit="return validateForm()">
				              <div class="box-body">
				                <div class="form-group">
				                  <label>Document Name<span class="text-danger">*</span></label>
				                  <input type="text" id="doc_name" name="doc_name" placeholder="Enter document name" class="form-control titleCase" maxlength="100">
				                  <input type="hidden" name="empid" value="<%= empReg.getUserid() %>">
				                </div>
				                <div class="clearfix"></div>
				                <div class="form-group">
				                  <label>Document detail</label>
				                  <textarea placeholder="Enter document detail" name="doc_detail" id="doc_detail" class="form-control titleCase" ma></textarea>
				                </div>
				                <div class="clearfix"></div>
				                <div class="form-group">
									<label class="btn btn-primary btn-flat btn-xs"><!-- File input<span class="text-danger">*</span>  -->
									<input type="file" id="doc_file" name="file"> 
									<i class="fa fa-fw fa-cloud-upload"></i> Browse Doc
									</label>
									
								</div>
				              </div>
				              <!-- /.box-body -->
				              <div class="box-footer">
				                <button class="btn btn-primary" type="submit">Upload</button>
				              </div>
				            </form>
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_USER')">
							<form role="form" action="userDocuments" method="POST" enctype="multipart/form-data"  onsubmit="return validateForm()">
				              <div class="box-body">
				                <div class="form-group">
				                  <label>Document Name<span class="text-danger">*</span></label>
				                  <input type="text" id="doc_name" name="doc_name" placeholder="Enter document name" class="form-control titleCase" maxlength="100">
				                </div>
				                <div class="clearfix"></div>
				                <div class="form-group">
				                  <label>Document detail</label>
				                  <textarea placeholder="Enter document detail" name="doc_detail" id="doc_detail" class="form-control titleCase" ma></textarea>
				                </div>
				                <div class="clearfix"></div>
				                <div class="form-group" >
				                  <label class="btn btn-primary btn-flat btn-xs">
				                  <input type="file" id="doc_file" name="file">
				                  <i class="fa fa-fw fa-cloud-upload"></i> Browse Doc 
                                    </label>
				                </div>
				              </div>
				              <!-- /.box-body -->
				              <div class="box-footer">
				                <button class="btn btn-primary" type="submit">Upload</button>
				              </div>
				            </form>
						</sec:authorize>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-md-12">
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Employee Documents
       					</h3>
       				</div>
					<div class="box-body table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th width="10%">Sno.</th>
									<th width="30%">Document Name</th>
									<th width="40%">Document Detail</th>
									<th width="10%">Upload Date</th>
									<th width="10%" class="text-center">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
								List<Documents> docList = (List)request.getAttribute("docList");
								if(docList != null && !docList.isEmpty())
								{
									int i = 1;
									for(Documents doc : docList)
									{
										String file_path = "/ems_uploads/"+doc.getReg().getUserid()+"/documents/"+doc.getDoc_file();
										%>
											<tr>
												<td><%= i++ %></td>
												
												<td><a href="<%= file_path %>" target="_blank"><%= doc.getDocumentName()%> </a></td>
												<td><%= doc.getDocumentDetail() %> </td>
												<td><%= DateFormats.ddMMMyyyy(timeZone).format(doc.getCreateDate()) %> </td>
												
												<td class="text-center">
													<sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_MANAGER')">
														<button class="btn btn-danger btn-xs file_delete" id="<%= doc.getDid()%>"><i class="fa fa-fw fa-remove"></i> Delete</button>
													</sec:authorize>
													<sec:authorize access="hasRole('ROLE_USER')">
													<%
														if(reg.getUserid().equals(doc.getUploadedBy()))
														{
															%>
																<button class="btn btn-danger btn-xs file_delete" id="<%= doc.getDid()%>"><i class="fa fa-fw fa-remove"></i> Delete</button>
															<%
														}
														else
														{
															%>
																<button class="btn btn-danger btn-xs disabled" title="No rights to delete this file"><i class="fa fa-fw fa-remove"></i> Delete</button>
															<%
														}
													
													%>
													</sec:authorize>
												</td>
											</tr>
										<%
									}
								}
								else
								{
									%>
										<tr>
											<td colspan="5">No data in the data source.</td>
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
<script src="js/jQuery-2.2.0.min.js"></script>
 <script type="text/javascript">
	 function validateForm()
	 {
		 var doc_name = $("#doc_name").val();
		 var doc_file = $('#doc_file').val();
		 var doc_detail = $('#doc_detail').val();
		 
		 
		 var valid = true;
		 $('.has-error').removeClass("has-error");
		 $('.file_error').remove();
		 if(doc_name == "")
		 {
			 $("#doc_name").parent().addClass("has-error");
			 valid = false;
		 }
		 if(doc_file == "")
		 {
			 $("#doc_file").parent().parent().append("<label class='file_error text-red'>Please select file</label>")
			 valid = false;
		 }
		 if(doc_detail.length > 255)
		 {
			 $("#doc_detail").parent().addClass("has-error");
			 valid = false;
		 }
		 
		 
		 
		 if(!valid)
		 {
		 	return false;
		 }
		 $('.submit_btn').attr("disabled","disabled");
		 $('.submit_btn').text("Uploading...");
	 }
	 
	 
	 $(document.body).on("click", ".file_delete", function(){
			var did = $(this).attr("id");
			var row = $(this).parent().parent();
			
			
			
			var r = confirm("Are you sure to delete this file ?");
			if (r) 
			{
				$.ajax({
					type : "GET",
					url : "deleteDocument",
					data : {'did':did},
					contentType : "application/json",
					success : function(data) {
						var obj = jQuery.parseJSON(data);
						if(obj.status)
						{
							row.remove();
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