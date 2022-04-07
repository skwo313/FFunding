<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<title>마이페이지</title>
<!-- Fonts and icons -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
<!-- Nucleo Icons -->
<link href="${path}/css/member/nucleo-icons.css" rel="stylesheet" />
<link href="${path}/css/member/nucleo-svg.css" rel="stylesheet" />
<!-- Font Awesome Icons -->
<script src="https://kit.fontawesome.com/42d5adcbca.js"
	crossorigin="anonymous"></script>
<!-- Material Icons -->
<link
	href="https://fonts.googleapis.com/icon?family=Material+Icons+Round"
	rel="stylesheet">
<!-- CSS Files -->
<link id="pagestyle"
	href="${path}/css/member/material-dashboard.css?v=3.0.1"
	rel="stylesheet" />
<script>
	$(document).ready(function() {
		var hasSession = "${member.mid}";
		if (hasSession == "") {
			alert("로그인이 필요합니다.");
			location.href = "${path}/member/login";
		}
		;
	})
</script>

<body class="g-sidenav-show bg-gray-200">
	<div class="main-content position-relative max-height-vh-100 h-100">

		<div class="container-fluid px-2 px-md-4">
			<div class="page-header min-height-300 border-radius-xl mt-4"
				style="background-image: url('https://images.unsplash.com/photo-1531512073830-ba890ca4eba2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80');">
				<span class="mask  bg-gradient-primary  opacity-6"></span>
			</div>

			<div class="card card-body mx-3 mx-md-10 mt-n9">
				<div class="row gx-4 mb-2">
					<div class="col-auto my-auto mx-3">
						<div class="h-100">
							<h5 class="mb-1">${member.mid}님</h5>
							<c:choose>
								<c:when test="${member.sellerck eq '1'.charAt(0)}">
									<p class="mb-0 font-weight-normal text-sm">메이커</p>
								</c:when>
								<c:otherwise>
									<p class="mb-0 font-weight-normal text-sm">서포터</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="col-lg-2">
						<a href="userConfirm" class="btn btn-outline-success btn-sm">회원정보 수정</a>
					</div>
					<div
						class="col-lg-2 col-md-6 my-sm-auto ms-sm-auto me-sm-0 mx-auto mt-3">
						<div class="nav-wrapper position-relative end-0">
							<c:if test="${member.sellerck eq '1'.charAt(0)}">
								<button class="btn btn-outline-primary btn-sm rounded-3" 
									 onclick="location.href='../apply/list'">
									<i class="material-icons text-lg position-relative">shop</i> 
									<span class="ms-1">등록 펀딩 리스트</span>
								</button>
							</c:if>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="row justify-content-center">
						<div
							class="col-12 col-xl-3 text-center border border-2 border-end-0 rounded-start rounded-3">
							<div class="card card-plain h-100 pt-4 pb-3">
								<div class="card-header pb-0 p-3">
									<p class="fs-2 fw-bold mb-0">
										<a href="fundingList">${info.FUNDING_CNT}</a>
									</p>
								</div>
								<div class="card-body p-3 fs-5 fw-bold">구매한 펀딩</div>
							</div>
						</div>
						<div class="col-12 col-xl-3 text-center border border-2 ">
							<div class="card card-plain h-100 pt-4 pb-3">
								<div class="card-header pb-0 p-3">
									<p class="fs-2 fw-bold mb-0">
										<a href="donation">${info.DONATION_CNT}</a>
									</p>
								</div>
								<div class="card-body p-3 fs-5 fw-bold">구매한 후원</div>
							</div>
						</div>
						<div
							class="col-12 col-xl-3 text-center border border-2 border-start-0 rounded-end rounded-3">
							<div class="card card-plain h-100 pt-4 pb-3">
								<div class="card-header pb-0 p-3">
									<p class="fs-2 fw-bold mb-0">
										<a href="point"><fmt:formatNumber value="${info.POINT}" /></a>
									</p>
								</div>
								<div class="card-body p-3 fs-5 fw-bold">포인트</div>
							</div>
						</div>
					</div>
					<!-- 나의 정보 수정 -->
					<div class="row">
						<div class="col-12 mt-4">
							<div class="mb-4 ps-3">
								<h6 class="mb-1">나의 정보</h6>
							</div>
						</div>
						<div class="row justify-content-center">
							<div class="col-12 col-xl-5 me-3 ms-6">
								<a href="point" class="row"> <i
									class="material-icons fs-3 col-1">paid</i> <span
									class="fs-5 col-8">포인트 충전</span> <i
									class="material-icons fs-3 col-1">chevron_right</i>
								</a>
							</div>
							<div class="col-12 col-xl-5">
								<a href="userConfirm" class="row"> <span
									class="material-icons fs-3 col-1">local_shipping</span> <span
									class="fs-5 col-8">배송지 관리</span> <i
									class="material-icons fs-3 col-1">chevron_right</i>
								</a>
							</div>
						</div>
					</div>
					<!-- 최근 펀딩 정보 -->
					
					<div class="row">
						<div class="col-12 mt-4">
							<div class="mb-5 ps-3">
								<h6 class="mb-1">나의 펀딩</h6>
								<p class="text-sm">최근 내가 구매한 펀딩 프로젝트</p>
							</div>
							<div class="row">
								<c:forEach var="list" items="${fundingList}">
									<div class="col-xl-3 col-md-6 mb-xl-0 mb-4">
										<div class="card card-blog card-plain">
											<div class="card-header p-0 mt-n4 mx-3">
												<a class="d-block shadow-xl border-radius-xl"
													href="/ffunding/funding/detail?fid=${list.FID}"> <img
													src="${path}/fundingimage/${list.FIMG}"
													alt="img-blur-shadow"
													class="img-fluid shadow border-radius-xl" style="height:150px;">
												</a>
											</div>
											<div class="card-body p-3">
												<p class="mb-0 text-sm">${list.FCATE}</p>
												<a href="/ffunding/funding/detail?fid=${list.FID}">
													<h5>${list.FNAME}</h5>
												</a>
												<p class="mb-4 text-sm">${list.FDES}</p>
												<div
													class="d-flex align-items-center justify-content-between">
													<button type="button"
														onclick="location.href='/ffunding/funding/detail?fid=${list.FID}'"
														class="btn btn-outline-primary btn-sm mb-0">프로젝트
														가기</button>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="fixed-plugin">
		<a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
			<i class="material-icons py-2">settings</i>
		</a>
		<div class="card shadow-lg">
			<div class="card-header pb-0 pt-3">
				<div class="float-start">
					<h5 class="mt-3 mb-0">Material UI Configurator</h5>
					<p>See our dashboard options.</p>
				</div>
				<div class="float-end mt-4">
					<button
						class="btn btn-link text-dark p-0 fixed-plugin-close-button">
						<i class="material-icons">clear</i>
					</button>
				</div>
				<!-- End Toggle Button -->
			</div>
			<hr class="horizontal dark my-1">
			<div class="card-body pt-sm-3 pt-0">


				<!-- Navbar Fixed -->
				<hr class="horizontal dark my-3">
				<div class="mt-2 d-flex">
					<h6 class="mb-0">Light / Dark</h6>
					<div class="form-check form-switch ps-0 ms-auto my-auto">
						<input class="form-check-input mt-1 ms-auto" type="checkbox"
							id="dark-version" onclick="darkMode(this)">
					</div>
				</div>
				<hr class="horizontal dark my-sm-4">
			</div>
		</div>
	</div>
	<!--   Core JS Files   -->
	<script src="${path}/js/member/core/popper.min.js"></script>
	<script src="${path}/js/member/core/bootstrap.min.js"></script>
	<script src="${path}/js/member/plugins/perfect-scrollbar.min.js"></script>
	<script src="${path}/js/member/plugins/smooth-scrollbar.min.js"></script>
	<script>
		var win = navigator.platform.indexOf('Win') > -1;
		if (win && document.querySelector('#sidenav-scrollbar')) {
			var options = {
				damping : '0.5'
			}
			Scrollbar.init(document.querySelector('#sidenav-scrollbar'),
					options);
		}
	</script>
	<!-- Github buttons -->
	<script async defer src="https://buttons.github.io/buttons.js"></script>
	<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="${path}/js/member/material-dashboard.min.js?v=3.0.1"></script>
</body>