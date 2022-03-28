<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/> 
<link href="${path}/css/manager/fundingApproval.css" rel="stylesheet">   
	
	 <!-- Begin Page Content -->
	 <div class="container-fluid">
	
	     <!-- Page Heading -->
	
	     <!-- DataTales Example -->
	     <div class="card shadow mb-4">
	         <div class="card-header py-3">
	             <h6 class="m-0 font-weight-bold text-primary">Funding Approval List</h6>
	         </div>
	         <div class="card-body">
	             <div class="table-responsive">
	                <div class="row">
	                    <form id="frm" class="form-inline mr-auto w-100 navbar-search">
	                    	<input type="hidden" name="curPage" value="1"/>
	                    	<div class="sortFrm">
	                            <div id="sort">
	                            	<select name="sort" class="form-control bg-light small">
	                            		<option value="new">최신순</option>
	                            		<option value="old">오래된순</option>
	                            		<option value="close">마감일순</option>
	                            	</select>
	                            </div>
	                        </div>
	                        <div class="pageFrm">
	                        	<span>Showing ${applyPagingVO.start} to ${applyPagingVO.end} of ${applyPagingVO.count} entries</span>
	                            <select name="pageSize" id="pageSize" class="form-control bg-light small">
	                            	<option value="20">20개 보기</option>
	                            	<option value="40">40개 보기</option>
	                            	<option value="60">60개 보기</option>
	                            	<option value="80">80개 보기</option>
	                            	<option value="100">100개 보기</option>
	                            </select>
	                        </div>
	                    </form>
	                </div>
	             	<table class="table table-bordered" id="dataTable">
	                     <thead>
	                         <tr>
	                             <th>No</th>
	                             <th>Category</th>
	                             <th>Name</th>
	                             <th>Price</th>
	                             <th>Target Price</th>
	                             <th>Registration Date</th>
	                             <th>Start Date</th>
	                         </tr>
	                     </thead>
	                     <tbody>
	                     	<c:forEach var="apply" items="${applyList}">
		                         <tr class="applyrow">
		                             <td>${apply.fid}</td>
		                             <td>${apply.fcate}</td>
		                             <td class="fname">${apply.fname}</td>
		                             <td>&#8361;<fmt:formatNumber value="${apply.fprice}" pattern="#,###"/></td>
		                             <td>&#8361;<fmt:formatNumber value="${apply.fgoal}" pattern="#,###"/></td>
		                             <td>${apply.fdate}</td>
		                             <td>${apply.fstartdate}</td>
		                         </tr>
	                         </c:forEach>
	                     </tbody>
	                </table>
					<div class="paging">
	                	<ul class="pagination">
							<c:if test="${applyPagingVO.startBlock!=1}">
								<li class="page-item"><a class="page-link" href="javascript:changePage(${applyPagingVO.startBlock-1})">Previous</a></li>
							</c:if>
							<c:forEach var="paging" begin="${applyPagingVO.startBlock}" end="${applyPagingVO.endBlock}">
								<li class="page-item ${paging==applyPagingVO.curPage?'active':''}">
							  		<a class="page-link" href="javascript:changePage(${paging})">${paging}</a>
							  	</li>
							</c:forEach>
							<c:if test="${applyPagingVO.endBlock!=applyPagingVO.pageCount}">
								<li class="page-item"><a class="page-link" href="javascript:changePage(${applyPagingVO.endBlock+1})">Next</a></li>
							</c:if>
						</ul>
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
		    		<button type="button" class="btn btn-primary btn-sm" id="close" data-dismiss="modal">OK</button>
		    	</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	//펀딩삭제 완료시 메시지
	let delmsg = "${param.delmsg}";
	if(delmsg!=null && delmsg!="") {
		$("#Modal").modal("show");
		$("#modalText").text(delmsg);
	}

	//펀딩승인 완료시 메시지
	let insmsg = "${param.insmsg}";
	if(insmsg!=null && insmsg!="") {
		$("#Modal").modal("show");
		$("#modalText").text(insmsg);
	}
	
	//한페이지에 보여질 게시물수 변경
	$("[name=pageSize]").val("${applyPagingVO.pageSize}");
	$("[name=pageSize]").change(function() {
		$("#frm").submit();
	});
	
	//정렬기준 변경
	$("[name=sort]").val("${applyPagingVO.sort}");
	$("[name=sort]").change(function() {
		$("#frm").submit();
	});
	
	//페이지 이동
	function changePage(no) {
		$("[name=curPage]").val(no);
		$("#frm").submit();
	}
	
	//펀딩신청 게시물 상세정보로 이동
	$(".applyrow").click(function(){
		let fid = $(this).children().eq(0).text();
		location.href="/ffunding/manager/fundingApproval/detail?fid="+fid;
	});
</script>