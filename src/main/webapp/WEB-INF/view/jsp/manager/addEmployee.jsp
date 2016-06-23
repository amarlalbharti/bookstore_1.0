<%@page import="com.ems.config.Roles"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="java.util.Date"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Attendance"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
    <section class="content-header">
      <h1 class="page-header"> New Employee </h1>
      <ol class="breadcrumb">
        <li><a href="managerDashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="manageremployees"><i class="fa fa-dashboard"></i> Employee List</a></li>
        <li class="active">New Employee</li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
		<%
          	String uidex = (String)request.getAttribute("uidex");
          	if(uidex != null && uidex.equals("exist"))
          	{
          		uidex = "User id already registered !";
          	}
          %>
      <!-- Your Page Content Here -->
		<div class="row">
			<div class="col-xs-12 col-md-12">
				<div class="box box-info">

					<div class="box-body no-padding">
						<div class="nav-tabs-custom">
				            <ul class="nav nav-tabs">
				              <li class="active"><a href="#tab_1" data-toggle="tab">Basic Info</a></li>
				              <li><a href="#tab_2" data-toggle="tab">Other Info</a></li>
				            </ul>
				            <div class="tab-content">
				              <div class="tab-pane active" id="tab_1">
				                	<form:form role="form" method="POST" action="managerAddEmployee" commandName="regForm" enctype="multipart/form-data" onsubmit="return validateForm()" autocomplete="off">
						              <div class="box-body">
						              <div class="form-group col-xs-12 col-md-6">
						                  <label >Employee Id<span class="text-danger">*</span></label>
						                  <form:input path="eId" id="eId" class="form-control" maxlength="20" tabindex="1" title="EID Format : YYYY-IN-0000"  placeholder="Enter employee Id"/>
						                  <span class="text-danger"><form:errors path="eId" /></span>
						                </div>
						                <div class="form-group col-xs-12 col-md-6">
						                  <label >Employee Name<span class="text-danger">*</span></label>
						                  <form:input path="name" class="form-control titleCase" maxlength="50" tabindex="5"  placeholder="Enter employee name"/>
						                  <span class="text-danger"><form:errors path="name" /></span>
						                </div>
						                <div class="clearfix"></div>
						                <div class="form-group col-xs-12 col-md-6">
						                  <label >Email Id<span class="text-danger">*</span></label>
						                  <form:input autocomplete="off" path="userid" maxlength="60" type="email" tabindex="10" class="form-control" placeholder="Enter employee user id" />
						                   <span class="text-danger">${uidex}<form:errors path="userid" /></span>
						                </div>
						                <div class="form-group col-xs-12 col-md-6">
						                  <label >User Role<span class="text-danger">*</span></label>
						                  <form:select path="userrole" class="form-control" tabindex="15">
						                  <form:option value=''>---SELECT---</form:option>
						                  	<form:option value='<%= Roles.ROLE_USER %>'><%= Roles.ROLE_USER %></form:option>
						                  </form:select>
						                  <span class="text-danger"><form:errors path="userrole" /></span>
						                </div>
						                <div class="clearfix"></div>
						                <div class="form-group col-xs-12 col-md-6">
						                  <label >Password<span class="text-danger">*</span></label>
						                  <form:password path="password" class="form-control" maxlength="30" tabindex="20" placeholder="Enter password" />
						                  <span class="text-danger"><form:errors path="password" /></span>
						                </div>
						                <div class="form-group col-xs-12 col-md-6">
						                  <label >Re-Enter Password<span class="text-danger">*</span></label>
						                  <form:password path="repassword" class="form-control" maxlength="30" tabindex="25" placeholder="Confirm password" />
						                  <span class="text-danger"><form:errors path="repassword" /></span>
						                </div>
						                <div class="clearfix"></div>
						                <div class="form-group col-xs-12 col-md-6 date" data-provide="datepicker">
						                  <label >Date of Birth<span class="text-danger">*</span></label>
						                  <form:input path="dob" class="form-control dob" placeholder="dd-MM-yyyy" tabindex="30" />
						                  <span class="text-danger"><form:errors path="dob" /></span>
						                </div>
						                <div class="form-group col-xs-12 col-md-6">
						                  <label >Joining Date<span class="text-danger">*</span></label>
						                  <form:input path="joiningDate" class="form-control" placeholder="dd-MM-yyyy" tabindex="35" />
						                  <span class="text-danger"><form:errors path="joiningDate" /></span>
						                </div>
						                <div class="clearfix"></div>
						                <div class="form-group col-xs-12 col-md-6">
						                  <div class="col-lg-6  no-padding">
							                  <label >Gender<span class="text-danger">*</span></label>
							                  <div class="input-group">
							                        <span class="input-group-addon">
							                          <form:radiobutton path="gender" value="male" tabindex="40" />
							                        </span>
							                    <label class="form-control">Male</label>
							                  </div>
							                  <!-- /input-group -->
							                </div>
							                <div class="col-lg-6">
							                  <label >&nbsp;</label>
							                  <div class="input-group">
							                        <span class="input-group-addon">
							                          <form:radiobutton path="gender" value="female" tabindex="45"/>
							                        </span>
							                    <label class="form-control">Female</label>
							                  </div>
							                  <!-- /input-group -->
							                </div>
						                </div>
						                <div class="form-group col-xs-12 col-md-6">
						                  <label >Department<span class="text-danger">*</span></label>
						                  <form:select path="department.departmentId" id="department" tabindex="50" class="form-control">
						                  <form:option value='0'>---SELECT---</form:option>
						                  		<c:forEach var="itam" items="${dpList}">
													<form:option value='${itam.departmentId }'>${itam.department }</form:option>
												</c:forEach>
						                  </form:select>
						                  <span class="text-danger"><form:errors path="department" /></span>
						                </div>
						                <div class="clearfix"></div>
						                <div class="form-group col-xs-12 col-md-6">
						                  <label >Designation<span class="text-danger">*</span></label>
						                  <form:select path="designation.designationId" id="designation" tabindex="55" class="form-control">
						                  		<form:option value='0'>---SELECT---</form:option>
						                  		<c:forEach var="ds" items="${dsList}">
													<form:option value='${ds.designationId }'>${ds.designation }</form:option>
												</c:forEach>
						                  </form:select>
						                  <span class="text-danger"><form:errors path="designation" /></span>
						                </div>
						                <div class="form-group col-xs-12 col-md-6">
						                  <label >Week Off<span class="text-danger">*</span></label>
						                  <form:select path="weekOff" class="form-control" tabindex="60">
						                  		<form:option value='0'>---SELECT---</form:option>
						                  		<form:option value='1'>SUNDAY</form:option>
						                  		<form:option value='2'>MONDAY</form:option>
						                  		<form:option value='3'>TUESDAY</form:option>
						                  		<form:option value='4'>WEDNESDAY</form:option>
						                  		<form:option value='5'>THURSDAY</form:option>
						                  		<form:option value='6'>FRIDAY</form:option>
						                  		<form:option value='7'>SATURDAY</form:option>
						                  		
						                  </form:select>
						                  <span class="text-danger"><form:errors path="branch" /></span>
						                </div>
						                <div class="clearfix"></div>
						                 <div class="form-group col-xs-12 col-md-6">
						                  <label >Branch Country<span class="text-danger">*</span></label>
						                  <form:select path="country.countryId" id="countryId" class="form-control" tabindex="65">
						                  <form:option value='0'>---SELECT---</form:option>
						                  		<c:forEach var="itam" items="${cList}">
													<form:option value='${itam.countryId }'>${itam.countryName }</form:option>
												</c:forEach>
						                  </form:select>
						                  <span class="text-danger"><form:errors path="country.countryId" /></span>
						                </div>
						                <div class="form-group col-xs-12 col-md-6">
						                  <label >Branch<span class="text-danger">*</span></label>
						                  <form:select path="branch.branchId" id="branch" class="form-control" tabindex="70">
						                  		<form:option value='0'>---SELECT---</form:option>
						                  </form:select>
						                  <span class="text-danger"><form:errors path="branch" /></span>
						                </div>
						                <div class="clearfix"></div>
						                <div class="form-group col-xs-12 col-md-6">
											<img alt="User" id="output" src="images/User_Avatar.png" style="max-height: 150px; max-width: 100px" />
						                </div>
						                <div class="form-group col-xs-12 col-md-6">
											<img alt="Document" id="output1" src="images/document.png" style="max-height: 100px; max-width: 300px"/>
						                </div>
						                
						                <div class="clearfix"></div>
						                <div class="form-group col-xs-12 col-md-6">
<!-- 						                  <label >Employee Image</label> -->
											<label class="btn btn-primary btn-flat btn-xs">
												<input name="userImage" id="u1" type="file" tabindex="75" accept="image/jpg,image/png,image/jpeg,image/gif" onchange="return ValidateFileUpload()" />
												<i class="fa fa-fw fa-cloud-upload"></i>
												Browse Image 
											</label>
											<div class="clearfix"></div>
											<span class="text-danger"><form:label path="" id="ui" class="image_error" /></span>
										</div>
						                <div class="form-group col-xs-12 col-md-6">
<!-- 						                  <label >Pan Upload</label> -->
											<label class=" btn btn-primary btn-flat btn-xs">
												<input name="userPan" id="u2" type="file" tabindex="80" accept="image/jpg,image/png,image/jpeg,image/gif" onchange="return ValidateFileUpload1()" />
												<i class="fa fa-fw fa-cloud-upload"></i>
												Browse Pan Card 
											</label>
											<div class="clearfix"></div>
											<span class="text-danger"><form:label path="" id="dl" /></span>
										</div>
						              </div>
						              <!-- /.box-body -->
						
						              <div class="box-footer col-xs-12 col-md-6">
						                <button type="submit" class="btn btn-primary" tabindex="85">Submit</button>
						              </div>
						            </form:form>
				              </div>
				              <!-- /.tab-pane -->
				              <div class="tab-pane" id="tab_2">
				                <div class="box-body">
						                <div class="form-group col-xs-12 col-md-6">
						                  <label >*Please Add Basic Info first.</label>
						                </div>
				                </div>
				              </div>
				              <!-- /.tab-pane -->
				              
				            </div>
				            <!-- /.tab-content -->
				          </div>
					</div>
				</div>
				
			</div>
		</div>
		
    </section>
    <!-- /.content -->
  </div>
<!-- <script src="js/jQuery-2.2.0.min.js"></script> -->
<script src="js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">
$('#dob').datetimepicker({
	timepicker:false,
	maxDate:new Date(),
	format:'d-m-Y'
});
$('#joiningDate').datetimepicker({
	timepicker:false,
	maxDate:new Date(),
	format:'d-m-Y'
});
</script>	
<script>
$(document).ready(function(){
    $("#eId").keypress(function(){
    	var eId = $("#eId").val();
    	if(eId.length == 4 || eId.length == 7)
    	{
    		eId += "-";
    		$("#eId").val(eId);
    	}
    });
});
</script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
        $("#countryId").change(function () {
        	
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
   						$("#branch").html("<option value='0' >---SELECT---</option>");
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
$(document).ready(function()
{
	$("#form").trigger('reset');
});
</script>
<script type="text/javascript">
	function validateForm()
	{
		var eId = $("#eId").val();
		var name = $("#name").val();
		var userid = $("#userid").val();
		var password = $("#password").val();
		var repassword = $("#repassword").val();
		var userrole = $("#userrole").val();
		var dob = $("#dob").val();
		var joiningDate = $("#joiningDate").val();
		var department = $("#department").val();
		var designation = $("#designation").val();
		var countryId = $("#countryId").val();
		var branch = $("#branch").val();
        var radioValue = $("input[name='gender']:checked").val();
		
		var valid = true;
		$('.has-error').removeClass("has-error");
		
		if(eId == "" || !$("#eId").val().match(/^(\d{4})(-)([A-Z]{2})(-)(\d{4})$/))
		{
			$("#eId").parent().addClass("has-error")
			valid = false;
		}
		
		if(name == "")
		{
			$("#name").parent().addClass("has-error")
			valid = false;
		}
		if(userid == "" || !isEmail(userid))
		{
			$("#userid").parent().addClass("has-error")
			valid = false;
		}
		if(password == "" || !checkComplexity(password))
		{
			$("#password").parent().addClass("has-error")
			valid = false;
		}
		if(repassword == "" || password != repassword || !checkComplexity(repassword))
		{
			$("#repassword").parent().addClass("has-error")
			valid = false;
		}
		if(userrole == "")
		{
			$("#userrole").parent().addClass("has-error")
			valid = false;
		}
		if(dob == "")
		{
			$("#dob").parent().addClass("has-error")
			valid = false;
			
		}
		if(joiningDate == "")
		{
			$("#joiningDate").parent().addClass("has-error")
			valid = false;
		}
		if(radioValue == undefined)
		{
			$("input[name='gender']").parent().parent().addClass("has-error");
			valid = false;
		}
		
		if(department == "0")
		{
			$("#department").parent().addClass("has-error")
			valid = false;
		}
		if(designation == "0")
		{
			$("#designation").parent().addClass("has-error")
			valid = false;
		}
		if(countryId == "0")
		{
			$("#countryId").parent().addClass("has-error")
			valid = false;
		}
		if(branch == "0")
		{
			$("#branch").parent().addClass("has-error")
			valid = false;
		}
		if(!valid)
		{
			return false;		
		}
		$(".submit_btn").attr("disabled","disabled");
		$(".submit_btn").text("Sending...");
	}

</script>
<Script>
function ValidateFileUpload() {

	var fuData = document.getElementById('u1');
	var FileUploadPath = fuData.value;
	document.getElementById('ui').innerHTML = '';

	if (FileUploadPath == '') {
	    document.getElementById('ui').innerHTML = 'Please upload an image.';
	} else {
	    var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

	    if (Extension == "gif" || Extension == "png" || Extension == "jpeg" || Extension == "jpg") {


	            if (fuData.files && fuData.files[0]) {

	                var size = fuData.files[0].size;

	                if(size > 512000){
	                    document.getElementById('ui').innerHTML = 'Maximum file size exceed.';
	                    $('#output').attr('src', 'images/User_Avatar.png');
	                    fuData.value = "";
	                    return;
	                }else{
	                    var reader = new FileReader();

	                    reader.onload = function(e) {
	                        $('#output').attr('src', e.target.result);
	                    }

	                    reader.readAsDataURL(fuData.files[0]);
	                }
	            }
	    } 
	else {
	        document.getElementById('ui').innerHTML = 'Photo only allows file types of GIF, PNG, JPG and JPEG.';
	        fuData.value = "";
	        $('#output').attr('src', 'images/User_Avatar.png');
	    }
	}}
	</script>
	<script>
function ValidateFileUpload1() {

	var fuData = document.getElementById('u2');
	var FileUploadPath = fuData.value;
	document.getElementById('dl').innerHTML = '';

	if (FileUploadPath == '') {
		document.getElementById('dl').innerHTML = 'Please upload an image.';
	} else {
	    var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();


	    if (Extension == "gif" || Extension == "png" || Extension == "jpeg" || Extension == "jpg") {


	            if (fuData.files && fuData.files[0]) {

	                var size = fuData.files[0].size;

	                if(size > 512000){
	                	document.getElementById('dl').innerHTML = 'Maximum file size exceed.';
	                    $('#output1').attr('src', 'images/document.png');
	                    fuData.value = "";
	                    return;
	                }else{
	                    var reader = new FileReader();

	                    reader.onload = function(e) {
	                        $('#output1').attr('src', e.target.result);
	                    }
	                    reader.readAsDataURL(fuData.files[0]);
	                }
	            }
	    } 
	else {
		document.getElementById('dl').innerHTML = 'Photo only allows file types of GIF, PNG, JPG and JPEG.';
	        fuData.value = "";
	        $('#output1').attr('src', 'images/document.png');
	    }
	}}
</script>

 </body>