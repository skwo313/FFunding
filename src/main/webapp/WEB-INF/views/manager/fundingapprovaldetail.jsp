<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/> 
<link href="${path}/css/manager/fundingapprovaldetail.css" rel="stylesheet">  
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
	<!-- Begin Page Content -->
	<div class="container-fluid">
	
	   <!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">Funding Information</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
		           <!-- Page Heading -->
					<div class="textmark">
			           	<h1 class="h3 mb-0 text-gray-800">Funding Application Form</h1>
					</div>
					<form id="frm" method="post">
						<table class="formtb">
							<tr>
								<th>ID</th>
								<td><input type="text" name="fid" value="${detail.fid}" class="formtd" readonly/></td>
								<th>Category</th>
								<td><input type="text" name="fcate" value="${detail.fcate}" class="formtd" readonly/></td>
								<th>Registration Date</th>
								<td><input type="text" name="fdate" value="${detail.fdate}" class="formtd" readonly/></td>
								<th>Writer</th>
								<td><input type="text" name="mid" value="${detail.writer}" class="formtd col" readonly/></td>
							</tr>
							<tr>
								<th>Name</th>
								<td colspan="7"><input type="text" name="fname" value="${detail.fname}" class="formtd" readonly/></td>
							</tr>
							<tr>
								<th>Price</th>
								<td><span class="won">&#8361;<input type="text" name="fprice" value="${detail.fprice}" class="formtd" readonly/></span></td>
								<th>Taget Price</th>
								<td><span class="won">&#8361;<input type="text" name="fgoal" value="${detail.fgoal}" class="formtd" readonly/></span></td>
								<th>Start Date</th>
								<td><input type="text" name="fstartdate" value="${detail.fstartdate}" class="formtd" readonly/></td>
								<th>End Date</th>
								<td><input type="text" name="fenddate" value="${detail.fenddate}" class="formtd" readonly/></td>
							</tr>
							<tr>
								<th>Description</th>
								<td colspan="7"><textarea class="formtd col" rows="15" name="fdes" readonly>${detail.fdes}</textarea></td>
							</tr>
							<tr>
								<th><p>Representative</p><p>Image</p></th>
								<td colspan="7">
									<c:if test="${detail.fimg[0] != null}">
										<p class="img"><img src="${path}/applyimage/${detail.fimg[0]}"/></p>
										<input type="hidden" name="fimg" value="${detail.fimg[0]}"/>
									</c:if>
								</td>
							</tr>
							<tr>
								<th><p>Detailed</p><p>Image</p></th>
								<td colspan="7">
									<c:if test="${detail.fimg != null}">
										<c:forEach var="i" begin="1" end="${fn:length(detail.fimg)}">
											<c:if test="${detail.fimg[i] != null}">
												<p class="img"><img src="${path}/applyimage/${detail.fimg[i]}"/></p>
												<input type="hidden" name="fimg${i}" value="${detail.fimg[i]}"/>
											</c:if>
										</c:forEach>
									</c:if>
								</td>
							</tr>
						</table>
					</form>
		            <div class="buttons">
		            	<button id="insBtn" class="btn btn-primary btn-sm">승인</button>
		               	<button id="delBtn" class="btn btn-secondary btn-sm">삭제</button>
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
		   	    	<button type="button" class="btn btn-primary btn-sm" id="yes">Yes</button>
		    		<button type="button" class="btn btn-secondary btn-sm" id="close" data-dismiss="modal">No</button>
		    	</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	$(document).ready(function() {
		//천단위콤마
		$("[name=fprice]").val($("[name=fprice]").val().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$("[name=fgoal]").val($("[name=fgoal]").val().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		
		$("#delBtn").click(function() {
			$("#Modal").modal("show");
			$("#modalText").text("Are you sure you want to delete it?");
			$("#yes").click(function() {
				$("#frm").attr("action", "/ffunding/manager/fundingapproval/detail/delete");
				$("#frm").submit();
			})
		});
	});
</script>