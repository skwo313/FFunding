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
<title>펀딩</title>
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
			
			var deleteYN = confirm("삭제하시겠습니까?");
			if (deleteYN == true) {

			formObj.attr("action", "delete");
			formObj.attr("method", "post");
			formObj.submit();
			
			}
		})

		// 취소
		$(".list_btn").on("click", function() {

			location.href = "list";
		})
	})

	function fn_fileDown(fileNo) {
		var formObj = $("form[name='readForm']");
		$("#FILE_NO").attr("value", fileNo);
		formObj.attr("action", "/ffunding/apply/fileDown");
		formObj.submit();
	}
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
				<input type="hidden" id="fid" name="fid" value="${read.fid}" /> <input
					type="hidden" id="page" name="page" value="${scri.page}"> <input
					type="hidden" id="perPageNum" name="perPageNum"
					value="${scri.perPageNum}"> <input type="hidden"
					id="searchType" name="searchType" value="${scri.searchType}">
				<input type="hidden" id="keyword" name="keyword"
					value="${scri.keyword}"> <input type="hidden" id="FILE_NO"
					name="FILE_NO" value="">
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
								<label for="fname">펀딩 제품 이름</label><br>
								<textarea id="fname" name="fname" class="form-control"
									readonly="readonly"><c:out value="${read.fname}" /></textarea>
								<br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-gorup">
								<label for="fname">펀딩 가격</label><br>
								<textarea id="fprice" name="fprice" class="form-control"
									readonly="readonly"><c:out value="${read.fprice}" /></textarea>
								<br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-gorup">
								<label for="fgoal">펀딩 목표 가격</label><br>
								<textarea id="fgoal" name="fgoal" class="form-control"
									readonly="readonly"><c:out value="${read.fgoal}" /></textarea>
								<br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-gorup">
								<label for="fdate">펀딩 등록 날짜</label><br>
								<textarea id="fdate" name="fdate" class="form-control"
									readonly="readonly"><c:out value="${read.fdate}" /></textarea>
								<br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-gorup">
								<label for="fstartdate">펀딩 시작 날짜</label><br>
								<textarea id="fstartdate" name="fstartdate" class="form-control"
									readonly="readonly"><c:out
										value="${read.fstartdate}" /></textarea>
								<br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-gorup">
								<label for="fenddate">펀딩 종료 날짜</label><br>
								<textarea id="fenddate" name="fenddate" class="form-control"
									readonly="readonly"><c:out value="${read.fenddate}" /></textarea>
								<br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-gorup">
								<label for="fdes">제품 상세 설명</label><br>
								<textarea id="fdes" name="fdes" class="form-control"
									readonly="readonly"><c:out value="${read.fdes}" /></textarea>
								<br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-gorup">
								<label for="writer">작성자</label><br> <input type="text"
									id="writer" name="writer" class="form-control"
									value="${read.writer}" readonly="readonly" /><br>
							</div>
						</td>
					</tr>
					<tr>
						<td><span>파일 목록</span>
							<div class="form-group" style="border: 1px solid #dbdbdb;">
								<c:forEach var="file" items="${file}">
									<a href="#"
										onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
								</c:forEach>
							</div></td>
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