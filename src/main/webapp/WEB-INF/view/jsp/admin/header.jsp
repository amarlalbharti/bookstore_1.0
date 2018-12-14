<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Dashboard</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/select2.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminLTE.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/skin-blue.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/datepicker3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dataTables.bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/alertify.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/alertify.default.css"/> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/alertify.default.css"/> 

 <!-- jQuery 2.2.0 -->
<script src="${pageContext.request.contextPath}/js/jQuery-2.2.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/alertify.js"></script>

<script src="${pageContext.request.contextPath}/js/admin_bookstore.js"></script>


 <style type="text/css">
input[type="file"] {
    display: none !important;
}
.custom-file-upload {
    cursor: pointer;
    margin-top: -30px !important;
    position: absolute !important;
}
.bodyCoverWait {
    position: fixed;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    z-index: 9999;
    opacity: 0.8;
    background: #ececec;
}
</style>
<script>
		function getLogOut(){
			if (XMLHttpRequest)
			{
				x=new XMLHttpRequest();
			}
			else
			{
				x=new ActiveXObject("Microsoft.XMLHTTP");
			}
		     x.onreadystatechange=function()
			{
		    	 if(x.readyState==4 && x.status==200)
					{
		    		 var res = x.responseText;
		    		 window.location.href="${pageContext.request.contextPath}/j_spring_security_logout";
		    		}
			}
			x.open("GET", "${pageContext.request.contextPath}/insertLogOut",true);
			x.send();
			return true;
		}
</script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="bodyCoverWait" style="text-align: center; ">
	<img style="position: relative;top: 250px;" alt="Please wait..." src="${pageContext.request.contextPath}/images/loading_spinner.gif">
</div>
<input type="hidden" id="root_path" value="${pageContext.request.contextPath}">
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
<!--       <span class="logo-mini"><b>A</b>LT</span> -->
      <!-- logo for regular state and mobile devices -->
<!--       <span class="logo-lg"><b>Admin</b>LTE</span> -->
		<img alt="Logo" class="logo-lg" src="/bookstore/images/bt-logo.png" width="100%" style="margin-top: 5px">
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
        
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="${pageContext.request.contextPath}/images/User_Avatar.png" class="user-image" alt="User Image">
              <span class="hidden-xs">Amar</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <img src="${pageContext.request.contextPath}/images/User_Avatar.png" class="img-circle" alt="User Image">

                <p>
                  Amar - Web Developer
                  <small>Member since Nov. 2012</small>
                </p>
              </li>
              <!-- Menu Body -->
              <li class="user-body">
                <div class="row">
                  <div class="col-xs-4 text-center">
                    <a href="#">Followers</a>
                  </div>
                  <div class="col-xs-4 text-center">
                    <a href="#">Sales</a>
                  </div>
                  <div class="col-xs-4 text-center">
                    <a href="#">Friends</a>
                  </div>
                </div>
                <!-- /.row -->
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="#" class="btn btn-default btn-flat">Profile</a>
                </div>
                <div class="pull-right">
                  <button onclick="getLogOut()" class="btn btn-default btn-flat">Sign out</button>
                </div>
              </li>
            </ul>
          </li>
          
        </ul>
      </div>
    </nav>
  </header>
<%
	String msg = (String)session.getAttribute("msg");
	String msgType = (String)session.getAttribute("msgType");
	if(msg != null && msgType != null){
		if(msgType.equals("success")){
			%>
				<script type="text/javascript">
					$(document).ready(function(){
						alertify.success("Success : <%= session.getAttribute("msg") %>" );
					});
				</script>
			<%
		}else if(msgType.equals("warning")){
			%>
				<script type="text/javascript">
					$(document).ready(function(){
						alertify.warning("Warning : <%= session.getAttribute("msg") %>" );
					});
				</script>
			<%
			
		}else if(msgType.equals("error")){
			%>
				<script type="text/javascript">
					$(document).ready(function(){
						alertify.error("Error : <%= session.getAttribute("msg") %>" );
					});
				</script>
			<%
		}
		session.removeAttribute("msg");
		session.removeAttribute("msgType");
		
	}
	
%>
  