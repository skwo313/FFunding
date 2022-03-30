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
				<h6 class="m-0 font-weight-bold text-primary">Funding Information</h6>
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
				<div class="modal-body">
					<form id="frm" class="form"  method="post">
						<input type="hidden" name="id" value="0"/>
						<div class="row">
							<span>Title</span>
							<input type="text" class="form-control" placeholder="Subject input" name="title">
						</div>
						<div class="row">
							<span>Start Date</span>
							<input type="text" class="form-control" name="start" placeholder="YYYY-MM-DD" id="datepicker"/>
						</div>
						<div class="row">
							<span>End Date</span>
							<input type="text" class="form-control" name="end" placeholder="YYYY-MM-DD" id="datepicker2"/>
						</div>
						<div class="colorFrm row">
							<div>
							<span class="colorT">Background Color</span>
							<input type="color" class="color form-control" value="#0099cc" name="backgroundColor" >
							</div>
							<div>
							<span class="colorT">Text Color</span>
							<input type="color" class="color form-control" value="#000000" name="textColor">
							</div>
						</div>
						<div class="row">
						</div>
					</form> 
				</div>
				<div class="modal-footer">
					<button type="button" id="regBtn" class="calBtn btn btn-primary">Register</button>
					<button type="button" id="uptBtn" class="calBtn btn btn-info">Update</button>
					<button type="button" id="delBtn" class="calBtn btn btn-danger">Delete</button>
					<button type="button" class="calBtn btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults({
			//달력 날짜 형태
            dateFormat: 'yy-mm-dd'
        });
		
		$("#datepicker").datepicker();
		$("#datepicker2").datepicker();
		
	    $('#datepicker').datepicker('setDate', 'today');
	});
	
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
	
	    var calendar = new FullCalendar.Calendar(calendarEl, {
			editable: true,
			selectable: true,
			businessHours: true,
			dayMaxEvents: true, // allow "more" link when too many events
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
		      	$("[name=end]").val(arg.end.getFullYear()+"-"+((arg.end.getMonth()+1)<10?"0"+(arg.end.getMonth()+1):(arg.end.getMonth()+1))+"-"+((arg.end.getDate()-1)<10?"0"+(arg.end.getDate()-1):(arg.end.getDate()-1)));
		          calendar.unselect()
			},
			eventClick: function(arg) {
		      	console.log(arg.event)
		      	formData(arg.event)
		      	$("#exampleModalLongTitle").text("Schedule Details");
		      	$("#regBtn").hide();
		      	$("#uptBtn").show();
		      	$("#delBtn").show();
		      	$("#Modal").modal("show");
			},
			events: [
		       
			]
		});
	    calendar.render();
	});
</script>