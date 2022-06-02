<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 찾기</title>
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
		margin-left: 20px;
	}
	
	input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
		{
		-webkit-appearance: none;
		margin: 0;
	}
</style>
<script>

	var emailChecked = false;

	function chkEmail(obj) {
		emailChecked = false;
		$(obj).next().addClass("accent-button");
	}
	
	function sendEmail(obj) {
		var brn = $('input[name=brn]').val();
		var email = $('input[name=email]').val();
		var button = $(obj);
		$(button).attr("disabled", true);
		$(button).text("• • •");
	
		if (email == null || email == '') {
			$(button).attr("disabled", false);
			$(button).text("이메일 인증");
			return;
		}
	
		$.ajax({
			type : "post",
			url : "sendemailforhfindingpw.do",
			data : "email=" + email + "&brn=" + brn, // 중복 체크를 일반과 호스트회원 각각 해야하므로 변수로 넣어줌
			success : function(data) {
	
				if (data == 2) {
					alert('해당 이메일로 가입한 정보가 없습니다.');
					$(button).attr("disabled", false);
					$(button).text("이메일 인증");
				} else if (data == 0) {
					$(button).attr("disabled", false);
					$(button).text("이메일 인증");
					$(button).removeClass("accent-button");
					$(".email-field2").css("display", "flex");
				}
			}
		})
	}
	
	function checkEmailKey() {
		var email = $('input[name=email]').val();
		var key = $('#email-key').val();
	
		if (key == null || key == '') {
			alert('값을 입력해 주세요.');
			return;
		}
	
		$.ajax({
			type : "post",
			url : "checkEmail.do",
			data : "email=" + email + "&regkey=" + key,
			success : function(data) {
				if (data == 0) {
					emailChecked = true;
					alert('인증이 완료되었습니다.');
					
					$("#emailForm").submit();
					
				} else if (data == 1) {
					alert('해당 이메일로 보낸 인증 키가 없습니다.\n다시 보내 주세요.');
				} else if (data == 2) {
					alert('인증 키가 일치하지 않습니다.');
				} else if (data == 3) {
					alert('인증 시간이 만료되었습니다.');
				}
			}
		})
	}

</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

		<div id="title">
			비밀번호 찾기
		</div>
		<div id="content">
			<div class="inner-box">
				<form id="emailForm" action="hfindpw.do" method="post">
					<div class="form-title">회원 가입시 사용한 사업자등록번호와 이메일을 입력하세요.</div>
					<div class="form-row join-row-content">
						<input class="form-input" type="text" name="brn" placeholder="사업자등록번호">
					</div>
					<div class="form-row join-row-content with-button email-field">
						<input class="form-input" type="email" name="email"
							onchange="chkEmail(this)" placeholder="이메일" required>
						<button type="button" class="normal-button join-button email-button"
							onclick="sendEmail(this)">이메일 인증</button>
					</div>
					<div class="form-row join-row-content with-button email-field email-field2">
						<input class="form-input" id="email-key" name="regkey" type="text" placeholder="30분 안에 입력해주세요.">
						<button type="button"
							class="normal-button join-button email-button accent-button"
							onclick="checkEmailKey()">인증키 입력</button>
					</div>
				</form>
			</div>
		</div>
		
	
</body>
</html>