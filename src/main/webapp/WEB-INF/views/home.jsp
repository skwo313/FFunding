<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script>
	$(document).ready(function() {
		$('.slider').bxSlider({
			auto : false,
			pager : false
		});
	});
</script>
<style>
.bx-wrapper {
	-moz-box-shadow: none;
	-webkit-box-shadow: none;
	box-shadow: none;
	border: 0;
}
.imgText {
	display: block;
	position: absolute;
	bottom: 0;
	left: 50%;
	transform: translate(-50%);
	width: 100%;
	max-width: 1440px;
	box-sizing: border-box !important;
}
.imgDes{
	width: 460px;
    line-height: 40px;
    font-size: 32px;
    font-weight: 700;
    word-break: break-all;
    letter-spacing: -.7px;
    color: #fff;
}
</style>
<title>FFunding</title>
<div class="slider">
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner1.png">
		<div class="imgText">
			<p class="imgDes"></p>
		</div>
		
	</div>
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner2.png">
	</div>
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner3.png">
	</div>
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner4.png">
	</div>
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner5.png">
	</div>
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner6.png">
	</div>
</div>
<div>hello</div>