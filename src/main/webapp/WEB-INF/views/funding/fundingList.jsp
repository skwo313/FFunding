<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${path}/css/bxslider.css">
<link rel="stylesheet" href="${path}/css/fundingList.css">
<style>
.bold {
	font-weight: bold;
}

li {
	list-style: none;
	float: left;
	padding: 6px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script>
	$(document).ready(function() {
		let val = "${sort}";
		if (val == "fstartdate") {
			$("#sort option:eq(1)").prop("selected", true);
		} else if (val == "price") {
			$("#sort option:eq(2)").prop("selected", true);
		} else if (val == "sell") {
			$("#sort option:eq(3)").prop("selected", true);
		}
	});
</script>
<script>
	$(document).ready(function() {
		$('.slider').bxSlider({
			auto : true,
			pager : false
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
			sendMessage();
			$('#chat-input').val('');
		});
		$("#chat-input").keyup(function(e) {
			if (e.keyCode == 13) {
				sendMessage();
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
<style>
</style>
<title>FFunding - 펀딩하기</title>
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
<nav class="categorybox">
	<ul class="category">
		<c:choose>
			<c:when test="${category eq '테크 · 가전'}">
				<li class="bold"><a href="/ffunding/funding?category=테크 · 가전"><i class="bi bi-display"></i>테크 · 가전</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/ffunding/funding?category=테크 · 가전"><i class="bi bi-display"></i>테크 · 가전</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${category eq '패션 · 잡화'}">
				<li class="bold"><a href="/ffunding/funding?category=패션 · 잡화"><i class="bi bi-bucket"></i>패션 · 잡화</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/ffunding/funding?category=패션 · 잡화"><i class="bi bi-bucket"></i>패션 · 잡화</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${category eq '뷰티'}">
				<li class="bold"><a href="/ffunding/funding?category=뷰티"><i class="bi bi-droplet"></i>뷰티</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/ffunding/funding?category=뷰티"><i class="bi bi-droplet"></i>뷰티</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${category eq '푸드'}">
				<li class="bold"><a href="/ffunding/funding?category=푸드"><i class="bi bi-egg"></i>푸드</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/ffunding/funding?category=푸드"><i class="bi bi-egg"></i>푸드</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${category eq '홈 · 리빙'}">
				<li class="bold"><a href="/ffunding/funding?category=홈 · 리빙"><i class="bi bi-house"></i>홈 · 리빙</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/ffunding/funding?category=홈 · 리빙"><i class="bi bi-house"></i>홈 · 리빙</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${category eq '여행 · 레저'}">
				<li class="bold"><a href="/ffunding/funding?category=여행 · 레저"><i class="bi bi-tsunami"></i>여행 · 레저</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/ffunding/funding?category=여행 · 레저"><i class="bi bi-tsunami"></i>여행 · 레저</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${category eq '스포츠 · 모빌리티'}">
				<li class="bold"><a href="/ffunding/funding?category=여행 · 레저"><i class="bi bi-bicycle"></i>스포츠 · 모빌리티</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/ffunding/funding?category=스포츠 · 모빌리티"><i class="bi bi-bicycle"></i>스포츠 · 모빌리티</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${category eq '캐릭터 · 굿즈'}">
				<li class="bold"><a href="/ffunding/funding?category=여행 · 레저"><i class="bi bi-snapchat"></i>캐릭터 · 굿즈</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/ffunding/funding?category=캐릭터 · 굿즈"><i class="bi bi-snapchat"></i>캐릭터 · 굿즈</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${category eq '게임 · 취미'}">
				<li class="bold"><a href="/ffunding/funding?category=게임 · 취미"><i class="bi bi-controller"></i>게임 · 취미</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="/ffunding/funding?category=게임 · 취미"><i class="bi bi-controller"></i>게임 · 취미</a></li>
			</c:otherwise>
		</c:choose>
	</ul>
</nav>
<section>
	<div class="container" style="border-bottom: 1px solid #f0f2f5; padding: 15px 0px; display: flex; justify-content: end;">
		<form>
			<select class="form-select" id="sort" aria-label="Default select example" style="width: 115px;" onchange="if(this.value) location.href=(this.value);">
				<option value="" selected disabled hidden>정렬</option>
				<option value="/ffunding/funding?category=${category}&sort=fstartdate">최신순</option>
				<option value="/ffunding/funding?category=${category}&sort=price">펀딩액순</option>
				<option value="/ffunding/funding?category=${category}&sort=sell">인기순</option>
			</select>
		</form>
	</div>
	<div class="container funding-list">
		<div class="row row-cols-3" id="list">
			<c:forEach items="${list}" var="list" varStatus="vs">
				<div class="col a1">
					<div class="col a2">
						<a href="/ffunding/funding/detail?fid=${list.fid}"> <img alt="" class="divImg" src="${path}/fundingimage/${list.fimg}">
						</a>
					</div>
					<div class="col">
						<h5 class="title a3">
							<a href="/ffunding/funding/detail?fid=${list.fid}"> <c:out value="${list.fname}"></c:out>
							</a>
						</h5>
					</div>
					<div class="col a4">
						<span class="cate"><c:out value="${list.fcate}"></c:out></span>
					</div>
					<div class="col">
						<div class="progress a5">
							<div class="progress-bar" style="width: <c:out value="${list.goal}"></c:out>%" role="progressbar" aria-valuenow="<c:out value="${list.goal}"></c:out>" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
					</div>
					<div class="col">
						<div class="row justify-content-between">
							<div class="col">
								<span class="percent"><c:out value="${list.goal}"></c:out>%</span> <span class="cate"><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price}" />원</span>
							</div>
							<div class="col a6">
								<span class="cate"><c:out value="${list.remain}"></c:out>일 남음</span>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div style="display: flex; justify-content: center;">
		<ul>
			<c:if test="${pageMaker.prev}">
				<li><a href="funding${pageMaker.makeQuery(pageMaker.startPage - 1)}&category=${category}&sort=${sort}">이전</a></li>
			</c:if>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				<li><a href="funding${pageMaker.makeQuery(idx)}&category=${category}&sort=${sort}">${idx}</a></li>
			</c:forEach>

			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li><a href="funding${pageMaker.makeQuery(pageMaker.endPage + 1)}&category=${category}&sort=${sort}">다음</a></li>
			</c:if>
		</ul>
	</div>
</section>