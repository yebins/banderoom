<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원구하기</title>
<style>
	* {
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}

	body {
		margin: 0px;
		background-color: rgb(245, 245, 245);
	}
	
	button:hover, input[type=button]:hover, input[type=submit]:hover, input[type=reset]:hover {
		cursor: pointer;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	
	#wrapper {
		width: 1200px;
		min-height: 100vh;
		margin: 0px auto;
		padding-top: 80px;
		display: flex;
		flex-direction: column;
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
	
	div#page-title {
		width: 100%;
		font-size: 36px;
		font-weight: bold;
		margin: 40px 0px;
	}
	
	div#page-content {
		width: 100%;
		min-height: 50vh;
	}
	
	button {
		width: 100px;
		height: 36px;
		border: none;
		border-radius: 18px;
		background-color: white;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
	}
	
	button.accent-button {
		background-color: #FB6544;
		color: white;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.4);
	}
	
	button:active {
		background-color: lightgray;
	}
	
	button.accent-button:active {
		background-color: #e2330c;
	}
	
	div.inner-box {
		width: 100%;
		height: 200px;
		background-color: white;
		border-radius: 15px;
		box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.2);
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		padding: 15px;
	}
	
	div.inner-box-button-wrap {
		display: flex;
		justify-content: flex-end;
	}
	
	
</style>
</head>
<body>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			팀원 모집
		</div>
		<div id="page-content">
			내용
		</div>
		
		<!-- 여기까지 틀이고 밑에는 요소 공통사항 -->
		<div>
			위까지는 틀이고 밑에는 요소 공통사항
			<br><br><br>
			버튼 세로 크기 수정시 border-radius도 수정해야함<br>
			<br>
			<button>버튼</button> 
			일반 버튼 (버튼이 여러개 줄줄이 배치될 시 하나만 강조 컬러 넣을것)<br><br>
			<button class="accent-button">버튼</button> 강조 버튼 (button class="accent-button")<br><br>
			<br><br><br>
			내부 박스 틀과 예시
			<div class="inner-box">
				<div class="inner-box-content">
				박스에 들어갈 내용
				</div>
				<div class="inner-box-button-wrap">
					<button>일반버튼</button>
					<button class="accent-button" style="margin-left: 15px;">강조버튼</button>
				</div>
			</div>
			<br><br>
		</div>
		<!-- 여기까지 -->
		
	</div>
	
</body>
</html>