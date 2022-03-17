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

		$(".cancel_btn").on("click", function() {
			event.preventDefault();
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
			<form name="updateForm" role="form" method="post" action="update">
				<input type="hidden" name="fid" value="${update.fid}"
					readonly="readonly" />
				<table>
					<tbody>
						<tr>
							<td>
								<div class="mb-3">
									<label for="fcate">카테고리</label><input type="text" id="fcate"
										name="fcate" class="form-control" value="${update.fcate}" />
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="mb-3">
									<label for="fname">이름</label>
									<textarea id="fname" class="form-control" name="fname"><c:out
											value="${update.fname}" /></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="mb-3">
									<label for="writer">작성자</label> <input type="text" id="writer"
										name="writer" class="form-control" value="${update.writer}"
										readonly="readonly" />
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="mb-3">
									<label for="fdate">등록날짜</label><input type="text" id="fdate"
										class="form-control" name="fdate" value="${update.fdate}"
										readonly="readonly" /><br>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									<button type="submit" class="btn btn-success update_btn">저장</button>
									<button type="submit" class="btn btn-primary cancel_btn">취소</button>
								</div>
							</td>
						</tr>
					</tbody>
				</table>

			</form>
		</section>
		<hr />
	</div>
</body>
</html>