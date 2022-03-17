<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>게시판</title>
</head>

<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form[name='readForm']");

		// 수정 
		$(".update_btn").on("click", function() {
			formObj.attr("action", "updateView");
			formObj.attr("method", "get");
			formObj.submit();
		})

		// 삭제
		$(".delete_btn").on("click", function() {
			formObj.attr("action", "delete");
			formObj.attr("method", "post");
			formObj.submit();
		})

		// 취소
		$(".list_btn").on("click", function() {

			location.href = "list";
		})
	})
</script>
<style>
table {
	width: 60%;
	margin-left: auto;
	margin-right: auto;
}
</style>
<body>

	<div id="root">
		<section id="container">
			<form name="readForm" role="form" method="post">
				<input type="hidden" id="fid" name="fid" value="${read.fid}" />
			</form>
			<table>
				<tbody>
					<tr>
						<td>
							<div class="form-group">
								<br> <label for="fcate" class="form-group">카테고리</label> <input
									type="text" id="fcate" name="fcate" class="form-control"
									value="${read.fcate}" readonly="readonly" />
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div class="form-gorup">
								<label for="fname">펀딩 제품 이름</label>
								<textarea id="fname" name="fname" class="form-control"
									readonly="readonly"><c:out value="${read.fname}" /></textarea>
							</div>
						</td>
					</tr>


					<tr>
						<td>
							<div class="form-gorup">

								<label for="writer">작성자</label><input type="text" id="writer"
									name="writer" class="form-control" value="${read.writer}"
									readonly="readonly" />
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-gorup">

								<label for="fdate">등록날짜</label><input type="text" id="fdate"
									name="fdate" class="form-control" value="${read.fdate}" /><br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div>
								<button type="button" class="list_btn btn btn-primary">목록</button>
								<button type="button" id="updatebutton"
									class="update_btn btn btn-warning">수정</button>
								<button type="button" id="deletebutton"
									class="delete_btn btn btn-danger">삭제</button>
								<br>
							</div>
						</td>
					</tr>
				</tbody>
			</table>

		</section>
		<hr />
	</div>
</body>
</html>