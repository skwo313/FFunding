<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>회원가입</title>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("#regForm").on("keyup", function(){
			let target = $(event.target).attr('id');
			regCheck(target);
			
			let validCount = $(".is-valid").length;
			if (validCount == 6) {
				$("#regBtn").prop("disabled", false);
				
				$("#regForm").keypress(function(e) {
					if (e.keyCode == 13) {
						submitForm();
						return false;
					}
				});
				
			} else {
				$("#regBtn").prop("disabled", true);
			}
		})
		$("#regForm").on("focusout", function(){
			let target = $(event.target).attr('id');
			regCheck(target);
		})
		$("#regBtn").click(function(){
			submitForm();
			return false;
		})
	})
	
	function regCheck(target) {
		let id = $("#id").val();
		let pw = $("#pw").val();
		let pwCk = $("#pwCk").val();
		let name = $("#name").val();
		let email = $("#email").val();
		let phone = $("#phone").val();
		
		let getID = RegExp(/^[a-zA-Z0-9]{4,12}$/);
		let getPW = RegExp(/^[a-zA-Z0-9]{8,16}$/);
		let getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
		let getName = RegExp(/^[가-힣]{2,}$/);
		let getPhone = RegExp(/^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/);
		let check = false;
		
		switch (target) {
			case "id":
				if (id == "") {
					$("#validID").removeClass("is-valid");
					$("#idMsg").text("아이디를 입력해주세요");
					$("#idMsg").show();
				} else if (!getID.test(id)) {
					$("#validID").removeClass("is-valid");
					$("#idMsg").text("영어+숫자로 아이디 4~12자를 입력해주세요");
					$("#idMsg").show();
				} else if (duplicate()) {
					$("#validID").removeClass("is-valid");
					$("#idMsg").text("이미 사용중인 아이디 입니다");
					$("#idMsg").show();
				} else {
					$("#validID").addClass("is-valid");
					$("#idMsg").hide();
					check = true;
				}
				break;
			case "pw":
				if (pw == "") {
					$("#validPW").removeClass("is-valid");
					$("#pwMsg").text("비밀번호를 입력해주세요");
					$("#pwMsg").show();
				} else if(!getPW.test(pw)) {
					$("#validPW").removeClass("is-valid");
					$("#pwMsg").text("영어+숫자로 아이디 8~16자를 입력해주세요");
					$("#pwMsg").show()
				} else {
					$("#validPW").addClass("is-valid");
					$("#pwMsg").hide();
					check = true;
				}
				break;
			case "pwCk":
				if (pwCk == "") {
					$("#validPwCk").removeClass("is-valid");
					$("#pwCkMsg").text("비밀번호 확인란을 입력해주세요");
					$("#pwCkMsg").show();
				} else if (pw != pwCk) {
					$("#validPwCk").removeClass("is-valid");
					$("#pwCkMsg").text("비밀번호가 일치하지 않습니다");
					$("#pwCkMsg").show();
				} else {
					$("#validPwCk").addClass("is-valid");
					$("#pwCkMsg").hide();
					check = true;
				}
				
				break;
			case "name":
				if (name == "") {
					$("#validName").removeClass("is-valid");
					$("#nameMsg").text("이름을 입력해주세요");
					$("#nameMsg").show();
				} else if (!getName.test(name)) {
					$("#validName").removeClass("is-valid");
					$("#nameMsg").text("이름 2자 이상을 입력해주세요")
					$("#nameMsg").show();
				} else {
					$("#validName").addClass("is-valid");
					$("#nameMsg").hide();
					check = true;
				}
				break;
			case "email":
				if (email == "") {
					$("#validEmail").removeClass("is-valid");
					$("#emailMsg").text("이메일을 입력해주세요");
					$("#emailMsg").show();
				} else if (!getMail.test(email)) {
					$("#validEmail").removeClass("is-valid");
					$("#emailMsg").text("이메일 형식에 맞게 입력해주세요 ex) example@naver.com");
					$("#emailMsg").show();
				}
				else {
					$("#validEmail").addClass("is-valid");
					$("#emailMsg").hide();
					check = true;
				}
				break;
			case "phone":
				if (phone == "") {
					$("#validPhone").removeClass("is-valid");
					$("#phoneMsg").text("휴대전화 번호를 입력해주세요");
					$("#phoneMsg").show();
				} else if (!getPhone.test(phone)){
					$("#validPhone").removeClass("is-valid");
					$("#phoneMsg").text("휴대전화 형식에 맞게 입력해주세요");
					$("#phoneMsg").show();
				}
				else {
					$("#validPhone").addClass("is-valid");
					$("#phoneMsg").hide();
					check = true;
				}
				break;
		}
		
		
	}
	
	function duplicate() {
		let id = {
				"mid" : $("#id").val()
		}
		let duplicate = false;
		
		$.ajax({
			url : "idChk",
			type : "POST",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify(id),
			async: false,
			success : function(result) {
				if (result == 1) {
					duplicate = true;
				}
			},
			error : function(request, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
		return duplicate;
	}
	
	function submitForm() {
		if(confirm("회원가입 하시겠습니까?")) {
			$("#regForm").submit();
		}
	}

</script>
<style>
.msg {
 	color: red; 
 	font-size: 13px;
 	position: relative;
 	bottom: 10px;
}
</style>

<main class="main-content  mt-0">
  <section>
    <div class="page-header min-vh-100">
      <div class="container">
        <div class="row">
          <div class="col-6 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 start-0 text-center justify-content-center flex-column">
            <div class="position-relative bg-gradient-primary h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center" style="background-image: url('${path}/img/ffunding.png'); background-size: cover;">
            </div>
          </div>
          <div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column ms-auto me-auto ms-lg-auto me-lg-5">
            <div class="card card-plain">
              <div class="card-header">
                <h4 class="font-weight-bolder">회원 가입</h4>
                <p class="mb-0"><strong>FFunding</strong> 회원이 되어 아이디어에 투자 하세요</p>
              </div>
              <div class="card-body">
                <form id="regForm" method="post" action="register" role="form">
                  <div id="validID" class="input-group input-group-outline mb-3">
                    <label class="form-label">* 아이디</label>
                    <input id="id" name="mid" type="text" class="form-control">
                  </div>
                  <span id="idMsg" class="msg"></span>
                  
                  <div id="validPW" class="input-group input-group-outline mb-3">
                    <label class="form-label">* 비밀번호</label>
                    <input id="pw" name="mpw" type="password" class="form-control">
                  </div>
                  <span id="pwMsg" class="msg"></span>
                  
                  <div id="validPwCk" class="input-group input-group-outline mb-3">
                    <label class="form-label">* 비밀번호 확인</label>
                    <input id="pwCk" type="password" class="form-control">
                  </div>
                  <span id="pwCkMsg" class="msg"></span>
                  
                  <div id="validName" class="input-group input-group-outline mb-3">
                    <label class="form-label">* 이름</label>
                    <input id="name" name="mname" type="text" class="form-control">
                  </div>
                  <span id="nameMsg" class="msg"></span>
                  
                  <div id="validEmail" class="input-group input-group-outline mb-3">
                    <label class="form-label">* 이메일</label>
                    <input id="email" name="memail" type="email" class="form-control">
                  </div>
                  <span id="emailMsg" class="msg"></span>
                  
                  <div id="validPhone" class="input-group input-group-outline mb-3">
                    <label class="form-label">* 휴대폰 번호</label>
                    <input id="phone" name="mphone" type="text" class="form-control">
                  </div>
                  <span id="phoneMsg" class="msg"></span>
                  
                  <div class="form-check form-check-info text-start ps-0">
                    <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" checked>
                    <label class="form-check-label" for="flexCheckDefault">
                      I agree the <a href="javascript:;" class="text-dark font-weight-bolder">Terms and Conditions</a>
                    </label>
                  </div>
                  <div class="text-center">
                    <button id="regBtn" type="button" class="btn btn-lg bg-gradient-primary btn-lg w-100 mt-4 mb-0" disabled>완료</button>
                  </div>
                </form>
              </div>
              <div class="card-footer text-center pt-0 px-lg-2 px-1">
                <p class="mb-2 text-sm mx-auto">
                  이미 FFunding 계정이 있나요?
                  <a href="login" class="text-primary text-gradient font-weight-bold">로그인</a>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</main>
 <!--   Core JS Files   -->
<script src="${path}/js/member/core/popper.min.js"></script>
<script src="${path}/js/member/core/bootstrap.min.js"></script>
<script src="${path}/js/member/plugins/perfect-scrollbar.min.js"></script>
<script src="${path}/js/member/plugins/smooth-scrollbar.min.js"></script>
 <script>
   var win = navigator.platform.indexOf('Win') > -1;
   if (win && document.querySelector('#sidenav-scrollbar')) {
     var options = {
       damping: '0.5'
     }
     Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
   }
 </script>
 <!-- Github buttons -->
 <script async defer src="https://buttons.github.io/buttons.js"></script>
 <!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
<script src="${path}/js/member/material-dashboard.min.js?v=3.0.1"></script>