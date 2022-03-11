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

section {
	display: flex;
	flex-direction: column;
}
</style>
<title>FFunding</title>
<div class="slider">
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner01.jpg">
		<div class="imgText">
			<p class="imgDes">머리빠짐을 절반으로</p>
			<p class="imgDes">심플리오 비오틴 탈모앰플</p>
		</div>
	</div>
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner02.png">
		<div class="imgText">
			<p class="imgDes">너도 이제 인싸!!</p>
			<p class="imgDes">버킷햇!</p>
		</div>

	</div>
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner03.png">
		<div class="imgText">
			<p class="imgDes">남산에서 한라산까지</p>
			<p class="imgDes">등산스텝 레벨업!</p>
		</div>
	</div>
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner04.jpg">
		<div class="imgText">
			<p class="imgDes">HAYAN 친환경 칫솔로</p>
			<p class="imgDes">미세플라스틱 없는 양치해요</p>
		</div>
	</div>
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner05.jpg">
		<div class="imgText">
			<p class="imgDes">오늘 알림 신청하면</p>
			<p class="imgDes">콜라겐 아이크림 전용 쿠폰</p>
		</div>
	</div>
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/banner06.png">
		<div class="imgText">
			<p class="imgDes">먼저 사용해 보세요</p>
			<p class="imgDes">무료 체험단 이벤트</p>
		</div>
	</div>
</div>
<section>
	<div class="container" style="border-bottom: 1px solid #f0f2f5; padding: 15px 0px;">
		<div>
			<h3>
				<strong>펀딩 실시간 리워드</strong>
			</h3>
		</div>
		<div class="row">
			<div class="col">
				<div class="thumbnail">
					<img alt="" style="width: 100%" class="radius" src="${pageContext.request.contextPath}/img/sample.png">
					<div class="caption">
						<div class="fundingName">이름</div>
						<div class="fundingAchieve">퍼센트</div>
						<div class="fundingCate">카테고리</div>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="thumbnail">
					<img alt="" style="width: 100%" src="${pageContext.request.contextPath}/img/sample.png">
					<div class="caption">
						<div class="fundingName">이름</div>
						<div class="fundingAchieve">퍼센트</div>
						<div class="fundingCate">카테고리</div>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="thumbnail">
					<img alt="" style="width: 100%" src="${pageContext.request.contextPath}/img/sample.png">
					<div class="caption">
						<div class="fundingName">이름</div>
						<div class="fundingAchieve">퍼센트</div>
						<div class="fundingCate">카테고리</div>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="thumbnail">
					<img alt="" style="width: 100%" src="${pageContext.request.contextPath}/img/sample.png">
					<div class="caption">
						<div class="fundingName">이름</div>
						<div class="fundingAchieve">퍼센트</div>
						<div class="fundingCate">카테고리</div>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="thumbnail">
					<img alt="" style="width: 100%" src="${pageContext.request.contextPath}/img/sample.png">
					<div class="caption">
						<div class="fundingName">이름</div>
						<div class="fundingAchieve">퍼센트</div>
						<div class="fundingCate">카테고리</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container" style="border-bottom: 1px solid #f0f2f5; padding: 15px 0px;">
		<div>
			<h3>
				<strong>펀딩 예정</strong>
			</h3>
		</div>
		<div class="row">
			<div class="col">
				<div class="card border mb-3">
					<img alt="" style="width: 100%; padding: 2px;" src="${pageContext.request.contextPath}/img/sample.png">
					<div class="caption">
						<div class="fundingName">이름</div>
						<div class="fundingAchieve">퍼센트</div>
						<div class="fundingCate">카테고리</div>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card border mb-3">
					<img alt="" style="width: 100%; padding: 2px;" src="${pageContext.request.contextPath}/img/sample.png">
					<div class="caption">
						<div class="fundingName">이름</div>
						<div class="fundingAchieve">퍼센트</div>
						<div class="fundingCate">카테고리</div>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card border mb-3">
					<img alt="" style="width: 100%; padding: 2px;" src="${pageContext.request.contextPath}/img/sample.png">
					<div class="caption">
						<div class="fundingName">이름</div>
						<div class="fundingAchieve">퍼센트</div>
						<div class="fundingCate">카테고리</div>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card border mb-3">
					<img alt="" style="width: 100%; padding: 2px;" src="${pageContext.request.contextPath}/img/sample.png">
					<div class="caption">
						<div class="fundingName">이름</div>
						<div class="fundingAchieve">퍼센트</div>
						<div class="fundingCate">카테고리</div>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card border mb-3">
					<img alt="" style="width: 100%; padding: 2px;" src="${pageContext.request.contextPath}/img/sample.png">
					<div class="caption">
						<div class="fundingName">이름</div>
						<div class="fundingAchieve">퍼센트</div>
						<div class="fundingCate">카테고리</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>