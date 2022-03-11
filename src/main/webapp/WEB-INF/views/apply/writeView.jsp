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