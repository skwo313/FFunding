<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
					<li><a class="active" href="/ffunding">메인화면</a></li>
					<li><a href="/ffunding/funding">펀딩하기</a></li>
					<li><a href="#">구매하기</a></li>
					<li><a href="#" onclick="location.href='board/list'">공지사항</a></li>
				</ul>
<!-- 				<i class="bi bi-list mobile-nav-toggle"></i> -->
			</div>
			<script type="text/javascript">
				$(document).ready(function(){
					// login 후 session처리
					var hasSession = "${member.mname}";
			
					console.log("${member.mid}");
					console.log("세션회원명: " + hasSession);
					<%--
					$("#~~~").click(function(){
						if( hasSession == "") {
							alert("로그인이 필요합니다!");
						}
					})
					--%>
				})
			</script>
			<div class="login" style="display: flex;">
				<ul>
					<c:choose>
						<c:when test="${not empty member.mid}">
							<li>${member.mid}님</li>
							<li><a href="#">마이페이지</a></li>
							<li><a href="#" onclick="location.href='/ffunding/member/logout'">로그아웃</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="#" onclick="location.href='/ffunding/member/login'">로그인</a></li>
							<li><a href="#">회원가입</a></li>
						</c:otherwise>
					</c:choose>
						<li><a class="getstarted" href="#" onclick="location.href='/email/email'">프로젝트 시작하기</a></li>
				</ul>
<!-- 				<i class="bi bi-list mobile-nav-toggle"></i> -->
			</div>
		</nav>
		<!-- .navbar -->
	</div>
</header>

<script type="text/javascript">
</script>
