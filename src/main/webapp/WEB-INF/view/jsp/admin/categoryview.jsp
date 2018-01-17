<%@page import="com.bookstore.util.DateUtils"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.bookstore.domain.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
					<label>Show <select name="example1_length"
						aria-controls="example1" class="form-control input-sm"><option
								value="10">10</option>
							<option value="25">25</option>
							<option value="50">50</option>
							<option value="100">100</option></select> entries
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
		<div class="row">
            <table class="table table-bordered table-striped">
              <thead>
              <tr>
                <th>Category Name</th>
                <th>Browser</th>
                <th>Platform(s)</th>
                <th>Create Date</th>
                <th>CSS grade</th>
              </tr>
              </thead>
              <tbody>
              <%
              	List<Category> categoryList = (List)request.getAttribute("categoryList");
              	if(categoryList != null && !categoryList.isEmpty()){
              		for(Category category : categoryList){
              			%>
              				<tr>
		                  <td><%= category.getCategoryName()%></td>
		                  <td>Internet
		                    Explorer 5.0
		                  </td>
		                  <td>Win 95+</td>
		                  <td><%= DateUtils.clientDateFormat.format(category.getCreateDate())%></td>
		                  <td>C</td>
		                </tr>
              			<%
              		}
              	}
              %>
              
              </tbody>
              <tfoot>
              <tr>
                <th>Rendering engine</th>
                <th>Browser</th>
                <th>Platform(s)</th>
                <th>Engine version</th>
                <th>CSS grade</th>
              </tr>
              </tfoot>
            </table>
            </div>
            <div class="row">
            	<div class="col-sm-5">
            		<div class="dataTables_info" id="example2_info" role="status" aria-live="polite">Showing 1 to 10 of 57 entries</div>
        		</div>
        		<div class="col-sm-7">
        			<div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
        				<ul class="pagination">
        					<li class="paginate_button previous disabled" id="example2_previous">
        						<a href="#" aria-controls="example2" data-dt-idx="0" tabindex="0">Previous</a>
     						</li>
    						<li class="paginate_button active">
    							<a href="#" aria-controls="example2" data-dt-idx="1" tabindex="0">1</a>
 							</li>
 							<li class="paginate_button ">
						<a href="#" aria-controls="example2" data-dt-idx="2" tabindex="0">2</a>
					</li>
					<li class="paginate_button ">
						<a href="#" aria-controls="example2" data-dt-idx="3" tabindex="0">3</a>
					</li>
					<li class="paginate_button ">
						<a href="#" aria-controls="example2" data-dt-idx="4" tabindex="0">4</a>
					</li>
					<li class="paginate_button ">
						<a href="#" aria-controls="example2" data-dt-idx="5" tabindex="0">5</a>
					</li>
					<li class="paginate_button ">
						<a href="#" aria-controls="example2" data-dt-idx="6" tabindex="0">6</a>
					</li>
					<li class="paginate_button next" id="example2_next">
						<a href="#" aria-controls="example2" data-dt-idx="7" tabindex="0">Next</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>