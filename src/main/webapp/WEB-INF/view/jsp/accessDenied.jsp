<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | 404 Page not found</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminLTE.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skin-blue.css">
</head>
<body class="hold-transition login-page">
<div class="login-box">
  
  <div class="login-box-body" style="background-color: transparent;">
    <img alt="" src="${pageContext.request.contextPath}/images/access_denied.jpg" width="100%">
    <div class="text-center" >
	     <a href="login" class="btn btn-primary btn-block btn-flat"><i class="fa fa-fw fa-sign-in"></i> <spring:message code="label.login.signin" /></a>
    </div>
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 2.2.0 -->
<script src="${pageContext.request.contextPath}/js/jQuery-2.2.0.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<!-- iCheck -->
</body>
</html>
