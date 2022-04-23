<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/base.css">
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
	font-size: 14px;
	font-weight: bold;
}

.join-row-content {
	margin-bottom: 30px;
}

input[type=text], input[type=email], input[type=password], input[type=number]
	{
	width: 100%;
	margin: 10px 0px;
	height: 50px;
	border: 1px solid lightgray;
	border-radius: 25px;
	padding: 0px 20px;
	box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
}

input.narrow {
	width: 400px;
}

div.with-button {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

div.email-field {
	margin: 0px;
}

div.email-field2, div.tel-field {
	display: none;
}

.join-button {
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
	box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
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
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
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
</style>
<script>
	var emailChecked = false;
	var nickChecked = false;
	var telChecked = false;
	
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
			type : "post",
			url : "sendEmail.do",
			data : "email=" + email + "&memberType=general", // 중복 체크를 일반과 호스트회원 각각 해야하므로 변수로 넣어줌
			success : function(data) {

				if (data == 2) {
					alert('이미 존재하는 이메일입니다.');
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
			data : "email=" + email + "&key=" + key,
			success : function(data) {
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

	function checkNickAlert(obj) {
		nickChecked = false;
		$(obj).next().addClass("accent-button");
	}

	function checkNickname(obj) {
		var nickname = $("input[name=nickname]");

		if (nickname == null || nickname == '') {
			return;
		}

		$.ajax({
			type : "post",
			url : "checkNickname.do",
			data : "nickname=" + nickname + "&memberType=general",
			success : function(data) {
				if (data == 1) {
					alert('이미 존재하는 닉네임입니다.');
				} else if (data == 0) {
					alert('사용 가능한 닉네임입니다.')
					$(obj).removeClass("accent-button");
					nickChecked = true;
				}
			}
		})
	}

	function searchAddr() {
		new daum.Postcode({
			oncomplete : function(data) {
				$('input[name=address]').val(
						data.address + " (" + data.bname + ")");
				$('input[name=addressDetail]').val(data.buildingName);
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
				$(".tel-field").css("display", "flex");
			}
		})
	}
	
	function checkTelAlert(obj) {
		telChecked = false;
		$(obj).next().addClass("accent-button");
	}
	

	function checkTelKey() {
		var tel = $('input[name=tel]').val();
		var key = $('#tel-key').val();

		if (key == null || key == '') {
			alert('값을 입력해 주세요.');
			return;
		}

		$.ajax({
			type : "post",
			url : "checkTel.do",
			data : "tel=" + tel + "&key=" + key,
			success : function(data) {
				if (data == 0) {
					telChecked = true;
					alert('인증이 완료되었습니다.');
					$(".tel-field").css("display", "none");
				} else if (data == 1) {
					alert('해당 번호로 보낸 인증 키가 없습니다.\n다시 보내 주세요.');
				} else if (data == 2) {
					alert('인증 키가 일치하지 않습니다.');
				}
			}
		})
	}
</script>
</head>
<body>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">일반 회원가입</div>
		<div id="page-content">

			<div class="inner-box">
				<div class="inner-box-content">
					<form class="joinform joinform-emailpw">
						<div class="join-row join-row-title">이메일</div>
						<div class="join-row join-row-content with-button email-field">
							<input class="narrow" type="email" name="email"
								onchange="chkEmail(this)">
							<button type="button" class="join-button email-button"
								onclick="sendEmail(this)">이메일 인증</button>
						</div>
						<div class="join-row join-row-content with-button email-field email-field2">
							<input class="narrow" id="email-key" type="text">
							<button type="button"
								class="join-button email-button accent-button"
								onclick="checkEmailKey()">인증키 입력</button>
						</div>
						<div>
							<div style="height: 30px;"></div>
						</div>
						<div class="join-row join-row-title">비밀번호</div>
						<div class="join-row join-row-content" style="margin: 0px;">
							<input id="pw1" type="password" name="password"><br>
							<input id="pw2" type="password" placeholder="한 번 더 입력">
						</div>
					</form>
				</div>
			</div>

			<p></p>

			<div class="inner-box">
				<div class="inner-box-content">
					<div class="profile-nickname-wrap">
						<div class="join-row join-row-title">프로필 사진과 닉네임</div>
						<div class="join-row join-row-content join-row-profile">
							<div class="profile-picture">
								<img
									src='<%=request.getContextPath()%>/images/profile_default.png'
									width='160px'>
							</div>

							<div class="file-upload">
								<form id="profile">
									<div class="filebox">
										<input type="file" id="file" name="profilePicture" accept="image/*"
											onchange="profileUpload()">
										<div id="profile-buttons">
											<label for="file">파일 선택</label>
											<button type="button" onclick="profileReset()">초기화</button>
										</div>
									</div>
								</form>
							</div>
						</div>

					</div>
					<form class="joinform joinform-rest">
						<div class="join-row join-row-title"></div>
						<div class="join-row join-row-content with-button">
							<input type="hidden" name="profileSrc"
								value="<%=request.getContextPath()%>/images/profile_default.png">
							<input class="narrow" type="text" name="nickname"
								onchange="checkNickAlert(this)" placeholder="닉네임">
							<button type="button" class="join-button nickname-button"
								onclick="checkNickname(this)">중복 확인</button>
						</div>

						<div class="join-row join-row-title">이름</div>
						<div class="join-row join-row-content">
							<input type="text" name="name">
						</div>
						<div class="join-row join-row-title">주소</div>
						<script>
							function searchAddr() {
								new daum.Postcode({
									oncomplete : function(data) {
										$('input[name=address]').val(
												data.address + " ("
														+ data.bname + ")");
										$('input[name=addressDetail]').val(
												data.buildingName);
									}
								}).open();
							}
						</script>
						<div class="join-row join-row-content">
							<input type="text" name="address" readonly onclick="searchAddr()"
								placeholder="주소 검색"> <input type="text"
								name="addressDetail" placeholder="상세 주소">
						</div>
						<div class="join-row join-row-title">휴대폰 번호</div>
						<div class="join-row join-row-content with-button" style="margin: 0px;">
							<input type="number" class="narrow" name="tel"
								id="tel-input" value="" autocomplete="off"
								oninput="maxLengthCheck(this)"
								onchange="checkTelAlert(this)"
								onfocus="chkPhoneType('focus', this)"
								onblur="chkPhoneType('blur', this)" min="0" placeholder="숫자만 입력"
								required>
							<button type="button" class="join-button tel-button"
								onclick="checkPhone(this)">휴대폰 인증</button>
						</div>
						<div class="join-row join-row-content with-button tel-field">
							<input class="narrow" id="tel-key" type="text">
							<button type="button"
								class="join-button tel-button accent-button"
								onclick="checkTelKey()">인증키 입력</button>
						</div>

						<div class="join-row join-row-title" style="margin-top: 30px">성별</div>
						<div class="join-row join-row-content gender-radioes">
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="gender" value="M" id="flexRadioDefault1" required>
							  <label class="form-check-label" for="flexRadioDefault1">
							    남자
							  </label>
							</div>
							<div class="form-check" style="margin-left: 20px;">
							  <input class="form-check-input" type="radio" name="gender" value="F" id="flexRadioDefault2" required>
							  <label class="form-check-label" for="flexRadioDefault2">
							    여자
							  </label>
							</div>
						</div>

					</form>
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