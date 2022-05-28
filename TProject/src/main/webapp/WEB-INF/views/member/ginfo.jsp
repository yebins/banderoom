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
<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	#page-content {
		max-width: 800px;
	}

	.inner-box {
		padding: 40px !important;
		margin: auto;
	}
	
	.inner-box:not(.inner-box:first-child) {
		margin-top: 40px;
	}
	
	.small-title {
		font-size: 14px;
		font-weight: bold;
	}
	.small-title:not(.small-title:first-child) {
		margin-top: 20px;
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
		display: flex;
		align-items: center;
		flex-wrap: wrap;
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
	.join-row-title {
		margin-bottom: 10px;
		font-size: 14px;
		font-weight: bold;
	}
	
	.join-row-content {
		margin-bottom: 30px;
	}
	
	input[type=text], input[type=email], input[type=password], input[type=number]
		{
		height: 36px;
		border: 1px solid lightgray;
		border-radius: 18px;
		padding: 0px 20px;
		box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
	}
	
	input.narrow {
		flex: 1;
		margin-right: 10px;
	}
	
	div.tel-field {
		display: none;
		margin-top: 15px;
	}
	
	.join-button {
		width: 120px;
	}
	
	input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
		{
		-webkit-appearance: none;
		margin: 0;
	}
	.form-check-input:checked {
	    background-color: #fb6544;
	    border-color: #fb6544;
	}
	
	.gender-radioes {
		display: flex;
	}
	
	.outter-buttons {
		width: 100%;
		margin: 50px 0px;
		display: flex;
		justify-content: flex-end;	
	}
	.form-check-input:focus {
		box-shadow: none;
	}
	
	.address-wrap input {
		width: 436px;
	}
	.address-wrap input:last-child {
	
		margin-top: 15px;
	}
	
	.info-modify {
		display: none;
	}
	
	.button-wrap {
		margin-top: 30px;
		text-align: right;
	}
	
	#info-submit-button {
		margin-left: 10px;
		display: none;
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
				location.reload();
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
				location.reload();
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

	var telChecked = true;

	function searchAddr() {
		new daum.Postcode({
			oncomplete : function(data) {
				$('input[name=address]').val(
						data.address + " ("
								+ data.bname + ")");
				$('input[name=addressDetail]').val(
						data.buildingName);
				$('input[name=addr1]').val(data.sido);
				$('input[name=addr2]').val(data.sigungu);
			}
		}).open();
	}

	function chkPhoneType(type, obj) {
		var input = $(obj).val();

		//focus out인 경우 
		//input type을 text로 바꾸고 '-'추가
		if (type == 'blur') {
			$(obj).prop('type', 'text');
			var phone = chkItemPhone(input);
		}

		//focus인 경우
		//input type을 number로 바꾸고 '-' 제거
		if (type == 'focus') {
			var phone = input.replace(/-/gi, '');
			$(obj).prop('type', 'number');
		}

		$(obj).val(phone);
	}

	function chkItemPhone(temp) {
		var number = temp.replace(/[^0-9]/g, "");
		var phone = "";

		if (number.length < 9) {
			return number;
		} else if (number.length < 10) {
			phone += number.substr(0, 2);
			phone += "-";
			phone += number.substr(2, 3);
			phone += "-";
			phone += number.substr(5);
		} else if (number.length < 11) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 3);
			phone += "-";
			phone += number.substr(6);
		} else {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 4);
			phone += "-";
			phone += number.substr(7);
		}

		return phone;
	}
	function maxLengthCheck(object) {
		if (object.value.length > 11) {
			object.value = object.value.slice(0, 11);
		}
	}
	
	function checkPhone(obj) {
		var tel = $('#tel-input').val()
		$(obj).attr("disabled", true);
		$(obj).text("• • •");

		if (tel == null || tel == '') {
			$(obj).attr("disabled", false);
			$(obj).text("휴대폰 인증");
			return;
		}

		
		$.ajax({
			type: "post",
			url: "sendSms.do",
			data: "tel=" + tel,
			success: function() {

				$(obj).attr("disabled", false);
				$(obj).text("휴대폰 인증");
				$(obj).removeClass("accent-button");
				$(".tel-field").css("display", "block");
			}
		})
	}
	
	function checkTelAlert(obj) {
		telChecked = false;
		$(obj).next().addClass("accent-button");
	}
	

	function checkTelKey() {
		var tel = $('input[name=tel]').val();
		var regkey = $('#tel-key').val();

		if (regkey == null || regkey == '') {
			alert('값을 입력해 주세요.');
			return;
		}

		$.ajax({
			type : "post",
			url : "checkTel.do",
			data : "tel=" + tel + "&regkey=" + regkey,
			success : function(data) {
				if (data == 0) {
					telChecked = true;
					alert('인증이 완료되었습니다.');
					$(".tel-field").css("display", "none");
				} else if (data == 1) {
					alert('해당 번호로 보낸 인증 키가 없습니다.\n다시 보내 주세요.');
				} else if (data == 2) {
					alert('인증 키가 일치하지 않습니다.');
				} else if (data == 3) {
					alert('인증 시간이 만료되었습니다.');
				}
			}
		})
	}
	
	function showInfoModify(buttonObj) {
		if ($(buttonObj).hasClass("pressed")) {
			location.reload();
		} else {
		
			$(".info-view").css("display", "none");
			$(".info-modify").css("display", "block");
			
			$(buttonObj).addClass("pressed");	
			$(buttonObj).text("취소");
			$("#info-submit-button").css("display", "inline-block");
		}
		
	}
	
	$(function() {
		if (login.gender == 'M') {
			$("#genderM").prop("checked", true);
		} else if (login.gender == 'F') {
			$("#genderF").prop("checked", true);
		}
	})
	
	function updateInfo() {
		
		if (!telChecked) {
			alert('휴대폰 인증이 필요합니다.');
			return;
		}

		if (
				$('input[name=name]').val() == '' ||
				$('input[name=name]').val() == null ||
				$('input[name=name]').val() == undefined ||
				$('input[name=address]').val() == '' ||
				$('input[name=address]').val() == null ||
				$('input[name=address]').val() == undefined ||
				$('input[name=gender]:checked').val() == '' ||
				$('input[name=gender]:checked').val() == null ||
				$('input[name=gender]:checked').val() == undefined) {
			
			alert('필수 항목을 입력해 주세요.');
			return;
		}
		
		$.ajax({
			type: "post",
			url: "ginfo.do",
			data: $("#info-form").serialize(),
			success: function(result) {
				if (result == 0) {
					alert('정보가 업데이트 되었습니다.');
					location.reload();
				} else if (result == 1) {
					alert('로그인이 필요합니다.');
					location.href='glogin.do';
				} else if (result == 2) {
					alert('정보 변경에 실패햇습니다.');
				}
			}
			
		})
		
	}
	
	function unregister() {
		if (!confirm('정말 탈퇴하시겠습니까?')) {
			return;
		}
		
		location.href='unregister.do';
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
								<button class="normal-button info-button" onclick="showPasswordForm()">비밀번호 변경</button>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="inner-box basic-info">
				<div class="info-view">
					<div class="small-title">
						이메일
					</div>
					<div class="info-content">
						${login.email}
					</div>
					<div class="small-title">
						이름
					</div>
					<div class="info-content">
						${login.name}
					</div>
					<div class="small-title">
						주소
					</div>
					<div class="info-content">
						${login.address}<br>
						${login.addressDetail}
					</div>
					<div class="small-title">
						전화번호
					</div>
					<div class="info-content">
						${login.tel}
					</div>
					<div class="small-title">
						성별
					</div>
					<div class="info-content">
						<c:if test="${login.gender == 'M'}">
						남자
						</c:if>
						<c:if test="${login.gender == 'F'}">
						여자
						</c:if>
					</div>
				</div>
				
			
				<div class="info-modify">
					<form id="info-form">
						<div class="small-title">
							이메일
						</div>
						<div class="info-content" style="margin-bottom: 30px;">
							${login.email}
						</div>
						<div class="join-row join-row-title">이름</div>
						<div class="join-row join-row-content">
							<input type="text" name="name" value="${login.name}" required>
						</div>
						<div class="join-row join-row-title">주소</div>
						<div class="join-row join-row-content address-wrap">
							<input type="hidden" name="addr1" value="${login.addr1}">
							<input type="hidden" name="addr2" value="${login.addr2}">
							<input type="text" name="address" readonly onclick="searchAddr()"
								placeholder="주소 검색" value="${login.address}" required><br>
							<input type="text" name="addressDetail" value="${login.addressDetail}" placeholder="상세 주소">
						</div>
						<div class="join-row join-row-title">휴대폰 번호</div>
						<div class="join-row join-row-content with-button" style="margin: 0px;">
							<input type="text" class="narrow" name="tel"
								id="tel-input" value="${login.tel}" autocomplete="off"
								oninput="maxLengthCheck(this)"
								onchange="checkTelAlert(this)"
								onfocus="chkPhoneType('focus', this)"
								onblur="chkPhoneType('blur', this)" min="0" placeholder="숫자만 입력"
								required>
							<button type="button" class="normal-button join-button tel-button"
								onclick="checkPhone(this)">휴대폰 인증</button>
						</div>
						<div class="join-row join-row-content with-button tel-field">
							<input class="narrow" id="tel-key" type="text" placeholder="5분 안에 입력해주세요.">
							<button type="button"
								class="normal-button join-button tel-button accent-button"
								onclick="checkTelKey()">인증키 입력</button>
						</div>
	
						<div class="join-row join-row-title" style="margin-top: 30px">성별</div>
						<div class="join-row join-row-content gender-radioes" style="margin-bottom: 0px;">
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="gender" value="M" id="genderM" required>
							  <label class="form-check-label" for="genderM">
							    남자
							  </label>
							</div>
							<div class="form-check" style="margin-left: 20px;">
							  <input class="form-check-input" type="radio" name="gender" value="F" id="genderF" required>
							  <label class="form-check-label" for="genderF">
							    여자
							  </label>
							</div>
						</div>
					</form>
				</div>
				<div class="button-wrap">
					<button class="normal-button" onclick="showInfoModify(this)">정보 수정</button>
					<button id="info-submit-button" class="normal-button accent-button" onclick="updateInfo()">정보 수정</button>			
				</div>
			</div>
			
			<div class="button-wrap">
				<button class="normal-button" style="margin-right: 40px;" onclick="unregister()">회원 탈퇴</button>
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