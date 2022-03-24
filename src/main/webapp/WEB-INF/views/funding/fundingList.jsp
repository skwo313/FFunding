<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bxslider.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fundingList.css">
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
</style>
<title>FFunding - 펀딩하기</title>
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
<nav class="categorybox">
	<ul class="category">
		<li><a href="#"><i class="bi bi-display"></i>테크 · 가전</a></li>
		<li><a href="#"><i class="bi bi-bucket"></i>패션 · 잡화</a></li>
		<li><a href="#"><i class="bi bi-droplet"></i>뷰티</a></li>
		<li><a href="#"><i class="bi bi-egg"></i>푸드</a></li>
		<li><a href="#"><i class="bi bi-house"></i>홈 · 리빙</a></li>
		<li><a href="#"><i class="bi bi-tsunami"></i>여행 · 레저</a></li>
		<li><a href="#"><i class="bi bi-bicycle"></i>스포츠 · 모빌리티</a></li>
		<li><a href="#"><i class="bi bi-snapchat"></i>캐릭터 · 굿즈</a></li>
		<li><a href="#"> <i class="bi bi-controller"></i> 게임 · 취미
		</a></li>
	</ul>
</nav>
<section>
	<div class="container" style="border-bottom: 1px solid #f0f2f5; padding: 15px 0px; display: flex; justify-content: end;">
		<form>
			<select class="form-select" aria-label="Default select example" style="width: 115px;">
				<option value="1">최신순</option>
				<option value="2">펀딩액순</option>
				<option value="3">인기순</option>
			</select>
		</form>
	</div>
	<div class="container" style="border-bottom: 1px solid #f0f2f5; padding: 15px 0px;">
		<div class="row row-cols-3">
			<c:forEach items="${list}" var="list" varStatus="vs">
				<div class="col" style="margin: 8px 0px;">
					<div class="col" style="margin-bottom: 10px">
						<img alt="" class="divImg" src="<c:out value="${list.fimg}"></c:out>">
					</div>

					<div class="col">
						<h5 class="title" style="margin-bottom: 2px; min-height: 48px;">
							<c:out value="${list.fname}"></c:out>
						</h5>
					</div>
					<div class="col" style="margin-bottom: 5px;">
						<span class="cate"><c:out value="${list.fcate}"></c:out></span>
					</div>
					<div class="col">
						<div class="progress" style="height: 5px;">
							<div class="progress-bar" style="width: <c:out value="${list.goal}"></c:out>%" role="progressbar" aria-valuenow="<c:out value="${list.goal}"></c:out>" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
					</div>
					<div class="col">
						<div class="row justify-content-between">
							<div class="col">
								<span class="percent"><c:out value="${list.goal}"></c:out>%</span> <span class="cate"><c:out value="${list.price}"></c:out>원</span>
							</div>
							<div class="col" style="text-align: right;">
								<span class="cate"><c:out value="${list.remain}"></c:out>일 남음</span>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</section>