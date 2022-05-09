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
<style>
#title {
    width: 100%;
    font-weight: bold;
    font-size: 25px;
    margin: 20px 0px;
}
#app-part{
	font-size: 18px;
	font-weight: bold;
}
#wrapper{
	padding-top: 0px!important;	
}
textarea{
    resize: none;
}
</style>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<div id="wrapper" style="width:580px; height:500px;">
		<div id="title">
			지원하기
		</div>
		<div id="page-content">
			<div class="inner-box" style="height: 110px; margin-bottom: 10px;">
				<div class="inner-box-content">
					<div class="app-title">지원 파트</div><br>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="part" value="보컬">보컬
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="part" value="베이스">베이스
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="part" value="드럼">드럼
					</div>
				</div>
			</div>
			<div class="inner-box" style="height: 330px; margin-bottom: 20px;">
				<div class="app-title">지원 내용</div><br>
				<textarea class="form-control" rows="10" cols="77"></textarea>
			</div>
			<div class="inner-box-button-wrap">
					<button class="normal-button accent-button" style="margin-bottom: 15px;">지원하기</button>
				</div>
		</div>
		
		
		
	</div>
	
</body>
</html>