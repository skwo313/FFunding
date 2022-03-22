<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/> 
<link href="${path}/css/manager/fundingapproval.css" rel="stylesheet">   
	
	 <!-- Begin Page Content -->
	 <div class="container-fluid">
	
	     <!-- Page Heading -->
	
	     <!-- DataTales Example -->
	     <div class="card shadow mb-4">
	         <div class="card-header py-3">
	             <h6 class="m-0 font-weight-bold text-primary">Member DataTables</h6>
	         </div>
	         <div class="card-body">
	             <div class="table-responsive">
	                <div class="row">
	                    <form class="form-inline mr-auto w-100 navbar-search">
	                    	<div class="col-sm-12 col-md-6">
	                            <div id="sort">
	                            	<select name="sort" class="form-control bg-light small">
	                            		<option value="new">최신순</option>
	                            		<option value="old">오래된순</option>
	                            		<option value="close">마감일순</option>
	                            	</select>
	                            </div>
	                        </div>
	                        <div class="col-sm-12 col-md-6">
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
	             	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	                     <thead>
	                         <tr>
	                             <th>No</th>
	                             <th>Category</th>
	                             <th>Name</th>
	                             <th>Price</th>
	                             <th>Registration Date</th>
	                             <th>Start Date</th>
	                             <th>Approval</th>
	                             <th>Refusal</th>
	                         </tr>
	                     </thead>
	                     <tbody>
	                         <tr>
	                             <td>1</td>
	                             <td>패션</td>
	                             <td class="fname">[남산반팔] 무난해 보여요? 땀나도 티 안 나는 초-기능성 티셔츠입니다</td>
	                             <td>149,000</td>
	                             <td>2022-03-12</td>
	                             <td>2022-03-28</td>
	                             <td><button name="addBtn" class="btn btn-primary">승인</button></td>
	                             <td><button name="delBtn" class="btn btn-secondary">거부</button></td>
	                         </tr>
	                     </tbody>
	                 </table>
	                 <div class="paging">
	                    <ul class="pagination">
						  <li class="page-item"><a class="page-link" href="#">Previous</a></li>
						  <li class="page-item"><a class="page-link" href="#">1</a></li>
						  <li class="page-item"><a class="page-link" href="#">2</a></li>
						  <li class="page-item"><a class="page-link" href="#">3</a></li>
						  <li class="page-item"><a class="page-link" href="#">Next</a></li>
						</ul>
	                 </div>
	             </div>
	         </div>
	     </div>
	
	 </div>
	 <!-- /.container-fluid -->