<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.model.LeaveDetailModel"%>
<%@page import="com.ems.domain.UserDetail"%>
<%@page import="com.ems.domain.Registration"%>
<%@page import="java.util.Date"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.LeaveDetail"%>
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
<input type="hidden" id=Mode name="Mode" value="${Mode}">
	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
       <!-- Main content -->
    <section class="content">
   
   <%
   		TimeZone timeZone = (TimeZone) request.getSession().getAttribute("timezone");
	%>
     
    <%
   	String Mode = (String)request.getAttribute("Mode");
    if(Mode.equals("add")){
    %>
		      	<!-- Your Page Content Here -->
				<div class="row">
					<div class="col-xs-12 col-md-12">
					 
					<h2>Leave Application Form</h2>
						
                				<form:form method="POST" role="form" action="useraddleave" commandName="leave" onsubmit="return validate()">
                				<div class="box box-info">
										<div class="box-body leave-form">
										
										  <div class="form-group col-xs-12 col-md-6">
							                <label>Send To</label><span class="text-danger">*</span>
							                <form:select path ="sendTo" class="form-control select2 search_emp" name='term' style="width: 100%;" autofocus="autofocus" tabindex="1">
							                </form:select>
							                <span class="text-danger"><form:errors path="sendTo" /></span>
							              </div>
							              <div class="form-group col-xs-12 col-md-6">
							                <label>Cc</label><span class="text-danger">*</span>
							                <form:select path ="cc" class="form-control search_empCc" name='term' style="width: 100%;" tabindex="5">
							              </form:select>
							              <span class="text-danger"><form:errors path="cc" /></span>
							              </div>
										  <div class="form-group col-xs-12 col-md-6" data-provide="datepicker" >
						                  <label>From Date</label>
						                  <span class="text-danger">*</span>
						                  <form:input path="fromDate" class="form-control dob" placeholder="dd-MM-yyyy" readonly="readonly"/>
						                  <span class="text-danger"><form:errors path="fromDate" /></span>
						                
						                </div>
						                
						              <div class="form-group col-xs-12 col-md-6">
						                  <label>To Date</label>
						                  <span class="text-danger">*</span>
						                  <form:input path="toDate" class="form-control" placeholder="dd-MM-yyyy" readonly="readonly"/>
						                  <span class="text-danger"><form:errors path="toDate" /></span>
						                  <div class="error-messages text-danger" style="display:none;"></div>
						                </div>
										  <div class="form-group col-xs-12 col-md-6">
										 <label>Leave Type</label>
											<span class="text-danger">*</span>
											 <form:select path="leaveType" class="form-control" tabindex="10">
											        <form:option value='Select'></form:option>
								                    <form:option value='Emergency Leave'></form:option>
								                  	<form:option value='Casual Leave'></form:option>
								                  	<form:option value='Priviledge Leave'></form:option>
								             </form:select><span class="text-danger"><form:errors path="leaveType" /></span>
										 
										  </div>
										   <div class="form-group col-xs-12 col-md-6">
											<label>Subject</label>
											<span class="text-danger">*</span>
											<form:input path="subject" cssClass="form-control titleCase" placeholder="Enter Subject" tabindex="15" maxlength="250"/>
											<span class="text-danger"><form:errors path="subject" /></span>
										 
										  </div>
										   <div class="form-group col-xs-12 col-md-6">
											<label>Reason</label>
											<span class="text-danger">*</span>
											<form:textarea path="reason" rows="5" cols="50" cssClass="form-control titleCase" style="resize:none;" placeholder="Enter Reason" tabindex="20"/>
											<span class="text-danger"><form:errors path="reason" /></span>
										  
										  </div>
										  
									    <div class="clearfix"></div>
											<div class="box-footer col-xs-12 col-md-12">
											<button type="submit" id="submit_btn" class="btn btn-primary btn-flat" >Submit</button>
										</div>
									</div>
								 </div>
								 </form:form>	
								</div>
							</div>
						
					
			<%
    }else if(Mode.equals("edit")){
			%>	
			<!-- Your Page Content Here -->
				<div class="row">
					<div class="col-xs-12 col-md-12">
					     
					<h2>Update Leave Application</h2>
							<form:form method="POST" role="form" action="usereditleave" commandName="leave" onsubmit="return validate()">
							            
								<div class="box box-info">
								        
									<div class="box-body leave-form">
										<div class="form-group">
											<form:hidden path="leaveId" cssClass="form-control" />
						  				</div>
						  				
						  				
										  
										  <div class="form-group col-xs-12 col-md-6">
							                <label>Send To</label><span class="text-danger">*</span>
							                <form:select path ="sendTo" class="form-control select2 search_emp" name='term' style="width: 100%;" autofocus="autofocus" tabindex="1">
							                <%
							                	Registration sendTo = (Registration)request.getAttribute("sendTo");
							                	if(sendTo != null)
							                	{
							                		%>
										                <form:option value='<%= sendTo.getUserid() %>'><%= sendTo.getName()+" &lt;"+sendTo.getUserid()+"&gt;" %></form:option>
							                		<%
							                	}
							                %>
							                </form:select>
							                <span class="text-danger"><form:errors path="sendTo" /></span>
							              </div>
							              <div class="form-group col-xs-12 col-md-6">
							                <label>Cc</label><span class="text-danger">*</span>
							                <form:select path ="cc" class="form-control search_empCc" name='term'  multiple="multiple" style="width: 100%;" tabindex="5">
							                 <%
							                 List<Registration> ccList = (List)request.getAttribute("cc");
							                 if(ccList != null && !ccList.isEmpty())
												{
													
													for(Registration cc : ccList)
													{
							                	
							                		%>
										                <form:option value='<%= cc.getUserid() %>' selected="selected"><%= cc.getName()+" &lt;"+cc.getUserid()+"&gt;" %></form:option>
							                		<%
							                	}
											}
							                
							                	%> 
							                	 
							                	
							                </form:select>
							                <span class="text-danger"><form:errors path="cc" /></span>
							              </div>
										  
										  
										  <div class="form-group col-xs-12 col-md-6" data-provide="datepicker">
						                  <label>From Date</label>
						                  <span class="text-danger">*</span>
						                  <form:input path="fromDate" class="form-control dob" placeholder="dd-MM-yyyy"/>
						                  <span class="text-danger"><form:errors path="fromDate" /></span>
						                
						                </div>
						               
						                <div class="form-group col-xs-12 col-md-6">
						                  <label>To Date</label>
						                  <span class="text-danger">*</span>
						                  <form:input path="toDate" class="form-control" placeholder="dd-MM-yyyy"/>
						                  <span class="text-danger"><form:errors path="toDate" /></span>
						                  <div class="error-messages text-danger" style="display:none;"></div>
						                </div>
										 <div class="form-group col-xs-12 col-md-6">
										 <label>Leave Type</label>
											<span class="text-danger">*</span>
											 <form:select path="leaveType" class="form-control" required="required" tabindex="10">
											        <form:option value='Select'></form:option>
								                    <form:option value='Emergency Leave'></form:option>
								                  	<form:option value='Casual Leave'></form:option>
								                  	<form:option value='Priviledge Leave'></form:option>
								             </form:select><span class="text-danger"><form:errors path="leaveType" /></span>
										
										  </div>
										  <div class="form-group col-xs-12 col-md-6">
											<label>Subject</label>
										    <span class="text-danger">*</span>
											<form:input path="subject" cssClass="form-control titleCase" placeholder="Enter Subject" tabindex="15" maxlength="250" style="resize:resize;"/>
											<span class="text-danger"><form:errors path="subject" /></span>
										 
										  </div>
										  <div class="form-group col-xs-12 col-md-6">
											<label>Reason</label>
											<span class="text-danger">*</span>
											<form:textarea path="reason" rows="5" cols="50" cssClass="form-control titleCase" style="resize:none;"  placeholder="Enter Reason" tabindex="20"/>
											<span class="text-danger"><form:errors path="reason" /></span>
										 
										  </div>
										  
									      <div class="clearfix"></div>
											<div class="box-footer col-xs-12 col-md-12">
											<button type="submit" class="btn btn-primary btn-flat" id="submit_btn" >Update</button>
										    </div>
									</div>
								 </div>
								</form:form>						              
							</div>
						</div>
				
			<%
    }
    else if(Mode.equals("view"))
    {
    	LeaveDetail leaveDetail = (LeaveDetail)request.getAttribute("leaveDetail");
    	Registration registration = leaveDetail.getRegistration();
        UserDetail userDetail = registration.getUserDetail();
    	if(leaveDetail != null && registration != null && userDetail != null)
    	{
			%>
			<div class="row">
					<div class="col-xs-12 col-md-12">
					     <div class="pull-right " style="padding-left: 20px;">
							 <a href="userprintleave?leaveId=<%= leaveDetail.getLeaveId()%>" target="_blank"><button class="btn btn-primary"><i class="fa fa-fw fa-print"></i> Print</button></a>
						 </div>	
					<h2>View Leave Application</h2>
				<div class="box box-info">
					<div class="box-body no-padding">
					
									<div class="form-horizontal">
									
						              <div class="box-body">
						            
						                  <div class="form-group col-md-6">
									        <label class="col-sm-4 control-label" style="text-align: left;">Name</label>
									         <div class="col-sm-8">
									          <label class="form-control label-text"><%= registration.getName() %></label>
									         </div>
									      </div>
									      <div class="form-group col-md-6">
									        <label class="col-sm-4 control-label"  style="text-align: left;">User ID</label>
									         <div class="col-sm-8">
									          <label class="form-control label-text"><%= registration.getUserid() %></label>
									         </div>
									      </div>
									       <div class="form-group col-md-6">
									        <label class="col-sm-4 control-label"  style="text-align: left;">Joining Date</label>
									         <div class="col-sm-8">
									          <label class="form-control label-text"><%= DateFormats.ddMMMyyyy(timeZone).format(registration.getJoiningDate()) %></label>
									         </div>
									      </div>
									      <%
									      	if(registration.getDepartment() != null)
									      	{
									      		%>
								                   <div class="form-group col-md-6">
											        <label class="col-sm-4 control-label" style="text-align: left;">Department</label>
											         <div class="col-sm-8">
											          <label class="form-control label-text"><%= registration.getDepartment().getDepartment() %></label>
											         </div>
											      </div>
									      		<%
									      	}
									      	if(registration.getDesignation() != null)
									      	{
									      		%>
											       <div class="form-group col-md-6">
											        <label class="col-sm-4"  style="text-align: left;">Designation</label>
											         <div class="col-sm-8">
											          <label class="form-control label-text"><%= registration.getDesignation().getDesignation() %></label>
											         </div>
											      </div>
									      		<%
									      	}
									      	if(userDetail != null)
									      	{
									      		%>
											       <div class="form-group col-md-6">
											        <label class="col-sm-4 control-label" style="text-align: left;">Mobile Number</label>
											         <div class="col-sm-8">
											          <label class="form-control label-text"><%= userDetail.getMobileNo() %></label>
											         </div>
											      </div>
									      		<%
									      	}
									      	
									      %>
									      <div class="form-group col-md-6">
						                   <label class="col-sm-4 control-label" style="text-align: left;">Send To</label>
						                    <div class="col-sm-8">
						                     <label class="form-control label-text"><%= leaveDetail.getSendTo() %></label>
						                    </div>
						                  </div>
						                <%   if(leaveDetail.getCc() != null)
									      	{
									      		%>
						                 <div class="form-group col-md-6">
						                  <label class="col-sm-4 control-label" style="text-align: left;">Cc</label>
						                   <div class="col-sm-8">
						                    <label class="form-control label-text"><%= leaveDetail.getCc() %></label>
						                   </div>
						                 </div>
						                <%
									      	} else{
						                %>
						                <div class="form-group col-md-6">
						                  <label class="col-sm-4 control-label" style="text-align: left;">Cc</label>
						                   <div class="col-sm-8">
						                    <label class="form-control label-text"><% out.println("NA"); %></label>
						                   </div>
						                 </div>
						                 
						                 <%
									      	}
						                 %>
						                  <div class="form-group col-md-6">
						                  <label class="col-sm-4 control-label" style="text-align: left;">From Date</label>
						                   <div class="col-sm-8">
						                    <label class="form-control label-text"><%= DateFormats.ddMMMyyyy(timeZone).format(leaveDetail.getFromDate()) %></label>
						                   </div>
						                 </div>
						                
						                 <div class="form-group col-md-6">
						                  <label class="col-sm-4 control-label" style="text-align: left;">To Date</label>
						                   <div class="col-sm-8">
						                    <label class="form-control label-text"><%= DateFormats.ddMMMyyyy(timeZone).format(leaveDetail.getToDate()) %></label>
						                   </div>
						                 </div>
						                
						                  <div class="form-group col-md-6">
						                  <label class="col-sm-4 control-label" style="text-align: left;">Leave Type</label>
						                   <div class="col-sm-8">
						                    <label class="form-control label-text"><%= leaveDetail.getLeaveType() %></label>
						                   </div>
						                 </div>
						                 
						                 <div class="form-group col-md-6">
						                  <label class="col-sm-4 control-label" style="text-align: left;">Status</label>
						                   <div class="col-sm-8">
						                    <label class="form-control label-text"><%= leaveDetail.getStatus() %></label>
						                   </div>
						                  </div>
						                 <%   if(leaveDetail.getApprovedBy() != null)
									      	{
									      		%>
											       <div class="form-group col-md-6">
											        <label class="col-sm-4 control-label" style="text-align: left;">Approved By</label>
											         <div class="col-sm-8">
											          <label class="form-control label-text"><%= leaveDetail.getApprovedBy() %></label>
											         </div>
											      </div>
											      
											      <div class="form-group col-md-6">
											        <label class="col-sm-4 control-label" style="text-align: left;">Approved Date</label>
											         <div class="col-sm-8">
											          <label class="form-control label-text"><%= DateFormats.ddMMMyyyy(timeZone).format(leaveDetail.getApprovedDate()) %></label>
											         </div>
											      </div>
									      		<%
									      	}
									      	
									      %>
						                  <div class="form-group col-md-6">
						                  <label class="col-sm-4 control-label" style="text-align: left;">Subject</label>
						                   <div class="col-sm-8">
						                    <label class="form-control label-text"><%= leaveDetail.getSubject() %></label>
						                   </div>
						                 </div>
						                
						                  <div class="form-group col-md-6">
						                  <label class="col-sm-4 control-label" style="text-align: left;">Reason</label>
						                   <div class="col-sm-8">
						                    <label  class="form-control label-text"><%= leaveDetail.getReason() %></label>
						                   </div>
						                 </div>
						                 
						                </div>
						            </div>
						        </div>
						    </div>
					   </div>
		          </div>
			<%
			
    	}
    }
    else
    {
    	%>
    		<div class="row">
					<div class="col-xs-12 col-md-12">
					     
						<h2>No Data available</h2>
						<div class="box box-info">
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
<script src="js/select2.full.min.js"></script>
<script src="js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript">


 $('#fromDate').datetimepicker({
	timepicker:false,
	format:'d-m-Y',
	minDate:new Date()

});
$('#toDate').datetimepicker({
	timepicker:false,
	format:'d-m-Y',
	minDate:$('#fromDate').val()

})  


function validate()
{
	var sendTo=$(".leave-form #sendTo").val();
	//var cc=$(".leave-form #cc").val();
	var fromDate=$(".leave-form #fromDate").val();
	var toDate=$(".leave-form #toDate").val();
	var leaveType=$(".leave-form #leaveType").val();
	var subject=$(".leave-form #subject").val();
	var reason=$(".leave-form #reason").val();
	
	var valid = true;
    $('.has-error').removeClass("has-error");
    
	
	if(sendTo==''||sendTo==null){
		$(".leave-form #sendTo").parent().addClass("has-error")
		valid=false;
		}	
	
	if(fromDate==''){
		$(".leave-form #fromDate").parent().addClass("has-error")
		valid=false;
		}
	
	if(toDate==''){
		$(".leave-form #toDate").parent().addClass("has-error")
		valid=false;
		}
	
	if(leaveType==''||leaveType=='Select'){
		$(".leave-form #leaveType").parent().addClass("has-error")
		valid=false;
		}
	
	if(subject==''){
		$(".leave-form #subject").parent().addClass("has-error")
		valid=false;
		}
	
	if(reason==''){
		$(".leave-form #reason").parent().addClass("has-error")
		valid=false;
		}
	
	$(".error-messages").text("").fadeIn();

	if(toDate<fromDate){
		$(".leave-form #toDate").parent().addClass("has-error")
		$(".error-messages").text("To Date cannot be less than from date").fadeIn();
		valid=false;
	}
	
	if(!valid)
    {
        return false;        
    }
	
    $(".leave-form #submit_btn").attr("disabled","disabled");
    if(($("#Mode").val())=='add'){
    $(".leave-form #submit_btn").text("Saving...");
    }
    
    if(($("#Mode").val())=='edit'){
        $(".leave-form #submit_btn").text("Updating...");
        }
}
</script>

<script type="text/javascript">

  $(function () {
	 //alert('hi');
    $(".search_emp").select2({
    	
    	minimumInputLength: 3,
        multiple: false,
        minimumResultsForSearch: 10,
        ajax: {
            url: 'searchEmployees',
            dataType: 'json',
            type: "GET",
            quietMillis: 50,
            data: function (term) {
//             	alert("::::: " + term.term)
                return {
                    q: term.term
                };
            },
            processResults: function (data) {
//             	alert("::::: " + data);
                return {
                    results: $.map(data, function (item) {
                        return {
                            text: item.name+" <"+item.userid+">",
//                             slug: item.slug,
                            id: item.userid
                        }
                    })
                };
            }
        }
    });
    
    
    $(".search_empCc").select2({
    	
    	minimumInputLength: 3,
        multiple: true,
        minimumResultsForSearch: 10,
        ajax: {
            url: 'searchEmployees',
            dataType: 'json',
            type: "GET",
            quietMillis: 50,
            data: function (term) {
//             	alert("::::: " + term.term)
                return {
                	q: term.term
                };
            },
            processResults: function (data) {
//             	alert("::::: " + data);
                return {
                    results: $.map(data, function (item) {
                        return {
                            text: item.name+" <"+item.userid+">",
//                             slug: item.slug,
                            id: item.userid
                        }
                    })
                };
            }
        }
    });
}); 
 
</script>	

 </body>