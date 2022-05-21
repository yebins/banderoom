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
	.inner-box {
		padding: 40px !important;
		margin: auto;
		max-width: 800px;
	}
	
	.small-title {
		font-size: 14px;
		font-weight: bold;
	}
	
	.content-wrap {
		margin-top: 15px;
	}
	
	.profile-wrap {
		display: flex;
		align-items: center;
	}
	
	.profile-picture-wrap {
		position: relative;
		margin-right: 40px;
	}
	
	.profile-picture {
		width: 140px;
		height: 140px;
		border-radius: 70px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		display: flex;
		justify-content: center;
		align-items: center;
		overflow: hidden;
	}
	
	.profile-picture img {
		width: 100%;
		height: 100%;
	}
	
	.profile-picture-update {
		width: 36px;
		height: 36px;
		border-radius: 18px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		background-color: white;
		position: absolute;
		bottom: 3px;
		right: 3px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.profile-picture-update:hover {
		cursor: pointer;
	}
	
	.profile-picture-update:active {
		filter: brightness(90%);
	}
	
	#profile-picture-input {
		display: none;
	}
	
	.nickname {
		font-size: 20px;
		font-weight: bold;
		height: 40px;
	}
	.profile-buttons {
		margin-top: 20px;
	}
	.profile-buttons {
		display: flex;
		align-items: center;
	}
	.info-button {
		margin-right: 20px;
		width: 120px;
		font-size: 16px;
	}
	
	.info-input {
		font-size: 16px;
		font-weight: normal;
		height: 36px;
		width: 260px;
		border: 1px solid lightgray;
		border-radius: 18px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		padding: 0px 20px;
		margin-right: 20px;
	}
	
</style>

<script>

	var login = {
			addr1: '${login.addr1}',
			addr2: '${login.addr2}',
			address: '${login.address}',
			addressDetail: '${login.addressDetail}',
			gender: '${login.gender}',
			name: '${login.name}',
			nickname: '${login.nickname}',
			
	}

	function updateProfile() {
	
		var formData = new FormData($('#profile-picture')[0])
		$.ajax({
			url: "profileupdate.do",
			type: "post",
			data: formData,
			contentType: false,
			processData: false,
			success: function(data) {
				$("#profile-picture-img").attr("src", data);
			}
		})
	}
	
	function profileReset() {
	
		var formData = new FormData($('#profile-picture')[0])
		$.ajax({
			url: "profilereset.do",
			type: "post",
			contentType: false,
			processData: false,
			success: function(data) {
				$("#profile-picture-img").attr("src", data);
			}
		})
	}

	function showNicknameInput(buttonObj) {
		
		if (!$(buttonObj).hasClass("accent-button")) {
			var html = "<input type='text' class='info-input' id='nickname' placeholder='닉네임' value='" + login.nickname + "'>";
			html += "<button class='normal-button accent-button info-button' onclick='updateNickname()'>변경</button>";
			$(".nickname").html(html);
			$(buttonObj).addClass("accent-button");
		} else {
			location.reload();
		}
		
	}
	
	function updateNickname() {
		var nickname = $("#nickname").val();
		
		if (nickname == '') {
			alert('닉네임을 입력해 주세요.');
			return;
		}
		
		$.ajax({
			type: "post",
			url: "updatenickname.do",
			data: "nickname=" + nickname,
			success: function(result) {
				if (result == 0) {
					alert('닉네임이 변경되었습니다.');
					location.reload();
				} else if (result == 1) {
					alert('로그인이 필요합니다.');
					location.href = 'glogin.do';
				} else if (result == 2) {
					alert('이미 존재하는 닉네임입니다.');
				} else if (result == 3) {
					alert('변경에 실패했습니다.');
				}
			}
		})
	}
	
	function showPasswordForm() {
		window.open('changepassword.do', '_blank', 
        'top=140, left=200, width=550, height=500, menubar=no,toolbar=no, ' 
        + 'location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');
	}

	function reload() {	// 자식 창에서 실행할 함수
		location.reload();
	}
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			내 정보
		</div>
		<div id="page-content">
			<div class="inner-box basic-info">
				<div class="small-title">
					기본정보
				</div>
				<div class="content-wrap">
					<div class="profile-wrap">
						<div class="profile-picture-wrap">
							<form id="profile-picture">
								<input type="file" name="profilePicture" id="profile-picture-input" onchange="updateProfile(this)">
							</form>
							<div class="profile-picture">
								<img id="profile-picture-img" src="${login.profileSrc}">
							</div>
							<label class="profile-picture-update" for="profile-picture-input">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
								  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
								  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
								</svg>
							</label>
						</div>
						<div class="nickname-pw-wrap">
							<div class="nickname">${login.nickname}</div>
							<div class="profile-buttons">
								<button class="normal-button info-button" onclick="profileReset()">사진 초기화</button>
								<button class="normal-button info-button" onclick="showNicknameInput(this)">닉네임 변경</button>
								<c:if test="${login.isKakao == 'N'}">
								<button class="normal-button info-button" onclick="showPasswordForm()">비밀변호 변경</button>
								</c:if>
							</div>
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
			<button class="normal-button">버튼</button> 
			일반 버튼 (button class="normal-button") (버튼이 여러개 줄줄이 배치될 시 하나만 강조 컬러 넣을것)<br><br>
			<button class="normal-button accent-button">버튼</button> 강조 버튼 (button class="normal-button accent-button")<br><br>
			<br><br><br>
			내부 박스 틀과 예시
			<div class="inner-box">
				<div class="inner-box-content">
				박스에 들어갈 내용
				</div>
				<div class="inner-box-button-wrap">
					<button class="normal-button">일반버튼</button>
					<button class="normal-button accent-button" style="margin-left: 15px;">강조버튼</button>
				</div>
			</div>
			<br><br>
		</div>
		<!-- 여기까지 -->
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>