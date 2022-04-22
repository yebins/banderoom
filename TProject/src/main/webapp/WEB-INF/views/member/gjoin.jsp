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
	div#page-content {
		width: 70%;
	}
	
	div.inner-box {
		padding: 80px;
		justify-content: flex-start;
		height: auto;
	}
	
	.join-row-title {
		margin-bottom: 10px;
		font-size:14px;
		font-weight: bold;
	}
	.join-row-content {
		margin-bottom: 30px;
	}
	
	input[type=text], input[type=email], input[type=password], input[type=number] {
		width: 100%;
		margin: 10px 0px;
		height: 50px;
		border: 1px solid lightgray;
		border-radius: 25px;
		padding: 0px 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
	}
	
	input.email-check {
		width: 400px;
	}
	
	div.email-field {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin: 0px;
	}
	div.email-field2 {
		display: none;
	}
	
	.email-button {
		width: 120px;
	}
	.filebox label {
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100px;
		height: 36px;
		border: none;
		border-radius: 18px;
		background-color: white;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
	}
	
	.join-row-profile {
		display: flex;
		margin: 10px 0px;
	}
	
	.profile-picture {
		width: 160px;
		height: 160px;
		border-radius: 80px;
		overflow: hidden;
		box-shadow: 0px 0px 10px rgba(0,0,0,0.3);
	}
	
	div.file-upload {
		margin-left: 40px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.filebox label:hover {
		cursor: pointer;
	}
	.filebox label:active {
		background-color: lightgray;
	}
	
	.filebox input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
	}
	
	.filebox {
		height: 120px;
		display: flex;
		justify-content: flex-start;
		align-items: center;
	}
	
	form#profile {
		width: 100%;
	}
	
	#profile-buttons {
		height: 80%;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		align-items: center;
	}
	
	div.profile-nickname-wrap {
		width: 100%;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
	}
	
	div.nickname-wrap {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	
	div.nickname-field {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin: 0px;
	}
	
	input.nickname {
		width: 400px;
	}
</style>
<script>
	var emailChecked = false;

	function profileUpload() {
		
		var formData = new FormData($('#profile')[0])
		$.ajax({
			url: "profileUpload.do",
			type: "post",
			data: formData,
			contentType: false,
			processData: false,
			success: function(data) {
				$('div.profile-picture').html("<img src='<%=request.getContextPath()%>" + data +"' width='160px'>");
				$('input[name=profileSrc]').val('<%=request.getContextPath()%>' + data);
			}
		});
		
	}
	
	function profileReset() {
		$('#profile')[0].reset();
		$('div.profile-picture').html("<img src='<%=request.getContextPath()%>/images/profile_default.png' width='160px'>");
		$('input[name=profileSrc]').val('<%=request.getContextPath()%>/images/profile_default.png');
	}
	
	function chkEmail(obj) {
		emailChecked = false;
		$(obj).next().addClass("accent-button");
	}
	
	function sendEmail(obj) {
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
			type: "post",
			url: "sendEmail.do",
			data: "email=" + email,
			success: function(data) {
				$(button).attr("disabled", false);
				$(button).text("이메일 인증");
				$(button).removeClass("accent-button");
				$(".email-field2").css("display", "flex");
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
			type: "post",
			url: "checkEmail.do",
			data: "email=" + email + "&key=" + key,
			success: function(data) {
				if (data == 0) {
					emailChecked = true;
					alert('인증이 완료되었습니다.');
					$(".email-field2").css("display", "none");
				} else if (data == 1) {
					alert('해당 이메일로 보낸 인증 키가 없습니다.\n다시 보내 주세요.');
				} else if (data == 2) {
					alert('인증 키가 일치하지 않습니다.');
				}
			}
		})
	}
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			일반 회원가입
		</div>
		<div id="page-content">
			
				<div class="inner-box">
					<div class="inner-box-content">
					<form class="joinform joinform-emailpw">
					<div class="join-row join-row-title">
						이메일
					</div>
					<div class="join-row join-row-content email-field">
						<input class="email-check" type="email" name="email" onchange="chkEmail(this)">
						<button type="button" class="email-button" onclick="sendEmail(this)">이메일 인증</button>
					</div>
					<div class="join-row join-row-content email-field email-field2">
						<input class="email-check" id="email-key" type="text">
						<button type="button" class="email-button accent-button" onclick="checkEmailKey()">인증키 입력</button>
					</div>
					<div>
					<div style="height: 30px;"></div>
					</div>
					<div class="join-row join-row-title">
						비밀번호
					</div>
					<div class="join-row join-row-content" style="margin: 0px;">
						<input id="pw1" type="password" name="password"><br>
						<input id="pw2" type="password" placeholder="한 번 더 입력">
					</div>
				</form>
				</div>
				</div>
				
				<p></p>
				
				<form class="joinform joinform-rest"></form>
				<div class="inner-box">
					<div class="inner-box-content">
						<div class="profile-nickname-wrap">
							<div class="join-row join-row-title">
								프로필 사진과 닉네임
							</div>
							<div class="join-row join-row-content join-row-profile">
								<div class="profile-picture">
									<img src='<%=request.getContextPath()%>/images/profile_default.png' width='160px'>
								</div>
								
								<div class="file-upload">
									<form id="profile">
										<div class="filebox">
											<input type="file" id="file" name="profilePicture" onchange="profileUpload()">
											<div id="profile-buttons">
											  <label for="file">파일 선택</label> 
												<button type="button" onclick="profileReset()">초기화</button>
											</div>
										</div>
									</form>
								</div>
							</div>
							<div class="join-row join-row-title">
							</div>
							<div class="join-row join-row-content nickname-field">
								<input type="hidden" name="profileSrc" value="<%=request.getContextPath()%>/images/profile_default.png">
								<input class="nickname" type="text" name="nickname" onchange="">
								<button type="button" class="email-button" onclick="sendEmail(this)">중복 확인</button>
							</div>
						</div>
					</div>
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