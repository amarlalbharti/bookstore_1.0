<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Log in</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="css/bootstrap.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="css/AdminLTE.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="css/blue.css">
<style type="text/css">
	.error {
		color: red;
	}
</style>
<%
	/*
	if((!request.getSession().isNew()))
	{
		System.out.println("old session deleting");
		request.getSession().invalidate();
	}
	*/

%>
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo" style="margin-bottom: 0px; padding-bottom: 0px;">
    <a href="index"><img alt="Vasonomics" src="images/vaso.png" style="width:360px; margin-bottom: 0px; padding-bottom: 0px;"/></a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
<!--     <p class="login-box-msg">Sign in to start your session</p> -->

  <form action="j_spring_security_check" method="post">
		<c:if test="${param.error}">
			<div class="error" style="height: auto;">
				Your login attempt was not successful, try again.<br /> Reason:
				${sessionScope.SPRING_SECURITY_LAST_EXCEPTION.message}
			</div>
			<br>
		</c:if>
		<%
			String resetPwd = (String)request.getParameter("resetPwd");
			if(resetPwd != null && resetPwd.equals("true"))
			{
				%>
					<div class="text-green" style="height: auto;">
						Password reset successfully, Login with new password ! <br>
					</div>
					<br>
				<%
			}
		%>
		<div class="form-group has-feedback">
        <input type="email" class="form-control" placeholder="Email" name="j_username" id="j_username" required="required">
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Password" name="j_password" id="j_password" required="required">
        <span class="fa fa-lock  form-control-feedback"></span>
      </div>
      <div class="row">
        <div class="col-xs-8">
          <div class="checkbox">
            <label>
              <input type="checkbox"> Remember Me
            </label>
          </div>
        </div>
        <!-- /.col -->
        <div class="col-xs-4">
          <button type="submit" class="btn btn-primary btn-block btn-flat"><i class="fa fa-fw fa-sign-in"></i> Sign In</button>
        </div>
        <!-- /.col -->
      </div>
    </form>

    <a href="forgotPassword">I forgot my password</a><br>
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
