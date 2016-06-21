<%@page import="java.util.Date"%>
<%@page import="com.ems.config.NumberFormat"%>
<%@page import="com.ems.domain.Attendance"%>
<%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Payroll"%>
<%@page import="java.util.List"%>
<script src="js/common_js.js"></script>.
  <script src="js/jQuery-2.2.0.min.js"></script>
  <style type="text/css" media="print">
  @page { size: landscape; }
</style>
<style>
td, th
{
padding-left: 5px;
}
.numTd
{
	text-align: right;
	padding-right: 5px;
}
</style>
<div class="box-header with-border">
	<h3 class="box-title">Payroll Report</h3>
</div>
<div class="box-body table-responsive">
	<%
	String status = request.getParameter("status");
	if(status == null)
	{
	List<Payroll> payrollList = (List)request.getAttribute("payList");
	if(payrollList != null && !payrollList.isEmpty())
	{
		%>
		<div style="border:1px #ccc solid;" class="printDiv">
		<%
		for(Payroll pp : payrollList)
		{
		%>
		<br/><br/><br/>
			<div style="width: 70%; float: left;">
				<label>Vasonomics (India) Pvt. Ltd. </label><br/>
				<label>31/B, 2nd Floor, Dixit Building, Odeon colony </label><br/>
				<label>Lucknow </label><br/>
				<label>Ph. : 0522-4028568 </label><br/>
			</div>
			<div style="width: 30%; float: right;">
				<img alt="Logo" src="images/logo.gif">
			</div>
			
			<!-- for Emp Detail -->
			<table style="width:100%; border-top: 1px #ccc solid; border-bottom: 1px #ccc solid;">
				<tr>
					<td style="width:20%">Employee Name</td><td colspan="3"><%= pp.getRegistration().getName() %></td>
				</tr>
				<tr>
					<td>Employee Code</td><td colspan="3">NA</td>
				</tr>
				<tr>
					<td style="width:20%">Designation</td><td style="width:35%"><%= pp.getRegistration().getDesignation().getDesignation() %></td>
					<td style="width:20%">Pay Days</td><td><%=pp.getNoOfPresentDays() %></td>
				</tr>
				<tr>
					<td style="width:20%">Salary Slip for the m/o</td><td colspan="3"><%= DateFormats.MMMformat().format(pp.getPayMonth()) %></td>
				</tr>
				<tr>
					<td style="width:20%">PF A/C Number</td><td colspan="3">NA</td>
				</tr>
			</table>
			<div style="height: 20px; border : 1px #ccc solid;"></div>
			<!-- for Payroll Detail -->
			<table border="1" style="width: 100%">
			<thead>
				<tr>
					<th width="15%">PARTICULARS</th>
					<th width="10%" style="text-align: center;">AMOUNT(Rs)</th>
					<th width="15%">PARTICULARS</th>
					<th width="10%" style="text-align: center;">AMOUNT(Rs)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				<th colspan="2" style="text-align: center;">EARNING</th>
				<th colspan="2" style="text-align: center;">DEDUCTION</th>
				</tr>
			<!-- Row 1 -->
				<tr>
					<td>BASIC SALARY</td>
					<td class="numTd"><%= pp.getBasicSal()%></td>
					<td>SALARY ADVANCE</td>
					<td class="numTd"><%= pp.getSalaryAdvance()%></td>
				</tr>
				<!-- Row 2 -->
				<tr>
					<td>H R ALLOWANCES</td>
					<td class="numTd"><%= pp.getHrAllowance()%></td>
					<td>PF DEDUCTIONS</td>
					<td class="numTd"><%= pp.getPfDeduction()%></td>
				</tr>
				<!-- Row 3 -->
				<tr>
					<td>Transport Allowance</td>
					<td class="numTd"><%= pp.getTransportAllowance()%></td>
					<td>TDS DEDUCTIONS</td>
					<td class="numTd"><%= pp.getTdsDeduction()%></td>
				</tr>
				<!-- Row 4 -->
				<tr>
					<td>Leave Travel Allowance</td>
					<td class="numTd"><%= pp.getLeaveTravelAllowance()%></td>
					<td>FOOD DEDUCTION</td>
					<td class="numTd"><%= pp.getFoodDeduction()%></td>
				</tr>
				<!-- Row 5 -->
				<tr>
					<td>SPECIAL ALLOWANCES</td>
					<td class="numTd"><%= pp.getSpecialAllowance()%></td>
					<td>RENT DEDUCTION </td>
					<td class="numTd"><%= pp.getRentDeduction()%></td>
				</tr>
				
				<!-- Row 6 -->
				<tr>
					<td style="text-align: center;"> - </td>
					<td style="text-align: center;"> - </td>
					<td>OTHER DEDUCTIONS </td>
					<td class="numTd"><%= pp.getOtherDeduction()%></td>
				</tr>
				<!-- Row 7 -->
				<tr>
					<th>Total Earning(A)</th>
					<th class="numTd"><%= pp.getTotelEarning()%></th>
					<th>Total Deduction(B)</th>
					<th class="numTd"><%= pp.getTotelDeduction()%></th>
				</tr>
				<!-- Row 8 -->
				<tr>
					<th>Net Pay(A-B)</th>
					<th colspan="3" style="text-align: left;"><%= pp.getNetPay()%></th>
				</tr>
				<tr>
					<th>Figure in Words :</th>
					<th colspan="3">Rupees  <%=NumberFormat.convert((int)pp.getNetPay()) %>&nbsp;only</th>
				</tr>
				<tr style="height: 50px;">
					<td colspan="4" align="center" valign="baseline">
					This is Computer generated report sign not required
					</td>
				</tr>
			</tbody>
		</table>
		<div class="clearfix visible-sm"></div>
		<DIV style="page-break-after:always"></DIV>
		<%
		}
		%>
		</div>
		<%
		}
	}
	else if(status != null)
	{
		if(status.equalsIgnoreCase("error_F"))
		{
			%>
			<div style="height: 25px; border : 1px #ccc solid;">
				<p id="msg" style="color: red;">Date format error occured.</p>
			</div>
			<%
		}
		else
		{
			%>
			<div style="height: 25px; border : 1px #ccc solid;">
				<p id="msg" style="color: red;">No data in the data source.</p>
			</div>
			<%
		}
	}
	%>
</div>
