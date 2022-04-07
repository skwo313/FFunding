<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<title>회원정보수정</title>
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
<link href="${path}/css/member/addrlinkSample.css" rel="stylesheet" />
<style>
.correct {
	color: green;
}

.incorrect {
	color: red;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#pwChBtn").click(function(){
			let cuttent_pw = $("#inputCurrentPw").val();
			let new_pw = $("#inputNewPw").val();
			let new_pw_check = $("#inputPwConfirm").val();
			let checkResult = $("#warning");
			let getPW = RegExp(/^[a-zA-Z0-9]{8,16}$/);
			
			let pw = {
				"currentmpw" : cuttent_pw,
				"mpw" : new_pw,
				"mid" : "${member.mid}"
			}
			
			if (cuttent_pw == "" || new_pw == "" || new_pw_check =="") {
				checkResult.html("빈칸 모두 입력해주세요");
				checkResult.attr("class", "incorrect");
				$("#inputNewPw").focus();
				return false;
			}
			if (!getPW.test(new_pw)) {
				checkResult.html("영어+숫자로 아이디 8~16자를 입력해주세요");
				checkResult.attr("class", "incorrect");
				$("#inputNewPw").focus();
				return false;
			}
			if (new_pw != new_pw_check) {
				checkResult.html("비밀번호가 일치하지 않습니다");
				checkResult.attr("class", "incorrect");
				$("#inputPwConfirm").focus();
				return false;
			}
			
			$.ajax({
				type : "POST",
				url : "${path}/mypage/userModify",
				contentType : "application/json",
				data : JSON.stringify(pw),
				dataType : "text",
				success : function(data) {
					if(data == 0){
						checkResult.html("현재 비밀번호와 일치하지 않습니다");
						checkResult.attr("class", "incorrect");
					} else {
						if(confirm("비밀번호 변경이 완료되었습니다.\n" +
							"새로운 비밀번호로 바로 로그인 하시겠습니까?")) {
							location.href = "${path}"+data;
						} else {
							location.href = "../";
						}
					}
				},
				error : function(request, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			});
		});
		
		$("#addrup").click(function(){
			let address = $("#roadAddrPart1").val();
			let address_detail1 = $("#addrDetail").val();
			let address_detail2 = $("#roadAddrPart2").val();
			let checkResult = $("#warningaddr")
			let addr = {
				"maddress" : address,
				"maddress_detail" : address_detail1+address_detail2,
				"mid" : "${member.mid}"
			};

			if (address == "" || address_detail1 == "" || address_detail2 =="") {
				checkResult.html("주소 검색을 눌러 배송지 정보를 입력해주세요");
				checkResult.attr("class", "incorrect");
				return false;
			}
			
			$.ajax({
				type : "POST",
				url : "${path}/mypage/updateAddr",
				contentType : "application/json",
				data : JSON.stringify(addr),
				dataType : "text",
				success : function(data) {
					alert("배송지 변경이 완료되었습니다");
					location.href = data;
				},
				error : function(request, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			});
		});
		
		
	});
	
</script>
<script language="javascript">
//document.domain = "abc.go.kr";

function goPopup(){
	// 호출된 페이지(jusoPopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
    var pop = window.open("/ffunding/mypage/popup","pop","width=700,height=420, scrollbars=yes, resizable=yes"); 
    
}
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn
						, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	console.log(roadAddrPart1+roadAddrPart2+addrDetail+zipNo )
	$("#roadAddrPart1").val(roadAddrPart1);
	$("#roadAddrPart2").val(roadAddrPart2);
	$("#addrDetail").val(addrDetail);
	$("#zipNo").val(zipNo);
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
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h4">회원정보수정</h1>
				</div>
	
				<form action="userModify" method="post">
					<table class="table table-responsive table-light align-middle">
						<tbody>
							<tr>
								<th class="table-info">아이디</th>
								<td><strong>${member.mid}</strong>
								<!-- 	<button type="button"
										class="btn btn-light btn-outline-secondary ms-2 mb-1 btn-sm">아이디
										변경</button></td>  --> 
							<tr>
								<th class="table-info">이름</th>
								<td><strong>${member.mname }</strong></td>
							</tr>
							<tr>
								<th class="table-info">비밀번호변경</th>
								<td>
									<div class="form-group form-group-sm">
										<div class="mb-3 row input-group input-group-outline">
											<label class="col-sm-3 col-form-label" for="inputCurrentPw">현재
												비밀번호</label>
											<div class="col-sm-4">
												<input class="form-control" type="password"
													id="inputCurrentPw" required>
											</div>
										</div>
										<div class="mb-3 row input-group input-group-outline">
											<label class="col-sm-3 col-form-label" for="inputNewPw">새
												비밀번호</label>
											<div class="col-sm-4">
												<input class="form-control" type="password" id="inputNewPw" required>
											</div>
										</div>
										<div class="mb-3 row input-group input-group-outline">
											<label class="col-sm-3 col-form-label" for="inputPwConfirm">비밀번호
												다시 입력</label>
											<div class="col-sm-4">
												<input class="form-control" type="password"
													id="inputPwConfirm" name="userPw" required>
											</div>
										</div>
										
										<div id="warning"></div>
										
										<button type="button" id="pwChBtn"
											class="btn btn-light btn-outline-secondary btn-sm">비밀번호
											변경</button>
									</div>
								</td>
							</tr>
							<tr>
								<th class="table-info">배송지</th>
								<td>
									<div class="mb-3 row input-group input-group-outline">
										<label class="col-sm-3 col-form-label" for="zipNo">우편번호</label>
										<input type="hidden" id="confmKey" name="confmKey" value=""  >
										<div class="col-sm-2">
											<input class="form-control" type="text" id="zipNo" name="zipNo" readonly style="width:100px">
										</div>
										<div class="col-sm-3">
											<input type="button" class="btn btn-light btn-outline-secondary btn-sm mb-1"
											 value="주소검색" onclick="goPopup();">
										</div>
									</div> 
									<div class="row input-group input-group-outline">
										<label class="col-sm-3 col-form-label" for="roadAddrPart1">도로명주소</label>
										<div class="col-sm-4">
											<input class="form-control" type="text" id="roadAddrPart1" ><br>
										</div>
									</div>
									<div class="row input-group input-group-outline">
										<label class="col-sm-3 col-form-label" for="roadAddrPart2">상세주소</label>
										<div class="col-sm-2">
											<input class="form-control" type="text" id="roadAddrPart2"  value="">
										</div>
										<div class="col-sm-2">
											<input class="form-control" type="text" id="addrDetail"  value="">
										</div>
									</div>
									
									<div id="warningaddr"></div>
									<button type="button" id="addrup"
											class="btn btn-light btn-outline-secondary btn-sm mt-3">배송지
											변경</button>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="usermodify-foot">
						<button type="button" onclick="location.href='main'" class="btn btn-success btn-sm mb-5">나가기</button>
					</div>
				</form>
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