<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	input[name=no] {
		display: none;
	}
</style>
</head>
<body>
	<form action="formtest.do">
	<input type="text" name="no" value="이게 넘어오면 안됨">
	<input type="text" name="yes" value="이거만 넘어가야함">
	<button>전송</button>
	</form>
</body>
</html>