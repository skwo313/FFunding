<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<title>펀딩 내역</title>
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
			//$('.alert').show();
			alert('로그인이 필요합니다');
			location.href = "${path}/member/login";
		};

	});
</script>
<!-- <div class="alert alert-warning alert-dismissible fade show" role="alert" style="display:none;">
    <span class="alert-icon align-middle">
      <span class="material-icons text-md">
      thumb_up_off_alt
      </span>
    </span>
    <span class="alert-text"><strong>경고!</strong> 로그인이 필요합니다</span>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div> -->
<body class="g-sidenav-show bg-gray-200">
	<div class="main-content position-relative max-height-vh-100 h-100">

		<div class="container-fluid px-2 px-md-4">
			<div class="page-header min-height-300 border-radius-xl mt-4"
				style="background-image: url('https://images.unsplash.com/photo-1531512073830-ba890ca4eba2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80');">
				<span class="mask  bg-gradient-primary  opacity-6"></span>
			</div>

			<div class="card card-body mx-3 mx-md-10 mt-n9">
				<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
	              <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
	                <h6 class="text-white text-capitalize ps-3">펀딩 내역</h6>
	              </div>
	            </div>

				<c:forEach var="flist" items="${fundingList}">
					<div class="orderContainer mx-auto rounded-3">
						<div class="orderdate text-success">
							<fmt:formatDate value="${flist.FO_DATE}" pattern="yyyy-MM-dd" />
							펀딩
						</div>

						<div class="card mb-4">
							<div class="row g-0">
								<div class="col-sm-9">
									<div class="row">
										<a href="/ffunding/funding/detail?fid=${flist.FID}"
											class="col-md-4"> <img
											src="${path}/fundingimage/${flist.FIMG}"
											class="img-thumbnail rounded-start imgs" alt="...">
										</a>
										<div class="col-md-8">
											<div class="orderName">
												<a href="/ffunding/funding/detail?fid=${flist.FID}">${flist.FNAME}</a>
											</div>
											<div class="orderInfo">
												<span><fmt:formatNumber value="${flist.FO_PRICE}" />
													원</span><span> • ${flist.FO_CNT}개</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-3 buttons">
									<button type="button"
										onclick="location.href='/ffunding/funding/detail?fid=${flist.FID}'"
										class="btn btn-outline-primary bsize">펀딩 프로젝트 가기</button>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>

				<div class="mb-5"></div>
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