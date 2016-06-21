<%@page import="com.ems.config.ProjectConfig"%>
<%@page import="com.ems.domain.UserRole"%>
<%@page import="java.util.Map"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="java.util.Date"%>
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
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
</head>
<body>
	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    
    <!-- Main content -->
    <section class="content">
	<!-- Your Page Content Here -->
		<div class="row">
			<%
				String error = (String)request.getParameter("error");
				if(error != null && error.equals("true") )
				{
					String errorMsg = request.getParameter("errorMsg");
					%>
						<div class="col-xs-12 col-md-12">
							<div class="alert alert-danger alert-dismissible">
								<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
								<h4>
									<i class="icon fa  fa-remove"></i> Failed !
								</h4>
								<%= errorMsg%>
							</div>
						</div>
					<%
				}
			
			%>
			<div class="col-xs-12 col-md-12">
				<div class="box box-info">
					<div class="box-header with-border">
						<h3 class="box-title">Attendance Report
       					</h3>
       				</div>
					<div class="box-body">
						<form action="secureReportExport" method="post" onsubmit="return validateForm()" id="filterForm">
							<div class="box-body">
								<label>Select fields for get report : </label><br/>
								<div class="input-group col-lg-3  no-padding" style="height:100px">
									<!-- <span class="input-group-addon">
									<input type="checkbox" id="attdn" name="attdn" class="sel_one" value="attdn" />
									</span> -->
									<label class="form-control" style="height:30px">Date Filter</label>
	
									<div class="input-group">
										<span class="input-group-addon"> 
										<input type="radio" id="dfilter_cur" name="dfilter" class="dfilter" value="all"  checked="checked" />
										</span> <label class="form-control">Current Month</label>
									</div>
									<div class="input-group date_filter">
				                        <span class="input-group-addon">
				                          <input type="radio" id="dfilter" name="dfilter" class="dfilter" value="filter"/>
				                        </span>
					                    <label class="form-control" style="height: auto">
						                    To :&nbsp;<br>
						                    <input type="text" name="sdate" id="sdate" class="from-control qdate" placeholder="dd-mm-yyyy"  disabled="disabled">
						                    <br>
						                    From :&nbsp;<br>
						                    <input type="text" name="edate" id="edate" class="from-control qdate" placeholder="dd-mm-yyyy" disabled="disabled">
					                    </label>
				                  </div>
								</div>
								<div class="input-group col-lg-3  no-padding">
									<!-- <span class="input-group-addon">
									<input type="checkbox" id="attdn" name="attdn" class="sel_one" value="attdn" />
									</span> -->
									<label class="form-control" style="height:30px">Employees Filter </label>
	
									<div class="input-group">
										<span class="input-group-addon"> 
										<input type="radio" id="empfilter_all" name="empfilter" class="empfilter" value="all" checked="checked" />
										</span> <label class="form-control">All Employees</label>
									</div>
									<div class="input-group">
										<span class="input-group-addon"> 
											<input type="radio" id="empfilter" name="empfilter" class="empfilter" value="filter" />
										</span> 
										<label class="form-control emp_filter" style="height: auto"> 
											Country :&nbsp;
											<select name="country" id="country" class="from-control col-xs-12 " disabled="disabled">
												<option value="0">-----Select-----</option>
												<c:forEach var="item" items="${countryList}">
													<option value="${item.countryId}">${item.countryName}</option>
												</c:forEach>
											</select><br>
											Branch :&nbsp;
											<select name="branch" id="branch" class="from-control col-xs-12 " disabled="disabled">
												<option value="0">-----Select-----</option>
											</select>
										</label>
									</div>
									<div class="clear-fix"></div>
								</div>
								<br>
								<div class="input-group">
								 	<button type="submit" class="btn btn-primary btn-flat"><i class="fa fa-fw fa-cloud-download"></i> Download</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
    </section>
    <!-- /.content -->
  </div>
<script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">
 $('#sdate').datetimepicker({
	timepicker:false,
	maxDate:new Date(),
	format:'d-m-Y'
});
$('#edate').datetimepicker({
	timepicker:false,
	maxDate:new Date(),
	format:'d-m-Y'
});
</script>
<script type="text/javascript">
  $(document).ready(function(){
	  $(document.body).on("click", ".dfilter", function() {
	  		var val = $(this).val();
	  		if(val=="all")
  			{
  				$(".date_filter #sdate").attr("disabled","disabled");
  				$(".date_filter #edate").attr("disabled","disabled");
  			}
	  		else
  			{
	  			$(".date_filter #sdate").removeAttr("disabled");
  				$(".date_filter #edate").removeAttr("disabled");
  			}
	  	});
	  $(document.body).on("click", ".empfilter", function() {
			var val = $(this).val();
			if (val == "all")
			{
				$(".emp_filter #country").attr("disabled", "disabled");
				$(".emp_filter #branch").attr("disabled", "disabled");
			} else {
				$(".emp_filter #country").removeAttr("disabled");
				$(".emp_filter #branch").removeAttr("disabled");
			}
		});
});
</script>
<script type="text/javascript">
    $(function () {
        $("#country").change(function () {
        	
            var selectedText = $(this).find("option:selected").text();
            var selectedValue = $(this).val();
        	
    		$.ajax({
    			type : "GET",
    			url : "getBranchNames",
    			data : {'cid':selectedValue},
    			contentType : "application/json",
    			success : function(data) {
    				var obj = jQuery.parseJSON(data);
    				if(!obj.error)
   					{
   						var list = obj.bList;
   						$("#branch").html("<option value='0' >---Select---</option>");
   						jQuery.each( list, function( i, val ) {
   						  $("#branch").append("<option value='"+val.id+"' > "+val.name+"</option>");
   						});
   					}
    				
    			},
    			error: function (xhr, ajaxOptions, thrownError) {
    		        alert(xhr.status);
    		      }
    		});
        });
    });
</script>
<script type="text/javascript">
	function validateForm()
	{
		var dfilter = $('input[name=dfilter]:checked', '#filterForm').val();
		var empfilter = $('input[name=empfilter]:checked', '#filterForm').val();
		var valid = true; 
		$(".error").removeClass("error");
		
		if(dfilter != "all")
		{
			var sdate = $("#sdate").val();
			var edate = $("#edate").val();
			
			if(sdate == "")
			{
				$("#sdate").addClass("error");
				valid = false; 
			}
			if(edate == "")
			{
				$("#edate").addClass("error");
				valid = false; 
			}
		}
		if(empfilter != "all")
		{
			var country = $("#country").val();
			if(country == "0")
			{
				$("#country").addClass("error");
				valid = false; 
			}
			
		}
		return valid;
		
	}
	

</script>



 </body>