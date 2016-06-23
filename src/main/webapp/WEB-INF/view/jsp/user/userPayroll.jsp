<%@page import="java.util.Calendar"%>
<%@page import="com.ems.config.Roles"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="java.util.Date"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Payroll"%>
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

<link rel="stylesheet" href="css/fullcalendar.css">
<link rel="stylesheet" href="css/fullcalendar.print.css" media="print">
 <script src="js/jQuery-2.2.0.min.js"></script>

</head>
<body>
	<div class="content-wrapper">
	
    <!-- Content Header (Page header) -->
 <%
		Registration registration = (Registration)request.getSession().getAttribute("registration");
	    System.out.println("Regi : " + registration);
	    String mode=(String)request.getAttribute("mode");
	    System.out.println("mode  .."+mode);
	%>
			    <section class="content-header">
			    
			    
			  
			      <h1 class="page-header"> My Payroll
				      <small><%= registration.getName() %></small>
			      </h1>
			     </section>
			    
			    <!-- Main content -->
	<section class="content">
				  <!-- Your Page Content Here -->
			<div class="row">
				<div class="col-xs-12 col-md-12">
					<div class="box box-info">
						<div class="box-header with-border">
							<h3 class="box-title">My Payroll
	       					</h3>
					    </div>
				<div class="box-body no-padding">
					<table class="table">
						<thead>
							<tr>
							    <th>Month</th>
								<th>Basic Salary</th>
								<th>Advance Salary</th>
								<th>PF Deduction</th>
								<th>Total Deduction</th>
								<th>Total Earning</th>
								<th>Net Pay</th>
								<th class="text-center">Action</th>
							</tr>
						</thead>
						<tbody>
						   <%
								List<Payroll> payrollList = (List)request.getAttribute("payrollList");
								if(payrollList != null && !payrollList.isEmpty())
								{
									int i=1;
									for(Payroll pr : payrollList)
									{
										%>
									<tr>
									    <td><%= DateFormats.MMMformat().format(pr.getCreateDate()) %></td>
										<td><%= pr.getBasicSal() %></td>
										<td><%= pr.getSalaryAdvance() %></td>
										<td><%= pr.getPfDeduction() %></td>
										<td><%= pr.getTotelDeduction() %></td>
										<td><%= pr.getTotelEarning() %></td>
										<td><%= pr.getNetPay() %></td>
										<td class="text-center">
										  <a class="btn btn-primary btn-xs" href="userPayroll?pid=<%= pr.getPid()%>" ><i class="fa fa-fw fa-clock-o"></i>View</a>
									    </td>
											</tr>
										<%
									}
								}
							else
								{
									%>
										<tr>
										<td colspan="8" >No data in the data source.</td>
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
		<%
		
	if(mode!=null){	
		if(mode.equalsIgnoreCase("view")){
			
		Payroll payroll=(Payroll)request.getAttribute("payroll");	
	    System.out.println("mode"+mode);
		%>	
		
			<div class="box box-info">
			
					<div class="box-header with-border">
						<h3 class="box-title">View Payroll</h3>
 					</div>
			
				<div class="box-body no-padding">
						
					<div class="form-horizontal">
									
						 <div class="box-body">
						            
			                  <div class="form-group col-md-6">
						        <label class="col-sm-4 control-label" style="text-align: left;">Name</label>
						         <div class="col-sm-8">
						          <label class="form-control label-text"><%= registration.getName() %></label>
						         </div>
						      </div>
						      <div class="form-group col-md-6">
						        <label class="col-sm-4 control-label"  style="text-align: left;">Joining Date</label>
						         <div class="col-sm-8">
						          <label class="form-control label-text"><%= DateFormats.ddMMMyyyy().format(registration.getJoiningDate()) %></label>
						         </div>
						      </div>
			                   <div class="form-group col-md-6">
						        <label class="col-sm-4 control-label" style="text-align: left;">Department</label>
						         <div class="col-sm-8">
						          <label class="form-control label-text"><%= registration.getDepartment().getDepartment() %></label>
						         </div>
						      </div>
						       <div class="form-group col-md-6">
						        <label class="col-sm-4"  style="text-align: left;">Designation</label>
						         <div class="col-sm-8">
						          <label class="form-control label-text"><%= registration.getDesignation().getDesignation() %></label>
						         </div>
						      </div>
						       <div class="form-group col-md-6">
						        <label class="col-sm-4 control-label" style="text-align: left;">Basic Salary</label>
						         <div class="col-sm-8">
						          <label class="form-control label-text"><%= payroll.getBasicSal() %></label>
						         </div>
						      </div>
						      <div class="form-group col-md-6">
			                   <label class="col-sm-4 control-label" style="text-align: left;">H R Allowances</label>
			                    <div class="col-sm-8">
			                     <label class="form-control label-text"><%= payroll.getHrAllowance() %></label>
			                    </div>
			                  </div>
			                
			                 <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">Transport Allowance</label>
			                   <div class="col-sm-8">
			                    <label class="form-control label-text"><%= payroll.getTransportAllowance() %></label>
			                   </div>
			                 </div>
			                
			                  <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">Leave Travel Allowances</label>
			                   <div class="col-sm-8">
			                    <label class="form-control label-text"><%= payroll.getLeaveTravelAllowance() %></label>
			                   </div>
			                 </div>
			                
			                 <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">Special Allowance</label>
			                   <div class="col-sm-8">
			                    <label class="form-control label-text"><%= payroll.getSpecialAllowance() %></label>
			                   </div>
			                 </div>
			                
			                  <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">Salary Advance</label>
			                   <div class="col-sm-8">
			                    <label class="form-control label-text"><%= payroll.getSalaryAdvance() %></label>
			                   </div>
			                 </div>
			                 
			                 <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">PF Deductions</label>
			                   <div class="col-sm-8">
			                    <label class="form-control label-text"><%= payroll.getPfDeduction() %></label>
			                   </div>
			                  </div>
			                
			                  <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">TDS Deductions</label>
			                   <div class="col-sm-8">
			                    <label class="form-control label-text"><%= payroll.getTdsDeduction() %></label>
			                   </div>
			                 </div>
			                 
			                  <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">Food Deductions</label>
			                   <div class="col-sm-8">
			                    <label class="form-control label-text"><%= payroll.getFoodDeduction() %></label>
			                   </div>
			                  </div>
			                
			                  <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">Rent Deductions</label>
			                   <div class="col-sm-8">
			                    <label class="form-control label-text"><%= payroll.getRentDeduction() %></label>
			                   </div>
			                 </div>
			                
			                  <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">Other Deductions</label>
			                   <div class="col-sm-8">
			                    <label  class="form-control label-text"><%= payroll.getOtherDeduction() %></label>
			                   </div>
			                 </div>
			                
			                <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">Total Earning</label>
			                   <div class="col-sm-8">
			                    <label class="form-control label-text"><%= payroll.getTotelEarning() %></label>
			                   </div>
			                  </div>
			                
			                  <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">Total Deductions</label>
			                   <div class="col-sm-8">
			                    <label class="form-control label-text"><%= payroll.getTotelDeduction() %></label>
			                   </div>
			                 </div>
			                
			                  <div class="form-group col-md-6">
			                  <label class="col-sm-4 control-label" style="text-align: left;">Net Pay</label>
			                   <div class="col-sm-8">
			                    <label  class="form-control label-text"><%= payroll.getNetPay() %></label>
			                   </div>
			                 </div>
			                
			                
			             </div>
			          </div>
			       </div>
			   </div>
			<%
		}
	}
		%>		  
				  
				
		</section>
    </div>
 </body>