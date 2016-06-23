<%@page import="java.util.Date"%>
<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@page import="java.util.TimeZone"%>
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
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<link rel="stylesheet" href="css/select2.min.css">

  <!-- Select2 -->
</head>
<body>
	<div class="content-wrapper">
    <!-- Main content -->
    <%
    	TimeZone timeZone = (TimeZone)request.getSession().getAttribute("timezone");
    %>
    
    
    <section class="content">
	      <div class="row">
	    	 <div class="col-lg-3 col-xs-6">
		    	 <div class="small-box bg-purple">
		           <div class="inner">
		             <h3>${emp_count}</h3>
		
		             <p>Total Employees</p>
		           </div>
		           <div class="icon">
		             <i class="ion ion-person-add"></i>
		           </div>
		           <a href="adminEmployees" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
		         </div>
	        </div>
	        <div class="col-lg-3 col-xs-6">
		    	 <div class="small-box bg-maroon">
		           <div class="inner">
		             <h3>${emp_in_count}</h3>
		
		             <p>Todays Emp Logins</p>
		           </div>
		           <div class="icon">
		             <i class="ion ion-clock"></i>
		           </div>
		           <a href="adminCheckInOut" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
		         </div>
	        </div>
			<div class="col-lg-3 col-xs-6">
		    	 <div class="small-box bg-yellow">
		           <div class="inner">
		             <h3>${leaveList}</h3>
		
		             <p>Employees Leaves</p>
		           </div>
		           <div class="icon">
		             <i class="fa fa-fw fa-calendar-times-o"></i>
		           </div>
		           <a href="secureleavesdash" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
		         </div>
	        </div>
			<div class="col-lg-3 col-xs-6">
		    	 <div class="small-box bg-red">
		           <div class="inner">
		             <h3>${payList}</h3>
		
		             <p>Payroll</p>
		           </div>
		           <div class="icon">
		             <i class="fa fa-wa fa-inr"></i>
		           </div>
		           <a href="securePayrollList" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
		         </div>
	        </div>
			
		</div>
		<div class=" row margin-bottom">
			<div class="col-xs-12">
				
				<%
				 	
					List<Attendance> attsList = (List)request.getAttribute("attsList");
			  		if(!attsList.isEmpty())
			  		{
			  			Attendance att = attsList.get(0);
			  			%>
			  				Check In : 
			  				<%= DateFormats.fullformat(timeZone).format(att.getInTime()) %>
							<br>
			  			<%
			  			
			  			
			  			if(att != null && att.getOutTime() != null)
		  				{
		  					%>
								Check Out : <%= DateFormats.fullformat(timeZone).format(att.getOutTime()) %>
								<br>
								Working Hours : <%= DateFormats.getWorkingHours(att.getInTime(), att.getOutTime()) %>
								
								<br><br>
		  					<%
		  				}
			  			else
			  			{
		  					%>
								<a href="empCheckOut"><button class="btn btn-primary ">Check Out</button></a> 
		  					<%
			  			}
			  		}
			  		else
			  		{
	  					%>
							<a href="empCheckIn"><button class="btn btn-primary ">Check In</button></a>
	  					<%
			  		}
				%>
			</div>
		</div>
		
		 <div class="col-md-6">
			<div class="col-md-12">
              <!-- <div class="form-group">
                <label>Multiple</label>
                <select class="form-control select2" name  multiple="multiple" data-placeholder="Select a State" style="width: 100%;">
                  <option>Alabama</option>
                  <option>Alaska</option>
                  <option>California</option>
                  <option>Delaware</option>
                  <option>Tennessee</option>
                  <option>Texas</option>
                  <option>Washington</option>
                </select>
              </div> -->
              <!-- <div class="form-group">
                <label>Minimal</label>
                <select id ="search_emp" class="form-control select2 search_emp" name='term' style="width: 100%;">
                  
                </select>
              </div> -->
			</div>
		</div>
    </section>
    <!-- /.content -->
  </div><!-- Select2 -->
<script src="js/select2.full.min.js"></script>
<script type="text/javascript">
 /* $(function () {
    $("#search_emp").select2({
        multiple: true,
        minimumResultsForSearch: 10,
        ajax: {
            url: 'searchEmployees',
            dataType: 'json',
            type: "GET",
            quietMillis: 50,
            data: function (term) {
//             	alert("::::: " + term.term)
                return {
                    q: term.term
                };
            },
            processResults: function (data) {
//             	alert("::::: " + data);
                return {
                    results: $.map(data, function (item) {
                        return {
                            text: item.name,
//                             slug: item.slug,
                            id: item.userid
                        }
                    })
                };
            }
        }
    });
}); */
 
</script>
 </body>