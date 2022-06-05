<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>오류</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
	#title {
		font-size: 36px;
		font-weight: bold;
		margin: 20px;
	}
	#content {
		padding: 0px 20px;
	}
	.inner-box {
		height: 320px;
		padding: 60px !important;
	}
	
	.form-row {
		margin-top: 15px;
		display: flex;
		align-items: center;
	}
	
	.form-title {
		font-size: 14px;
		font-weight: bold;
		
	}
	
	.form-input {
		height: 36px;
		padding: 0px 20px;
		border-radius: 18px;
		border: 1px solid lightgray;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);	
		flex: 1;
		margin-right: 20px;
	}
	
	.pwCheck-message {
		margin-top: 10px;
		font-size: 14px;
		color: #fb6544;
	}
	
	.button-wrap {
		margin-top: 30px;
		text-align: right;
	}
	
	.email-field2 {
		display: none;
	}
	
	.join-button {
		width: 120px;
	}
	
</style>
<script>
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

		<div id="title">
			비밀번호 찾기
		</div>
		<div id="content">
			<div class="inner-box">
				인증 내용이 올바르지 않습니다.
			</div>
		</div>
		
	
</body>
</html>