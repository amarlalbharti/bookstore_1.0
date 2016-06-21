<%@page import="com.ems.domain.Branch"%>
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
    
    <!-- Main content -->
    <section class="content">
		
      <!-- Your Page Content Here -->
		<div class="row">
				<div class="col-xs-12 col-md-12">
				<%
					String status = (String)request.getParameter("status");
					String dStatus = (String)request.getParameter("dStatus");
				
				    if(status != null)
				    {
				    	if(status.equals("success"))
						{
				    	%>
				    		<div class="alert alert-success alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Success !
								</h4>
								New branch add successfully !
							</div>
				    	<%
						}
				    	else if(status.equals("success_update"))
						{
				    	%>
				    		<div class="alert alert-success alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa fa-check"></i> Success !
								</h4>
								Branch updated successfully !
							</div>
				    	<%
						}
				    	if(status.equals("failed"))
						{
				    	%>
				    		<div class="alert alert-danger alert-dismissible">
									<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
									<h4>
										<i class="icon fa  fa-remove"></i> Failed !
									</h4>
									Oops, Opration failed !
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
					Branch delete successfully !
				</div>
			</div>
			<div class="col-xs-12 col-md-12">
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Branch List</small>
       					</h3>
       					<div class="box-tools pull-right">
				         <div class="pull-right " style="padding-left: 20px;">
				         	<a href="adminAddBranch" ><button class="btn btn-primary btn-sm"><i class="fa fa-fw fa-plus"></i> Add Branch</button> </a>
				         </div>
				       </div>
					</div>
					<div class="box-body table-responsive">
						<table class="table table-hover">
							<thead>
								<tr>
									<th width="2%">S.n.</th>
									<th width="10%">Branch Name</th>
									<th width="6%">Contact No</th>
									<th width="15%">Address</th>
									<th width="5%">Pin Code</th>
									<th width="5%">Country</th>
									<th width="10%" class="text-center">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
								List<Branch> bList = (List)request.getAttribute("bList");
								if(bList != null && !bList.isEmpty())
								{
									int i = 1;
									for(Branch br : bList)
									{
										%>
											<tr>
												<td><%= i++ %></td>
												<td><%= br.getBranchName() %> </td>
												<td><%= br.getPhoneNo() %> </td>
												<td><%= br.getAddress() %> </td>
												<td><%= br.getPinCode() %> </td>
												<td><%= br.getCountry().getCountryName() %> </td>
												<td class="text-center"> 
												<a class="btn btn-primary btn-xs" href="adminAddBranch?branchId=<%=br.getBranchId() %>" ><i class="fa fa-fw fa-edit"></i> Edit</a>
												&nbsp;
												<a id="<%=br.getBranchId() %>" class="btn btn-primary btn-xs dl" href="javascript:void" ><i class="fa fa-fw fa-remove"></i> Delete</a>
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
  
 <script type="text/javascript">
	$(document.body).on("click", ".dl", function(){
		var brid = $(this).attr("id");
		var btn =$(this);
		var row = $(this).parent().parent();
		
		var r = confirm("Are you sure to delete branch ?");
		if (r) 
		{
			$.ajax({
				type : "GET",
				url : "adminDeleteBranch",
				data : {'brid':brid},
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
</script> 
</body>