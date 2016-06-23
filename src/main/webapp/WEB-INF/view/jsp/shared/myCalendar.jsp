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
			Hello
		</div>
		
    </section>
    <!-- /.content -->
  </div><!-- Select2 -->

 </body>