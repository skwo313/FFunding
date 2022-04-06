<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/>     
	
	<!-- Begin Page Content -->
	<div class="container-fluid">
	
	    <!-- Page Heading -->
	
	    <!-- Content Row -->
	    <div class="row">
	
	        <!-- Earnings (Monthly) Card Example -->
	        <div class="col-xl-3 col-md-6 mb-4">
	            <div class="card border-left-primary shadow h-100 py-2">
	                <div class="card-body">
	                    <div class="row no-gutters align-items-center">
	                        <div class="col mr-2">
	                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
	                                Member Total</div>
	                            <div class="h5 mb-0 font-weight-bold text-gray-800">${userCnt}명</div>
	                        </div>
	                        <div class="col-auto">
	                            <i class="bi bi-people-fill fa-2x text-gray-300"></i>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	
	        <!-- Earnings (Monthly) Card Example -->
	        <div class="col-xl-3 col-md-6 mb-4">
	            <div class="card border-left-success shadow h-100 py-2">
	                <div class="card-body">
	                    <div class="row no-gutters align-items-center">
	                        <div class="col mr-2">
	                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
	                                Waiting for Funding</div>
	                            <div class="h5 mb-0 font-weight-bold text-gray-800">${applyCnt}개</div>
	                        </div>
	                        <div class="col-auto">
	                            <i class="bi bi-patch-question-fill fa-2x text-gray-300"></i>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	
	        <!-- Earnings (Monthly) Card Example -->
	        <div class="col-xl-3 col-md-6 mb-4">
	            <div class="card border-left-info shadow h-100 py-2">
	                <div class="card-body">
	                    <div class="row no-gutters align-items-center">
	                        <div class="col mr-2">
	                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
	                           		Funding Schedule</div>
	                            <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${expectCnt}개</div>
	                        </div>
	                        <div class="col-auto">
	                            <i class="bi bi-patch-exclamation-fill fa-2x text-gray-300"></i>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	
	        <!-- Pending Requests Card Example -->
	        <div class="col-xl-3 col-md-6 mb-4">
	            <div class="card border-left-warning shadow h-100 py-2">
	                <div class="card-body">
	                    <div class="row no-gutters align-items-center">
	                        <div class="col mr-2">
	                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
	                                Funding Progress</div>
	                            <div class="h5 mb-0 font-weight-bold text-gray-800">${progressCnt}개</div>
	                        </div>
	                        <div class="col-auto">
	                            <i class="bi bi-patch-check-fill fa-2x text-gray-300"></i>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	
	    <!-- Content Row -->
	
	    <!-- Area Chart -->
	    <div class="nopadding col-xl-12 col-lg-4">
	        <div class="card shadow mb-4">
	            <!-- Card Header - Dropdown -->
	            <div
	                class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                <h6 class="m-0 font-weight-bold text-primary">Visitor</h6>
	            </div>
	            <!-- Card Body -->
	            <div class="card-body">
	                <div class="chart-area">
	                    <canvas id="myAreaChart2"></canvas>
	                </div>
	            </div>
	        </div>
	    </div>
	    
	    <div class="row">
	   		<!-- Bar Chart -->
	    	<div class="col-xl-8 col-lg-4">
	            <div class="card shadow mb-4">
	                <div class="card-header py-3">
	                    <h6 class="m-0 font-weight-bold text-primary">Funding Category</h6>
	                </div>
	                <div class="card-body">
	                    <div class="chart-bar">
	                        <canvas id="myBarChart"></canvas>
	                    </div>
	                </div>
	            </div>
	        </div>
	    
	    	<!-- Area Chart -->
		    <div class="col-xl-4 col-lg-4">
		        <div class="card shadow mb-4">
		            <!-- Card Header - Dropdown -->
		            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Member</h6>
                    </div>
                    <!-- Card Body -->
                    <div class="card-body">
                        <div class="chart-pie pt-4 pb-2">
                            <canvas id="myPieChart"></canvas>
                        </div>
                        <div class="mt-4 text-center small">
                            <span class="mr-2">
                                <i class="fas fa-circle text-primary"></i> General
                            </span>
                            <span class="mr-2">
                                <i class="fas fa-circle text-success"></i> Seller
                            </span>
                        </div>
                    </div>
		        </div>
		    </div>
		</div>
	<!-- /.container-fluid -->
 	</div>
	<!-- 채팅 -->
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
$(document).ready(function() {
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
		var mx = parseInt($(".chat-logs").height())
		
		$(".chat-logs").scrollTop(mx);
	}
	// handler의 afterConnectionClose와 연동
	wsocket.onclose=function(){
		wsocket.send("${member.mid}님 연결끊김");
	}
	
}
</script>
    <!-- Page level plugins -->
    <script src="${path}/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->

    <script src="${path}/js/demo/chart-area-demo2.js"></script>
    <script src="${path}/js/demo/chart-pie-demo.js"></script>
    <script src="${path}/js/demo/chart-bar-demo.js"></script>