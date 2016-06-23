<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Log in</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="css/bootstrap.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="css/AdminLTE.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="css/blue.css">
<style type="text/css">
	.error {
		color: red;
	}
</style>

</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo" style="margin-bottom: 0px; padding-bottom: 0px;">
    <a href="index"><img alt="Vasonomics" src="images/vaso.png" style="width:360px; margin-bottom: 0px; padding-bottom: 0px;"/></a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
<!--     <p class="login-box-msg">Sign in to start your session</p> -->

  <form action="forgotPassword" method="post">
  		<div class="form-group has-feedback">
		<%
			String resetPwd = (String) request.getAttribute("resetPwd");
			if(resetPwd != null )
			{
				if(resetPwd.equals("true"))
				{
					%>
						<p class="text-info">${resetMsg }</p>
					<%
				}
				else if(resetPwd.equals("false"))
				{
					%>
						<p class="text-danger">${resetMsg }</p>
					<%
				}
				
			}
		%>
		</div>
		<div class="form-group has-feedback">
        <input type="email" class="form-control" placeholder="Email" name="userid" value="${userid}" required="required">
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      
      <div class="row">
        <div class="col-xs-6">
          
        </div>
        <!-- /.col -->
        <div class="col-xs-6">
          <button type="submit" class="btn btn-primary btn-block btn-flat">Reset Password</button>
        </div>
        <!-- /.col -->
      </div>
    </form>

    
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 2.2.0 -->
<script src="js/jQuery-2.2.0.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="js/bootstrap.js"></script>
</body>
</html>
