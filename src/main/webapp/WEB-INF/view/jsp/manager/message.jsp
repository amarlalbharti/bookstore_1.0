<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<link rel="stylesheet" href="css/bootstrap3-wysihtml5.min.css">
<link rel="stylesheet" href="css/skin-blue.css">
<link rel="stylesheet" href="css/AdminLTE.css">
</head>
<body>
	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <!-- Main content -->
    <section class="content">
		
      <!-- Your Page Content Here -->
		<div class="row">
			<div class="col-xs-12 col-md-12">
    <%
			String var[] =  request.getParameterValues("var");
			if (var != null) 
			{
				ArrayList<String> list = new ArrayList<String>();
				String id = "";
				for(String ll : var)
				{
					list.add(ll);
					id += ll;
				}
		%>
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Create Message</small>
       					</h3>
       					
					</div>
					<div class="box-body">
					<form action="managerSendMessage" method="post" onsubmit="return validateForm()">
					<div class="form-group col-xs-12 col-md-6">To :
						    <textarea rows="3" cols="10" name="email" id="email" readonly="readonly" class="form-control" style="resize:none;"><%=id %></textarea>
				 		</div>
				 		<div class="form-group col-xs-12 col-md-8">
						    <input name="sub" id="sub" class="form-control" placeholder="Enter Subject"/>
				 		</div>
						<div class="form-group col-xs-12 col-md-8">
						    <textarea rows="5" cols="30" name="msg" id="msg" class="form-control textarea" style="resize:none;" placeholder="Enter Message Here"></textarea>
						    <label class="text-danger" id="err"></label>
				 		</div>
				 		<div class="form-group col-xs-12 col-md-12">
							<button class="btn btn-primary">Send Message</button>
						</div>
				 		</form>
					</div>
				</div>
				<% 
				} 
				%>
			</div>
		</div>
		
    </section>
    <!-- /.content -->
  </div>
<script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/bootstrap3-wysihtml5.all.min.js"></script>
  <script>
  $(function () {
	    $(".textarea").wysihtml5();
	  });
</script>
<script type="text/javascript">
	function validateForm()
	{
		var email = $("#email").val();
		var sub = $("#sub").val();
		var msg = $("#msg").val();
		document.getElementById('err').innerHTML = '';
		
		var valid = true;
		$('.has-error').removeClass("has-error");
		
		if(email == "")
		{
			$("#email").parent().addClass("has-error")
			valid = false;
		}
		if(sub == "")
		{
			$("#sub").parent().addClass("has-error")
			valid = false;
		}
		if(msg == "")
		{
			$("#msg").parent().addClass("has-error")
			valid = false;
			document.getElementById('err').innerHTML = '*Please provide Message';
		}

		if(!valid)
		{
			return false;		
		}
		$(".btn-primary").attr("disabled","disabled");
		$(".btn-primary").text("Sending...");
	}
</script>
 </body>
 </html>