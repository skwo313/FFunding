<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${path}/css/bxslider.css">
<link rel="stylesheet" href="${path}/css/fundingDetail.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
$(document).ready(function() {

	$(".chat-box").hide();
	$(".chatbox-open").click(function() {
		$(".chat-box").show();
		$(".chatbox-open").hide();
		sock = new SockJS("http://localhost:7080/ffunding/echo/");
		sock.onopen = onOpen;
		sock.onmessage = onMessage;
		sock.onclose = onClose;
	});
	$(".chatbox-close").click(function() {
		$(".chat-box").hide();
		$(".chatbox-open").show();
		sock.send("${member.mid}님 연결끊김");
		sock.close();
		

	});
	$("#chat-submit").click(function() {
		sendMessage();
		$('#chat-input').val('');
	});
	$("#chat-input").keyup(function(e) {
		if (e.keyCode == 13) {sendMessage();}
		
	});
	
});
function order_send() {
	location.href = "/ffunding/funding/detail/order?fid=${detail.fid}";
}
function onOpen(e) {
	sock.send("${member.mid}님 입장하셨습니다");
}
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
	sock.send(str);
	$('#chat-input').val(""); $('#chat-input').focus();
}
// 서버로부터 메시지를 받았을 때
function onMessage(e) {
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
	var mx = parseInt($(".chat-logs").height())
	
	$(".chat-logs").scrollTop(mx);
}
// 서버와 연결을 끊었을 때
function onClose(e) {
	sock.send("${member.mid}님 연결끊김");
}
</script>
<title>FFunding - 펀딩하기</title>
<div class="container">
	<div class="row" style="border-bottom: solid 1.5px #dcdcdc;">
		<div class="col-sm-8" style="margin: 15px 0px;">
			<div class="title">
				<c:out value="${detail.fname}"></c:out>
			</div>
		</div>
		<div class="col-sm-8">
			<div class="row">
				<div class="col" style="text-align: center;">
					<img class="divImg" alt="" src="<c:out value="${detail.fimg}"></c:out>">
				</div>
			</div>
			<div class="row fundimg-des">
				<c:out value="${detail.fdes}"></c:out>
			</div>
		</div>
		<div class="col" style="border-left: solid 1px #dcdcdc;">
			<div class="col">
				<div class="info-box">
					<div class="info-text">
						<span class="info-des">남은기간</span> <span class="d-day"><c:out value="${detail.remain}"></c:out>일 남음</span>
					</div>
					<div class="progress info-text" style="height: 5px;">
						<div class="progress-bar" style="width: <c:out value="${detail.goal}"></c:out>%" role="progressbar" aria-valuenow="<c:out value="${detail.goal}"></c:out>" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
					<div class="info-text">
						<span class="info-des">달성률</span> <span> <strong><c:out value="${detail.goal}"></c:out></strong>% 달성
						</span>
					</div>
					<div class="info-text">
						<span class="info-des">펀딩금액</span> <span> <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${detail.price}" /></strong>원 펀딩
						</span>
					</div>
					<div class="info-text">
						<span class="info-des">참여자</span> <span> <strong><c:out value="${detail.sell}"></c:out></strong>명의 서포터
						</span>
					</div>
					<div class="row justify-content-md-center" style="margin-bottom: 20px;">
						<div class="col-4 cale">
							<div>
								<i class="bi bi-calendar"></i>
							</div>
							<div>
								<span>펀딩 시작일</span>
							</div>
							<div>
								<span class="date"><fmt:formatDate value="${detail.fstartdate}" pattern="yyyy-MM-dd" /></span>
							</div>
						</div>
						<div class="col-2 cale">
							<div>
								<i class="bi bi-dash-lg"></i>
							</div>
						</div>
						<div class="col-4 cale">
							<div>
								<i class="bi bi-calendar"></i>
							</div>
							<div>
								<span>펀딩 종료일</span>
							</div>
							<div>
								<span class="date"><fmt:formatDate value="${detail.fenddate}" pattern="yyyy-MM-dd" /></span>
							</div>
						</div>
					</div>
					<c:if test="${not empty member.mid}">
					<div class="info-text">
						<input type="button" class="form-control butn"  onclick="order_send();" value="주문하기"/>
					</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<div class="row justify-content-md-center" style="margin: 40px 0px;">
		<div class="col-8">
			<img alt="" class="img-fluid" src="<c:out value="${detail.fimg1}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="<c:out value="${detail.fimg2}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="<c:out value="${detail.fimg3}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="<c:out value="${detail.fimg4}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="<c:out value="${detail.fimg5}"></c:out>">
		</div>
	</div>
</div>