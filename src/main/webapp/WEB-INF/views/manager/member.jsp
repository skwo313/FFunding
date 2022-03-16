<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<fmt:requestEncoding value="utf-8"/> 
<link href="${path}/css/member.css" rel="stylesheet">   
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<template id="schTmp">
	<div class="row">
		<form id="frm" method="post" onsubmit="return false;" class="form-inline mr-auto w-100 navbar-search">
			<div class="col-sm-12 col-md-6">
				<div id="search" class="input-group">
				    <input type="hidden" v-model="paging.type"/>
					<select id="type" v-model="type" class="form-control bg-light border-0 small">
				    	<option value="id">아이디</option>
				       	<option value="name">이름</option>
				    </select>
				    <input type="text" v-model="searchtext" @keyup.enter="search" class="form-control bg-light border-0 small" placeholder="Search for">
				    <input type="hidden" v-model="paging.searchtext"/>
				    <div class="input-group-append">
				    	<button class="btn btn-primary" type="button" @click="search">
				    		<i class="fas fa-search fa-sm"></i>
				    	</button>
				    </div>
				 </div>
			 </div>
			 <div class="col-sm-12 col-md-6" id="pagepick">
			 	<span>Showing {{see.start}} to {{see.end}} of {{see.count}} entries</span>
				<select v-model="paging.pageSize" @change="searchSize" class="form-control bg-light small">
				   	<option value="20">20개 보기</option>
				    <option value="40">40개 보기</option>
				    <option value="60">60개 보기</option>
				    <option value="80">80개 보기</option>
				    <option value="100">100개 보기</option>
				</select>
			 </div>
		</form>
	</div>
</template>
<template id="listTmp">
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
        <tr v-for="member in mlist" class="memberrow">
            <td>{{member.mid}}</td>
            <td>{{member.mname}}</td>
            <td>{{member.mphone}}</td>
            <td>{{member.memail}}</td>
            <td class="addr">{{member.maddress}} {{member.maddress_detail}}</td>
            <td>{{member.point | filter}}</td>
            <td v-if="member.sellerck=='1'">판매자</td>
            <td v-else>일반회원</td>
        </tr>
    </tbody>
</table>
</template>
<template id="pageTmp">
	<div class="paging">
	    <ul class="pagination">
			<li class="page-item" v-if="page.startBlock!=1"><a class="page-link" @click="changePage(page.startBlock-1)">Previous</a></li>
	 	 	<li v-for="cnt in list()" :class="cnt==page.curPage?'page-item active':'page-item'">
	  			<a class="page-link" @click="changePage(cnt)">{{cnt}}</a>
	  		</li>
			<li class="page-item" v-if="page.endBlock!=page.pageCount"><a class="page-link" @click="changePage(page.endBlock+1)">Next</a></li>
		</ul>
	</div>
</template>
<script type="text/javascript">
	//이벤트버스 생성
	var eventBus = new Vue();
	
	//천단위 콤마
	Vue.filter("filter", function(value){
        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});
	
	Vue.component("sch-comp",{
		template:"#schTmp",
		data:function(){
			return {paging:{type:"", searchtext:"", pageSize:20, curPage:1}, type:"id", searchtext:""}
		},
		props:["see"],
		methods:{
			//검색이벤트
			search:function(){
				//검색이벤트를 진행해야만 검색값이 넘어감
				//검색타입 또는 검색값을 입력만하고 이벤트 발생시키지 않을시에는 데이터가 넘어가지 않음
				this.paging.type=this.type;
				this.paging.searchtext=this.searchtext;
				eventBus.$emit("search", this.paging);
			},
			//한페이지당 게시물수 선택
			searchSize:function(){
				//페이지당 게시물수가 변할때 1페이지로 변경시키지 않으면 버그 발생
				this.paging.curPage=1;
				eventBus.$emit("search", this.paging);
			}
		}
	});
	Vue.component("list-comp",{
		template:"#listTmp",
		props:["mlist"]
	});
	Vue.component("page-comp",{
		template:"#pageTmp",
		props:["page"],
		methods:{
			//페이지 블록범위
			list:function(){
				var list = [];
				for(var idx=this.page.startBlock; idx<=this.page.endBlock; idx++) {
					list.push(idx);
				}
				return list;
			},
			//다른 페이지 이동
			changePage:function(cnt){
				eventBus.$emit("curpage", cnt);
			}
		}
	});

	$(document).ready(function(){
		var vm = new Vue({
			el:"#member",
			data:{paging:{}, memberList:[]},
			created:function(){
				eventBus.$on("search", this.search);
				eventBus.$on("curpage", this.curpage);
				this.search(this.paging);
			},
			methods:{
				search:function(pdata){
					//axios안에서 this를 사용하면 axios를 가리키게 되므로, axios에서 변수 선언
					vm = this;
					vm.paging = pdata;
					axios({
						method:"post",
						url:"/ffunding/manager/member/data",
						params:vm.paging
					}).then((res)=>{
						vm.paging = res.data.memberPagingVO;
						vm.memberList = res.data.memberList;
					}).catch((error)=>console.log(error));
				},
				curpage:function(page){
					this.paging.curPage = page;
					this.search(this.paging);
				}
			}
		});
	});
	
	//회원 상세정보 이동
	$(document).on("click", ".memberrow", function(){
		let mid = $(this).children().eq(0).text();
		location.href="/ffunding/manager/member/detail?mid="+mid;
	});
</script>
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
	                <sch-comp :see="paging"></sch-comp>
	             	<list-comp :mlist="memberList"></list-comp>
	                <page-comp :page="paging"></page-comp>
	             </div>
	         </div>
	     </div>
	 </div>
	 <!-- /.container-fluid -->