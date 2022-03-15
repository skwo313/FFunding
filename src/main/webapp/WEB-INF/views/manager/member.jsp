<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/> 
<link href="${path}/css/member.css" rel="stylesheet">   

                <!-- Begin Page Content -->
                <div id="member" class="container-fluid">

                    <!-- Page Heading -->

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Member DataTables</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
	                            <div class="row">
		                            <form id="frm" method="post" class="form-inline mr-auto w-100 navbar-search">
		                            	<input type="hidden" name="curPage" value="1"/>
		                            	<div class="col-sm-12 col-md-6">
			                                <div id="search" class="input-group">
			                                	<select id="type" name="type" class="form-control bg-light border-0 small">
			                                		<option value="id">아이디</option>
			                                		<option value="name">이름</option>
			                                	</select>
			                                    <input type="text" name="searchtext" value="${MMemberPagingVO.searchtext}" class="form-control bg-light border-0 small" placeholder="Search for">
			                                    <div class="input-group-append">
			                                        <button class="btn btn-primary" type="submit">
			                                            <i class="fas fa-search fa-sm"></i>
			                                        </button>
			                                    </div>
			                                </div>
		                                </div>
		                                <div class="col-sm-12 col-md-6" id="pagepick">
		                                	<span>Showing ${MMemberPagingVO.start} to ${MMemberPagingVO.end} of ${MMemberPagingVO.count} entries</span>
			                                <select name="pageSize" class="form-control bg-light small">
			                                	<option value="20">20개 보기</option>
			                                	<option value="40">40개 보기</option>
			                                	<option value="60">60개 보기</option>
			                                	<option value="80">80개 보기</option>
			                                	<option value="100">100개 보기</option>
			                                </select>
		                                </div>
		                            </form>
	                            </div>
                            	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Phone</th>
                                            <th>Email</th>
                                            <th>Address</th>
                                            <th>Point</th>
                                            <th>Division</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="member" items="${memberList}">
                                        <tr class="memberrow">
                                            <td>${member.mid}</td>
                                            <td>${member.mname}</td>
                                            <td>${member.mphone}</td>
                                            <td>${member.memail}</td>
                                            <td class="addr">${member.maddress} ${member.maddress_detail}</td>
                                            <td><fmt:formatNumber value="${member.point}" pattern="#,###"/></td>
                                            <td>
                                            	<c:choose>
                                            		<c:when test="${member.sellerck eq '1'.charAt(0)}">판매자</c:when>
                                            		<c:otherwise>일반회원</c:otherwise>
                                            	</c:choose>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="paging">
	                                <ul class="pagination">
									  <c:if test="${MMemberPagingVO.startBlock!=1}">
										  <li class="page-item"><a class="page-link" href="javascript:changePage(${MMemberPagingVO.startBlock-1})">Previous</a></li>
									  </c:if>
									  <c:forEach var="paging" begin="${MMemberPagingVO.startBlock}" end="${MMemberPagingVO.endBlock}">
									  	<li class="page-item ${paging==MMemberPagingVO.curPage?'active':''}">
									  		<a class="page-link" href="javascript:changePage(${paging})">${paging}</a>
									  	</li>
									  </c:forEach>
									  <c:if test="${MMemberPagingVO.endBlock!=MMemberPagingVO.pageCount}">
										  <li class="page-item"><a class="page-link" href="javascript:changePage(${MMemberPagingVO.endBlock+1})">Next</a></li>
									  </c:if>
									</ul>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->
                
<script type="text/javascript">
	//한페이지에 보여질 게시물수 변경
	var pageSize="${MMemberPagingVO.pageSize}";
	$("[name=pageSize]").val(pageSize);
	$("[name=pageSize]").change(function() {
		console.log($("[name=pageSize]").val());
		$("#frm").submit();
	});
	
	//페이지 이동
	function changePage(no) {
		$("[name=curPage]").val(no);
		$("#frm").submit();
	}
	
	//회원 상세정보 이동
	$(".memberrow").click(function(){
		var mid = $(this).children().eq(0).text();
		location.href="/ffunding/manager/member/detail?mid="+mid;
	});
</script>