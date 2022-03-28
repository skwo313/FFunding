<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="${pageContext.request.contextPath}/css/chat.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<header id="header" class="fixed-top d-flex align-items-center">
	<div class="container d-flex align-items-center justify-content-between">
		<div class="logo">
			<h1 class="text-light">
				<a href="/ffunding"><img src="${pageContext.request.contextPath}/img/logo.png" alt="" class="img-fluid"></a>
			</h1>
		</div>

		<nav id="navbar" class="navbar">
			<div class="nav" style="display: flex;">
				<ul>
					<li><a href="/ffunding">메인화면</a></li>
					<li><a href="/ffunding/funding">펀딩하기</a></li>
					<li><a href="#" onclick="location.href='/ffunding/board/list'">공지사항</a></li>
				</ul>
<!-- 				<i class="bi bi-list mobile-nav-toggle"></i> -->
			</div>
			<script type="text/javascript">
				$(document).ready(function(){
					// login 후 session처리
					var hasSession = "${member.mname}";
					console.log(hasSession);
				})
			</script>
			<div class="login" style="display: flex;">
				<ul>
					<c:choose>
						<c:when test="${member.adminck eq '1'.charAt(0)}">
							<li>${member.mid}님</li>
							<li><a href="/ffunding/manager/dashboard" onclick="location.href">관리자페이지</a></li>
							<li><a href="/ffunding/member/logout" onclick="location.href">로그아웃</a></li>
						</c:when>
						<c:when test="${not empty member.mid}">
							<li>${member.mname}님</li>
							<li><a href="#">마이페이지</a></li>
							<li><a href="/ffunding/member/logout" onclick="location.href">로그아웃</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="/ffunding/member/login" onclick="location.href">로그인</a></li>
							<li><a href="/ffunding/member/registerView" onclick="location.href">회원가입</a></li>
						</c:otherwise>
					</c:choose>
						<li><a class="getstarted" href="#" onclick="location.href='/ffunding/email/email'">프로젝트 시작하기</a></li>
				</ul>
<!-- 				<i class="bi bi-list mobile-nav-toggle"></i> -->
			</div>
		</nav>
		<!-- .navbar -->
	</div>
</header>

<script type="text/javascript">
</script>
