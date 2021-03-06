<%@page import="com.bookstore.domain.Registration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles-extras" prefix="tilesx"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
</head>
<body>
  <aside class="main-sidebar">
  <tilesx:useAttribute name="currentpage"/>
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="${pageContext.request.contextPath}/images/User_Avatar.png" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>Amar</p>
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>
      
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">MAIN NAVIGATION</li>
        <li class="${currentpage == 'dashboard' ? 'active' : ''}">
          <a href="dashboard">
            <i class="fa fa-dashboard"></i> <span>Dashboard</span>
          </a>
        </li>
        <li class="${currentpage == 'category' || currentpage == 'products' || currentpage == 'attribute' ? 'active' : ''} treeview">
          <a href="#">
            <i class="fa fa-book"></i>
            <span>CataLog</span>
          </a>
          <ul class="treeview-menu">
            <li class="${currentpage == 'category' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/category"><i class="fa fa-circle-o"></i> Categories</a></li>
            <li class="${currentpage == 'products' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/products"><i class="fa fa-circle-o"></i> Products</a></li>
            <li class="${currentpage == 'attribute' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/attributes"><i class="fa fa-circle-o"></i> Attributes</a></li>
          </ul>
        </li>
        <li class="${currentpage == 'sales' ? 'active' : ''} treeview">
          <a href="#">
            <i class="fa fa-book"></i>
            <span><spring:message code="label.admin.leftmenu.sales" /></span>
          </a>
          <ul class="treeview-menu">
            <li class="${currentpage == 'sales' ? 'active' : ''}">
            	<a href="${pageContext.request.contextPath}/admin/sales/orders">
            		<i class="fa fa-circle-o"></i> <spring:message code="label.admin.leftmenu.orders" />
            	</a>
           	</li>
          </ul>
        </li>
        
        <li class="${currentpage == 'customer' ? 'active' : ''} treeview">
          <a href="#">
            <i class="fa fa-user"></i>
            <span><spring:message code="label.admin.leftmenu.customers" /></span>
          </a>
          <ul class="treeview-menu">
            <li class="${currentpage == 'customer' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/customers"><i class="fa fa-circle-o"></i> <spring:message code="label.admin.leftmenu.customers" /></a></li>
            <li class="${currentpage == 'customer' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/admin/customers/online"><i class="fa fa-circle-o"></i> <spring:message code="label.admin.leftmenu.online.customers" /></a></li>
          </ul>
        </li> 
        
        <li class="treeview">
          <a href="#">
            <i class="fa fa-files-o"></i>
            <span>Layout Options</span>
            <span class="label label-primary pull-right">4</span>
          </a>
          <ul class="treeview-menu">
            <li><a href="pages/layout/top-nav.html"><i class="fa fa-circle-o"></i> Top Navigation</a></li>
            <li><a href="pages/layout/boxed.html"><i class="fa fa-circle-o"></i> Boxed</a></li>
            <li><a href="pages/layout/fixed.html"><i class="fa fa-circle-o"></i> Fixed</a></li>
            <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle-o"></i> Collapsed Sidebar</a></li>
          </ul>
        </li>
        
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
  </body>
</html>