<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<br>
<br>
<title>펀딩 목록</title>
<style type="text/css">
li {
	list-style: none;
	float: left;
	padding: 6px;
}
</style>
</head>
<body>
	<div class="container">
		<section id="container">
			<form role="form" method="get">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>카테고리</th>
							<th>이름</th>
							<th>작성자</th>
							<th>등록날짜</th>
						</tr>
					</thead>

					<c:forEach items="${list}" var="list">
						<tr>
							<td><c:out value="${list.fcate}" /></td>
							<td><a href="readView?fid=${list.fid}"><c:out
										value="${list.fname}" /></a></td>
							<td><c:out value="${list.writer}" /></td>
							<td><c:out value="${list.fdate}" /></td>
						</tr>
					</c:forEach>
				</table>
			</form>
		</section>
	</div>
</body>
</html>