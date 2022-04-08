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
	$(document).keypress(function(e) { 
     	if (e.keyCode == 13) e.preventDefault(); 
     });
</script>
<script>
	$(document).ready(
			function() {
				$('#fo_cnt').on(
						'change',
						function() {
							if($("#fo_cnt").val()>5){
								alert("5개 초과 하실수 없습니다");
								$("#fo_cnt").val(5);
							}
							var cal = (Number($('#fprice').val()) * Number($(
									'#fo_cnt').val()))
									+ Number($('#fo_donation').val());
							$('#fo_price').val(cal);
						});
				$('#fo_donation').on(
						'change',
						function() {
							var cal = (Number($('#fprice').val()) * Number($(
									'#fo_cnt').val()))
									+ Number($('#fo_donation').val());
							$('#fo_price').val(cal);
						});
				$("#btnOrder").click(function() {
					var tot = $('#fo_price').val();
					var cnt = $('#fo_cnt').val();
					
					
					if (cnt =="0"){
						alert("주문내용을 선택해주세요");
						$('#fo_cnt').focus();
						return false;
					}
					if (tot =="0"){
						alert("주문내용을 선택해주세요");
						$('#fo_price').focus();
						return false;
					}
					console.log("point"+${mid.point});
					console.log("tot"+tot);
					
					if(${mid.point}< tot){
						alert("포인트가 부족합니다");
						$('#fo_donation').focus();
						return false;
					}
					$(".form1")("action", "/ffunding/funding/detail/order");
					$(".form1").submit();
				});
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
	function handleOnInput(el, maxlength) {
		  if(el.value.length > maxlength)  {
		    el.value 
		      = el.value.substr(0, maxlength);
		  }
		}
</script>
<style>
.imgbox {
	text-align: center;
	margin-top: 40px;
}

.order {
	max-width: 17%;
}

.btn {
	margin-bottom: 40px;
}
</style>
<title>FFunding - 주문</title>

<div class="container-sm" style="max-width: 643px;">
	<div class="row row-cols-1">
		<div class="col imgbox">
			<img alt="" src="${pageContext.request.contextPath}/img/orderimg.png"
				class="img-fluid order">
		</div>
		<div class="order_text">
			<h1 class="order_text2">
				<p align="center">ORDER</p>
				<p style="font-size: 15px">▶제품명 : ${detail.fname}</p>
				<p style="font-size: 15px">▶${detail.remain}일후 자동 배송처리됩니다</p>
			</h1>
		</div>
		<form class="order_form" name="form1" method="post">
			<div class="col">
				<div class="form-floating mb-3">
					<input type="number" class="form-control" id="fprice"
						value="${detail.fprice}" readonly> <label
						for="floatingInputValue">제품 가격</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="number" class="form-control" name="fo_cnt" id="fo_cnt"
						value="0" min="0" max="5" oninput='handleOnInput(this,1)'>
					<label for="floatingInputValue">수량 입력</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="number" class="form-control" name="fo_donation"
						id="fo_donation" value="0" min="0"> <label
						for="floatingInputValue">추가 후원금액 입력</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="number" class="form-control" name="fo_price"
						id="fo_price" value="0" readonly> <label
						for="floatingInputValue">총 결제 금액</label>
				</div>
			</div>
			<input type="hidden" class="form-control" name="mid" id="mid"
				value="${member.mid}">
			<div class="col">
				<button type="submit" id="btnOrder"
					class="w-100 btn btn-lg btn-primary" style="width: 100%;">결제</button>
			</div>
		</form>
	</div>
</div>