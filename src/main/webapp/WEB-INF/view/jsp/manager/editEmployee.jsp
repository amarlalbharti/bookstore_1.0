<%@page import="com.ems.config.ProjectConfig"%>
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
      <h1 class="page-header">Update Employee </h1>
      <ol class="breadcrumb">
        <li><a href="managerDashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
        <li><a href="manageremployees"><i class="fa fa-dashboard"></i> Employee List</a></li>
        <li class="active">update Employee</li>
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
          	Registration empReg = (Registration)request.getAttribute("empReg");
          	if(empReg != null)
          	{
          		%>
          		
		      <!-- Your Page Content Here -->
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="box box-info">
							<div class="box-body no-padding">
								<div class="nav-tabs-custom">
						            <div class="tab-content">
						              <div class="tab-pane active" id="tab_1">
						                	<form:form role="form" method="POST" action="managerEditEmployee" enctype="multipart/form-data" commandName="empForm" onsubmit="return validateForm()" autocomplete="off">
								              <div class="box-body">
								               <div class="form-group col-xs-12 col-md-6">
								                  <label >Employee Id</label>
								                  <label class="form-control" ><%= empReg.geteId() %></label>
								                </div>
								                <div class="form-group col-xs-12 col-md-6">
								                  <label >Employee Name<span class="text-danger">*</span></label>
								                  <form:input path="name" class="form-control titleCase" maxlength="50" placeholder="Enter employee name"/>
								                  <form:hidden path="userid" />
								                  <form:hidden path="userrole"/>
								                  <span class="text-danger"><form:errors path="name" /></span>
								                </div>
								                <div class="clearfix"></div>
								                <div class="form-group col-xs-12 col-md-6">
								                  <label >Email Id</label>
								                  <label class="form-control" ><%= empReg.getUserid() %></label>
								                </div>
								                <div class="form-group col-xs-12 col-md-6">
								                  <label >User Role</label>
								                  <form:select path="userrole" class="form-control" tabindex="5">
								                  	<form:option value=''>Select User role</form:option>
								                  	<form:option value='<%= Roles.ROLE_USER %>'><%= Roles.ROLE_USER %></form:option>
								                  </form:select>
								                  <span class="text-danger"><form:errors path="userrole" /></span>
								                </div>
								                <div class="clearfix"></div>
								                <div class="form-group col-xs-12 col-md-6 date" data-provide="datepicker">
								                  <label >Date of Birth<span class="text-danger">*</span></label>
								                  <form:input path="dob" class="form-control dob" placeholder="dd-MM-yyyy" />
								                  <span class="text-danger"><form:errors path="dob" /></span>
								                </div>
								                <div class="form-group col-xs-12 col-md-6">
								                  <label >Joining Date<span class="text-danger">*</span></label>
								                  <form:input path="joiningDate" class="form-control" placeholder="dd-MM-yyyy" />
								                  <span class="text-danger"><form:errors path="joiningDate" /></span>
								                </div>
								                <div class="clearfix"></div>
								                <div class="form-group col-xs-12 col-md-6">
								                  <div class="col-lg-6  no-padding">
									                  <label >Gender<span class="text-danger">*</span></label>
									                  <div class="input-group">
									                        <span class="input-group-addon">
									                          <form:radiobutton path="gender" value="male" checked="true" />
									                        </span>
									                    <label class="form-control">Male</label>
									                  </div>
									                  <!-- /input-group -->
									                </div>
									                <div class="col-lg-6">
									                  <label >&nbsp;</label>
									                  <div class="input-group">
									                        <span class="input-group-addon">
									                          <form:radiobutton path="gender" value="female"/>
									                        </span>
									                    <label class="form-control">Female</label>
									                  </div>
									                  <!-- /input-group -->
									                </div>
								                </div>
								                <div class="form-group col-xs-12 col-md-6">
								                  <label >Department<span class="text-danger">*</span></label>
								                  <form:select path="department.departmentId" id="department" class="form-control">
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
								                  
								                  <form:select path="designation.designationId" id="designation" class="form-control">
								                  	<form:option value='0'>---SELECT---</form:option>
								                  		<c:forEach var="ds" items="${dsList}">
															<form:option value='${ds.designationId }'>${ds.designation }</form:option>
														</c:forEach>
								                  </form:select>
								                  <span class="text-danger"><form:errors path="designation" /></span>
								                </div>
								                <div class="form-group col-xs-12 col-md-6">
								                  <label >Branch Country<span class="text-danger">*</span></label>
								                  <form:select path="country.countryId" id="countryId" class="form-control">
								                  <form:option value='0'>---SELECT---</form:option>
								                  		<c:forEach var="itam" items="${cList}">
															<form:option value='${itam.countryId }'>${itam.countryName }</form:option>
														</c:forEach>
								                  </form:select>
								                  <span class="text-danger"><form:errors path="country.countryId" /></span>
								                </div>
								                <div class="clearfix"></div>
								                <div class="form-group col-xs-12 col-md-6">
								                  <label >Branch<span class="text-danger">*</span></label>
								                  <form:select path="branch.branchId" id="branch" class="form-control">
								                  		<form:option value='0'>---SELECT---</form:option>
								                  		<c:forEach var="itam" items="${bList}">
															<form:option value='${itam.branchId }'>${itam.branchName }</form:option>
														</c:forEach>
								                  </form:select>
								                  <span class="text-danger"><form:errors path="branch" /></span>
								                </div>
								                <div class="form-group col-xs-12 col-md-6">
								                  <label >Week Off<span class="text-danger">*</span></label>
								                  <form:select path="weekOff" class="form-control">
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
							                <div class="form-group col-xs-12 no-padding">
							                <%	
				 						        if(empReg.getProfileImage() != null && !empReg.getProfileImage().isEmpty())
				 						        {
				 						           	String path = "/ems_uploads/"+empReg.getUserid()+"/Profile_Photo/" + empReg.getProfileImage();
										     %>
												<img alt="Image not available" id="output" src="<%=path %>" style="max-height: 150px; max-width: 100px" />
											<% } else { %>
												<img alt="Image" id="output" src="images/Camera_Icon.png" style="max-height: 150px; max-width: 100px" />
											<% } %>
											</div>
											<div class="form-group col-xs-12 no-padding">
												<label class="btn btn-primary btn-flat btn-xs">
													<input name="userImage" id="u1" type="file" accept="image/jpg,image/png,image/jpeg,image/gif" tabindex="75" onchange="return ValidateFileUpload()" />
													<i class="fa fa-fw fa-cloud-upload"></i>
													Browse Image 
												</label>
												<span class="text-danger"><form:label path="" id="userImgErr" class="image_error" /></span>
											</div>
						                </div>
						                
						                <div class="form-group col-xs-12 col-md-6">
							                <div class="form-group col-xs-12 no-padding">
							                <%
							                if(empReg.getPanImage() != null && (!empReg.getPanImage().isEmpty()))
							                {
							                	String panPath = "/ems_uploads/"+empReg.getUserid()+"/Pan_Scan/"+ empReg.getPanImage();
							                %>
												<img alt="Scan not Available" id="output1" src="<%=panPath %>" style="max-height: 100px; max-width: 300px"/>
							                <% } else { %>
							                	<img alt="Scan not Available" id="output1" src="images/document.png" style="max-height: 100px; max-width: 300px"/>
							                <% } %>
							                </div>
							                <div class="form-group col-xs-12 no-padding">
											<label class=" btn btn-primary btn-flat btn-xs">
												<input name="userPan" id="u2" type="file" accept="image/jpg,image/png,image/jpeg,image/gif" tabindex="80" onchange="return ValidateFileUpload1()" />
												<i class="fa fa-fw fa-cloud-upload"></i>
												Browse Pan Card 
											</label>
											<span class="text-danger"><form:label path="" id="userPanImg" /></span>
											</div>
						                </div>
						                <div class="clearfix"></div>
								              </div>
								              <!-- /.box-body -->
								
								              <div class="box-footer col-xs-12 col-md-6">
								                <button type="submit" class="btn btn-primary submit_btn">Update</button>
								              </div>
								            </form:form>
						              </div>
						
						              <!-- /.tab-pane -->
						              
						            </div>
						            <!-- /.tab-content -->
						          </div>
							</div>
						</div>
						
					</div>
				</div>
				<%
		     	}
		     %>
    </section>
    <!-- /.content -->
  </div>
<script src="js/jQuery-2.2.0.min.js"></script>
<script src="js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">
$('#dob').datetimepicker({
	timepicker:false,
	format:'d-m-Y'
});
$('#joiningDate').datetimepicker({
	timepicker:false,
	format:'d-m-Y'
});
</script>
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
		var name = $("#name").val();
		var userid = $("#userid").val();
		var userrole = $("#userrole").val();
		var dob = $("#dob").val();
		var joiningDate = $("#joiningDate").val();
		var department = $("#department").val();
		var designation = $("#designation").val();
        var radioValue = $("input[name='gender']:checked").val();
		
		var valid = true;
		$('.has-error').removeClass("has-error");
		
		
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
		
		if(!valid)
		{
			return false;		
		}
		$(".submit_btn").attr("disabled","disabled");
		$(".submit_btn").text("Updating...");
	}

</script>
  <Script>
function ValidateFileUpload() {

	var fuData = document.getElementById('u1');
	var FileUploadPath = fuData.value;
	document.getElementById('userImgErr').innerHTML = '';

	if (FileUploadPath == '') {
		document.getElementById('userImgErr').innerHTML = 'Please upload an image.';

	} else {
	    var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

	    if (Extension == "gif" || Extension == "png" || Extension == "jpeg" || Extension == "jpg") {


	            if (fuData.files && fuData.files[0]) {

	                var size = fuData.files[0].size;

	                if(size > 512000){
	                	document.getElementById('userImgErr').innerHTML = 'Maximum file size exceed.';
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
		document.getElementById('userImgErr').innerHTML = 'Photo only allows file types of GIF, PNG, JPG and JPEG.';
	        fuData.value = "";
	        $('#output').attr('src', 'images/User_Avatar.png');
	    }
	}}
	</script>
	<script>
function ValidateFileUpload1() {

	var fuData = document.getElementById('u2');
	var FileUploadPath = fuData.value;
	document.getElementById('userPanImg').innerHTML = '';

	if (FileUploadPath == '') {
		document.getElementById('userPanImg').innerHTML = 'Please upload an image.';

	} else {
	    var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

	    if (Extension == "gif" || Extension == "png" || Extension == "jpeg" || Extension == "jpg") {


	            if (fuData.files && fuData.files[0]) {

	                var size = fuData.files[0].size;

	                if(size > 512000){
	                	document.getElementById('userPanImg').innerHTML = 'Maximum file size exceed.';
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
		document.getElementById('userPanImg').innerHTML = 'Photo only allows file types of GIF, PNG, JPG and JPEG.';
	        fuData.value = "";
	        $('#output1').attr('src', 'images/document.png');
	    }
	}}
</script>
 </body>