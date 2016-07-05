<%@page import="java.util.Calendar"%>
<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="com.ems.domain.Notification"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles-extras"
	prefix="tilesx"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="image/x-icon" href="images/favicon.png" rel="icon">
<title></title>
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
<script>
	function getLogOut() {
		if (XMLHttpRequest) {
			x = new XMLHttpRequest();
		} else {
			x = new ActiveXObject("Microsoft.XMLHTTP");
		}
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var res = x.responseText;
				// 		    		 alert(res);
				window.location.href = "${pageContext.request.contextPath}/j_spring_security_logout";
			}
		}
		x.open("GET", "${pageContext.request.contextPath}/insertLogOut", true);
		x.send();
		return true;
	}
</script>
<script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/jquery.slimscroll.min.js"></script>

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
.atgmail
{
   position: absolute;
   top: 27px;
   right: 10px;
   color: #999;
   padding-top:5px;
   padding-right:8px;
   -webkit-user-select: none;
   -moz-user-select: none;
   user-select: none;
   direction: ltr;
}
</style>

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="bodyCoverWait" style="text-align: center; ">
	<img style="position: relative;top: 250px;" alt="Please wait..." src="images/loading_spinner.gif">
</div>



	<%
		Registration registration = (Registration) request.getSession().getAttribute("registration");
		String img_path = null;
		if(registration.getProfileImage() != null)
		{
			img_path = "/ems_uploads/"+registration.getUserid()+"/Profile_Photo/"+registration.getProfileImage();
			
		}
		
	%>
	<div class="wrapper">
		<header class="main-header"> <!-- Logo --> 
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<a href="adminDashboard" class="logo" style="background-color: #fff;">
				<span class="logo-mini" style="color: #000;"><b>V</b>aso</span> <span
				class="logo-lg"><img alt="" src="images/logo.gif"> </span>
			</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_MANAGER')">
			<a href="managerDashboard" class="logo"
				style="background-color: #fff;"> <span class="logo-mini"
				style="color: #000;"><b>V</b>aso</span> <span class="logo-lg"><img
					alt="" src="images/logo.gif"> </span>
			</a>
		</sec:authorize> <sec:authorize access="hasRole('ROLE_USER')">
			<a href="userDashboard" class="logo" style="background-color: #fff;">
				<span class="logo-mini" style="color: #000;"><b>V</b>aso</span> <span
				class="logo-lg"><img alt="" src="images/logo.gif"> </span>
			</a>
		</sec:authorize> <!-- Header Navbar --> <nav class="navbar navbar-static-top"
			role="navigation"> <!-- Sidebar toggle button--> <a href="#"
			class="sidebar-toggle" data-toggle="offcanvas" role="button"> <span
			class="sr-only">Toggle navigation</span>
		</a> <!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<!-- Messages: style can be found in dropdown.less-->
				<li class="dropdown messages-menu">
		            <a style="color: black;padding: 10px;"><select class="sel_timezone zone_select2" >
					<%
						TimeZone ctz = (TimeZone)request.getSession().getAttribute("timezone");
						TimeZone timeZone = Calendar.getInstance().getTimeZone();
						String ids[] = timeZone.getAvailableIDs();
						for(String id : ids)
						{
							if(ctz.getID().equals(id))
							{
								%>
					            	<option value="<%= id %>" selected="selected"><%= id %></option>
								<%
							}
							else
							{
								%>
					            	<option value="<%= id %>"><%= id %></option>
								<%
							}
						}
					%>
		            </select>
		            </a>
		         </li>
		         <li class="dropdown notifications-menu">
                  <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                   <i class="fa fa-bell-o"></i>
					<span class="label label-warning" id="count"></span>
				  </a>
					  <ul class="dropdown-menu">
						<li class="header">You have notifications</li>
						<li>
							<div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 200px;">
								<ul class="menu noti_msg" style="overflow-y: auto; width: 100%; height: 200px;">
									<!-- <li>
										<a href="#"> 
											<i class="fa fa-users text-aqua"></i>
										</a>
									</li> -->
                        
								</ul>
								<div class="slimScrollBar" style="background: rgb(0, 0, 0) none repeat scroll 0% 0%; width: 3px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 195.122px;"></div>
								<div class="slimScrollRail" style="width: 3px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51) none repeat scroll 0% 0%; opacity: 0.2; z-index: 90; right: 1px;"></div>
							</div>
							
						</li>
						<li class="footer">
							<a href="notifications">View all</a>
						</li>				  
					</ul>
				</li>				  
				  
				  
				<!-- User Account Menu -->
				<li class="dropdown user user-menu">
					<!-- Menu Toggle Button --> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <!-- The user image in the navbar--> <img
						src="<% if(img_path != null){out.println(img_path);}else{out.println("images/User_Avatar.png");} %>" class="user-image profile_image" alt="Image">
						<!-- hidden-xs hides the username on small devices so only the image appears. -->
						<span class="hidden-xs"><%=registration.getName()%></span>
				</a>
					<ul class="dropdown-menu">
						
						<!-- The user image in the menu -->
						<li class="user-header">
						
						
						
					    <img src="<% if(img_path != null){out.println(img_path);}else{out.println("images/User_Avatar.png");} %>" class="img-circle profile_image" alt="Image">
         				<label class="custom-file-upload btn btn-block">
							<input id="profile-image" type="file" accept="image/jpg,image/png,image/jpeg,image/gif" onchange="uploadProfileImage();">
							<input type="hidden" id="userid" value="${registration.getUserid()}">
							<i class="fa fa-camera"></i>
						</label>
						 <span class="text-danger"><label id="ui"></label></span>
							<p>
								<%=registration.getName()%>
								-
								<%
									if (registration.getDesignation() != null)
									{
										out.println(registration.getDesignation().getDesignation());
									}
								%>
								<small>Member since <%=DateFormats.ddMMMyyyy(ctz).format(registration.getRegdate())%></small>
							</p>
						</li>

						<!-- Menu Footer-->
						<li class="user-footer">
							<div class="pull-left">
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<a href="adminProfile" class="btn btn-default btn-flat"><i class="fa fa-fw fa-gears"></i> Profile</a>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_MANAGER')">
									<a href="managerProfile" class="btn btn-default btn-flat"><i class="fa fa-fw fa-gears"></i> Profile</a>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_USER')">
									<a href="userprofile" class="btn btn-default btn-flat"><i class="fa fa-fw fa-gears"></i> Profile</a>
								</sec:authorize>
							</div>
							<div class="pull-right">
								<button class="btn btn-default btn-flat" onclick="getLogOut()">
								<i class="fa fa-fw fa-sign-out"></i> Sign out</button>
							</div>
						</li>
					</ul>
				</li>
				<!-- Control Sidebar Toggle Button -->
				<!-- <li>
		            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
		          </li> -->
			</ul>
		</div>
		</nav>
 </header>
 <%-- <%
 if(ctz.getID().equals("GMT"))
	{
		%>
			 <script type="text/javascript">
			 $(document).ready(function(){
// 				 if (confirm("Do you want to set your default timezone")) {
				     $.ajax({
							type : "GET",
							url : "changeToDefaultTimezone",
							data : {},
							contentType : "application/json",
							success : function(data) {
								var obj = jQuery.parseJSON(data);
								if(obj.success)
								{
									$(".sel_timezone").val(obj.tz);
								}
							},
							error: function (xhr, ajaxOptions, thrownError) {
						        alert(xhr.status);
						      }
						});
// 					 } 
				 });
			 </script>
		<%
	}
 %>
  --%>
 
 <script type="text/javascript">
 $(document).ready(function(){
	 $(document.body).on("change", ".sel_timezone", function() {
		 
		 var tz = $(this).val();
		 
		 if (confirm("Are you sure for change timezone to "+tz+"!")) {
		     $.ajax({
					type : "GET",
					url : "changeTimezone",
					data : {'tz':tz},
					contentType : "application/json",
					success : function(data) {
						var obj = jQuery.parseJSON(data);
						if(obj.success)
						{
							location.reload();
						}
					},
					error: function (xhr, ajaxOptions, thrownError) {
				        alert(xhr.status);
				      }
				});
		 } 
	 });
 });
 
 jQuery(document).ready(function() {
 $(document.body).on("click", ".notifications-menu", function(){
		
	     $.ajax({
			type : "GET",
			url : "getNotificationList",
			data : {},
			contentType : "application/json",
			success : function(data) {
					var obj = jQuery.parseJSON(data);
					var array = obj.notiList;
					$(".noti_msg").html("");
					jQuery.each( array, function( i, val ) {
					
						if(val.type=="leave"){
						  //$(".noti_msg").append("<li><a style='white-space: pre-line;'><i class='fa fa-fw fa-bell-slash'>"+val.msg+"</i></a></li>");
							$(".noti_msg").append("<li> <a style='white-space: pre-line;'><i class='fa fa-fw fa-bell-slash text-red'></i><span>"+val.msg+"</span></a></li>");
						}
						if(val.type=="bank_detail"){
							$(".noti_msg").append("<li> <a style='white-space: pre-line;'><i class='fa fa-dollar text-yellow'></i><span>"+val.msg+"</span></a></li>");
						}
						if(val.type=="attendance"){
							$(".noti_msg").append("<li> <a style='white-space: pre-line;'><i class='fa fa-clock-o text-red'></i><span>"+val.msg+"</span></a></li>");
						}
						if(val.type=="password"){
							$(".noti_msg").append("<li> <a style='white-space: pre-line;'><i class='fa fa-user text-red'></i><span>"+val.msg+"</span></a></li>");
						}
						if(val.type=="payroll"){
							$(".noti_msg").append("<li> <a style='white-space: pre-line;'><i class='fa fa-inr text-green'></i><span>"+val.msg+"</span></a></li>");
						}
						if(val.type=="document"){
							$(".noti_msg").append("<li> <a style='white-space: pre-line;'><i class='fa fa-files-o text-yellow'></i><span>"+val.msg+"</span></a></li>");
						}
						if(val.type=="other_detail"){
							$(".noti_msg").append("<li> <a style='white-space: pre-line;'><i class='fa fa-user text-aqua'></i><span>"+val.msg+"</span></a></li>");
						}
					});
					$("#count").text("0");
			}
		});
    }); 
 
 }); 

 
 

 
 $(document).ready(function(){
		
     $.ajax({
		type : "GET",
		url : "getNotificationCount",
		data : {},
		contentType : "application/json",
		success : function(data) {
				var obj = jQuery.parseJSON(data);
				var count = obj.count;
				document.getElementById('count').innerHTML=count;		        
		}
		
	});
}); 

		 
	function uploadProfileImage()
	{
		var image=document.getElementById("profile-image").files[0];
		var senddata=new FormData();
	 	senddata.append("image", image);
		$.ajax({
	 		  url: "${pageContext.request.contextPath}/profileImageUpld",
	 		  type: "POST",
	 		  async: "false",
	 		  data: senddata,
	 		  processData: false,  // tell jQuery not to process the data
	 		  contentType: false,   // tell jQuery not to set contentType
	 		  success:function(response){
	 			  //alert(response);
	 			  if(response != "failed")
	 				  {
	 				  	var userid = $('#userid').val();
	 				  	$('.profile_image').attr('src',response);
	 				  }
	 			  else
	 				  {
	 				  	alert("Ooops something wrong !");
	 				  }
	 			 
	 		  }
	 		});
	}
	
	$(document).ready(function(){
		$('.bodyCoverWait').hide();
	});
	
</script>
<script src="js/select2.full.min.js"></script>
<script type="text/javascript">
$(function () {
    $(".zone_select2").select2();
});
    
</script>