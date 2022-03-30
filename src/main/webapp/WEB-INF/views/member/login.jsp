<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />


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
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<title>로그인</title>
<style>
#selectLan{
	width: 180px;
	padding: .5em .5em;
	border: 1px solid #999;
	font-family: inherit;
	background: url('${path}/img/arrow.png') no-repeat 95% 50%;
	border-radius: 5px;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	z-index:3;
}
</style>


<script>
	$(document).ready(function() {
		
		let msg = "${msg}";
		if (msg != "") {
			success(msg);
		};
		
		$("#form").keypress(function(e) {
			if (e.keyCode == 13) {
				loginBtn();
			}
		});

		let rememberId = localStorage.getItem("saveId");
		if (rememberId != "" && rememberId != "N") {
			$("[name=mid]").val(rememberId);
		}
		$("#selectLan").val("${param.lang}")
		$("#selectLan").change(function() {
			var lan = $('#selectLan').val();
			location.href = "/ffunding/member/choiceLan?lang=" + lan;

		});
	})
	function loginBtn() {
		let mid = $("[name=mid]").val();
		let mpw = $("[name=mpw]").val();
		let saveIdCheck = $("#rememberMe").prop("checked");

		if (saveIdCheck) {
			localStorage.setItem("saveId", mid);
		} else {
			localStorage.setItem("saveId", 'N');
		}

		let loginData = {
			"mid" : mid,
			"mpw" : mpw
		};
		$.ajax({
			type : "POST",
			url : "loginCk",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(loginData),
			success : function(result) {
				if (result == 0) {
					if (mid == "") {
						$("#loginFail").html("아이디를 입력하세요.");
						$("[name=mid]").focus();
					} else if (mpw == "") {
						$("#loginFail").html("비밀번호를 입력하세요.");
						$("[name=mpw]").focus();
					} else {
						$("#loginFail").html("아이디 또는 비밀번호를 다시 확인 후 시도해 주세요.");
						$("[name=mid]").focus();
					}
					return false;
				} else if (result == 9) {
					alert("통신 오류");
					return false;
				} else {
					window.location.replace("${path}/");
				}
			},
			error : function(request, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
	}
	function success(msg) {
		Swal.fire({
		  position: 'top-end',
		  icon: 'success',
		  title: msg,
		  showConfirmButton: false,
		  timer: 1500
		})
	}
	
</script>

<main class="main-content  mt-0">
	<div class="page-header align-items-start min-vh-100"
		style="background-image: url('https://images.unsplash.com/photo-1497294815431-9365093b7331?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80');">
		<span class="mask bg-gradient-dark opacity-6"></span>
		<div class="container my-auto">
			<div class="row">
				<div class="col-lg-4 col-md-8 col-12 mx-auto">
					<div class="card z-index-0 fadeIn3 fadeInBottom">
						<div
							class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
							<div
								class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-1">
								<h4 class="text-white font-weight-bolder text-center mt-2 mb-0">
									<spring:message code="login" />
								</h4>
								<div class="row mt-3">
									<div id="naver_id_login" class="col-2 text-center ms-auto">
										<a class="btn btn-link px-1" href="${naver_url}"
											onclick="window.open(this.href,'naverLogin','width=800,height=800');return false;">
											<img style="border-radius:30%; width:33px;" src="${path}/img/naver.ico" class="fa"></img>
										</a>
									</div>

									<div class="col-2 text-center px-auto">
										<a class="btn btn-link px-1" href="${google_url}"
											onclick="window.open(this.href,'googleLogin','width=800,height=800');return false;">
											<img style="border-radius:30%; width:31px;"  src="${path}/img/google2.jpeg" class="fa"></img>
										</a>
									</div>
									<div class="col-2 text-center me-auto">
										<a class="btn btn-link px-1" href="${kakao_url}"
											onclick="window.open(this.href,'kakaoLogin','width=800,height=800');return false;"> 
											<img style="border-radius:30%; width:31px; object-fit: cover;" src="${path}/img/kakao.png" class="fa"></img>
										</a>
									</div>
								</div>
							</div>
						</div>
						<div class="card-body">
							<form id="form" method="post" role="form" class="text-start">
								<div class="input-group input-group-outline my-3">
									<input type="text" class="form-control" name="mid"
										autocomplete="off" placeholder="<spring:message code="id"/>">
								</div>
								<div class="input-group input-group-outline mb-3">
									<input type="password" class="form-control" name="mpw"
										placeholder="<spring:message code="pass"/>">
								</div>

								<div id="loginFail" style="color: red; font-size: 15px;"></div>
				
								<div class="row mt-3 justify-content-between">
									<div
										class="form-check form-switch d-flex align-items-center mb-3 ms-auto col-5">
										<input class="form-check-input" type="checkbox" id="rememberMe">
										<label class="form-check-label mb-0 ms-2" for="rememberMe"><spring:message
												code="saveid" /></label>
									</div>
									<div class="col-6 text-center ms-auto" >
										<a class="form-check-label" href="find" onclick="location.href">
											<spring:message code="findidpass" /></a>
									</div>
								</div>
								
								<div class="text-center">
									<button type="button" onclick="loginBtn()"
										class="btn bg-gradient-primary w-100 my-4 mb-2">
										<spring:message code="login" />
									</button>
								</div>
								<p class="mt-4 text-sm text-center">
									<spring:message code="regment" />
									<a href="registerView"
										class="text-primary text-gradient font-weight-bold"><spring:message
											code="reg" /></a>
								</p>
							</form>
							<div>
								<!-- 언어 선택 -->
								<select class="form-select form-select-sm mx-auto mt-5" id="selectLan">
									<option value=""><spring:message code="chlange" /></option>
									<option value="ko"><spring:message code="ko" /></option>
									<option value="en"><spring:message code="en" /></option>
								</select>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<!--   Core JS Files   -->
<script src="${path}/js/member/core/popper.min.js"></script>
<script src="${path}/js/member/core/bootstrap.min.js"></script>
<script src="${path}/js/member/plugins/perfect-scrollbar.min.js"></script>
<script src="${path}/js/member/plugins/smooth-scrollbar.min.js"></script>
<!-- Github buttons -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
<script src="${path}/js/member/material-dashboard.min.js?v=3.0.1"></script>
