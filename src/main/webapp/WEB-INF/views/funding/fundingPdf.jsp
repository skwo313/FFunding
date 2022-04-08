<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
<script>
	$(document).ready(
			function() {
	
				$(".chat-box").hide();
				$(".chatbox-open").click(function() {
					$(".chat-box").show();
					$(".chatbox-open").hide();
					conn();
				});
				$(".chatbox-close").click(function() {
					$(".chat-box").hide();
					$(".chatbox-open").show();
					wsocket.send("${member.mid}님 연결끊김");
					wsocket.close();
					

				});
				$("#chat-submit").click(function() {
					if($("#chat-input").val()==""){
						$("#chat-input").val()=="";
					}else{
						sendMessage();
						$('#chat-input').val('');
					}
					
				});
				$("#chat-input").keyup(function(e) {
					if (e.keyCode == 13) {
						if($("#chat-input").val()==""){
							$("#chat-input").val()=="";
						}else{
							sendMessage();
						}
					}

				});
			});
	function sendMessage() {
		var mid = "${member.mid}";
		var msg = $('#chat-input').val();
		var str = mid;
		str += "<div class='m_me'>";
		str += "<i class='fa fa-user' style='font-size: 28px'></i>";
		str += "<span class='chat__message-body'>";
		str += msg;
		str += "</span>";
		str += "</div>";
		wsocket.send(str);
		$('#chat-input').val(""); $('#chat-input').focus();
	}

	function conn(){
		wsocket = new WebSocket("ws:/106.10.71.20:7080/ffunding/echo");
		wsocket.onopen=function(e){ 
			console.log(e);
			wsocket.send("${member.mid}님 입장하셨습니다");
		}
		wsocket.onmessage=function(e){
			var data = e.data;
			var returnId = null; //데이터를 보낸 사람
			var arr = data.split("<");
			for (var i = 0; i < arr.length; i++) {
				console.log('arr[' + i + ']: ' + arr[i]);
			}
			var returnId = arr[0];

			var sessionId = '${member.mid}'; //현재 세션에 로그인 한 사람
			console.log("sessionId : " + sessionId);
			console.log("returnId : " + returnId);
			if (sessionId == returnId) {
				var str = "<" + arr[1] + " " + sessionId + "</div>"
				str += "<" + arr[1] + "<" + arr[2] + "<" + arr[3];
				str += "<" + arr[4] + "<" + arr[5] + "<" + arr[6];
				$(".chat-logs").append(str);

			} else {
				var str = "<div>" + arr[0] + "</div>";
				str += "<div>"
				str += "<" + arr[2] + "<" + arr[3];
				str += "<" + arr[4] + "<" + arr[5] + "<" + arr[6];
				$(".chat-logs").append(str);
			}
			$(".chat-logs").scrollTop($(".chat-logs")[0].scrollHeight);
		}
		// handler의 afterConnectionClose와 연동
		wsocket.onclose=function(){
			wsocket.send("${member.mid}님 연결끊김");
		}
		
	}
</script>
<style>
.imgbox{
	text-align: center;
	margin-top: 40px;
}
.order{
	max-width: 17%;
}
.btn{
	margin-bottom: 40px;
}


</style>
<title>FFunding - 주문</title>

<div class="container-sm" style="max-width: 643px;">
	<div class="row row-cols-1">
		<div class="order_text" style="margin-top: 30px;">
			<h1 class="order_text2">
				<p align="center">PDF 다운로드</p>
			</h1>
		</div>
		<form class="pdf_form" name="form1" action="/ffunding/funding/pdf/down">
			<div class="col">
				<div class="form-floating mb-3">
					<input type="text" class="form-control" 
						value="${detail.remain}일" readonly> <label
						for="floatingInputValue">남은기간</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="text" class="form-control" 
						value="${detail.goal}" readonly> <label
						for="floatingInputValue">달성률</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="text" class="form-control" 
						value="${detail.price}" readonly> <label
						for="floatingInputValue">펀딩금액</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="text" class="form-control" 
						value="${detail.sell-1}명" readonly> <label
						for="floatingInputValue">참여자</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="text" class="form-control" 
						value="${detail.fprice}" readonly> <label
						for="floatingInputValue">가격</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="text" class="form-control" 
						value="<fmt:formatDate value='${detail.fstartdate}' pattern='yyyy-MM-dd' />" readonly> <label
						for="floatingInputValue">펀딩 시작일</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="text" class="form-control" 
						value="<fmt:formatDate value='${detail.fenddate}' pattern='yyyy-MM-dd' />" readonly> <label
						for="floatingInputValue">펀딩 종료일</label>
				</div>
			</div>
			<input type="hidden" class="form-control" name="fid"
						value="${detail.fid}" readonly> <label
						for="floatingInputValue"></label>
			<div class="col">
				<button type="submit" id="btnPdf"
					class="w-100 btn btn-lg btn-primary" style="width: 100%;">출력하기</button>
			</div>
		</form>
	</div>
</div>