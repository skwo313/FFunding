<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script>
	$(document).ready(function() {

	});
</script>
<style>
.imgbox{
	text-align: center;
	margin-top: 40px;
}
.order{
	max-width: 17%;
}
.btn{
	margin-bottom: 40px;
}
</style>
<title>FFunding - 주문</title>
<div class="container-sm" style="max-width: 643px; height: 60vh;">
	<div class="row row-cols-1">
		<div class="col imgbox">
			<img alt="" src="${pageContext.request.contextPath}/img/orderimg.png" class="img-fluid order">
		</div>
		<div class="col">
		<h3>주문하기</h3>
		</div>
		<div class="col">
			<div class="form-floating mb-3">
				<input type="number" class="form-control" id="floatingInputValue" value="30000" readonly>
				<label for="floatingInputValue">제품 가격</label>
			</div>
		</div>
		<div class="col">
			<div class="form-floating mb-3">
				<input type="number" class="form-control" id="floatingInputValue" value="1">
				<label for="floatingInputValue">수량 입력</label>
			</div>
		</div>
		<div class="col">
			<div class="form-floating mb-3">
				<input type="number" class="form-control" id="floatingInputValue" value="0">
				<label for="floatingInputValue">추가 후원금액 입력</label>
			</div>
		</div>
		<div class="col">
			<div class="form-floating mb-3">
				<input type="number" class="form-control" id="floatingInputValue" placeholder="" value="30000" readonly>
				<label for="floatingInputValue">총 결제 금액</label>
			</div>
		</div>
		
		<div class="col btn">
			<input type="button" class="form-control" value="결제">
		</div>
	</div>
</div>