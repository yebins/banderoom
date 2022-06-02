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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
	#title {
		font-size: 36px;
		font-weight: bold;
		margin: 20px;
		color: #F5F5F5;
	}
	#content {
		padding: 0px 20px;
	}
	.inner-box {
		height: 320px;
		padding: 30px 60px !important;
	}
	
	.form-row:not(.form-row:last-child) {
		margin-bottom: 20px;
	}
	
	.form-title {
		font-size: 14px;
		font-weight: bold;
		
	}
	
	.form-input {
		height: 36px;
		padding: 0px 20px;
		margin-top: 10px;
		border-radius: 18px;
		border: 1px solid lightgray;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);	
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
	
</style>
<script>

	var pwChecked = false;
	
	function chkPw() {
		var pwReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
	
		pwChecked = false;
		if ($("#pw1").val() == $("#pw2").val() && pwReg.test($("#pw1").val())) {
			pwChecked = true;
			$(".pwCheck-message").text("");
		} else {
			if($("#pw2").val() != '') {
				
				if ($("#pw1").val() != $("#pw2").val()) {
					$(".pwCheck-message").text("비밀번호가 일치하지 않습니다.");
				} else if (!pwReg.test($("#pw1").val())) {
					$(".pwCheck-message").text("영문, 숫자, 기호 포함 8자 이상 입력해주세요.");
				}
			}
		}
	}
	
	function changePassword() {
		
		if (pwChecked == false) {
			return;
		}
		
		if (
			$("#pw1").val() == "" ||
			$("#pw2").val() == ""
		) {
			alert('비밀번호를 입력해 주세요.');
			return;
		}
		
		$.ajax({
			type: "post",
			url: "hfindpwchange.do",
			data: $("#password").serialize(),
			success: function(result) {
				if (result == 0) {
					alert('비밀번호가 변경되었습니다.');
					window.close();
				} else if (result == 1) {
					alert('인증 정보가 맞지 않습니다.');
					window.close();
				} else if (result == 2) {
					alert('비밀번호 변경에 실패했습니다.');
				}
			}
		})
	}
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

		<div id="title">
			비밀번호 변경
		</div>
		<div id="content">
			<div class="inner-box">
				<form id="password">
					<input type="hidden" name="brn" value="${hostVO.brn}">
					<input type="hidden" name="email" value="${emailRegVO.email}">
					<input type="hidden" name="regkey" value="${emailRegVO.regkey}">
					<div class="password-form">
						<div class="form-row">
							<div class="form-title">새로운 비밀번호</div>
							<input id="pw1" class="form-input" type="password" name="pw1" onchange="chkPw()">
						</div>
						<div class="form-row">
							<div class="form-title">비밀번호 확인</div>
							<input id="pw2" class="form-input" type="password" name="pw2" onchange="chkPw()">
							<div class="pwCheck-message"></div>
						</div>
					</div>
				</form>
			</div>
			<div class="button-wrap">
				<button class="normal-button accent-button" onclick="changePassword()">변경</button>
			</div>
		</div>
		
	
</body>
</html>