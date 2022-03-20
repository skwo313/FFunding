<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<link href="${path}/css/mail.css" rel="stylesheet">   
	
	<!-- Begin Page Content -->
	<div id="member" class="container-fluid">
	
	    <!-- Page Heading -->
	
	    <!-- DataTales Example -->
	    <div class="card shadow mb-4">
	        <div class="card-header py-3">
	            <h6 class="m-0 font-weight-bold text-primary">Mail Service</h6>
	        </div>
	        <form method="post" class="mailFrm" enctype="multipart/form-data">
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
					<tr>
						<th>File</th>
						<td>
							<div class="uploadFrm">
								<div class="uploadBox">
									Please select a file to upload!
								</div>
								<label for="upload" class="uploadBtn">Upload File</label>
								<input type="file" name="attach" id="upload" multiple/>
							</div>
							<p class="selftext">exe, sh, zip, alz, msi, gz, ppk 파일은 업로드할 수 없습니다.</p>
						</td>
					</tr>
				</table>
				<div class="sendBtn">
					<button id="send" type="button" class="btn btn-primary">Send</button>
				</div>
			</form>
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
	//첨부파일 배열
	let filesArr = new Array();
	//첨부파일 업로드시 화면에 표시할 배열
	let viewFiles = new Array();
	//파일을 선택적으로 삭제할 수 있도록 구분하기 위한 변수
	let fileNum = 0;
	
	//파일 선택삭제
	function delFile(cnt) {
		//선택한 파일을 삭제 후 다시 처음부터 배치하기 위해 fileNum 초기화
		fileNum = 0;
		//선택한 파일을 filesArr 배열에서 삭제처리
		filesArr.splice(cnt, 1);
		//배열형식의 파일을 files형식으로 다시 바꿔줄 수 있는 DataTransfer() 선언
		let dataTransfer = new DataTransfer();
		//선택한 파일을 삭제 후 fileNum을 재배치하여 view단에 보여주기 위하여 viewFiles 초기화
		viewFiles.splice(0);
		//선택한 파일을 삭제한 후에도 files에 파일이 남아있는 경우  
		if(filesArr.length!=0) {
			filesArr.forEach(function(f) {
				//view단에 보여줄 수 있도록 추가
				viewFiles.push("<span class='fileName'>" + f.name + "<i class='bi bi-x' onclick='delFile(" + fileNum + ")'></i></span>");
				//배열형식의 파일목록을 DataTransfer로 저장
				dataTransfer.items.add(f);
				fileNum++;
			});
			$(".uploadBox").html(viewFiles);
		//선택한 파일을 삭제한 후 files에 남아있는 파일이 없을경우
		} else {
			$(".uploadBox").text("Please select a file to upload!");
		}
		//DataTransfer에 저장된 파일들을 files에 저장
		$("#upload")[0].files = dataTransfer.files;
	}
	
	$(document).ready(function(){
		//첨부파일 업로드
		//첨부파일 업로드 후, 재업로드할 경우 이전 첨부했던 첨부파일 내용이 지워지 않고 유지된 상태로 추가
		$("#upload").on("change", function() {
			//업로드할 수 없는 확장자 선언
			const regex = /(.*?\.(exe|sh|zip|alz|msi|gz|ppk)$)/;
			
			//배열형식의 파일을 files형식으로 다시 바꿔줄 수 있는 DataTransfer() 선언
			let dataTransfer = new DataTransfer();
			
			//이미 업로드되어있던 파일을 DataTransfer에 먼저 넣음
			filesArr.forEach(function(f) {
				dataTransfer.items.add(f);
			})
			
			//방금 업로드한 파일 목록을 배열로 받음
			let fileArr = Array.from($("#upload")[0].files);
			
			fileArr.forEach(function(f) {
				//확장자 체크해서 업로드할 수 있는 확장자일 경우
				if(!(regex.test(f.name))) {
					//업로드한 파일 목록을 view단에 보여줄 수 있도록 추가
					viewFiles.push("<span class='fileName'>" + f.name + "<i class='bi bi-x' onclick='delFile(" + fileNum + ")'></i></span>");
					//배열형식의 파일목록을 DataTransfer로 저장
					dataTransfer.items.add(f);
					//재업로드시 이전 첨부파일 목록을 유지하면서 추가할 수 있도록 선언된 전역변수에 push
					filesArr.push(f);
					fileNum++;
				}
			});
			//만약 업로드했던 파일이 확장자에 맞지않아 업로드되지 않았고, 그 외에 업로드된 파일이 없을 경우
			if(filesArr.length!=0) {
				$(".uploadBox").html(viewFiles);
			//확장자에 맞지 않아 업로드되지 않았던 파일이 있지만, 그 외에 업로드된 파일이 있거나 모두 정상적으로 업로드 된 경우
			} else {
				$(".uploadBox").text("Please select a file to upload!");
			}
			//모두 업로드되어 DataTransfer에 저장된 파일들을 files에 저장
			$("#upload")[0].files = dataTransfer.files;
		});
		
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