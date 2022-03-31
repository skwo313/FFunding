<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 부가적인 테마 -->
<meta charset="UTF-8">
<title>아이디∙비밀번호 찾기</title>
<style>
table {
	width: 50%;
	margin-left: auto;
	margin-right: auto;
}

.correct {
	color: green;
}

.incorrect {
	color: red;
}

.title {
	margin: 0 auto;
    padding: 0 16px;
    max-width: 1024px;
    color: rgba(0,0,0,.84);
    padding-top: 56px;
    padding-bottom: 10px;
    font-weight: 700;
}
.section_find {
	border: 3px solid #e9e9e9;
	padding: 20px 30px 20px 30px;
    text-align: center;
	display: none;    
}
</style>
<div class="findID">
	<div>
		<h4 class="title">아이디 찾기</h4>
	</div>
	<table>
		<tbody>
			<tr>
				<td>
					<div class="mail_wrap">
						<br>
						<div class="mail_name">이메일 (가입할 때 입력한 이메일을 입력해주세요)</div>
						<input class="form-control" name="memberMail"><br>

						<div class="mail_check_wrap">
						인증번호 입력란
							<div class="mail_check_input_box" id="mail_check_input_box_false">
							<input class="mail_check_input" disabled="disabled"  style="width:100%; height: 30px;">
						</div>
						
							<div class="clearfix"></div>
							<span id="mail_check_input_box_warn"></span>
							<br>
						</div>
					</div>
					

				</td>
			</tr>
			<tr>
				<td>
					<br>
					<button class="mail_check_button btn btn-success" id="sendbutton">인증번호 전송</button>
					<button class="write_button btn btn-success" disabled="disabled" id="applywritebutton" onclick="show()" style="float: right;">확인</button>
					<br>
				</td>
			</tr>
			<tr>
				<td>
					<div class="section_find">
						고객님의 정보와 일치하는 아이디는 <strong class="findId" style="color:red;"></strong> 입니다.
					</div>
				</td>
			</tr>
		</tbody>
	</table>


	<script>
		var code = ""; //이메일전송 인증번호 저장위한 코드
		var id ="";
		
		/* 인증번호 이메일 전송 */
		$(".mail_check_button").click(function() {

			var email = $(".form-control").val(); // 입력한 이메일
			var checkBox = $(".mail_check_input"); // 인증번호 입력란
			var boxWrap = $(".mail_check_input_box"); // 인증번호 입력란 박스
			var findSection = $(".section_find"); // 결과 박스
			
			$.ajax({

				type : "GET",
				url : "findCheck?email=" + email + "&isFindId=1",
				dataType : "json",
				success : function(data) {
					console.log(data.num +",,,,," + data.findId);
					//console.log("data : " + data);
					checkBox.attr("disabled", false);
					boxWrap.attr("id", "mail_check_input_box_true");
					code = data.num;
					id = data.findId;
					
					if (code == "0"){
						findSection.html("해당 이메일과 일치하는 계정이 없습니다");
						findSection.show();
						checkBox.attr("disabled", true);
					}
				}

			});

		});

		/* 인증번호 비교 */
		$(".mail_check_input").blur(function() {

			var inputCode = $(".mail_check_input").val(); // 입력코드    
			var checkResult = $("#mail_check_input_box_warn"); // 비교 결과     

			if (inputCode == code) { // 일치할 경우
				checkResult.html("인증번호가 일치합니다.");
				checkResult.attr("class", "correct");
				
				document.getElementById("applywritebutton").disabled = false;
				
				$(".findId").text(id);
				
			} else { // 일치하지 않을 경우
				checkResult.html("인증번호를 다시 확인해주세요.");
				checkResult.attr("class", "incorrect");
				
				document.getElementById("applywritebutton").disabled = true;
			}

		 });
		function show() {
			$(".section_find").show();
		}
	</script>
</div>

<div class="findPW">
	<div>
		<h4 class="title">비밀번호 찾기</h4>
	</div>
	<table>
		<tbody>
			<tr>
				<td>
					<div class="mail_wrap">
						<br>
						<div>아이디</div>
						<input id="mid" class="form-control" type="text" name="mid">
						
						<div class="mail_name">이메일 (가입할 때 입력한 이메일을 입력해주세요)</div>
						<input id="mail" class="form-control" name="memberMail">

						<div class="mail_check_wrap">
						인증번호 입력란
							<div class="mail_check_input_box_pw" id="mail_check_input_box_false">
							<input class="mail_check_input_pw" disabled="disabled"  style="width:100%; height: 30px;">
						</div>
							
						<div>새 비밀번호</div>
						<input id="new_pw" class="form-control" type="password" name="pw" disabled="disabled">
						
						<div>비밀번호 확인</div>	
						<input id="new_pw_check" class="form-control" type="password" name="pwCk" disabled="disabled"/>
							
							<div class="clearfix"></div>
							<span id="mail_check_input_box_pw_warn"></span>
							<br>
						</div>
					</div>

				</td>
			</tr>
			<tr>
				<td>
					<br>
					<button class="mail_check_button_pw btn btn-success" id="sendbutton">인증번호 전송</button>
					<button class="write_button btn btn-success" disabled="disabled" id="applychangepw" style="float: right;">확인</button>
					<br>
				</td>
			</tr>
		</tbody>
	</table>
	
	
	<script>
		var code = ""; //이메일전송 인증번호 저장위한 코드
		
		/* 인증번호 이메일 전송 */
		$(".mail_check_button_pw").click(function() {

			var email = $("#mail").val(); // 입력한 이메일
			var checkBox = $(".mail_check_input_pw"); // 인증번호 입력란
			var boxWrap = $(".mail_check_input_box_pw"); // 인증번호 입력란 박스
			var checkResult = $("#mail_check_input_box_pw_warn");
			
			$.ajax({

				type : "GET",
				url : "findCheck?email=" + email +"&isFindId=0",
				dataType : "json",
				success : function(data) {

					//console.log("data : " + data);
					checkBox.attr("disabled", false);
					boxWrap.attr("id", "mail_check_input_box_true");
					code = data.num;
					
					if (code == "0"){
						checkResult.html("해당 이메일과 일치하는 계정이 없습니다");
						checkResult.attr("class", "incorrect");
						checkBox.attr("disabled", true);
					}
				}

			});

		});

		/* 인증번호 비교 */
		$(".mail_check_input_pw").blur(function() {

			var inputCode = $(".mail_check_input_pw").val(); // 입력코드    
			var checkResult = $("#mail_check_input_box_pw_warn"); // 비교 결과     

			if (inputCode == code) { // 일치할 경우
				checkResult.html("인증번호가 일치합니다.");
				checkResult.attr("class", "correct");
				
				document.getElementById("applychangepw").disabled = false;
				
				$("#new_pw, #new_pw_check").attr("disabled", false);
				
			} else { // 일치하지 않을 경우
				checkResult.html("인증번호를 다시 확인해주세요.");
				checkResult.attr("class", "incorrect");
				
				document.getElementById("applychangepw").disabled = true;
				
				$("#new_pw, #new_pw_check").attr("disabled", true);
			}

		 });
		$("#applychangepw").click(function() {
			var pw = {
				"mpw" : $("#new_pw").val(),
				"memail" : $("#mail").val(),
				"mid" : $("#mid").val()
			}
			var new_pw = $("#new_pw").val();
			var new_pw_check = $("#new_pw_check").val();
			var id = $("#mid").val();
			var checkResult = $("#mail_check_input_box_pw_warn");
			var getPW = RegExp(/^[a-zA-Z0-9]{8,16}$/);
			
			if (new_pw == "" || new_pw_check =="" || id == "") {
				checkResult.html("빈칸 모두 입력해주세요");
				checkResult.attr("class", "incorrect");
				$("#new_pw").focus();
				return false;
			}
			if (!getPW.test(new_pw)) {
				checkResult.html("영어+숫자로 아이디 8~16자를 입력해주세요");
				checkResult.attr("class", "incorrect");
				$("#new_pw").focus();
				return false;
			}
			if (new_pw != new_pw_check) {
				checkResult.html("비밀번호가 일치하지 않습니다");
				checkResult.attr("class", "incorrect");
				$("#new_pw_check").focus();
				return false;
			}
			
			$.ajax({
				type : "POST",
				url : "findPw",
				contentType : "application/json",
				data : JSON.stringify(pw),
				dataType : "text",
				success : function(data) {
					if(data == 0) {
						checkResult.html("해당 이메일과 일치하는 아이디가 없습니다.");
						checkResult.attr("class", "incorrect");
					} else {
						if(confirm("비밀번호 변경이 완료되었습니다.\n" +
							"새로운 비밀번호로 바로 로그인 하시겠습니까?")) {
							location.href = data;
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
	</script>
</div>
