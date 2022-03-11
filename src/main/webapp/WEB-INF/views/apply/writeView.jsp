<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
	 	<title>게시판</title>
	</head>
	<body>
	
		<div id="root">
			<section id="container">
				<form role="form" method="post" action="/apply/write">
					<table>
						<tbody>
							<tr>
								<td>
									<label for="fcate">카테고리</label><input type="text" id="fcate" name="fcate" />
								</td>
							</tr>					
							<tr>
								<td>
									<label for="fname">펀딩제품 이름</label><input type="text" id="fname" name="fname" />
								</td>
							</tr>
							<tr>
								<td>
									<label for="fprice">펀딩 가격</label><input type="text" id="fprice" name="fprice" />
								</td>
							</tr>
							<tr>
								<td>
									<label for="fgoal">펀딩목표 가격</label><input type="text" id="fgoal" name="fgoal" />
								</td>
							</tr>		
							<tr>						
								<td>						
									<button type="submit">작성</button>
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