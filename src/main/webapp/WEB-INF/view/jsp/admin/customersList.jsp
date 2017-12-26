<%@page import="com.bookstore.domain.Registration"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="com.bookstore.config.DateUtils"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

</head>
<body>
<div class="row">
	<div class="col-sm-6">
		<div class="dataTables_length" id="example1_length">
			<label>Show 
			<select name="products_rpp" id="products_rpp" aria-controls="example1" class="form-control input-sm">
				<option value="5" ${rpp==5 ? 'selected': '' }>5</option>
				<option value="10" ${rpp==10 ? 'selected': '' }>10</option>
				<option value="25" ${rpp==25 ? 'selected': ''}>25</option>
				<option value="50" ${rpp==50 ? 'selected': ''}>50</option>
				<option value="100"  ${rpp==100 ? 'selected': ''}>100</option>
				</select>
				entries
			</label>
		</div>
	</div>
	<div class="col-sm-6">
		<div id="example1_filter" class="dataTables_filter">
			<label>Search:<input class="form-control input-sm"
				placeholder="" aria-controls="example1" type="search"></label>
		</div>
	</div>
</div>
<%
	    int rpp = (Integer)request.getAttribute("rpp");
	  	int pn = (Integer)request.getAttribute("pn");
	  	int start = ((pn-1)*rpp);
	  	int  count = start; 
	  	%>
	<div class="">
      <table id="example1"  class="table table-bordered table-striped">
        <thead>
        <tr>
          <th style="text-align: center;">#</th>
          <th>Email</th>
          <th>Name</th>
          <th>Gender</th>
          <th style="text-align: center;">Active</th>
          <th>Create Date</th>
          <th style="text-align: center;">Action</th>
        </tr>
        </thead>
        <tbody>
        <%
        	List<Registration> customerList = (List)request.getAttribute("customersList");
        	if(customerList != null && !customerList.isEmpty()){
        		for(Registration customer : customerList){
        			
        			%>
        				<tr>
        				  <td style="text-align: center;"><%= ++count%></td>
			              <td><%= customer.getLoginInfo().getUserid() %></td>
			              <td><%= customer.getFirstName() + " " + customer.getLastName()%></td>
			              <td><%= customer.getGender()%></td>
			              <td style="text-align: center;"><%= customer.getLoginInfo().getIsActive()%></td>			             
			              <td><%= DateUtils.clientDateFormat.format(customer.getCreateDate())%></td>
			              <td style="text-align: center;">
			              	<a href="${pageContext.request.contextPath}/admin/customers/edit/<%= customer.getRid()%>" class="btn btn-flat btn-sm btn-primary"><i class="fa fa-fw fa-edit"></i> View</a>
			              </td>
			            </tr>
        			<%
        		}
        	}
        %>
        
        </tbody>
      </table>
      </div>
<%
 	long listcount = (Long)request.getAttribute("listcount");
 	int lastpage = ((int)listcount)/rpp;
 	if(listcount%rpp > 0){
 		lastpage = lastpage + 1; 
 	}
 		  
 %>
<div class="row">
   	<div class="col-sm-5">
   		<div class="dataTables_info" id="example2_info" role="status" aria-live="polite">Showing <%= listcount>0?start+1:0 %> to <%= count %> of <%= listcount %> entries</div>
	</div>
	<div class="col-sm-7">
		<div class="dataTables_paginate paging_simple_numbers" id="products_paginate">
			<ul class="pagination">
				<%
					if(pn>1){
						%>
						<li class="paginate_button previous" id="products_previous" pn="<%= pn-1 %>">
	  						<a href="javascript:void(0);" aria-controls="example2" data-dt-idx="0" tabindex="0"><spring:message code="label.datatable.pagination.previous"/></a>
						</li>
					<%	
					}else{
					%>
						<li class="paginate_button previous disabled">
  							<a href="javascript:void(0);" aria-controls="example2" data-dt-idx="0" tabindex="0"><spring:message code="label.datatable.pagination.previous"/></a>
						</li>
					<%	
						
					}
   				%>
				<li class="paginate_button active">
					<a href="#" aria-controls="example2" data-dt-idx="1" tabindex="0"><%= pn %></a>
				</li>
				<%
					if(pn<lastpage){
						%>
							<li class="paginate_button next" id="products_next" pn="<%= pn+1 %>">
								<a href="javascript:void(0);" aria-controls="example2" data-dt-idx="7" tabindex="0"><spring:message code="label.datatable.pagination.next"/></a>
							</li>
						<%	
					}else{
						%>
 							<li class="paginate_button next disabled" >
								<a href="javascript:void(0);" aria-controls="example2" data-dt-idx="7" tabindex="0"><spring:message code="label.datatable.pagination.next"/></a>
							</li>
						<%	
					}
     			%>
       					
			</ul>
		</div>
	</div>
</div>
  
</body>
</html>