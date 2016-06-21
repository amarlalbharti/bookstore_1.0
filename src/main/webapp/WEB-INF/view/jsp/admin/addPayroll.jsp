  <%@page import="com.ems.config.DateFormats"%>
<%@page import="com.ems.domain.Payroll"%>
<script src="js/common_js.js"></script>.
  <script src="js/jQuery-2.2.0.min.js"></script>
<div class="box-header with-border">
	<h3 class="box-title">Add Payroll</h3>
 	<div class="box-tools pull-right">
    	<div class="pull-right " style="padding-left: 20px;">
<!--    	<button class="btn btn-primary btn-sm adPay"><i class="fa fa-fw fa-user-plus"></i> Add Payroll</button> -->
        </div>
    </div>
	</div>
	<div class="box-body no-padding">
		<%
		Payroll payroll = (Payroll)request.getAttribute("payroll");
		if(payroll != null)
		{
			%>
				<div class="box-body">
				<div class="form-group col-xs-12 col-md-12">
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Employee Id</label>
		            <input class="form-control" type="text" name="eId" id="eId" value="<%= payroll.getRegistration().getUserid()%>" placeholder="Enter Employee Id" tabindex="1" readonly="readonly" maxlength="50"/>
		            <input type="hidden" name="pId" id="pId" value="<%= payroll.getPid()%>"/>
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Employee Name</label>
		            <input autocomplete="off" name="name" id="name" type="text" value="<%= payroll.getRegistration().getName()%>" class="form-control" tabindex="5" readonly="readonly" maxlength="50" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Designation</label>
		            <input autocomplete="off" name="designation" id="designation" type="text" value="<%= payroll.getRegistration().getDesignation().getDesignation()%>" class="form-control" tabindex="10" readonly="readonly" maxlength="50" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Basic Salary</label>
		            <input autocomplete="off" name="bSal" id="bSal" type="text" value="<%= payroll.getBasicSal()%>" class="form-control" placeholder="Enter Basic Salary" readonly="readonly" tabindex="15"  maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >H R Allowances</label>
		            <input autocomplete="off" name="hrAlwnc" id="hrAlwnc" onkeypress="return isFloat(event)" type="text" value="<%= payroll.getHrAllowance()%>" class="form-control number_only" placeholder="Enter H R Allowance" tabindex="25"  maxlength="10" />
		            </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Transport Allowance</label>
		            <input autocomplete="off" name="trnspAlwnc" id="trnspAlwnc" type="text" value="<%= payroll.getTransportAllowance()%>" class="form-control number_only" placeholder="Enter Transport Allowance" tabindex="30"  maxlength="10" />
					</div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Leave Travel Allowances</label>
		            <input autocomplete="off" name="lveTrvlAlwnc" id="lveTrvlAlwnc" type="text" value="<%= payroll.getLeaveTravelAllowance()%>" class="form-control number_only" placeholder="Enter Leave Travel Allowance" tabindex="35" maxlength="10" />
					</div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Special Allowance</label>
		            <input autocomplete="off" name="splAlwnc" id="splAlwnc" type="text" value="<%= payroll.getSpecialAllowance()%>" class="form-control number_only" placeholder="Enter Special Allowance" tabindex="40" maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label>Salary Advance</label>
		            <input autocomplete="off" name="salAdv" id="salAdv" type="text" value="<%= payroll.getSalaryAdvance()%>" class="form-control number_only" placeholder="Enter Advance Salary" tabindex="45" maxlength="10" />
					</div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >PF Deduction</label>
		            <input autocomplete="off" name="pf" id="pf" type="text" value="<%= payroll.getPfDeduction()%>" class="form-control number_only" placeholder="Enter PF Deductions" tabindex="50" maxlength="10" />
					</div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >TDS Deduction</label>
		            <input autocomplete="off" name="tds" id="tds" type="text" value="<%= payroll.getTdsDeduction()%>" class="form-control number_only" placeholder="Enter TDS Deductions" tabindex="55" maxlength="10" />
		            </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Food Deduction</label>
		            <input autocomplete="off" name="food" id="food" type="text" value="<%= payroll.getFoodDeduction()%>" class="form-control number_only" placeholder="Enter TDS Deductions" tabindex="60" maxlength="10" />
		            </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Rent Deduction</label>
		            <input autocomplete="off" name="rent" id="rent" type="text" value="<%= payroll.getRentDeduction()%>" class="form-control number_only" placeholder="Enter TDS Deductions" tabindex="65" maxlength="10" />
					</div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Other Deductions</label>
		            <input autocomplete="off" name="otDed" id="otDed" type="text" value="<%= payroll.getOtherDeduction()%>" class="form-control number_only" placeholder="Enter Other Deductions" tabindex="70" maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Total Earning</label>
		            <input autocomplete="off" name="tlEr" id="tlEr" type="text" value="<%= payroll.getTotelEarning()%>" class="form-control" maxlength="20" readonly="readonly" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Total Deductions</label>
		            <input autocomplete="off" name="tlDd" id="tlDd" type="text" value="<%= payroll.getTotelDeduction()%>" class="form-control" maxlength="20" readonly="readonly" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Net Pay</label>
		            <input autocomplete="off" name="ntPay" id="ntPay" type="text" value="<%= payroll.getNetPay()%>" class="form-control" maxlength="20" readonly="readonly" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Payslip Month</label>
		            <input autocomplete="off" name="payMonth" id="payMonth" type="text" value="<%= DateFormats.monthformat().format(payroll.getPayMonth()) %>" class="form-control" maxlength="20" placeholder="Month : mm-yyyy" readonly="readonly" />
		          </div>
		          </div>
		        </div>
			<%
		}
		else
		{
			%>
				<div class="box-body">
				<p id="msg" style="color: red; display :none"></p>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Employee Id</label>
		            <input class="form-control" type="text" name="eId" id="eId" placeholder="Enter Employee Id" tabindex="1" maxlength="50"/>
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Employee Name</label>
		            <input autocomplete="off" name="name" id="name" type="text" class="form-control" tabindex="5" readonly="readonly" maxlength="50" />
		          </div>
		          <div class="clearfix"></div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Designation</label>
		            <input autocomplete="off" name="designation" id="designation" type="text" class="form-control" tabindex="10" readonly="readonly" maxlength="50" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Basic Salary</label>
		            <input autocomplete="off" name="bSal" id="bSal" type="text" class="form-control" placeholder="Enter Basic Salary" readonly="readonly" tabindex="15"  maxlength="10" />
		          </div>
		          <div class="clearfix"></div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >H R Allowances</label>
		            <input autocomplete="off" name="hrAlwnc" id="hrAlwnc" type="text" class="form-control number_only" placeholder="Enter H R Allowance" tabindex="25"  maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Transport Allowance</label>
		            <input autocomplete="off" name="trnspAlwnc" id="trnspAlwnc" type="text" class="form-control number_only" placeholder="Enter Transport Allowance" tabindex="30"  maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Leave Travel Allowances</label>
		            <input autocomplete="off" name="lveTrvlAlwnc" id="lveTrvlAlwnc" type="text" class="form-control number_only" placeholder="Enter Leave Travel Allowance" tabindex="35" maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Special Allowance</label>
		            <input autocomplete="off" name="splAlwnc" id="splAlwnc" type="text" class="form-control number_only" placeholder="Enter Special Allowance" tabindex="40" maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label>Salary Advance</label>
		            <input autocomplete="off" name="salAdv" id="salAdv" type="text" class="form-control number_only" placeholder="Enter Advance Salary" tabindex="45" maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >PF Deductions</label>
		            <input autocomplete="off" name="pf" id="pf" type="text" class="form-control number_only" placeholder="Enter PF Deductions" tabindex="50" maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >TDS Deductions</label>
		            <input autocomplete="off" name="tds" id="tds" type="text" class="form-control number_only" placeholder="Enter TDS Deductions" tabindex="55" maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Food Deduction</label>
		            <input autocomplete="off" name="food" id="food" type="text" class="form-control number_only" placeholder="Enter Food Deductions" tabindex="60" maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Rent Deduction</label>
		            <input autocomplete="off" name="rent" id="rent" type="text" class="form-control number_only" placeholder="Enter Rent Deductions" tabindex="65" maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Other Deductions</label>
		            <input autocomplete="off" name="otDed" id="otDed" type="text" class="form-control number_only" placeholder="Enter Other Deductions" tabindex="70" maxlength="10" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Total Earning</label>
		            <input autocomplete="off" name="tlEr" id="tlEr" type="text" class="form-control" maxlength="20" readonly="readonly" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Total Deductions</label>
		            <input autocomplete="off" name="tlDd" id="tlDd" type="text" class="form-control" maxlength="20" readonly="readonly" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Net Pay</label>
		            <input autocomplete="off" name="ntPay" id="ntPay" type="text" class="form-control" maxlength="20" readonly="readonly" />
		          </div>
		          <div class="form-group col-xs-12 col-md-6">
		            <label >Payslip Month</label>
		            <input autocomplete="off" name="payMonth" id="payMonth" type="text" class="form-control" maxlength="20" tabindex="75" placeholder="Month : mm-yyyy" title="Enter month in 'mm-yyyy' format" />
		          </div>
		        </div>
			<%
		}
		%>
        
        <!-- /.box-body -->
        <div class="box-footer col-xs-12 col-md-6">
        	<div class="form-group col-xs-12 col-md-6">
          		<button onclick="return validateForm();" class="btn btn-primary submit_btn" tabindex="80">Submit</button>
          	</div>
        </div>
        
	</div>
	<script type="text/javascript">
	$(document.body).on("change", ".number_only" ,function () {

		var bSal, hrAlwnc, trnspAlwnc, lveTrvlAlwnc, splAlwnc, salAdv, pf, tds, otDed,food,rent;
		bSal = hrAlwnc = trnspAlwnc = lveTrvlAlwnc = splAlwnc = salAdv = pf = tds = otDed = food = rent = 0.0;
		
		if($("#bSal").val() != "")
		{
			bSal =parseFloat( $("#bSal").val());
		}
		if($("#hrAlwnc").val() != "")
		{
			hrAlwnc = parseFloat($("#hrAlwnc").val());
		}
		if($("#trnspAlwnc").val() != "")
		{
			trnspAlwnc = parseFloat($("#trnspAlwnc").val());
		}
		if($("#lveTrvlAlwnc").val() != "")
		{
			lveTrvlAlwnc = parseFloat($("#lveTrvlAlwnc").val());
		}
		if($("#splAlwnc").val() != "")
		{
			splAlwnc = parseFloat($("#splAlwnc").val());
		}
		
		if($("#salAdv").val() != "")
		{
			salAdv = parseFloat($("#salAdv").val());
		}
		
		if($("#pf").val() != "")
		{
			pf = parseFloat($("#pf").val());
		}
		
		if($("#tds").val() != "")
		{
			tds = parseFloat($("#tds").val());
		}
		
		if($("#otDed").val() != "")
		{
			otDed = parseFloat($("#otDed").val());
		}
		
		if($("#food").val() != "")
		{
			food = parseFloat($("#food").val());
		}
		
		if($("#rent").val() != "")
		{
			rent = parseFloat($("#rent").val());
		}
		
		var tlEr = bSal+hrAlwnc+trnspAlwnc+lveTrvlAlwnc+splAlwnc;
		var tlDd = salAdv+pf+tds+otDed+food+rent;
		var ntPay = tlEr -tlDd;
		
		$("#tlEr").val(tlEr);
		$("#tlDd").val(tlDd);
		$("#ntPay").val(ntPay);
// 		alert(tlEr -tlDd);
	 });
	</script>
