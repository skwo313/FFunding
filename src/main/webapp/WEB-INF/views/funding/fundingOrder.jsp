<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
	$(document).ready(
			function() {
				$("#mid").hide();
				$('#fo_cnt').on(
						'change',
						function() {
							var cal = (Number($('#fprice').val()) * Number($(
									'#fo_cnt').val()))
									+ Number($('#fo_donation').val());
							$('#fo_price').val(cal);
						});
				$('#fo_donation').on(
						'change',
						function() {
							var cal = (Number($('#fprice').val()) * Number($(
									'#fo_cnt').val()))
									+ Number($('#fo_donation').val());
							$('#fo_price').val(cal);
						});
				$("#btnOrder").click(function() {
					var tot = $('#fo_price').val();
					var cnt = $('#fo_cnt').val();
					if (tot =="0"){
						alert("수량을 선택해주세요");
						$('#fo_price').focus();
						return false;
					}
					$(".form1")("action", "/ffunding/funding/detail/order");
					$(".form1").submit();
				});
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

<div class="container-sm" style="max-width: 643px;">
	<div class="row row-cols-1">
		<div class="col imgbox">
			<img alt="" src="${pageContext.request.contextPath}/img/orderimg.png"
				class="img-fluid order">

		</div>
		<div class="order_text">
			<h1 class="order_text2">
				<span>O</span><span>R</span><span>D</span><span>E</span><span>R</span>
			</h1>
		</div>
		<form class="order_form" name="form1" method="post">
			<div class="col">
				<div class="form-floating mb-3">
					<input type="number" class="form-control" id="fprice"
						value="${detail.fprice}" readonly> <label
						for="floatingInputValue">제품 가격</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="number" class="form-control" name="fo_cnt" id="fo_cnt"
						value="0" min="0" max="5"> <label for="floatingInputValue">수량
						입력</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="number" class="form-control" name="fo_donation"
						id="fo_donation" value="0" min="0"> <label
						for="floatingInputValue">추가 후원금액 입력</label>
				</div>
			</div>
			<div class="col">
				<div class="form-floating mb-3">
					<input type="number" class="form-control" name="fo_price"
						id="fo_price" value="0" readonly> <label
						for="floatingInputValue">총 결제 금액</label>
				</div>
			</div>
			<input type="text" class="form-control" name="mid" id="mid"
				value="${member.mid}">
			<div class="col">
				<button type="submit" id="btnOrder"
					class="w-100 btn btn-lg btn-primary" style="width: 100%;">결제</button>
			</div>
		</form>
	</div>
</div>