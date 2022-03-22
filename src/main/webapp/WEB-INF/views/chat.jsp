<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="${path}/css/chat.css" rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

<button class="chatbox-open">
	<i class="fa fa-comment fa-2x"></i>
</button>
<div class="chat-box" style="dispaly: none;">
	<div class="chat-box-header">
		<span>고객 센터</span>
		<button class="chatbox-close">
			<i class="fa fa-window-close-o" aria-hidden="true" id="chat-close"></i>
		</button>
	</div>

	<div class="chat-box-body">
		<div class="chat-box-overlay"></div>
		<div class="chat-logs"></div>
	</div>
	<div class="chat-input">
		<input type="text" id="chat-input" placeholder="Send a message..." />
		<button type="submit" class="chat-submit" id="chat-submit">
			<i class="material-icons">send</i>
		</button>
	</div>
</div>





<script type="text/javascript">
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
	sock.onclose

});
$("#chat-submit").click(function() {

	sendMessage();
	$('#chat-input').val('');
});
$("#chat-input").keyup(function() {
	if (event.keyCode == 13) sendMessage();
});
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

}
// 서버와 연결을 끊었을 때
function onClose(e) {
	$(".chat-logs").append("${member.mid}님연결 끊김");
}

</script>