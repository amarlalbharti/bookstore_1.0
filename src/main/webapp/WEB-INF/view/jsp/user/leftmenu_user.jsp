<%@page import="java.util.Calendar"%>
<%@page import="com.ems.domain.Registration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles-extras"
	prefix="tilesx"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
</head>
<body>
<aside class="main-sidebar">
<tilesx:useAttribute name="currentpage"/>
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
	<%
		Registration registration = (Registration)request.getSession().getAttribute("registration");
	    String img_path = null;
    
        if(registration.getProfileImage() != null)
        {
        img_path = "/ems_uploads/"+registration.getUserid()+"/Profile_Photo/"+registration.getProfileImage();
        
        }
	%>
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="<% if(img_path != null){out.println(img_path);}else{out.println("images/User_Avatar.png");} %>" class="img-circle profile_image" alt="null">
        </div>
        <div class="pull-left info">
          <p><%= registration.getName() %></p>
          <a href="javascript:void(0)">Employee</a>
          <!-- Status -->
        </div>
      </div>

      
      <!-- /.search form -->

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu">
        <li class="header" id="time">HEADER</li>
        <!-- Optionally, you can add icons to the links -->
        <li class="${currentpage == 'dashboard' ? 'active' : ''}"><a href="userDashboard"><i class="fa fa-dashboard"></i><span>Dashboard</span></a></li>
        <li class="${currentpage == 'attendance' ? 'active' : ''}"><a href="userAttendance"><i class="fa fa-clock-o"></i> <span>My Attendance</span></a></li>
        <li class="${currentpage == 'userprofile' ? 'active' : ''}"><a href="userprofile"><i class="fa fa-user"></i><span>View Profile</span></a></li>
        <li class="${currentpage == 'leave' ? 'active' : ''}"><a href="userleavedetail"><i class="fa fa-fw fa-bell-slash"></i><span>Leave Details</span></a></li>
        <li class="${currentpage == 'documents' ? 'active' : ''}"><a href="userDocuments"><i class="fa fa-files-o"></i><span>My Documents</span></a></li>
        <li class="${currentpage == 'payroll' ? 'active' : ''}"><a href="userPayroll"><i class="fa fa-hand-o-right"></i><span>My Payroll</span></a></li>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>
  
  
   
<script type="text/javascript">

(function () {
    function checkTime(i) {
        return (i < 10) ? "0" + i : i;
    }

    function startTime() {
        var today = new Date(),
            h = checkTime(today.getHours()),
            m = checkTime(today.getMinutes()),
            s = checkTime(today.getSeconds());
        document.getElementById('time').innerHTML = h + ":" + m + ":" + s;
        t = setTimeout(function () {
            startTime()
        }, 500);
    }
    startTime();
})


</script>	



	