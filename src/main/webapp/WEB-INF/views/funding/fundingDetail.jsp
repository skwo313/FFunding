<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	
</script>
<style>
img {
	object-fit: cover;
}

.divImg {
	width: 90%;
	height: 100%;
	border-radius: 5px;
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
	margin-top: 40px;
}

.d-day {
	font-size: 30px;
	font-weight: 600;
}

.fundimg-des {
	font-size: 18px;
	font-weight: 600;
	padding: 20px 20px;
}

.info-text {
	margin-bottom: 40px;
}

.info-des {
	font-size: 14px;
	letter-spacing: -.3px;
	min-width: 70px;
	line-height: 30px;
	display: inline-block;
	color: #969696;
}

.butn {
	background-color: #00a2a2;
	color: white;
	font-size: 20px;
	font-weight: 600;
}

strong {
	padding-right: 5px;
	font-size: 24px;
}

.cale {
	text-align: center;
}

.date {
	font-size: 14px;
	font-weight: 700;
	color: #002fa3;
}
</style>
<title>FFunding - 펀딩하기</title>
<div class="container">
	<div class="row" style="border-bottom: solid 1.5px #dcdcdc;">
		<div class="col-sm-8" style="margin: 15px 0px;">
			<div class="title">상의 의류전용 프리미엄 옷걸리 클로랑스</div>
		</div>
		<div class="col-sm-8">
			<div class="row">
				<div class="col" style="text-align: center;">
					<img class="divImg" alt="" src="${pageContext.request.contextPath}/img/fundingsample.jpg">
				</div>
			</div>
			<div class="row fundimg-des">제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명 제품 설명</div>
		</div>
		<div class="col" style="border-left: solid 1px #dcdcdc;">
			<div class="col">
				<div class="info-box">
					<div class="info-text">
						<span class="info-des">남은기간</span> <span class="d-day"> 15일 남음 </span>
					</div>
					<div class="progress info-text" style="height: 5px;">
						<div class="progress-bar w-75" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
					<div class="info-text">
						<span class="info-des">달성률</span> <span> <strong>1819</strong>% 달성
						</span>
					</div>
					<div class="info-text">
						<span class="info-des">펀딩금액</span> <span> <strong>17,984,000</strong>원 펀딩
						</span>
					</div>
					<div class="info-text">
						<span class="info-des">참여자</span> <span> <strong>646</strong>명의 서포터
						</span>
					</div>
					<div class="row justify-content-md-center" style="margin-bottom: 20px;">
						<div class="col-4 cale">
							<div>
								<i class="bi bi-calendar"></i>
							</div>
							<div>
								<span>펀딩 시작일</span>
							</div>
							<div>
								<span class="date">2022.03.21</span>
							</div>
						</div>
						<div class="col-2 cale">
							<div>
								<i class="bi bi-dash-lg"></i>
							</div>
						</div>
						<div class="col-4 cale">
							<div>
								<i class="bi bi-calendar"></i>
							</div>
							<div>
								<span>펀딩 종료일</span>
							</div>
							<div>
								<span class="date">2022.04.21</span>
							</div>
						</div>
					</div>
					<div class="info-text">
						<input type="button" class="form-control butn" value="펀딩하기" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row justify-content-md-center" style="margin-bottom: 40px;">
		<div class="col-8">
			<img alt="" class="img-fluid" src="${pageContext.request.contextPath}/img/detailsample1.jpg">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="${pageContext.request.contextPath}/img/detailsample2.jpg">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="${pageContext.request.contextPath}/img/detailsample3.jpg">
		</div>
	</div>
</div>