<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${path}/css/bxslider.css">
<link rel="stylesheet" href="${path}/css/fundingDetail.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	
</script>
<title>FFunding - 펀딩하기</title>
<div class="container">
	<div class="row" style="border-bottom: solid 1.5px #dcdcdc;">
		<div class="col-sm-8" style="margin: 15px 0px;">
			<div class="title">
				<c:out value="${detail.fname}"></c:out>
			</div>
		</div>
		<div class="col-sm-8">
			<div class="row">
				<div class="col" style="text-align: center;">
					<img class="divImg" alt="" src="<c:out value="${detail.fimg}"></c:out>">
				</div>
			</div>
			<div class="row fundimg-des">
				<c:out value="${detail.fdes}"></c:out>
			</div>
		</div>
		<div class="col" style="border-left: solid 1px #dcdcdc;">
			<div class="col">
				<div class="info-box">
					<div class="info-text">
						<span class="info-des">남은기간</span> <span class="d-day"><c:out value="${detail.remain}"></c:out>일 남음</span>
					</div>
					<div class="progress info-text" style="height: 5px;">
						<div class="progress-bar" style="width: <c:out value="${detail.goal}"></c:out>%" role="progressbar" aria-valuenow="<c:out value="${detail.goal}"></c:out>" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
					<div class="info-text">
						<span class="info-des">달성률</span> <span> <strong><c:out value="${detail.goal}"></c:out></strong>% 달성
						</span>
					</div>
					<div class="info-text">
						<span class="info-des">펀딩금액</span> <span> <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${detail.price}" /></strong>원 펀딩
						</span>
					</div>
					<div class="info-text">
						<span class="info-des">참여자</span> <span> <strong><c:out value="${detail.sell}"></c:out></strong>명의 서포터
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
								<span class="date"><fmt:formatDate value="${detail.fstartdate}" pattern="yyyy-MM-dd" /></span>
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
								<span class="date"><fmt:formatDate value="${detail.fenddate}" pattern="yyyy-MM-dd" /></span>
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
			<img alt="" class="img-fluid" src="<c:out value="${detail.fimg1}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="<c:out value="${detail.fimg2}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="<c:out value="${detail.fimg3}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="<c:out value="${detail.fimg4}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="<c:out value="${detail.fimg5}"></c:out>">
		</div>
	</div>
</div>