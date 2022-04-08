<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${path}/css/bxslider.css">
<link rel="stylesheet" href="${path}/css/home.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script>
	$(document).ready(function() {
		$('.slider').bxSlider({
			auto : true,
			pager : false,
			pause: 4000
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
	var result = '${result}';
	if (result == 'Y') {
		alert("주문이 완료되었습니다");
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
		$('#chat-input').val("");
		$('#chat-input').focus();
	}

	function conn() {
		wsocket = new WebSocket("ws:/106.10.71.20:7080/ffunding/echo");
		wsocket.onopen = function(e) {
			console.log(e);
			wsocket.send("${member.mid}님 입장하셨습니다");
		}
		wsocket.onmessage = function(e) {
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
		wsocket.onclose = function() {
			wsocket.send("${member.mid}님 연결끊김");
		}

	}
</script>
<title>FFunding</title>
<div class="slider">
	<div>
		<img alt="" src="${path}/img/banner01.jpg">
		<div class="imgText">
			<p class="imgDes">머리빠짐을 절반으로</p>
			<p class="imgDes">심플리오 비오틴 탈모앰플</p>
		</div>
	</div>
	<div>
		<img alt="" src="${path}/img/banner02.png">
		<div class="imgText">
			<p class="imgDes">너도 이제 인싸!!</p>
			<p class="imgDes">버킷햇!</p>
		</div>

	</div>
	<div>
		<img alt="" src="${path}/img/banner03.png">
		<div class="imgText">
			<p class="imgDes">남산에서 한라산까지</p>
			<p class="imgDes">등산스텝 레벨업!</p>
		</div>
	</div>
	<div>
		<img alt="" src="${path}/img/banner04.jpg">
		<div class="imgText">
			<p class="imgDes">HAYAN 친환경 칫솔로</p>
			<p class="imgDes">미세플라스틱 없는 양치해요</p>
		</div>
	</div>
	<div>
		<img alt="" src="${path}/img/banner05.jpg">
		<div class="imgText">
			<p class="imgDes">오늘 알림 신청하면</p>
			<p class="imgDes">콜라겐 아이크림 전용 쿠폰</p>
		</div>
	</div>
	<div>
		<img alt="" src="${path}/img/banner06.png">
		<div class="imgText">
			<p class="imgDes">먼저 사용해 보세요</p>
			<p class="imgDes">무료 체험단 이벤트</p>
		</div>
	</div>
</div>
<section>
	<div class="container" style="border-bottom: 1px solid #f0f2f5; padding: 15px 0px;">
		<div class="row">
			<div class="col" style="border-right: 1px solid #f0f2f5;">
				<div style="padding-bottom: 15px;">
					<h3>
						<strong>달성금액 리워드</strong>
					</h3>
				</div>
				<c:forEach items="${goalRank}" var="goalRank" varStatus="vs" end="4">
					<div class="row fundingWrap">
						<div class="col-1">
							<h3>
								<strong><c:out value="${(vs.index)+1}"></c:out></strong>
							</h3>

						</div>
						<div class="col-8">
							<div class="col">
								<h4 class="title">
									<a href="/ffunding/funding/detail?fid=${goalRank.fid}"><c:out value="${goalRank.fname}"></c:out> </a>
								</h4>
							</div>
							<div class="col">
								<span class="percent"><c:out value="${goalRank.goal}"></c:out>%</span> <span class="cate"><c:out value="${goalRank.fcate}"></c:out></span>
							</div>
						</div>
						<div class="col-3">
							<img alt="" class="divImg" src="${path}/fundingimage/<c:out value="${goalRank.fimg}"></c:out>">
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="col">
				<div style="padding-bottom: 15px;">
					<h3>
						<strong>판매량 리워드</strong>
					</h3>
				</div>
				<c:forEach items="${sellRank}" var="sellRank" varStatus="vs" end="4">
					<div class="row fundingWrap">
						<div class="col-1">
							<h3>
								<strong><c:out value="${(vs.index)+1}"></c:out></strong>
							</h3>

						</div>
						<div class="col-8">
							<div class="col">
								<h4 class="title">
									<a href="/ffunding/funding/detail?fid=${sellRank.fid}"><c:out value="${sellRank.fname}"></c:out> </a>
								</h4>
							</div>
							<div class="col">
								<span class="percent"><c:out value="${sellRank.sell-1}"></c:out>건</span> <span class="cate"><c:out value="${sellRank.fcate}"></c:out></span>
							</div>
						</div>
						<div class="col-3">
							<img alt="" class="divImg" src="${path}/fundingimage/<c:out value="${sellRank.fimg}"></c:out>">
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="container" style="border-bottom: 1px solid #f0f2f5; padding: 15px 0px;">
		<div>
			<h3>
				<strong>펀딩 예정</strong>
			</h3>
		</div>
		<div class="row">
			<c:forEach items="${expected}" var="expected" varStatus="vs" end="5">
				<div class="col">
					<div class="thumbnail" style="height: 100%;">
						<div class="col" style="margin-bottom: 10px; height: 70%;">
							<img alt="" class="divImg" src="${path}/fundingimage/<c:out value="${expected.fimg}"></c:out>">
						</div>

						<div class="col">
							<h5 class="title">
								<c:out value="${expected.fname}"></c:out>
							</h5>
						</div>
						<div class="col">
							<span class="percent"><fmt:formatDate value="${expected.fstartdate}" pattern="yyyy-MM-dd" /></span> <span class="cate"><c:out value="${expected.fcate}"></c:out></span>
						</div>
					</div>
				</div>
			</c:forEach>


		</div>
	</div>
</section>