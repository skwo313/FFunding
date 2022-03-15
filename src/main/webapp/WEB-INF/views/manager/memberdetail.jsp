<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/> 
<link href="${path}/css/memberdetail.css" rel="stylesheet">  
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 

                <!-- Begin Page Content -->
                <div class="container-fluid">
					
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Member Information</h6>
                        </div>
                        <div class="card-body">
		                    <!-- Page Heading -->
							<div class="textmark">
		                        <h1 class="h3 mb-0 text-gray-800">Modify Profile</h1>
		                    </div>
		                    <div class="modify">
		                    	<form id="frm" method="post">
			                    	<input type="hidden" name="adminck" value="0"/>
			                    	<div class="info">
			                         	<table class="modifytb">
											<tr>
												<th>ID</th>
												<td><input type="text" name="mid" value="${detail.mid}" readonly/></td>	 
											</tr>                           	
											<tr>
												<th>New Password</th>
												<td>
													<input type="hidden" name="mpw" value="${detail.mpw}"/>
													<input type="password" name="newpw" value=""/>
												</td>	 
											</tr>                           	
											<tr>
												<th>New Password Verification</th>
												<td><input type="password" name="newpwck" value=""/></td>	
											</tr>                           	
											<tr>
												<th>Name</th>
												<td><input type="text" name="mname" value="${detail.mname}"/></td>	 
											</tr>                           	
											<tr>
												<th>Phone</th>
												<td>
													<input type="text" name="phone1" value="" class="phone1"/> - 
													<input type="text" name="phone2" value="" class="phone2"/> - 
													<input type="text" name="phone3" value="" class="phone3"/>
													<input type="hidden" name="mphone" value="${detail.mphone}"/>
												</td>		 
											</tr>                           	
											<tr>
												<th>Email</th>
												<td>
													<input type="text" name="email1" value="" class="email1"/> @ 
													<input type="text" name="email2" value="" class="email2"/>
													<input type="hidden" name="memail" value="${detail.memail}"/>
												</td>		 
											</tr>                           	
											<tr>
												<th>Address</th>
												<td>
													<input type="text" name="maddress" id="address" value="${detail.maddress}" class="address1" placeholder="기본주소" readonly/><br/>
													<input type="text" name="maddress_detail" value="${detail.maddress_detail}" class="address" placeholder="상세주소"/>
												</td>		 
											</tr>                           	
											<tr>
												<th>Point</th>
												<td><input type="number" name="point" value="${detail.point}" class="point"/></td>	 
											</tr>                           	
											<tr>
												<th>Division</th>
												<td class="division">
													<label for="general">일반회원</label>
													<input type="radio" name="sellerck" id="general" value="0" ${detail.sellerck eq '0'.charAt(0)?'checked':''}/>
													<label for="seller">판매자</label>
													<input type="radio" name="sellerck" id="seller" value="1" ${detail.sellerck eq '1'.charAt(0)?'checked':''}/>
												</td>	 
											</tr>                           	
			                           	</table>
		                           	</div>
	                           	</form>
	                           	<div class="buttons">
				                	<button id="uptBtn" class="btn btn-secondary btn-sm">수정</button>
				                	<button id="backBtn" class="btn btn-primary btn-sm">목록</button>
	                           	</div>
		                    </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->
                
                <!-- Modal-->
				<div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
					    	<div class="modal-body">
					 			<div class="modal-title" id="exampleModalLongTitle"><span id="modalText"></span></div>
							</div>
							<div class="modal-footer" id="modal-footer">
					   	    	<button type="button" class="btn btn-primary btn-sm" id="upt">OK</button>
					    		<button type="button" class="btn btn-secondary btn-sm" id="close" data-dismiss="modal"></button>
					    	</div>
						</div>
					</div>
				</div>
                
<script type="text/javascript">
	//회원정보수정 유효성체크시, 공통부분
	let open = function() {
		$("#Modal").modal("show");
		$("#close").text("OK");
		$("#close").attr("class","btn btn-secondary btn-sm");
		$("#upt").hide();
	}
	
	//회원정보수정 완료시, 출력할 메시지
	let msg = "${param.msg}";
	if(msg!=null && msg!="") {
		open();
		$("#modalText").text(msg);
		$("#close").attr("class","btn btn-primary btn-sm");
	}
	
	//핸드폰번호 3칸으로 나누어 출력
	let phone = "${detail.mphone}";
	phone = phone.split("-");
	$("[name=phone1]").val(phone[0]);
	$("[name=phone2]").val(phone[1]);
	$("[name=phone3]").val(phone[2]);
	
	//이메일 2칸으로 나누어 출력
	let email = "${detail.memail}";
	email = email.split("@");
	$("[name=email1]").val(email[0]);
	$("[name=email2]").val(email[1]);

	//회원정보수정 유효성체크
	$(document).ready(function() {
		$("#uptBtn").click(function() {
			$("#Modal").modal("show");
			$("#modalText").text("Do you want to modify your membership information?");
			$("#upt").show();
			$("#close").text("Cancel");
			$("#close").attr("class","btn btn-secondary btn-sm");
			$("#upt").click(function() {
				if($("[name=mname]").val()==null || !($("[name=mname]").val())) {
					open();
					$("#modalText").text("Please check \"Name\" one more time.");
					$("[name=mname]").focus();
				} else if($("[name=phone1]").val()==null || !($("[name=phone1]").val()) || !($.isNumeric($("[name=phone1]").val())) || $("[name=phone2]").val()==null || !($("[name=phone2]").val()) || !($.isNumeric($("[name=phone2]").val())) || $("[name=phone3]").val()==null || !($("[name=phone3]").val()) || !($.isNumeric($("[name=phone3]").val()))) {
					open();
					$("#modalText").text("Please check \"Phone\" one more time.");
				} else if($("[name=point]").val()==null || !($("[name=point]").val()) || $("[name=point]").val()<0) {
					open();
					$("#modalText").text("Please check \"Point\" one more time.");
					$("[name=point]").val("${detail.point}");
				} else {
					//새비밀번호에 입력값이 있으면
					if($("[name=newpw]").val()!=null && $("[name=newpw]").val()!="") {
						//새비밀번호확인란에도 입력값이 있어야 한다.
						if($("[name=newpwck]").val()==null || !($("[name=newpwck]").val())) {
							open();
							$("#modalText").text("Please check \"New PassWord Verification\" one more time.");
							return false;
						//새비밀번호와 새비밀번호확인란의 입력값은 동일해야한다.
						} else if($("[name=newpw]").val()!=$("[name=newpwck]").val()) {
							open();
							$("#modalText").text("\"New Password\" and \"New Password verification\" do not match.");
							return false;
						}
						//위 과정을 모두 거치고 유효성체크에 이상이 없으면 현재비밀번호에 새비밀번호 값 넣기
						$("[name=mpw]").val($("[name=newpw]").val());
					} 
						//나누어 입력했던 핸드폰번호, 이메일 다시 합쳐 넘기기
						$("[name=mphone]").val($("[name=phone1]").val()+"-"+$("[name=phone2]").val()+"-"+$("[name=phone3]").val());
						$("[name=memail]").val($("[name=email1]").val()+"@"+$("[name=email2]").val());
						$("#frm").attr("action", "/ffunding/manager/member/detail/update");
						$("#frm").submit();
				}
			});
		});
		
		//목록 버튼 클릭시, 회원리스트 페이지로 이동
		$("#backBtn").click(function() {
			location.href="/ffunding/manager/member";
		});
		
		//기본주소 클릭시 다음 주소api 호출
		$("#address").click(function() {
			new daum.Postcode({
	            oncomplete: function(data) {
	            	//선택한 값의 기본주소 표시
	            	$("[name=maddress]").val(data.address);
	            	//기본주소 표시 후 상세주소로 포커스 이동
	            	$("[name=maddress_detail]").focus();
	            }
	        }).open();
		});
	});
</script>