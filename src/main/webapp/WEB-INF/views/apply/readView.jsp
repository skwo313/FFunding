<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>펀딩목록 게시판</title>
</head>
<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='readForm']");
			
			// 수정 
			$(".update_btn").on("click", function(){
				formObj.attr("action", "updateView");
				formObj.attr("method", "get");
				formObj.submit();				
			})
			
			// 삭제
			$(".delete_btn").on("click", function(){
				formObj.attr("action", "delete");
				formObj.attr("method", "post");
				formObj.submit();
			})
			
			// 취소
			$(".list_btn").on("click", function(){
				
				location.href = "list";
			})
		})
	</script>
<body>

	<div id="root">
		<section id="container">
			<form name="readForm" role="form" method="post">
			<input type="hidden" id="fid" name="fid" value="${read.fid}" />
				<table>
					<tbody>
						<tr>
							<td><label for="fcate">카테고리</label><input type="text"
								id="fcate" name="fcate" value="${read.fcate}" /></td>
						</tr>
						<tr>
							<td><label for="fname">이름</label><input type="text"
								id="fname" name="fname" value="${read.fname}" /></td>
						</tr>
						<tr>
							<td><label for="writer">작성자</label> <textarea id="writer"
									name="writer"><c:out value="${read.writer}" /></textarea></td>
						</tr>
						<tr>
							<td><label for="fdate">등록날짜</label><input type="text"
								id="fdate" name="fdate" value="${read.fdate}" /></td>
						</tr>
					</tbody>
				</table>
				<div>
					<button type="submit" class="update_btn">수정</button>
					<button type="submit" class="delete_btn">삭제</button>
					<button type="submit" class="list_btn">목록</button>	
				</div>
			</form>
		</section>
		<hr />
	</div>
</body>
</html>