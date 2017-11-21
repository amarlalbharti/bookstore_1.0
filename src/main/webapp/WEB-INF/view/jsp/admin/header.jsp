<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Dashboard</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="css/select2.min.css">
<link rel="stylesheet" href="css/bootstrap.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="css/AdminLTE.css">
<link rel="stylesheet" href="css/skin-blue.css">
<link rel="stylesheet" href="css/datepicker3.css">
<link rel="stylesheet" href="css/dataTables.bootstrap.css">
<link rel="stylesheet" href="css/alertify.css" />
<link rel="stylesheet" href="css/alertify.default.css"/> 
 <!-- jQuery 2.2.0 -->
<script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/alertify.js"></script>
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
</head>
<body class="hold-transition skin-blue sidebar-mini" style="display: none;">
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="dashboard" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>LT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>Admin</b>LTE</span>
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
              <img src="images/User_Avatar.png" class="user-image" alt="User Image">
              <span class="hidden-xs">Amar</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <img src="images/User_Avatar.png" class="img-circle" alt="User Image">

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
                  <a href="#" class="btn btn-default btn-flat">Sign out</a>
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
  