<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/> 
<link href="${path}/css/manager/memberdetail.css" rel="stylesheet">  
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
									<span class="warning" id="pwtext">No spaces allowed.</span>
								</td>	 
							</tr>                           	
							<tr>
								<th>New Password Verification</th>
								<td>
									<input type="password" name="newpwck" value=""/>
									<span class="warning" id="pctext"></span>
								</td>
							</tr>                           	
							<tr>
								<th>Name</th>
								<td>
									<input type="text" name="mname" value="${detail.mname}"/>
									<span class="warning" id="ntext">Please enter your name and check the space.</span>
								</td>	 
							</tr>                           	
							<tr>
								<th>Phone</th>
								<td>
									<input type="text" name="phone1" value="" class="phone1"/> - 
									<input type="text" name="phone2" value="" class="phone2"/> - 
									<input type="text" name="phone3" value="" class="phone3"/>
									<input type="hidden" name="mphone" value="${detail.mphone}"/>
									<span class="warning" id="phtext">Please enter your mobile number and check the space.</span>
								</td>		 
							</tr>                           	
							<tr>
								<th>Email</th>
								<td>
									<input type="text" name="email1" value="" class="email1"/> @ 
									<input type="text" name="email2" value="" class="email2"/>
									<input type="hidden" name="memail" value="${detail.memail}"/>
									<p class="warningp" id="etext">Please fill in the form of an email and check the space.</p>
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
								<td>
									<input type="number" name="point" value="${detail.point}" class="point"/>
									<span class="warning" id="potext">Please enter the point.</span>
								</td>	 
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
	   	    	<button type="button" class="btn btn-primary btn-sm" id="move">Go ListPage</button>
	    		<button type="button" class="btn btn-secondary btn-sm" id="close" data-dismiss="modal">Go CurrentPage</button>
	    	</div>
		</div>
	</div>
	</div>
<script type="text/javascript">
	$(document).ready(function() {
		//회원정보수정 완료시, 출력할 메시지
		let msg = "${param.msg}";
		if(msg!=null && msg!="") {
			$("#Modal").modal("show");
			$("#modalText").text(msg);
			$("#move").click(function(){
				location.href="/ffunding/manager/member";
			});
		}
		
		//핸드폰번호 3칸으로 나누어 출력
		let phone = "${detail.mphone}";
		console.log("${detail.mphone}")
		phone = phone.split("-");
		$("[name=phone1]").val(phone[0]);
		$("[name=phone2]").val(phone[1]);
		$("[name=phone3]").val(phone[2]);
		
		//이메일 2칸으로 나누어 출력
		let email = "${detail.memail}";
		email = email.split("@");
		$("[name=email1]").val(email[0]);
		$("[name=email2]").val(email[1]);
	
		let noSpace = function(obj) {             
	      	var space = /\s/;
	        if(space.exec(obj.value)) {
	            obj = obj.replace(' ','');
	        }
	      }
		
		//유효성검사 실패시 공통부분
		let open = function() {
			$("#pwtext").hide();
			$("#pctext").hide();
			$("#ntext").hide();
			$("#phtext").hide();
			$("#etext").hide();
			$("#potext").hide();
		}
		//초기에는 안보이게 설정
		open();
		
		//회원정보수정 유효성체크
		let memberCk = function() {
			const mailck = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
			const spaceck = /\s/;
			
			if($("[name=mname]").val()==null || !($("[name=mname]").val()) || spaceck.exec($("[name=mname]").val())) {
				open();
				$("#ntext").show();
				$("[name=mname]").focus();
				return false;
			}
			if($("[name=phone1]").val()==null || !($("[name=phone1]").val()) || !($.isNumeric($("[name=phone1]").val())) || spaceck.exec($("[name=phone1]").val())) {
				open();
				$("#phtext").show();
				$("[name=phone1]").focus();
				return false;
			} else if($("[name=phone2]").val()==null || !($("[name=phone2]").val()) || !($.isNumeric($("[name=phone2]").val())) || spaceck.exec($("[name=phone2]").val())) {
				open();
				$("#phtext").show();
				$("[name=phone2]").focus();
				return false;
			} else if($("[name=phone3]").val()==null || !($("[name=phone3]").val()) || !($.isNumeric($("[name=phone3]").val())) || spaceck.exec($("[name=phone3]").val())) {
				open();
				$("#phtext").show();
				$("[name=phone3]").focus();
				return false;
			}
			if($("[name=email1]").val()!=null && $("[name=email1]").val()!="" || $("[name=email2]").val()!=null && $("[name=email2]").val()!="") {
				if(spaceck.exec($("[name=email1]").val())) {
					open();
					$("#etext").show();
					$("[name=email1]").focus();
					return false;
				} else if(!(mailck.test($("[name=email1]").val()+"@"+$("[name=email2]").val()))) {
					open();
					$("#etext").show();
					$("[name=email2]").focus();
					return false;
				}
			}
			if($("[name=point]").val()==null || !($("[name=point]").val()) || $("[name=point]").val()<0) {
				open();
				$("#potext").show();
				$("[name=point]").val("${detail.point}");
				$("[name=mname]").focus();
				return false;
			}
			//새비밀번호에 입력값이 존재할 경우
			if($("[name=newpw]").val()!=null && $("[name=newpw]").val()!="") {
				//비밀번호에 공백은 사용 불가능하다.
				if(spaceck.exec($("[name=newpw]").val())) {
					open();
					$("#pwtext").show();
					$("[name=newpw]").focus();
					return false;
				//새비밀번호확인란에도 입력값이 있어야 한다.
				} else if($("[name=newpwck]").val()==null || !($("[name=newpwck]").val())) {
					open();
					$("#pctext").text("Please enter the New Password Verification.");
					$("#pctext").show();
					$("[name=newpwck]").focus();
					return false;
				//새비밀번호와 새비밀번호확인란의 입력값은 동일해야한다.
				} else if($("[name=newpw]").val()!=$("[name=newpwck]").val()) {
					open();
					$("#pctext").text("New Password and New Password verification do not match.");
					$("#pctext").show();
					$("[name=newpwck]").focus();
					return false;
				}
				//위 과정을 모두 거치고 유효성체크에 이상이 없으면 현재비밀번호에 새비밀번호 값 넣기
				$("[name=mpw]").val($("[name=newpw]").val());
			}
			return true;
		}
			
		$("#uptBtn").click(function() {
			let ck = memberCk();
			if(ck) {
				//나누어 입력했던 핸드폰번호, 이메일 다시 합쳐 넘기기
				$("[name=mphone]").val($("[name=phone1]").val()+"-"+$("[name=phone2]").val()+"-"+$("[name=phone3]").val());
				if($("[name=email1]").val()==null || $("[name=email1]").val()=="" && $("[name=email2]").val()==null || $("[name=email2]").val()=="") {
					$("[name=memail]").val("");
				} else {
					$("[name=memail]").val($("[name=email1]").val()+"@"+$("[name=email2]").val());
				}
				
				$("#frm").attr("action", "/ffunding/manager/member/detail/update");
				$("#frm").submit();
			}
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