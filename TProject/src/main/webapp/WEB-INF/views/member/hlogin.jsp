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
	#wrapper {
		height: 100vh;
		width: 100%;
		max-width: unset;
		box-shadow: none;
		background-color: rgb(245,245,245);
		justify-content: center;
		padding: 0px;
	}
	div#login-wrap {
		width: 480px;
		height: 600px;
		background: #fbe6b2;
		border-radius: 15px;
		box-shadow: 0px 5px 10px rgba(0,0,0,0.2);
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	
	.login-logo {
		width: 50%;
	}
	.login-logo:hover {
		cursor: pointer;
	}
	
	div#login-host-title {
		font-weight: bold;
		margin: 20px auto;
	}
	
	form#login-form {
		width: 100%;
	}
	
	div#login-form-elements {
		width: 100%;
		display: flex;
		flex-direction: column;
		padding: 0px 80px;
	}
	
	input.login-input {
		width: 100%;
		margin: 10px 0px;
		height: 50px;
		border: 1px solid lightgray;
		border-radius: 25px;
		padding: 0px 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
	}
	
	.login-submit {
		width: 100%;
		margin: 10px 0px;
		height: 50px;
		border-radius: 25px;
		border: 0px;
	}
	
	button.login-button {
		width: 100%;
		margin: 10px 0px;
		height: 50px;
		border-radius: 25px;
		overflow: hidden;
	}
	
	button.login-button-kakao {
		background: #FEE500;
		position: relative;
	}
	
	button.login-button-kakao:active {
		filter: brightness(90%);
	}
	
	img.kakao-login-symbol {
		position: absolute;
		top: 0px;
		left: 0px;
	}
	
	div#login-link {
		width: 50%;
		margin-top: 40px;
		font-size: 14px;
		display: flex;
		justify-content: space-between;
	}
	
	div#findpw-link:hover {
		cursor: pointer;
	}
</style>

<script>

function hLogin() {

	 var brn = $("input[name=brn]").val();
	 var password = $("input[name=password]").val();
	 
	 if (brn == '' || brn == null || brn == undefined ||
			 password == '' || password == null || password == undefined) {
		 return;
	 }
	 
	 $.ajax({
		 type: "post",
		 url: "hlogin.do",
		 data: $("form#login-form").serialize(),
		 success: function(data) {
			 
			 if (data == 0) {
				 alert('일치하는 회원 정보가 없습니다.\n이메일과 비밀번호를 확인해 주세요.')
			 } else if (data == 1) {
				 location.href = document.referrer;
			 }
			 
		 }
	 })
}

	function enterkey() {
		if (window.event.keyCode == 13) {
			hLogin();
	  }
	}
	
	function findPw() {
		window.open('hfindpw.do', '_blank', 
		        'top=140, left=200, width=550, height=500, menubar=no,toolbar=no, ' 
		        + 'location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');
	}

</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<div id="wrapper">
		<div id="login-wrap">
			<img src="<%=request.getContextPath() %>/images/logo.png" class="login-logo" onclick='location.href="/"'>
			<div id="login-host-title">호스트 로그인</div>
				<form id="login-form">
					<div id="login-form-elements">
						<input class="login-input" type="text" name="brn" placeholder="사업자등록번호">
						<input class="login-input" type="password" name="password" placeholder="비밀번호" onkeyup="enterkey()">
						<button class="normal-button accent-button login-submit" type="button" onclick="hLogin()">로그인</button>
					</div>
				</form>
				<div id="login-link">
					<div id="findpw-link" onclick="findPw()">비밀번호를 잊으셨나요?</div>
					<div id="separator">|</div>
					<div id="join-link"><a href='hjoin.do'>회원가입</a></div>
				</div>
		</div>
		
		<!-- 여기까지 틀이고 밑에는 요소 공통사항 
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