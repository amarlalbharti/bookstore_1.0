<%@page import="java.util.TimeZone"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.ems.config.Roles"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="java.util.Date"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Attendance"%>
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
<link rel="stylesheet" href="css/select2.min.css">
<link rel="stylesheet" href="css/fullcalendar.css">
<link rel="stylesheet" href="css/fullcalendar.print.css" media="print">
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
<style type="text/css">

.ul {
    margin:0px;
    padding:0px;
    position:absolute;
    width: 100%; 
}
.ul li {
    list-style:none;
    display:block;
    border:1px solid #2e2e2e;
    background:#f9f9f9;
    padding: 2px 5px;
    
}
</style>
</head>
<body>
	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <%
    	TimeZone timeZone = (TimeZone) request.getSession().getAttribute("timezone");
    	List<Attendance> lm_atts = (List)request.getAttribute("attList");
    	Registration empReg = (Registration)request.getAttribute("empReg");
    	if(empReg != null)
    	{
    		Calendar joiningCal = Calendar.getInstance();
    		joiningCal.setTime(empReg.getJoiningDate());
    		
    		
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
		
			    <section class="content-header">
			      <h1 class="page-header"> Employee Attendance
				      <small><%= empReg.getName() %></small>
			      </h1>
			      <ol class="breadcrumb">
			        <li><a href="adminDashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
			        <li><a href="adminEmployees"><i class="fa fa-dashboard"></i> Employee List</a></li>
			        <li class="active"><%= empReg.getUserid() %></li>
			      </ol>
			    </section>
			    
			    <!-- Main content -->
			    <section class="content">
				  <!-- Your Page Content Here -->
				  	<div class="row">
					  	<div class="col-xs-12 col-md-6">
					  		
					  		<div class="box box-info">
					            <div class="box-body" style="min-height: 210px;">
					            	<div class=" col-xs-12 emp_search input-group input-group-sm margin-bottom">
						               <div class=" col-xs-4 text-bold">
						               		Search Employee
						               </div>
						               <div class=" col-xs-8 no-padding">
											<select id ="search_emp" class="form-control search_emp" style="width: 100%">
	                						</select>
						               </div>
						               
						            </div>
						            <div class="emp_detail" >
								  		<p><label class="form-control">Name : <%= empReg.getName() %></label></p>
								  		<p><label class="form-control">User Id : <%= empReg.getUserid() %></label></p>
								  		<p><label class="form-control">Department : <%= empReg.getDepartment().getDepartment() %></label></p>
								  		<p><label class="form-control">Designation : <%= empReg.getDesignation().getDesignation()%></label></p>
						            </div>
						            <div class="emp_search_list" style="display: none;">
						            </div>
					            </div>
					            <!-- /.box-body -->
					          </div>
					  		
					  		
					  	</div>
	
						<div class="col-xs-12 col-md-6">
							<div class="box box-info">
								<div class="box-header with-border">
					              <h3 class="box-title">Summary <small>For Month <%= DateFormats.MMMformat(timeZone).format(sdate) %> </small> </h3>
					              <button class="pull-right btn btn-primary btn-xs btn_use_filter">
					              <i class="fa fa-fw fa-plus"></i>	Filter
					              </button>
					            </div>
								<div class="box-body">
									<div class="form-group margin-bottom">
										<% 
											Calendar c_cal = Calendar.getInstance();
											Set<Date> set = new HashSet();
											int weekoffs = 0;
											int totaldays = 0;
											
											if(lm_atts != null && !lm_atts.isEmpty())
											{
												Calendar cals = Calendar.getInstance();
												for(Attendance at : lm_atts)
												{
													set.add(DateFormats.ddMMyyyy(timeZone).parse(DateFormats.ddMMyyyy(timeZone).format(at.getInTime())));
// 													cals.setTime(at.getInTime());
												}
												
												Date dt = lm_atts.get(0).getInTime();
												System.out.println("dt :"+dt);
												if(dt.getMonth() == new Date().getMonth() && dt.getYear() == new Date().getYear())
												{
													cals.setTime(dt);
													int month = cals.get(Calendar.MONTH);
													System.out.println(cals.getTime()+ " vs "+c_cal.getTime());
													while(cals.before(c_cal) && month == cals.get(Calendar.MONTH) )
													{
														totaldays++;
														if(cals.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)
														{
															weekoffs++;
														}
														cals.add(Calendar.DATE, -1);
													}
												}
												else
												{
													
													cals.setTime(dt);
													int month = cals.get(Calendar.MONTH);
													while(month == cals.get(Calendar.MONTH))
													{
														totaldays++;
														if(empReg.getJoiningDate().after(cals.getTime()))
														{
															break;
														}
														if(cals.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)
														{
															weekoffs++;
														}
														cals.add(Calendar.DATE, -1);
													}
												}
												
												
												
													System.out.println("Total Days : "+totaldays);
											}
											%>
												<label class="form-label"> Total Present : </label> <%= set.size() %> Days<br>
												<label class="form-label"> Total Week Off's : </label> <%= weekoffs %> Days<br>
												<label class="form-label"> Total Absents : </label> <%= totaldays-(weekoffs + set.size()) %> Days
											<%
										%>
										<br>
	             					</div>
             						<div>
             							<div class="export_data">
	             							<div class="form-group col-xs-12 col-md-6">
			       						 		<a class="btn btn-primary btn-flat"  href="adminEmpAttendanceExport?empid=<%= empReg.getUserid() %>&qm=<%= DateFormats.monthformat().format(sdate)%>" title="Click to export excel sheet" target="_blank"><i class="fa fa-fw fa-file-excel-o"></i> Export</a>
				       							
				       						</div>
				       					</div>
			       						 <div class="clearfix"></div>
			       						 <div class="export_filter" style="display: none;">
				       						 <form role="form" method="GET" action="adminEmpAttendanceExport" onsubmit="return report_validate()">
								              <div class="box-body">
									                <div class="form-group col-xs-12 col-md-6">
									                  <label >Start Date</label>
									                  <input name="sdate" id="sdate" class="form-control sdate"  placeholder="dd-MM-yyyy"/>
									                  <input type="hidden" name="empid" id="empid" value="<%=empReg.getUserid() %>" />
									                  <span class="text-danger"><form:errors path="name" /></span>
									                </div>
									                <div class="form-group col-xs-12 col-md-6">
									                  <label >Start Date</label>
									                  <input name="edate" id="edate" class="form-control edate"  placeholder="dd-MM-yyyy"/>
									                  <span class="text-danger"><form:errors path="name" /></span>
									                </div>
									                <div class="form-group col-xs-12 col-md-6">
									                	<button class="btn btn-primary btn-flat"   title="Click to export excel sheet" >
									                		<i class="fa fa-fw fa-file-excel-o"></i> Export
									                	</button>
									                </div>
								                </div>
							                </form>
							                <script type="text/javascript">
							                	function report_validate()
							                	{
							                		var empid = $("#empid").val();
							                		var sdate = $("#sdate").val();
							                		var edate = $("#edate").val();
							                		$(".has-error").removeClass("has-error")
							                		
							                		var valid = true;
							                		if(empid == "")
						                			{
						                				location.reload();
						                			}
							                		if(sdate == "")
						                			{
						                				$("#sdate").parent().addClass("has-error");
						                				valid = false;
						                			}
							                		if(edate == "")
						                			{
						                				$("#edate").parent().addClass("has-error");
						                				valid = false;
						                			}
							                		
							                		return valid;
							                	}
							                </script>
			       						 </div>
						            </div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						
						
						<div class="col-xs-12 col-md-12">
							<div class="box box-info">
								<div class="box-header with-border">
									<h3 class="box-title">Check In/Out <small>for <%= DateFormats.MMMformat(timeZone).format(sdate) %></small>
			       					
			       					</h3>
			       					<div class="box-tools pull-right">
							         <ul class="pagination pagination-sm inline">
							           <%
							           	Calendar joinDate = Calendar.getInstance();
										joinDate.setTime(empReg.getJoiningDate());
										System.out.println("==================================== ");
										
										Calendar sd = Calendar.getInstance();
										sd.setTime(sdate);
										
										System.out.println("joinDate : " + joinDate.getTime());
										System.out.println("pdate : " + sd.getTime());
										
							           	if(joinDate.get(Calendar.MONTH) >= sd.get(Calendar.MONTH) && joinDate.get(Calendar.YEAR) >= sd.get(Calendar.YEAR))
							           	{
							           		%>
									           <li class="disabled"><a ><i class="fa fa-fw fa-backward"></i></a></li>
							           		<%
							           	}
							           	else
							           	{
							           		%>
									           <li title='Previous month attendance'><a href="adminViewEmpAttendence?empid=<%= empReg.getUserid() %>&qm=<%= DateFormats.monthformat(timeZone).format(pdate)%>"><i class="fa fa-fw fa-backward"></i></a></li>
							           		<%
							           	}
							           %>
							           <li title='Current month attendance'><a href="adminViewEmpAttendence?empid=<%= empReg.getUserid() %>"><i class="fa fa-fw fa-home"></i></a></li>
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
									           <li title='Next month attendance'><a href="adminViewEmpAttendence?empid=<%= empReg.getUserid() %>&qm=<%= DateFormats.monthformat(timeZone).format(ndate)%>" ><i class="fa fa-fw fa-forward"></i></a></li>
											<%
							           	}
							           %>
							         </ul>
							         <div class="pull-right " style="padding-left: 20px;">
							         	<form>
							         		<input type="hidden" name="empid" value="<%= empReg.getUserid()%>">
								           <input type="text" name="qm" id="qm" class="from-control" placeholder="mm-yyyy" value="" title="Enter month in mm-yyyy format">
								           <button title="Click to view attendance">Go</button> 
							           </form>
							         </div>
							       </div>
								</div>
								<div class="box-body  table-responsive no-padding">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>Date</th>
												<th>Check In Time</th>
												<th>Check Out Time</th>
												<th>Working Hours</th>
												<th>Task</th>
												<th class="text-center">Action</th>
											</tr>
										</thead>
										<tbody>
										<%
											
											if(lm_atts != null && !lm_atts.isEmpty())
											{
												for(Attendance at : lm_atts)
												{
													%>
														<tr id="<%=at.getAid() %>">
															<td><%= DateFormats.ddMMMyyyy(timeZone).format(at.getInTime()) %> </td>
															<td><%= DateFormats.timeformat(timeZone).format(at.getInTime()) %> </td>
															<td><% if(at.getOutTime() != null){out.println( DateFormats.timeformat(timeZone).format(at.getOutTime()));}else{out.println("NA");} %></td>
															<td><%= DateFormats.getWorkingHours(at.getInTime(), at.getOutTime()) %></td>
															<%
																if(at.getTask() != null)
																{
																	%>
																		<td><%= at.getTask() %></td>
																	<%
																}
																else
																{
																	%>
																		<td>NA</td>
																	<%
																}
															%>
															<td class="text-center ">
																<button class="editAtt btn btn-primary btn-xs btn-flat" title="Click to Edit attendance">Edit</button> 
															</td>
															
															
														</tr>
													<%
												}
											}
											else
											{
												%>
													<tr>
														<td colspan="6">No data in the data source.</td>
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
    		<%
    	}
    %>
  </div>
<script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/jquery.datetimepicker.full.js"></script>
<script src="js/select2.full.min.js"></script>

 <script type="text/javascript">
 jQuery(document).ready(function() {

	$(document.body).on("click", ".editAtt", function() {
		var row = $(this).parent().parent();
		var aid =  $(this).parent().parent().attr("id");
		$.ajax({
			type : "GET",
			url : "editAttendance",
			data : {'aid':aid},
			contentType : "application/json",
			success : function(data) {
				var obj = jQuery.parseJSON(data);
				var att = obj.att;
				
				row.find("td:eq(1)").html("<input class='from-control timepicker inTime' type='text' placeholder='HH:mm AM' value='"+att.inTime+"'>");
				row.find("td:eq(2)").html("<input class='from-control timepicker outTime' type='text' placeholder='HH:mm AM' value='"+att.outTime+"'>");
				row.find("td:eq(4)").html("<input class='from-control timepicker task' type='text' value='"+att.task+"'>");
				row.find("td:eq(5)").html("<button class='updateAtt btn btn-primary btn-xs btn-flat'>Save</button>&nbsp;<button class='cancelAtt btn btn-danger btn-xs btn-flat'>Cancel</button>");
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
		});
	});
	
	$(document.body).on("click", ".updateAtt", function() {
		
		var btn = $(this);
		$(this).text("updating ...")
		var row = $(this).parent().parent();
		var aid =  $(this).parent().parent().attr("id");
		
		var inTime = row.find(".inTime").val();
		var outTime = row.find(".outTime").val();
		var task = row.find(".task").val();
// 		alert(inTime + " : "+ outTime);
		
		$.ajax({
			type : "GET",
			url : "updateAttendance",
			data : {'aid':aid,'inTime':inTime,'outTime':outTime,'task':task },
			contentType : "application/json",
			success : function(data) {
// 				alert(data);
				var obj = jQuery.parseJSON(data);
				if(obj.success)
				{
					var att = obj.att;
					/* row.find("td:eq(1)").html(inTime);
					row.find("td:eq(2)").html(outTime);
					row.find("td:eq(4)").html(task);
					row.find("td:eq(5)").html("<button class='editAtt btn btn-primary btn-xs btn=flat'>Edit</button>");
					 */
					row.find("td:eq(1)").html(att.inTime);
					if(att.outTime != "")
					{
						row.find("td:eq(2)").html(att.outTime);
					}
					else
					{
						row.find("td:eq(2)").html("NA");
					}
					row.find("td:eq(3)").html(att.wh);
					if(att.task != "")
					{
						row.find("td:eq(4)").html(att.task);
					}
					else
					{
						row.find("td:eq(4)").html("NA");
					}
					row.find("td:eq(5)").html("<button class='editAtt btn btn-primary btn-xs btn=flat'>Edit</button>");
					 
					 
				}
				else if(!obj.in_success)
				{
					btn.text("Save");
					row.find(".inTime").addClass("error");
				}
				else
				{
					btn.text("Save");
					row.find(".outTime").addClass("error");
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
		});
	});
	
	$(document.body).on("click", ".cancelAtt", function() {
		var row = $(this).parent().parent();
		var aid =  $(this).parent().parent().attr("id");
		$.ajax({
			type : "GET",
			url : "editAttendance",
			data : {'aid':aid},
			contentType : "application/json",
			success : function(data) {
				var obj = jQuery.parseJSON(data);
				var att = obj.att;
				
				row.find("td:eq(1)").html(att.inTime);
				if(att.outTime != "")
				{
					row.find("td:eq(2)").html(att.outTime);
				}
				else
				{
					row.find("td:eq(2)").html("NA");
				}
				row.find("td:eq(3)").html(att.wh);
				if(att.task != "")
				{
					row.find("td:eq(4)").html(att.task);
				}
				else
				{
					row.find("td:eq(4)").html("NA");
				}
				row.find("td:eq(5)").html("<button class='editAtt btn btn-primary btn-xs btn=flat'>Edit</button>");
				
				
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
		});
	});
});
	</script>

<script>
 $('.sdate').datetimepicker({
	timepicker:false,
	maxDate:new Date(),
	format:'d-m-Y'
});
$('.edate').datetimepicker({
	timepicker:false,
	maxDate:new Date(),
	format:'d-m-Y'
});

$(document).ready(function(){
	
	$(document.body).on("click", ".btn_use_filter", function() {
		$(".export_data").hide();
		$(".export_filter").show();
		$(this).addClass("btn_no_filter");
		$(this).removeClass("btn_use_filter");
		
	});
	
	$(document.body).on("click", ".btn_no_filter", function() {
		$(".export_filter").hide();
		$(".export_data").show();
		$(this).addClass("btn_use_filter");
		$(this).removeClass("btn_no_filter");
		
	});

});
</script>
<script type="text/javascript">
$(document.body).on("keyup", ".emp_search .emp_text", function() {
	$(".emp_detail").hide();
	$(".emp_search_list").show();
	var text = $(this).val();
	if(text.length < 3)
	{
		return false;
	}
	$(".emp_search_list").html("Searching...");
	$.ajax({
		type : "GET",
		url : "searchEmployees",
		data : {'search_text':text},
		contentType : "application/json",
		success : function(data) {
			var obj = jQuery.parseJSON(data);
			if(obj.success)
			{
				var list = obj.regList;
				$(".emp_search_list").html("");
				var dd = "<ul class='nav nav-pills nav-stacked'>";
				jQuery.each( list, function( i, val ) {
					dd += "<li><a href='#'><i class='fa fa-user'></i> "+val.name+" </a></li>";
				});
				dd += "</ul>";
				$(".emp_search_list").html(dd);
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
	        alert(xhr.status);
	      }
	});
});
</script>
<script src="js/select2.full.min.js"></script>
<script type="text/javascript">
$(function () {
    $("#search_emp").select2({
    	minimumInputLength: 3,
    	multiple: false,
        minimumResultsForSearch: 10,
        ajax: {
            url: 'searchEmployees',
            dataType: 'json',
            type: "GET",
            quietMillis: 50,
            data: function (term) {
                return {
                    q: term.term
                };
            },
            processResults: function (data) {
                return {
                    results: $.map(data, function (item) {
                        return {
                            text: item.name+" <"+item.userid+">",
                            id: item.userid
                        }
                    })
                };
            }
        }
    });
});

$(document).ready(function(){
	
	$(document.body).on("change", "#search_emp", function() {
		window.location.href = "adminViewEmpAttendence?empid="+$(this).val();
	});
});

</script>

 </body>