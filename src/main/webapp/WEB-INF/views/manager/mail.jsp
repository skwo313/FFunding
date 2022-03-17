<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/> 
<link href="${path}/css/mail.css" rel="stylesheet">   
	
	<!-- Begin Page Content -->
	<div id="member" class="container-fluid">
	
	    <!-- Page Heading -->
	
	    <!-- DataTales Example -->
	    <div class="card shadow mb-4">
	        <div class="card-header py-3">
	            <h6 class="m-0 font-weight-bold text-primary">Mail Service</h6>
	        </div>
	        	<form method="post" class="mailFrm">
					<table class="mailtb">
						<tr>
							<th>Title</th>
							<td>
								<input type="text" name="title" class="form-control"/>
								<p class="warning" id="ttext">Please enter the title.</p>							
							</td>
						</tr>
						<tr>
							<th>Recipient</th>
							<td>
								<div class="recipient">
									<input type="text" id="recipient" name="recipient" class="form-control"/>
									<div>
										<label for="self" class="relabel">Self</label>
										<input type="radio" name="recipientck" id="self" class="reradio" value="0" checked/>
										<label for="all" class="relabel">All</label>
										<input type="radio" name="recipientck" id="all" class="reradio" value="1"/>
										<label for="seller" class="relabel">Seller</label>
										<input type="radio" name="recipientck" id="seller" class="reradio" value="2"/>
									</div>
								</div>
								<p class="warning" id="rtext"></p>	
								<p class="selftext">이메일을 여러개 입력할 경우 쉼표(,)로 구분하세요.</p>
							</td>
															
						</tr>
						<tr>
							<th>Content</th>
							<td>
								<textarea  name="content" rows="20" class="form-control" ></textarea>
								<p class="warning" id="ctext">Please enter the content.</p>	
							</td>									
						</tr>
					</table>
					<div class="sendBtn">
						<button id="send" class="btn btn-primary" type="button">Send</button>
					</div>
				</form>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- Modal-->
	<div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
		    	<div class="modal-body">
		 			<div class="modal-title" id="exampleModalLongTitle"><span id="modalText"></span></div>
				</div>
				<div class="modal-footer" id="modal-footer">
		    		<button type="button" class="btn btn-primary btn-sm" id="close" data-dismiss="modal">OK</button>
		    	</div>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
	$(document).ready(function(){
		//이메일 전송 완료시, 출력할 메시지
		if("${param.msg}"!=null && "${param.msg}"!="") {
			$("#Modal").modal("show");
			$("#modalText").html("${param.msg}");
		}
		
		//모두에게 또는 판매자에게만 전송시 input 입력값을 작성하지 못하고, 전송하지 못하도록 처리
		$("[name=recipientck]").click(function() {
			if($("[name=recipientck]:checked").val()!=0) {
				$("#recipient").attr("disabled", true);
				$(".selftext").hide();
				$("#rtext").hide();
			} else {
				$("#recipient").attr("disabled", false);
				$(".selftext").show();
			}
		});
		
		//유효성검사 실패시 공통부분
		let open = function() {
			$("#ttext").hide();
			$("#rtext").hide();
			$("#ctext").hide();
		}
		//초기에는 안보이게 설정
		open();
		
		//이메일 전송 유효성검사
		let sendCk = function(){
			//이메일 유효성검사를 위한 변수 설정
			const mailck = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
			
			//직접입력시, 여러 이메일을 입력했을때 구분
			let recipients = $("[name=recipient]").val().split(",", -1);

			if($("[name=title]").val()==null || !($("[name=title]").val())) {
				open();
				$("#ttext").show();
				$("[name=title]").focus();
				return false;
			} 
			if($("[name=recipientck]:checked").val()=='0') {
				if($("[name=recipient]").val()==null || !($("[name=recipient]").val())) {
					open();
					$("#rtext").text("Please enter the recipient.");
					$("#rtext").show();
					$("[name=recipient]").focus();
					return false;
				} else {
					for(let i=0; i<recipients.length; i++) {
						if(!(mailck.test(recipients[i].trim()))) {
							open();
							$("#rtext").text("Please check the recipient.");
							$("#rtext").show();
							$("[name=recipient]").focus();
							return false;
						}
					}
				}
			}
			if($("[name=content]").val()==null || !($("[name=content]").val())) {
				open();
				$("#ctext").show();
				$("[name=content]").focus();
				return false;
			}
			return true;
		}
		
		//유효성검사 성공시 submit
		$("#send").click(function() {
			let ck = sendCk();
			if(ck) {
				$(".mailFrm").attr("action", "/ffunding/manager/mail/send");
				$(".mailFrm").submit();
			}
		});

	});
</script>