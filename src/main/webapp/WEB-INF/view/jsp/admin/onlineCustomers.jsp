<%@page import="com.bookstore.comparator.SessionInfoComparator"%>
<%@page import="java.util.Collections"%>
<%@page import="com.bookstore.util.CustomerUtils"%>
<%@page import="org.springframework.security.core.userdetails.UserDetails"%>
<%@page import="org.springframework.security.core.session.SessionInformation"%>
<%@page import="com.bookstore.domain.Registration"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="com.bookstore.util.DateUtils"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

</head>
<body>
	

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header clearfix" >
      <h1 class="pull-left"><spring:message code="label.customers.online"/></h1>
      
    </section>

    <!-- Main content -->
    <section class="content" style="min-height: 530px;">
      
      <!-- Main row -->
      <div class="row">
        <div class="col-md-12">
          <!-- Horizontal Form -->
          <div class="box box-info">
            <div class="box-body">
				<table id="example1"  class="table table-bordered">
			        <thead>
				        <tr class="bg-primary">
				          <th style="text-align: center;"><input type="checkbox" name="sel[]"> </th>
				          <th>Email</th>
				          <th>Session Id</th>
				          <th>Authorities</th>
				          <th>Last Used</th>
				          <th style="text-align: center;">Action</th>
				        </tr>
			        </thead>
			        <tbody>
			        <%
			        	List<SessionInformation> customerList = (List)request.getAttribute("sessionsList");
			        	if(customerList != null && !customerList.isEmpty()){
			        		for(SessionInformation sess : customerList){
			        			UserDetails ud = (UserDetails)sess.getPrincipal();
			        			
			        			%>
			        				<tr class="<%= CustomerUtils.getCustomerStatusClass(sess) %>">
						              <td style="text-align: center;"><input type="checkbox" name="sel[]"></td>
						              <td><%= ud.getUsername() %></td>
						              <td><%= sess.getSessionId()%></td>
						              <td><%= ud.getAuthorities()%></td>
						              <td title="<%= sess.getLastRequest()%>"><%= DateUtils.fullFormat.format(sess.getLastRequest())%></td>
						              <td style="text-align: center;">
						              	<a href="${pageContext.request.contextPath}/admin/customers/logout/<%= sess.getSessionId()%>" class="btn btn-flat btn-sm btn-danger"><i class="fa fa-fw fa-sign-out"></i> Log Out</a>
						              </td>
						            </tr>
			        			<%
			        		}
			        	}
			        %>
			        
			        </tbody>
			      </table>
            </div>
          </div>
        </div>
        
      </div>
      <!-- /.row (main row) -->

    </section>
    <!-- /.content -->
  </div>
<script src="${pageContext.request.contextPath}/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/js/dataTables.bootstrap.js"></script>
<script>
  $(function () {
    $('#example1').DataTable({
      "paging": true,
      "lengthChange": true,
      "searching": true,
      "ordering": false,
      "info": true,
      "autoWidth": false
    });
  });
</script>

  
</body>
</html>