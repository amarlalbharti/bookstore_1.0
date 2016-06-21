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

</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo" style="margin-bottom: 0px; padding-bottom: 0px;">
    <a href="index"><img alt="Vasonomics" src="images/vaso.png" style="width:360px; margin-bottom: 0px; padding-bottom: 0px;"/></a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
<!--     <p class="login-box-msg">Sign in to start your session</p> -->

  <form action="resetPassword" method="post" id="resetPwd" onsubmit="return validate()">
		<div class="form-group has-feedback">
			<%
				String resetPwd = (String)request.getAttribute("resetPwd");
				if(resetPwd != null && resetPwd.equals("false"))
				{
					%>
						<p class="text-danger">${errorMsg}</p>
					<%
				}
			%>
		</div>
		<div class="form-group has-feedback">
	        <input type="password" class="form-control" placeholder="New password" name="new_password" id="new_password" required="required">
	        <input type="hidden" name="email" value="${email}">
	        <input type="hidden" name="token" value="${token}">
	        <span class="fa fa-lock form-control-feedback"></span>
	        <span class="text-danger error error_pw"></span>
        </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Confirm password" name="conf_password" id="conf_password" required="required">
        <span class="fa fa-lock  form-control-feedback"></span>
        <span class="text-danger error error_re"></span>
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
<script type="text/javascript">
$(document).ready(function()
{
	$("#resetPwd").trigger('reset');
});

function validate()
{
	var new_password = $("#new_password").val();
	var conf_password = $("#conf_password").val();
	var valid = true;
	if(!checkComplexity(new_password))
	{
		$('.error_pw').text("Invalid Password !")
		valid = false;
	}
	if(new_password != conf_password)
	{
		$('.error_re').text("Password not matched !")
		valid = false;
	}
	if(!valid)
	{
		return false;
	}
	return false;
}
function checkComplexity(password)
{
	var strongRegex = new RegExp("^(?=.{4,})(((?=.*[a-z])(?=.*[0-9]))).*$", "g");
	return strongRegex.test(password)
}
</script>
</html>
