<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${path}/css/bxslider.css">
<link rel="stylesheet" href="${path}/css/fundingDetail.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
	console.log("세션아이디: "+${member.mid});
	console.log("제품아이디: "+${detail.fmid});
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
function pdf_send() {
	location.href = "/ffunding/funding/detail/pdf?fid=${detail.fid}";
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
					<img class="divImg" alt="" src="${path}/fundingimage/<c:out value="${detail.fimg}"></c:out>">
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
						<span class="info-des">참여자</span> <span> <strong><c:out value="${detail.sell-1}"></c:out></strong>명의 서포터
						</span>
					</div>
					<div class="info-text">
						<span class="info-des">판매자</span> <span> <strong><c:out value="${detail.fmid}"></c:out></strong>
						</span>
					</div>
					<div class="info-text">
						<span class="info-des">가격</span> <span> <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${detail.fprice}" /></strong>원
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
					<c:if test="${empty member.mid}">
					<div class="info-text">
						<span class="info-des">로그인 후 결제할 수 있습니다.</span>
					</div>
					</c:if>
					<c:set var = "sid" value = "${member.mid}" />
					<c:set var = "id" value = "${detail.fmid}" />
					<c:if test="${sid eq id}">
					<div class="info-text">
						<input type="button" class="form-control butn"  onclick="pdf_send();" value="출력하기"/>
					</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<div class="row justify-content-md-center" style="margin: 40px 0px;">
		<div class="col-8">
			<img alt="" class="img-fluid" src="${path}/fundingimage/<c:out value="${detail.fimg1}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="${path}/fundingimage/<c:out value="${detail.fimg2}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="${path}/fundingimage/<c:out value="${detail.fimg3}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="${path}/fundingimage/<c:out value="${detail.fimg4}"></c:out>">
		</div>
		<div class="col-8">
			<img alt="" class="img-fluid" src="${path}/fundingimage/<c:out value="${detail.fimg5}"></c:out>">
		</div>
	</div>
</div>