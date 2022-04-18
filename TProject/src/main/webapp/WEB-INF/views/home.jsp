<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {
		margin: 0px;
	}
	
	#wrapper {
		width: 1200px;
		height: 100vh;
		margin: 0px auto;
		
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	
	div#logo {
		width: 200px;
		height: 150px;
		border: 1px solid black;
		
	}
	
	div#space {
		height: 50px;
	}
	
	div.button {
		width: 370px;
		height: 370px;
		background: #F1747C;	
		border-radius: 30px;
		margin: 50px;
		
	}
	
	div#buttons {
		
		display: flex;
		justfy-content: center;
		align-items: center;
	}
	
	div.button {
		
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		align-items: flex-start;
		}
	
	div.text {
		color: white;
		font-weight: bold;
		font-size: 24px;
		
		padding: 20px;
	}
	
	div.arrow-wrap {
		display: flex;
		width: 100%;
		justify-content: flex-end;
		align-items: center;
		background-color: rgba(255,255,255,0.8);
		
	}
	
	div.arrow-text {
		font-size: 20px;
		
		
	}
	
	div.arrow {
		width: 70px;
		height: 70px;
		
		border: 1px solid black;
		border-radius: 25px;
	}
</style>
</head>
<body>
	<c:import url="/header.do"></c:import>
	<div id="wrapper">
	</div>
	
</body>
</html>