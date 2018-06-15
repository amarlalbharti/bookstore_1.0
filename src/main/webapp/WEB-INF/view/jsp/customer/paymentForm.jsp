<%@page import="com.bookstore.util.Util"%>
<%@page import="com.bookstore.util.ProductOrderUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <meta charset="utf-8">
  <meta class="viewport" name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>
<body>
	<h1>PayUForm </h1>
        <form action="${pageContext.request.contextPath}/payment/form/submit"  name="payuform" method=POST >
            <input type="hidden" name="key"value="h3yf0nYk" />
            <input type="hidden" name="hash_string" value="" />
            <input type="hidden" name="hash" />

            <input type="hidden" name="txnid" value="1527673473468"/>

            <table>
                <tr>
                    <td><b>Mandatory Parameters</b></td>
                </tr>
                <tr>
                    <td>Amount: </td>
                    <td><input name="amount"  /></td>
                    <td>First Name: </td>
                    <td><input name="firstname" id="firstname"  /></td>
                </tr>
                <tr>
                    <td>Email: </td>
                    <td><input name="email" id="email" value="amarlalbharti@gmail.com"  /></td>
                    <td>Phone: </td>
                    <td><input name="phone" value="9198530154" /></td>
                </tr>
                <tr>
                    <td>Product Info: </td>
                    <td colspan="3"><textarea name="productinfo" ></textarea></td>
                </tr>
                <tr>
                    <td>Success URI: </td>
                    <td colspan="3"><input name="surl"  size="64" value="<%= Util.projectURL+"payment/success" %>" /></td>
                </tr>
                <tr>
                    <td>Failure URI: </td>
                    <td colspan="3"><input name="furl"  size="64" value="<%= Util.projectURL+"payment/failure" %>" /></td>
                </tr>

                <tr>
                    <td colspan="3"><input type="hidden" name="service_provider" value="payu_paisa" /></td>
                </tr>
                <tr>
                    <td><b>Optional Parameters</b></td>
                </tr>
                <tr>
                    <td>Last Name: </td>
                    <td><input name="lastname" id="lastname"  /></td>
                    <td>Cancel URI: </td>
                    <td><input name="curl" value="" /></td>
                </tr>
                <tr>
                    <td>Address1: </td>
                    <td><input name="address1" /></td>
                    <td>Address2: </td>
                    <td><input name="address2"  /></td>
                </tr>
                <tr>
                    <td>City: </td>
                    <td><input name="city"  /></td>
                    <td>State: </td>
                    <td><input name="state"  /></td>
                </tr>
                <tr>
                    <td>Country: </td>
                    <td><input name="country"  /></td>
                    <td>Zipcode: </td>
                    <td><input name="zipcode"  /></td>
                </tr>
                
                <td colspan="4"><input type="submit" value="Submit"  /></td>


                </tr>
            </table>
        </form>
	
</body>
</html>