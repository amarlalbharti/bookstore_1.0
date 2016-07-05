<%@page import="com.ems.domain.Registration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles-extras" prefix="tilesx"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
		Registration reg = (Registration)request.getSession().getAttribute("registration");
		
		String img_path = null;
		
		if(reg.getProfileImage() != null)
		{
			img_path = "/ems_uploads/"+reg.getUserid()+"/Profile_Photo/"+reg.getProfileImage();
			
		}
	%>
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="<% if(img_path != null){out.println(img_path);}else{out.println("images/User_Avatar.png");} %>" class="img-circle profile_image" alt="User Image">
        </div>
        <div class="pull-left info">
          <p><%= reg.getName() %></p>
          <sec:authorize access="hasRole('ROLE_ADMIN')">
          <a href="javascript:void(0)">Admin</a>
          </sec:authorize>
          
          <sec:authorize access="hasRole('ROLE_MANAGER')">
          <a href="javascript:void(0)">Manager</a>
          </sec:authorize>
          <!-- Status -->
        </div>
      </div>

      
      <!-- /.search form -->

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu">
        <li class="header" id="time">HEADER</li>
        <!-- Optionally, you can add icons to the links -->
        <sec:authorize access="hasRole('ROLE_ADMIN')">
        <li class="${currentpage == 'dashboard' ? 'active' : ''}"><a href="adminDashboard"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a></li>
        <li class="${currentpage == 'attendance' ? 'active' : ''}"><a href="adminCheckInOut"><i class="fa fa-clock-o"></i> <span>Today's Attendance</span></a></li>
        <li class="${currentpage == 'employees' ? 'active' : ''}"><a href="adminEmployees"><i class="fa fa-user"></i> <span>Employees List</span></a></li>
        <li class="${currentpage == 'leaves' ? 'active' : ''}"><a href="secureleavesdash"><i class="fa fa-fw fa-calendar-times-o"></i> <span>Employees Leaves</span></a></li>
        <li class="${currentpage == 'report' ? 'active' : ''}"><a href="secureReport"><i class="fa fa-book"></i> <span>Report</span></a></li>
		<li class="${currentpage == 'payroll' ? 'active' : ''}"><a href="securePayrollList"><i class="fa fa-wa fa-inr"></i> <span>Payroll</span></a></li>
        <li class="treeview  ${currentpage == 'branch' ? 'active' : ''} ${currentpage == 'country' ? 'active' : ''} ${currentpage == 'department' ? 'active' : ''} ${currentpage == 'designation' ? 'active' : ''}">
          <a href="#">
           <i class="fa fa-folder"></i> <span>Dynamic data</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
	        <li class="${currentpage == 'branch' ? 'active' : ''}"><a href="adminViewBranch"><i class="fa fa-circle-o text-red"></i> <span>Branch</span></a></li>
	        <li class="${currentpage == 'country' ? 'active' : ''}"><a href="adminViewCountry"><i class="fa fa-circle-o text-green"></i> <span>Country</span></a></li>
	        <li class="${currentpage == 'department' ? 'active' : ''}"><a href="adminViewDepartment"><i class="fa fa-circle-o text-aqua"></i> <span>Department</span></a></li>
	        <li class="${currentpage == 'designation' ? 'active' : ''}"><a href="adminViewDesignation"><i class="fa fa-circle-o text-maroon"></i> <span>Designation</span></a></li>
          </ul>
        </li>
        </sec:authorize>
        <sec:authorize access="hasRole('ROLE_MANAGER')">
        <li class="${currentpage == 'dashboard' ? 'active' : ''}"><a href="managerDashboard"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a></li>
        <li class="${currentpage == 'attendance' ? 'active' : ''}"><a href="managerCheckInOut"><i class="fa fa-clock-o"></i> <span>Today's Attendance</span></a></li>
        <li class="${currentpage == 'employees' ? 'active' : ''}"><a href="manageremployees"><i class="fa fa-user"></i> <span>Employees List</span></a></li>
        <li class="${currentpage == 'leaves' ? 'active' : ''}"><a href="secureleavesdash"><i class="fa fa-fw fa-calendar-times-o"></i> <span>Employees Leaves</span></a></li>
      	<li class="${currentpage == 'report' ? 'active' : ''}"><a href="secureReport"><i class="fa fa-book"></i> <span>Report</span></a></li>
        <li class="${currentpage == 'payroll' ? 'active' : ''}"><a href="securePayrollList"><i class="fa fa-wa fa-inr"></i> <span>Payroll</span></a></li>

        </sec:authorize>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>
<script type="text/javascript">
/* $(document).ready(function(){
	$.ajax({
		type : "GET",
		url : "getCurrentTime",
		data : {},
		contentType : "application/json",
		success : function(data) {
			var obj = jQuery.parseJSON(data);
// 			alert(obj.millis);
// 			alert(new Date(obj.millis));
// 			alert(new Date());
				var today = new Date(),
	            h = checkTime(today.getHours()),
	            m = checkTime(today.getMinutes()),
	            s = checkTime(today.getSeconds());
	        document.getElementById('time').innerHTML = h + ":" + m + ":" + s;
	        t = setTimeout(function () {
	            startTime()
	        }, 500);
		},
		error: function (xhr, ajaxOptions, thrownError) {
	        alert(xhr.status);
	      }
	});
}); */
</script>
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
})();
</script>	