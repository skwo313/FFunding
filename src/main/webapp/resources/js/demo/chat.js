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
