<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminLTE.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/blue.css">
<style type="text/css">

.error {
	color: red;
}
	
html 
{ 
  background: url(${pageContext.request.contextPath}/images/ems-bg.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
.bodyCoverWait {
    position: fixed;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    z-index: 9999;
    opacity: 0.9;
    background: #ececec;
}
</style>

</head>
<body class="hold-transition login-page" style="background: transparent;">
<div class="bodyCoverWait" style="text-align: center; ">
	<img style="position: relative;top: 250px;" alt="Please wait..." src="${pageContext.request.contextPath}/images/loading_spinner.gif">
</div>

<div class="login-box">
  <div class="login-logo" style="margin-bottom: 0px; padding-bottom: 0px;">
    <a href="index"><img alt="Book Store" src="${pageContext.request.contextPath}/images/logo.jpg" style="width:360px; margin-bottom: 0px; padding-bottom: 0px;"/></a>
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
        <input type="email" class="form-control" placeholder="<spring:message code="label.login.email" />" name="j_username" id="j_username" required="required">
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="<spring:message code="label.login.password" />" name="j_password" id="j_password" required="required">
        <span class="fa fa-lock  form-control-feedback"></span>
      </div>
      <div class="row">
        <div class="col-xs-6">
          <div class="checkbox">
            <label>
              <input type="checkbox" name="_spring_security_remember_me"> <spring:message code="label.login.remember_me" />
            </label>
          </div>
        </div>
        <!-- /.col -->
        <div class="col-xs-6">
          <button type="submit" class="btn btn-primary btn-block btn-flat"><i class="fa fa-fw fa-sign-in"></i> <spring:message code="label.login.signin" /></button>
        </div>
        <!-- /.col -->
      </div>
    </form>

    <a href="forgotPassword"><spring:message code="label.login.forgotpassword" /></a><br>
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 2.2.0 -->
<script src="${pageContext.request.contextPath}/js/jQuery-2.2.0.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script>
$(document).ready(function(){
 
});

$(document).ready(function(){
	$('.bodyCoverWait').hide();
});
</script>
</body>
</html>
