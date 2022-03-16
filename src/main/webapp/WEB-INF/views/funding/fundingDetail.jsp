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
	width: 90%;
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

.title {
	font-size: 36px;
	font-weight: 700;
	font-family: 'Noto Sans KR', sans-serif !important;
	font-weight: 700;
	letter-spacing: -1px;
	line-height: 50px;
}
</style>
<title>FFunding-펀딩하기</title>
<div class="container">
	<div class="row">
		
		<div class="col-sm-8" style="margin: 15px 0px;">
			<div class="title">상의 의류전용 프리미엄 옷걸리 클로랑스</div>
		</div>
		<div class="col-sm-8">
			<div class="row">
				<div class="col" style="text-align: center;">
					<img class="divImg" alt="" src="${pageContext.request.contextPath}/img/fundingsample.jpg">
				</div>
			</div>
		</div>
		<div class="col">
			<div class="col-sm-4">
				<div class="info-box">
					<div class="progress-bar w-75" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
					<p>15 일 남음</p>
					<p>1819 % 달성</p>
					<p>17,984,000 원 펀딩</p>
					<p>646 명의 서포터</p>
				</div>
			</div>
		</div>
	</div>
</div>