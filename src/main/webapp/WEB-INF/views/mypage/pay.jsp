<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<title>포인트 충전</title>
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
<link
	href="${path}/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" />
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>

<script type="text/javascript">
	$(document).ready(function() {

		var hasSession = "${member.mid}";
		if (hasSession == "") {
			alert("로그인이 필요합니다.");
			location.href = "${path}/member/login";
		}
		;
	});

	var IMP = window.IMP;
	IMP.init("imp59712775"); // 가맹점 식별코드

	function requestPay() {
		// IMP.request_pay(param, callback) 결제창 호출
		var amount = $("#amount").val();
		const rand = Math.floor(Math.random() * 1000000)+111111;
		console.log(rand);
		
		IMP.request_pay({ // param
			pg : "html5_inicis",
			pay_method : "card",
			merchant_uid : rand,
			name : "[FFunding] 포인트 충전",
			amount : amount,
			buyer_email : "${member.memail}",
			buyer_name : "${member.mname}",
			buyer_tel : "${member.mphone}",
			buyer_addr : "${member.maddress}",
			buyer_postcode : "${member.maddress_detail}"
		}, function(rsp) { // callback
			console.log(rsp);
			if (rsp.success) {
				let payInfo = {
						"mid" : "${member.mid}",
		                "point" : amount
				};
				$.ajax({
		            url: "endPoint",
		            type: "POST",
		            contentType : "application/json",
		            data : JSON.stringify(payInfo),
		           
		        });
				
            	alert('결제가 완료되었습니다.');
            	location.href = "main";
			} else {
				alert('결제에 실패하였습니다.');
			}
		});
	}
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
							<h6 class="text-white text-capitalize ps-3">포인트 충전</h6>
						</div>
					</div>
					<div class="card-body px-0 pb-2">

						<section>
							<div class="container py-5">

								<div class="row d-flex justify-content-center">
									<div class="col-md-10 col-lg-6 col-xl-6">
										<div class="card rounded-3">
											<div class="card-header">
												<p class="row text-center mb-0">
													<strong class="fs-5 fw-bold col-5">현재 사용가능 포인트</strong> <strong
														class="fs-5 fw-bold col-3" style="color: #7185f2"><fmt:formatNumber
															value="${point}" /> P</strong>
												</p>
											</div>
											<div class="card-body mx-1 my-2">

												<div class="pt-3">

													<div class="d-flex flex-row pb-3">
														<div
															class="rounded border d-flex w-100 px-3 py-2 align-items-center">
															<div class="d-flex flex-column py-1">
																<p class="mb-1 small text-primary">충전 금액 입력</p>
																<div class="d-flex flex-row align-items-center">
																	<input type="number" step="10000" class="form-control form-control-sm"
																		id="amount" style="width: 200px;" />
																	<h6 class="mb-0 text-primary pe-1">원</h6>
																</div>
															</div>
														</div>
													</div>
												</div>

												<div
													class="d-flex justify-content-between align-items-center pb-1">
													<a href="main" class="text-muted">나가기</a>
													<button type="button" onclick="requestPay()"
														class="btn btn-primary btn-lg">결제하기</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</section>
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