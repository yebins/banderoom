<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
	.list-content{
		width:100%;
		height:370px;
	}
	.list-title{
		width:100%;
	}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			글쓰기
		</div>
		<div id="page-content">
		<div class="inner-box" style="height:500px;">
			<div>
				<input type="text" class="list-title" placeholder="제목을 입력하세요">
			</div>
				<div class="inner-box-content">
					<textarea name="editorTxt" id="editorTxt" cols="10" placeholder="내용을 입력해주세요" style="width: 100%;"></textarea>
				</div>
				<div class="inner-box-button-wrap">
					<button class="accent-button" style="margin-left: 15px;">저장</button>
					<button>취소하기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>