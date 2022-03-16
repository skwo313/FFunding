<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script>
	$(document).ready(function() {
		$('.slider').bxSlider({
			auto : true,
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
	margin-bottom: 20px;
}

.imgDes {
	width: 460px;
	line-height: 40px;
	font-size: 32px;
	font-weight: 700;
	word-break: break-all;
	letter-spacing: -.7px;
	color: #fff;
}

img {
	object-fit: cover;
}

.fundingWrap {
	margin-bottom: 16px;
	height: 100px;
}

.divImg {
	width: 100%;
	height: 100%;
	border-radius: 5px;
}

.title {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}

.percent {
	margin-right: 6px;
	color: #00a2a2;
	font-weight: 700;
}

.cate {
	color: #90949c;
	font-weight: 400;
}

.progress-bar {
	background-color: #00a2a2;
}

.headImage {
	background-image:
		url("${pageContext.request.contextPath}/img/sample2.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
	width: 100%;
	height: 200px;
	filter: blur(15px);
	z-index: 1;
}

.headImage::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: inherit;
	z-index: -1;
	filter: blur(6px);
	-webkit-filter: blur(6px);
	-moz-filter: blur(6px);
	-o-filter: blur(6px);
	filter: url(#blur);
}
</style>
<title>FFunding-펀딩하기</title>
<div class="container-fluid headImage">
	<div class="row">
		<div class="col">1</div>
		<span>dds</span>
	</div>
	<div class="row">
		<div class="col">2</div>
	</div>
</div>