<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<title>후원 내역</title>
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
<link href="${path}/css/member/mypage.css" rel="stylesheet" />

<script type="text/javascript">
	$(document).ready(function() {

		var hasSession = "${member.mid}";
		if (hasSession == "") {
			alert("로그인이 필요합니다.");
			location.href = "${path}/member/login";
		}
		;
	});
</script>

<body class="g-sidenav-show bg-gray-200">
	<div class="main-content position-relative max-height-vh-100 h-100">

		<div class="container-fluid px-2 px-md-4">
			<div class="page-header min-height-300 border-radius-xl mt-4"
				style="background-image: url('https://images.unsplash.com/photo-1531512073830-ba890ca4eba2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80');">
				<span class="mask  bg-gradient-primary  opacity-6"></span>
			</div>

			<div class="card card-body mx-3 mx-md-10 mt-n9">
				<div class="card my-4">
					<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
						<div
							class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
							<h6 class="text-white text-capitalize ps-3">후원 내역</h6>
						</div>
					</div>
					<div class="card-body px-0 pb-2">
						<div class="table-responsive p-0">
							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th
											class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">펀딩
											진행중인 프로젝트</th>
										<th
											class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">카테고리</th>
										<th
											class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">후원금액</th>
										<th
											class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">날짜</th>
									</tr>
								</thead>
								<tbody>
									<jsp:useBean id="now" class="java.util.Date" />

									<c:forEach var="dlist" items="${donaList}">
										<fmt:formatDate value="${dlist.FENDDATE}" pattern="yyyyMMddHHmm" var="endDate" />
										<fmt:formatDate value="${now}" pattern="yyyyMMddHHmm" var="nowDate" />
										<c:if test="${nowDate < endDate}">
											<tr>
												<td>
													<div class="d-flex px-2 py-1">
														<div>
															<a href="${path}/funding/detail?fid=${dlist.FID}"> <img
																src="${path}/fundingimage/${dlist.FIMG}"
																class="avatar avatar-sm me-3 border-radius-lg"
																alt="user1">
															</a>
														</div>
														<div class="d-flex flex-column justify-content-center">
															<h6 class="mb-0 text-sm">
																<a href="${path}/funding/detail?fid=${dlist.FID}">${dlist.FNAME}</a>
															</h6>
														</div>
													</div>
												</td>
												<td>
													<p class="text-xs font-weight-bold mb-0">${dlist.FCATE}</p>
												</td>
												<td class="align-middle text-center text-sm"><span
													class="badge badge-sm bg-gradient-success"> <fmt:formatNumber
															value="${dlist.FO_DONATION}" />원
												</span></td>
												<td class="align-middle text-center"><span
													class="text-secondary text-xs font-weight-bold"> <fmt:formatDate
															value="${dlist.FO_DATE}" pattern="yy/MM/dd" />
												</span></td>
											</tr>
										</c:if>
									</c:forEach>

								</tbody>
							</table>

							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th
											class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">펀딩이
											끝난 프로젝트</th>
										<th
											class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">카테고리</th>
										<th
											class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">후원금액</th>
										<th
											class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="dlist" items="${donaList}">
										<fmt:formatDate value="${dlist.FENDDATE}" pattern="yyyyMMddHHmm" var="endDate" />
										<fmt:formatDate value="${now}" pattern="yyyyMMddHHmm" var="nowDate" />
										<c:if test="${nowDate > endDate}">
										<tr>
											<td>
												<div class="d-flex px-2 py-1">
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0 text-sm">
															${dlist.FNAME}
														</h6>
													</div>
												</div>
											</td>
											<td>
												<p class="text-xs font-weight-bold mb-0">${dlist.FCATE}</p>
											</td>
											<td class="align-middle text-center text-sm"><span
												class="badge badge-sm bg-gradient-success"> <fmt:formatNumber
														value="${dlist.FO_DONATION}" />원
											</span></td>
											<td class="align-middle text-center"><span
												class="text-secondary text-xs font-weight-bold"> <fmt:formatDate
														value="${dlist.FO_DATE}" pattern="yy/MM/dd" />
											</span></td>
										</tr>
										</c:if>
									</c:forEach>

								</tbody>
							</table>
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