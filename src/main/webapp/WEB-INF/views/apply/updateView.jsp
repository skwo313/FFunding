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
									<label for="fname">펀딩 제품 이름</label><br>
									<textarea id="fname" class="form-control" name="fname"><c:out
											value="${update.fname}" /></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="mb-3">
									<label for="fprice">펀딩 가격</label><br>
									<textarea id="fprice" class="form-control" name="fprice"><c:out
											value="${update.fprice}" /></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="mb-3">
									<label for="fgoal">펀딩 목표 가격</label><br>
									<textarea id="fgoal" class="form-control" name="fgoal"><c:out
											value="${update.fgoal}" /></textarea>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="mb-3">
									<label for="fdate">펀딩 등록 날짜</label><br>
									<textarea id="fdate" class="form-control" name="fdate"><c:out
											value="${update.fdate}" /></textarea>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="mb-3">
									<label for="fstartdate">펀딩 시작 날짜</label><br>
									<textarea id="fstartdate" class="form-control" name="fstartdate"><c:out
											value="${update.fstartdate}" /></textarea>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="mb-3">
									<label for="fenddate">펀딩 종료 날짜</label><br>
									<textarea id="fenddate" class="form-control" name="fenddate"><c:out
											value="${update.fenddate}" /></textarea>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="mb-3">
									<label for="fdes">제품 상세 설명</label><br>
									<textarea id="fdes" class="form-control" name="fdes"><c:out
											value="${update.fdes}" /></textarea>
								</div>
							</td>
						</tr>
					
						<tr>
							<td>
								<div class="mb-3">
									<label for="writer">작성자</label> <input type="text" id="writer"
										name="writer" class="form-control" value="${update.writer}"
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