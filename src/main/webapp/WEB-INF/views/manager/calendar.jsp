<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/> 
<link href="${path}/css/manager/calendar.css" rel="stylesheet"> 
<link href='${path}/css/manager/main.css' rel='stylesheet' />
<link href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" >
<script src='${path}/js/main.js'></script> 
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 
	<!-- Begin Page Content -->
	<div class="container-fluid">
	
	   <!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">Schedule Management</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					  <div id='calendar'></div>
				</div>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->
	
	<!-- Modal-->
	<div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle">Schedule Registration</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="pad modal-body">
					<form id="frm" class="form"  method="post">
						<input type="hidden" name="id" value="0"/>
						<input type="hidden" name="borderColor" value="#66CDAA"/>
						<div class="row">
							<span>Title</span>
							<input type="text" class="form-control" placeholder="Subject input" name="title">
							<span id="titleT" class="warning">Please enter the contents.</span>
						</div>
						<div class="row">
							<span>Start Date</span>
							<input type="text" class="form-control" name="start" id="start"/>
							<span id="startT" class="warning">Please type in the format 'YYYY-MM-DD'.</span>
						</div>
						<div class="row">
							<span>End Date</span>
							<input type="text" class="form-control" name="endView" id="end"/>
							<input type="hidden" name="end"/>
							<span id="endT" class="warning"></span>
						</div>
						<div class="colorFrm row">
							<div>
							<span class="colorT">Background Color</span>
							<input type="color" class="color form-control" value="#66CDAA" name="backgroundColor">
							</div>
							<div>
							<span class="colorT">Text Color</span>
							<input type="color" class="color form-control" value="#FFFFFF" name="textColor">
							</div>
						</div>
						<div class="row">
						</div>
					</form> 
				</div>
				<div class="modal-footer">
					<button type="button" id="regBtn" class="fontsz btn btn-primary">Register</button>
					<button type="button" id="uptBtn" class="fontsz btn btn-primary">Update</button>
					<button type="button" id="delBtn" class="fontsz btn btn-primary">Delete</button>
					<button type="button" class="fontsz btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal-->
	<div class="modal fade" id="Modal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
		    	<div class="modal-body">
		 			<div class="modal-title" id="exampleModalLongTitle2"><span id="modalText" class="fontsz"></span></div>
				</div>
				<div class="modal-footer" id="modal-footer2">
		   	    	<button type="button" class="fontsz btn btn-primary btn-sm" id="yes">Yes</button>
		    		<button type="button" class="fontsz btn btn-secondary btn-sm" id="close" data-dismiss="modal">No</button>
		    	</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	$(function() {
		//datepicker 공통부분
		$.datepicker.setDefaults({
			//달력 날짜 형태
            dateFormat: 'yy-mm-dd'
        });
		
		//datepicker 선언
		$("#start").datepicker();
		$("#end").datepicker();
		
		//Modal 켜질 때 초기 start데이터에 따라 end데이터 선택 범위 지정
		$("#Modal").on("shown.bs.modal", function() {
			$("#end").datepicker("option", "minDate", $("[name=start]").val());
		});
		
		//start데이터 변경시 end데이터 선택 범위 변경
		$("#start").change(function() {
			console.log($("[name=start]").val())
			$("#end").datepicker("option", "minDate", $("[name=start]").val());
		});
		//datepicker 초기값 설정
	    //$('#datepicker').datepicker('setDate', 'today');
	});
	
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
	
	    var calendar = new FullCalendar.Calendar(calendarEl, {
			editable: true,
			selectable: true,
			businessHours: true,
			dayMaxEvents: true, // allow "more" link when too many events
			//캘린더 빈공간 클릭시 이벤트 등록창 열기
			select: function(arg) {
		      	$("#exampleModalLongTitle").text("Schedule Registration");
		      	$("#regBtn").show();
		      	$("#uptBtn").hide();
		      	$("#delBtn").hide();
		      	//상세데이터 확인 후, 다시 등록할 때 초기화
		      	$("#frm")[0].reset();
		      	$("#Modal").modal("show");
		      	//클릭시, 가져온 속성값 로딩
		      	$("[name=start]").val(arg.start.getFullYear()+"-"+((arg.start.getMonth()+1)<10?"0"+(arg.start.getMonth()+1):(arg.start.getMonth()+1))+"-"+(arg.start.getDate()<10?"0"+arg.start.getDate():arg.start.getDate()));
		      	$("[name=end]").val(arg.end.getFullYear()+"-"+((arg.end.getMonth()+1)<10?"0"+(arg.end.getMonth()+1):(arg.end.getMonth()+1))+"-"+(arg.end.getDate()<10?"0"+arg.end.getDate():arg.end.getDate()));
		      	//fullcalendar에서는 예를들어, end의 데이터로 24일 선택시 25일로 표기됨
		      	//25일 00:00:00으로 설정되어 있는데, 데이터 등록시 캘린더에는 25일 00:00:00 이전인 24일까지 표시
		      	//즉, 캘린더에는 제대로 반영되지만 데이터 등록시 혼동을 줄 수 있으므로 데이터 등록시에는 getMinutes()-1을 통해 24일 23:59:00을 만들어주고, getDate()로 '일'만 추출하여 표시
		      	arg.end.setMinutes(arg.end.getMinutes()-1);
		      	$("[name=endView]").val(arg.end.getFullYear()+"-"+((arg.end.getMonth()+1)<10?"0"+(arg.end.getMonth()+1):(arg.end.getMonth()+1))+"-"+(arg.end.getDate()<10?"0"+arg.end.getDate():arg.end.getDate()));
		        
		      	$("#end").change(function() {
		      		let date = arg.end;
		      		//datepicker에서 년, 월, 일 추출
		      		let year = $("[name=endView]").val().substr(0,4);
		      		let month = $("[name=endView]").val().substr(5,2);
		      		let day = $("[name=endView]").val().substr(8,2);
		      		//date에 선택한 년, 월, 일 삽입
		      		date.setFullYear(year);
		      		date.setMonth(month-1);
		      		//'일'은 선택한 날짜보다 +1일이어야 캘린더에 선택한 날짜만큼 표시해줄수 있으므로, +1일을 더해줌
		      		date.setDate(Number(day)+1);
		      		$("[name=end]").val(date.getFullYear()+"-"+((date.getMonth()+1)<10?"0"+(date.getMonth()+1):(date.getMonth()+1))+"-"+(date.getDate()<10?"0"+date.getDate():date.getDate()));
		      	});
		      	calendar.unselect()
			},
			//이벤트 클릭시 설정한 이벤트 보기
			eventClick: function(arg) {
		      	formData(arg.event)
		      	$("#exampleModalLongTitle").text("Schedule Details");
		      	$("#regBtn").hide();
		      	$("#uptBtn").show();
		      	$("#delBtn").show();
		      	$("#Modal").modal("show");
			},
			//이벤트 옮길시 날짜 변경
		    eventDrop:function(info){
		    	formData(info.event);
				$("#frm").attr("action","/ffunding/manager/calendar/update");
		    	$("#frm").submit();
		    },
		    //이벤트 크기 조절시 날짜 변경
		    eventResize:function(info){
		    	formData(info.event);
				$("#frm").attr("action","/ffunding/manager/calendar/update");
		    	$("#frm").submit();
		    },
		    //ajax로 json데이터를 받아와 달력에 표시
		    events: function(info, successCallback, failureCallback) {
		    	$.ajax({
		    		type:"post",
		    		url:"/ffunding/manager/calendar/list",
		    		dataType:"json",
		    		success:function(data) {
		    			successCallback(data.calendarList);
		    		},
		    		error:function(err) {
		    			failureCallback(err);
		    		}
		    	});
		      }
		});
	    calendar.render();
	});
	//이벤트 상세정보 및 변경시 공통부분
	function formData(event) {
    	$("[name=id]").val(event.id)
    	$("[name=title]").val(event.title)
    	$("[name=start]").val(event.start.getFullYear()+"-"+((event.start.getMonth()+1)<10?"0"+(event.start.getMonth()+1):(event.start.getMonth()+1))+"-"+(event.start.getDate()<10?"0"+event.start.getDate():event.start.getDate()));
    	$("[name=end]").val(event.end.getFullYear()+"-"+((event.end.getMonth()+1)<10?"0"+(event.end.getMonth()+1):(event.end.getMonth()+1))+"-"+(event.end.getDate()<10?"0"+event.end.getDate():event.end.getDate()));
    	//'일'은 -1분 처리하여 선택했던 날짜를 표시
    	let date = event.end;
    	date.setMinutes(date.getMinutes()-1);
    	$("[name=endView]").val(date.getFullYear()+"-"+((date.getMonth()+1)<10?"0"+(date.getMonth()+1):(date.getMonth()+1))+"-"+(date.getDate()<10?"0"+date.getDate():date.getDate()));
    	$("[name=backgroundColor]").val(event.backgroundColor);
    	$("[name=textColor]").val(event.textColor);
	}
	
	$(document).ready(function() {
		//배경색상이 변하면 테두리 색상도 변경
		$("[name=backgroundColor]").change(function() {
			$("[name=borderColor]").val($("[name=backgroundColor]").val());
		});
		
		//유효성검사 실패시 공통부분
		let hideT = function() {
			$("#titleT").hide();
			$("#startT").hide();
			$("#endT").hide();
		}
		//초기에는 안보이게 설정
		hideT();
		
		//유효성검사
		let ck = function() {
			//날짜형식(YYYY-MM-DD) 정규식
			const dateck = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);

			if($("[name=title]").val()==null || $("[name=title]").val()=="") {
				hideT();
				$("#titleT").show();
				$("[name=title]").focus();
				return false;
			}
			//날짜형식인지 체크
			if(!(dateck.test($("[name=start]").val()))) {
				hideT();
				$("#startT").show();
				$("[name=start]").focus();
				return false;
			}
			if(!(dateck.test($("[name=endView]").val()))) {
				hideT();
				$("#endT").text("Please type in the format 'YYYY-MM-DD'.").show();
				$("[name=endView]").focus();
				return false;
			}
			//종료날짜가 시작날짜보다 작은지 체크
			if($("[name=start").val()>$("[name=endView]").val()) {
				hideT();
				$("#endT").text("The end date must be equal to or greater than the start date.").show();
				$("[name=endView]").focus();
				return false;
			}
			hideT();
			return true;
		}
		
		//등록버튼 클릭시
		$("#regBtn").click(function() {
			if(ck()) {
				$("#Modal2").modal("show");
				$("#modalText").text("Would you like to register your schedule?");
				$("#yes").click(function() {
					$("#frm").attr("action", "/ffunding/manager/calendar/insert");
					$("#frm").submit();
				});
			}
		});
		
		//수정버튼 클릭시
		$("#uptBtn").click(function() {
			if(ck()) {
				$("#Modal2").modal("show");
				$("#modalText").text("Would you like to revise the schedule?");
				$("#yes").click(function() {
					$("#frm").attr("action", "/ffunding/manager/calendar/update");
					$("#frm").submit();
				});
			}
		});
		
		//삭제버튼 클릭시
		$("#delBtn").click(function() {
			$("#Modal2").modal("show");
			$("#modalText").text("Are you sure you want to delete the schedule?");
			$("#yes").click(function() {
				$("#frm").attr("action", "/ffunding/manager/calendar/delete");
				$("#frm").submit();
			});
		});
	});
</script>