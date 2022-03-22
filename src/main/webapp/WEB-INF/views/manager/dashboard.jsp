<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/>     
	
	<!-- Begin Page Content -->
	<div class="container-fluid">
	
	    <!-- Page Heading -->
	
	    <!-- Content Row -->
	    <div class="row">
	
	        <!-- Earnings (Monthly) Card Example -->
	        <div class="col-xl-3 col-md-6 mb-4">
	            <div class="card border-left-primary shadow h-100 py-2">
	                <div class="card-body">
	                    <div class="row no-gutters align-items-center">
	                        <div class="col mr-2">
	                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
	                                Member Total</div>
	                            <div class="h5 mb-0 font-weight-bold text-gray-800">${userTot}명</div>
	                        </div>
	                        <div class="col-auto">
	                            <i class="bi bi-people-fill fa-2x text-gray-300"></i>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	
	        <!-- Earnings (Monthly) Card Example -->
	        <div class="col-xl-3 col-md-6 mb-4">
	            <div class="card border-left-success shadow h-100 py-2">
	                <div class="card-body">
	                    <div class="row no-gutters align-items-center">
	                        <div class="col mr-2">
	                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
	                                Stand By</div>
	                            <div class="h5 mb-0 font-weight-bold text-gray-800">12개</div>
	                        </div>
	                        <div class="col-auto">
	                            <i class="bi bi-patch-question-fill fa-2x text-gray-300"></i>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	
	        <!-- Earnings (Monthly) Card Example -->
	        <div class="col-xl-3 col-md-6 mb-4">
	            <div class="card border-left-info shadow h-100 py-2">
	                <div class="card-body">
	                    <div class="row no-gutters align-items-center">
	                        <div class="col mr-2">
	                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
	                           		Prearranged</div>
	                            <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">21개</div>
	                        </div>
	                        <div class="col-auto">
	                            <i class="bi bi-patch-exclamation-fill fa-2x text-gray-300"></i>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	
	        <!-- Pending Requests Card Example -->
	        <div class="col-xl-3 col-md-6 mb-4">
	            <div class="card border-left-warning shadow h-100 py-2">
	                <div class="card-body">
	                    <div class="row no-gutters align-items-center">
	                        <div class="col mr-2">
	                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
	                                Progress</div>
	                            <div class="h5 mb-0 font-weight-bold text-gray-800">52개</div>
	                        </div>
	                        <div class="col-auto">
	                            <i class="bi bi-patch-check-fill fa-2x text-gray-300"></i>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	
	    <!-- Content Row -->
	
	    <div class="row">
	
	        <!-- Area Chart -->
	        <div class="col-xl-6 col-lg-4">
	            <div class="card shadow mb-4">
	                <!-- Card Header - Dropdown -->
	                <div
	                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                    <h6 class="m-0 font-weight-bold text-primary">Funding Approval Count</h6>
	                </div>
	                <!-- Card Body -->
	                <div class="card-body">
	                    <div class="chart-area">
	                        <canvas id="myAreaChart"></canvas>
	                    </div>
	                </div>
	            </div>
	        </div>
	        
	        <!-- Area Chart -->
	        <div class="col-xl-6 col-lg-4">
	            <div class="card shadow mb-4">
	                <!-- Card Header - Dropdown -->
	                <div
	                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                    <h6 class="m-0 font-weight-bold text-primary">Visitor</h6>
	                </div>
	                <!-- Card Body -->
	                <div class="card-body">
	                    <div class="chart-area">
	                        <canvas id="myAreaChart2"></canvas>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	      
	       
	    <div class="row">
	    	<!-- Bar Chart -->
	    	<div class="col-xl-6 col-lg-4">
	            <div class="card shadow mb-4">
	                <div class="card-header py-3">
	                    <h6 class="m-0 font-weight-bold text-primary">Member</h6>
	                </div>
	                <div class="card-body">
	                    <div class="chart-bar">
	                        <canvas id="myBarChart"></canvas>
	                    </div>
	                </div>
	            </div>
	        </div>
	    
	        <!-- Pie Chart -->
	        <div class="col-xl-4 col-lg-5">
	            <div class="card shadow mb-4">
	                <!-- Card Header - Dropdown -->
	                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                    <h6 class="m-0 font-weight-bold text-primary">Revenue Sources</h6>
	                    <div class="dropdown no-arrow">
	                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
	                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
	                        </a>
	                    </div>
	                </div>
	                <!-- Card Body -->
	                <div class="card-body">
	                    <div class="chart-pie pt-4 pb-2">
	                        <canvas id="myPieChart"></canvas>
	                    </div>
	                    <div class="mt-4 text-center small">
	                        <span class="mr-2">
	                            <i class="fas fa-circle text-primary"></i> Direct
	                        </span>
	                        <span class="mr-2">
	                            <i class="fas fa-circle text-success"></i> Social
	                        </span>
	                        <span class="mr-2">
	                            <i class="fas fa-circle text-info"></i> Referral
	                        </span>
	                    </div>
	                </div>
	            </div>
	        </div>
		</div>
	<!-- /.container-fluid -->
 	</div>

    <!-- Page level plugins -->
    <script src="${path}/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="${path}/js/demo/chart-area-demo.js"></script>
    <script src="${path}/js/demo/chart-area-demo2.js"></script>
    <script src="${path}/js/demo/chart-bar-demo.js"></script>
    <script src="${path}/js/demo/chart-pie-demo.js"></script>