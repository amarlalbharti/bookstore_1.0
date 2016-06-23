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
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="css/bootstrap.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="css/AdminLTE.css">
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect.
  -->
  <link rel="stylesheet" href="css/skin-blue.css">
</head>
<body>
	<div class="content-wrapper">
    
    <!-- Main content -->
    <section class="content">
    <div class="row">
	    	 <div class="col-lg-3 col-xs-6">
		    	 <div class="small-box bg-aqua">
		           <div class="inner">
		             <h3>${emp_count}</h3>
		
		             <p>Total Employees</p>
		           </div>
		           <div class="icon">
		             <i class="ion ion-person-add"></i>
		           </div>
		           <a href="manageremployees" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
		         </div>
	        </div>
	        <div class="col-lg-3 col-xs-6">
		    	 <div class="small-box bg-green">
		           <div class="inner">
		             <h3>${emp_in_count}</h3>
		
		             <p>Todays Emp Logins</p>
		           </div>
		           <div class="icon">
		             <i class="ion ion-clock"></i>
		           </div>
		           <a href="managerCheckInOut" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
		         </div>
	        </div>
			
	      </div>
		<div class=" row bottom-padding">
			<div class="col-xs-12">
				<%
					List<Attendance> attsList = (List)request.getAttribute("attsList");
			  		if(!attsList.isEmpty())
			  		{
			  			Attendance att = attsList.get(0);
			  			%>
			  				Login Time : <%= DateFormats.fullformat().format(att.getInTime()) %><%
			  			%>
							<br><br>
			  			<%
			  			
			  			
			  			Attendance attendance = attsList.get(0);
			  			if(attendance != null && attendance.getOutTime() == null)
		  				{
		  					%>
								<a href="empCheckOut"><button class="btn btn-primary ">Check Out</button></a> 
		  					<%
		  				}
			  			else
			  			{
		  					%>
								<a href="empCheckIn"><button class="btn btn-primary ">Check In</button></a>
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
      <!-- Your Page Content Here -->
      <div id="clear" style="height:15px"></div>
	
    </section>
    <!-- /.content -->
  </div>
 </body>