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

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<title>게시판</title>
</head>
<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='writeForm']");
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				formObj.attr("action", "/board/write");
				formObj.attr("method", "post");
				formObj.submit();
			});
			fn_addFile();
		})
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
		function fn_addFile(){
			var fileIndex = 1;
			//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
			$(".fileAdd_btn").on("click", function(){
				$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
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
<br><br>
		<section id="container">
			<form name="writeForm" method="post" action="/board/write"
				enctype="multipart/form-data">
				<table>
					<tbody>
							<tr>
							<td>
								<div class="mb-3">
								<label for="title">제목</label><input type="text"
									id="title" name="title" class="form-control" title="제목을 입력하세요." />
									</div>
								</td>
							</tr>
							<tr>
								<td>
								<div class="mb-3">
								<label for="content">내용</label>
								<textarea id="content" name="content" class="form-control" rows="10"
										title="내용을 입력하세요."></textarea>
										</div>
										</td>
							</tr>
							<tr>
								<td>
								<div class="mb-3">
								<label for="writer">작성자</label><input type="text"
									id="writer" name="writer" class="form-control" title="작성자를 입력하세요."
									value="${member.userId}" />
									</div>
									</td>
							</tr>
							<tr>
							<tr>
								<td id="fileIndex"></td>
							</tr>
							<tr>
								<td>
							<button class="write_btn btn btn-success" type="submit" id="write_btn">작성</button>
							<button class="fileAdd_btn btn btn-primary" type="button">파일추가</button>	
							<button type="button" class="btn btn-primary" onclick="location.href='list'">목록</button>
								</td>
							</tr>
					</tbody>
				</table>
			</form>