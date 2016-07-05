<%@page import="java.util.Date"%>
<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@page import="java.util.TimeZone"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Attendance"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<link rel="stylesheet" href="css/fullcalendar.css">
<link rel="stylesheet" href="css/fullcalendar.print.css" media="print">
  <!-- Select2 -->
</head>
<body>
<div class="content-wrapper">
    <!-- Main content -->
    <%
    	TimeZone timeZone = (TimeZone)request.getSession().getAttribute("timezone");
    %>
    <section class="content-header">
      <h1>
        Calendar
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
      	<sec:authorize access="hasRole('ROLE_ADMIN')">
        	<li><a href="adminDashboard"><i class="fa fa-dashboard"></i> Home</a></li>
        </sec:authorize>
        <sec:authorize access="hasRole('ROLE_MANAGER')">
        	<li><a href="managerDashboard"><i class="fa fa-dashboard"></i> Home</a></li>
        </sec:authorize>
        <sec:authorize access="hasRole('ROLE_USER')">
        	<li><a href="userDashboard"><i class="fa fa-dashboard"></i> Home</a></li>
        </sec:authorize>
        <li class="active">Calendar</li>
      </ol>
    </section>
    <!-- /.content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-body no-padding">
              <!-- THE CALENDAR -->
              <div id="calendar"></div>
            </div>
          </div>
        </div>
        
        <div class="col-md-6">
              <table>
              <tr>
              <td style="height: 10px; width: 20px; background-color: #D84832;"></td>
              <td style="padding-left: 5px;">Absent</td>
              </tr>
              <tr>
              <td style="height: 10px; width: 20px; background-color: #00a65a;"></td>
              <td style="padding-left: 5px;">Present</td>
              </tr>
              <tr>
              <td style="height: 10px; width: 20px; background-color: #F643F9;"></td>
              <td style="padding-left: 5px;">Leave</td>
              </tr>
              <tr>
              <td style="height: 10px; width: 20px; background-color: #EFDE10;"></td>
              <td style="padding-left: 5px;">Birthday</td>
              </tr>
				<tr>
					<td style="height: 10px; width: 20px; background-color: #0000FF;"></td>
					<td style="padding-left: 5px;">Week off</td>
				</tr>
				</table>
            </div>
        
      </div>
    </section>
  </div><!-- Select2 -->
  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="js/fullcalendar.min.js"></script>
<!-- Page specific script -->
<script>
jQuery(document).ready(function () {
    //Date for the calendar events (dummy data)
    var date = new Date();
    var d = date.getDate(),
        m = date.getMonth(),
        y = date.getFullYear();
	var ary = [];
	var aryLve = [];
//     alert('1');
 $.ajax({
	type : "GET",
	url : "searchEmployeeEvent",
	contentType : "application/json",
	success : function(data) {
		var obj = jQuery.parseJSON(data);
		if(!obj.error)
		{
		    var list = obj.att;
		    var weekOff = obj.weekOff;
		    if(weekOff == null)
	    	{
		    	weekOff = 1;
	    	}
		    
			jQuery.each( list, function( i, val ) {
				if(val.title != "On Leave" && val.title != "Absent" && !val.title.includes("BirthDay"))
				{
					ary.push(
						{
					           title: val.title,
					           start: val.start,
					           backgroundColor: "#00a65a",
					           borderColor: "#00a65a" 
					      }
						);
				}
				
				if(val.title == "Absent")
				{
					ary.push(
					{
			           title: val.title,
			           start: val.start,
			           backgroundColor: "#D84832",
			           borderColor: "#D84832" 
				      }
					);
				}
				
				if(val.title == "On Leave")
				{
					ary.push(
					{
				           title: val.title,
				           start: val.start,
				           end: val.end,
				           backgroundColor: "#F643F9",
				           borderColor: "#F643F9" 
				      }
					);
				}
				
				if(val.title.includes("BirthDay"))
				{
					ary.push(
					{
				           title: val.title,
				           start: val.start,
				           backgroundColor: "#EFDE10",
				           borderColor: "#EFDE10" 
				      }
					);
				}
				
			});
			
			ary.push(
					{
				           title: 'Week off',
				           start: '00:01',
				           end: '23:59',
				           backgroundColor: "#0000FF",
				           borderColor: "#0000FF",
				           dow: [ weekOff-1 ]
				      }
					);
			
			//Cal Start
			
	$('#calendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      buttonText: {
        today: 'today',
        month: 'month',
        week: 'week',
        day: 'day'
      },
      //Random default events
      events: ary
//     	  [
//         {
//           title: 'All Day Event',
//           start: new Date(y, m, 1),
//           backgroundColor: "#f56954", //red
//           borderColor: "#f56954" //red
//         },
//         {
//           title: 'Long Event',
//           start: new Date(y, m, d - 5),
//           end: new Date(y, m, d - 2),
//           backgroundColor: "#f39c12", //yellow
//           borderColor: "#f39c12" //yellow
//         }
//       ]
      ,
      editable: false,
      droppable: false, // this allows things to be dropped onto the calendar !!!
      drop: function (date, allDay) { // this function is called when something is dropped

        // retrieve the dropped element's stored Event Object
        var originalEventObject = $(this).data('eventObject');

        // we need to copy it, so that multiple events don't have a reference to the same object
        var copiedEventObject = $.extend({}, originalEventObject);

        // assign it the date that was reported
        copiedEventObject.start = date;
        copiedEventObject.allDay = allDay;
        copiedEventObject.backgroundColor = $(this).css("background-color");
        copiedEventObject.borderColor = $(this).css("border-color");

        // render the event on the calendar
        // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
        $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

      }
    });
			//cal End
}
		else
		{
			$('#calendar').fullCalendar({
			      header: {
			        left: 'prev,next today',
			        center: 'title',
			        right: 'month,agendaWeek,agendaDay'
			      },
			      buttonText: {
			        today: 'today',
			        month: 'month',
			        week: 'week',
			        day: 'day'
			      },
			      //Random default events
			      events: ary
//			     	  [
//			         {
//			           title: 'All Day Event',
//			           start: new Date(y, m, 1),
//			           backgroundColor: "#f56954", //red
//			           borderColor: "#f56954" //red
//			         },
//			         {
//			           title: 'Long Event',
//			           start: new Date(y, m, d - 5),
//			           end: new Date(y, m, d - 2),
//			           backgroundColor: "#f39c12", //yellow
//			           borderColor: "#f39c12" //yellow
//			         }
//			       ]
			      ,
			      editable: false,
			      droppable: false, // this allows things to be dropped onto the calendar !!!
			      drop: function (date, allDay) { // this function is called when something is dropped

			        // retrieve the dropped element's stored Event Object
			        var originalEventObject = $(this).data('eventObject');

			        // we need to copy it, so that multiple events don't have a reference to the same object
			        var copiedEventObject = $.extend({}, originalEventObject);

			        // assign it the date that was reported
			        copiedEventObject.start = date;
			        copiedEventObject.allDay = allDay;
			        copiedEventObject.backgroundColor = $(this).css("background-color");
			        copiedEventObject.borderColor = $(this).css("border-color");

			        // render the event on the calendar
			        // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
			        $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

			      }
			    });
		}
		
		
	}
  });
    


  });
</script>
 </body>