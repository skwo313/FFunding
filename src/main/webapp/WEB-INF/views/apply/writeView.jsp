<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<title>Test1</title>
</head>
<style>
table {
	width: 60%;
	margin-left: auto;
	margin-right: auto;
}

div.a{
	font-size: 30px;
	font-weight: 800;
}

div.b{
	font-size: 20px;
	font-weight: 500;
}

div.c{
	font-size: 15px;
	font-weight: 150;
}
</style>
<body>

	<div id="root">
		<section id="container">
			<form role="form" method="post" action="/apply/write" enctype="multipart/form-data">
				<table>
					<tbody>
						
						<tr>
							<td><br>		
							<div class="a">				
								메이커님, 환영합니다!<br><br>
							</div>
							<div class="b">
								가벼운 마음으로 메이커님의 정보를 입력해 보세요.☺<br><br><br>
							</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="c">
									<label for="fcate">카테고리*</label><br>
									서포터들이 관심을 가질만한 카테고리를 1개만 선택하세요<br>
									<select id="fcate" name="fcate" size="1" class="form-control">
									<option value="">선택하세요</option>
									<option value="테스트">테스트</option>
									<option value="테스트">테스트1</option>
									</select><br>

								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="c">
									<label for="fname">펀딩제품 이름*</label><br><input type="text" id="fname" name="fname" class="form-control" /><br>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="c">
									<label for="fprice">펀딩 가격*</label><br><input type="text" id="fprice" name="fprice" class="form-control" /><br>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="c">
									<label for="fgoal">펀딩목표 가격*</label><br><input type="text" id="fgoal" name="fgoal" class="form-control" /><br>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="c">
									<label for="fdate">펀딩 등록 날짜*</label><br><input type="text" id="fdate" name="fdate" class="form-control" /><br>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
							<label for="fstartdate">펀딩 시작 날짜*</label><br><input type="text" id="fstartdate" name="fstartdate" class="form-control" /><br>
							</td>
						</tr>
						
						<tr>
							<td>
							<label for="fenddate">펀딩 종료 날짜*</label><br><input type="text" id="fenddate" name="fenddate" class="form-control" /><br>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="c">
									<label for="fimg">제품 대표 이미지</label><br><input type="text" id="fimg" name="fimg" class="form-control" /><br>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="c">
									<label for="fimg1">제품 대표 이미지</label><br><input type="text" id="fimg1" name="fimg1" class="form-control" /><br>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="c">								
									<label for="fimg2">제품 대표 이미지</label><br><input type="text" id="fimg2" name="fimg2" class="form-control" /><br>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="c">
									<label for="fimg3">제품 대표 이미지</label><br><input type="text" id="fimg3" name="fimg3" class="form-control" /><br>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="c">
									<label for="fdes">제품 상세 설명</label><br><input type="text" id="fdes" name="fdes" class="form-control" /><br>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="c">
									<label for="writer">작성자*</label><br><input type="text" id="writer" name="writer" class="form-control" /><br>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<input type="file" name="file">
							</td>
						</tr>
						
						
						<tr>
							<td>
								<div class="c">
									<input type="checkbox" name="agreement" value="1"><label>&nbsp;(필수) 개인 정보 수집 동의 </label>		
								</div>
							</td>		
						</tr>	

						<tr>
							<td>
								<button type="submit" class="write_btn btn btn-success">작성</button>
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