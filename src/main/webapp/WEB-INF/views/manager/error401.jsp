<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Error</title>

    <!-- Custom fonts for this template-->
    <link href="${path}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${path}/css/manager/sb-admin-2.min.css" rel="stylesheet">
	<link href="${path}/css/manager/error.css" rel="stylesheet">   
	<link rel="icon" href="${path}/img/favicon.ico" type="image/x-icon" sizes="16x16">

</head>
<body>
	 <!-- 401 Error Text -->
	 <div class="text-center">
	 	<div class="container-fluid">
		    <div class="error mx-auto" data-text="401">401</div>
		    <p class="lead text-gray-800 mb-5">Only administrators can access it.</p>
		    <p class="text-gray-500 mb-0">Please try again with administrative privileges.</p>
		    <a href="/ffunding/">&larr; Back to Home</a>
	 	</div>
	 </div>
</body>
</html>