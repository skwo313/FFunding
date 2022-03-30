<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
	
	<!-- Sidebar -->
	<ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar">
	
	    <!-- Sidebar - Brand -->
	    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/ffunding/manager/dashboard">
	        <div class="sidebar-brand-icon">
	           <img src="${pageContext.request.contextPath}/img/logo1.png" alt="로고오류"/>
	        </div>
	        <div class="sidebar-brand-text">
	           <img src="${pageContext.request.contextPath}/img/logo2.png" alt="로고오류"/>
	        </div>
	    </a>
	
	    <!-- Divider -->
	    <hr class="sidebar-divider my-0">
	
	    <!-- Nav Item - Dashboard -->
	    <li class="nav-item ${active eq 'dashboard'?'active':''}">
	        <a class="nav-link" href="/ffunding/manager/dashboard">
	            <i class="fas fa-fw fa-tachometer-alt"></i>
	            <span>Dashboard</span>
	        </a>
	    </li>
	
	    <!-- Divider -->
	    <hr class="sidebar-divider">
	
	    <!-- Heading -->
	    <div class="sidebar-heading">
	        Interface
	    </div>
	
	    <!-- Nav Item - Pages Collapse Menu -->
	    <li class="nav-item ${active eq 'member'?'active':''}">
	        <a class="nav-link" href="/ffunding/manager/member" >
	            <i class="fas fa-user"></i>
	            <span>Member</span>
	        </a>
	    </li>
	
	    <!-- Nav Item - Utilities Collapse Menu -->
	    <li class="nav-item ${active eq 'fundingApproval'?'active':''}">
	        <a class="nav-link" href="/ffunding/manager/fundingApproval">
	          <i class="bi bi-chat-left-dots-fill"></i>
	            <span>Funding Approval</span>
	        </a>
	    </li>
	    
	    <!-- Nav Item - Utilities Collapse Menu -->
	    <li class="nav-item ${active eq 'purchaseApproval'?'active':''}">
	        <a class="nav-link" href="/ffunding/manager/purchaseApproval">
	            <i class="bi bi-clipboard2-check-fill"></i>
	            <span>Purchase Approval</span>
	        </a>
	    </li>
	    
	    <!-- Nav Item - Utilities Collapse Menu -->
	    <li class="nav-item ${active eq 'mail'?'active':''}">
	        <a class="nav-link" href="/ffunding/manager/mail">
	            <i class="bi bi-envelope-fill"></i>
	            <span>Mail</span>
	        </a>
	    </li>
	
		<!-- Nav Item - Utilities Collapse Menu -->
	    <li class="nav-item ${active eq 'calendar'?'active':''}">
	        <a class="nav-link" href="/ffunding/manager/calendar">
	            <i class="bi bi-calendar2-week-fill"></i>
	            <span>Calendar</span>
	        </a>
	    </li>
	
	    <!-- Divider -->
	    <hr class="sidebar-divider d-none d-md-block">
	
	    <!-- Sidebar Toggler (Sidebar) -->
	    <div class="text-center d-none d-md-inline">
	        <button class="rounded-circle border-0" id="sidebarToggle"></button>
	    </div>
	</ul>
	<!-- End of Sidebar -->