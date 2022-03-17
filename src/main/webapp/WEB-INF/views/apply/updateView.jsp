<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>게시판</title>
</head>
<script type="text/javascript">
		$(document).ready(function(){
			
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/apply/list";
			})
		})
	
	</script>
<body>

	<div id="root">
		<section id="container">
			<form name="updateForm" role="form" method="post" action="update">
				<input type="hidden" name="fid" value="${update.fid}"
					readonly="readonly" />
				<table>
					<tbody>
						<tr>
							<td><label for="fcate">카테고리</label><input type="text"
								id="fcate" name="fcate" value="${update.fcate}" /></td>
						</tr>
						<tr>
							<td><label for="fname">이름</label>
							<textarea id="fname" name="fname"><c:out
										value="${update.fname}" /></textarea></td>
						</tr>
						<tr>
							<td><label for="writer">작성자</label><input type="text"
								id="writer" name="writer" value="${update.writer}"
								readonly="readonly" /></td>
						</tr>
						<tr>
							<td><label for="fdate">등록날짜</label><input type="text"
								id="fdate" name="fdate" value="${update.fdate}"
								readonly="readonly" /></td>
						</tr>
					</tbody>
				</table>
				<div>
					<button type="submit" class="update_btn">저장</button>
					<button type="submit" class="cancel_btn">취소</button>
				</div>
			</form>
		</section>
		<hr />
	</div>
</body>
</html>