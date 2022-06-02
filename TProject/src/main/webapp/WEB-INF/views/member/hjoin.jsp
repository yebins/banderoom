<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<meta charset="UTF-8">
<title>호스트 회원가입</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/member/gjoin.css">

<script>

var brnChecked = false;
var emailChecked = false;
var pwChecked = false;
var nickChecked = false;
var telChecked = false;


function checkBrn(obj) {
	var brn = $("input[name=brn]").val();

	if (brn == null || brn == '' || brn == undefined) {
		return;
	}
	$(obj).attr("disabled", true);
	$(obj).text("• • •");

	$.ajax({
		type : "post",
		url : "checkBrn.do",
		data : "brn=" + brn,
		success : function(data) {
			if (data == 1) {
				alert('이미 존재하는 사업자등록번호입니다.');
			} else if (data == 0) {
				alert('사용 가능한 사업자등록번호입니다.')
				$(obj).removeClass("accent-button");
				brnChecked = true;
			}
			$(obj).attr("disabled", false);
			$(obj).text("중복 확인");
		}
	})
}


function profileUpload() {
	
	var formData = new FormData($('#profile')[0])
	$.ajax({
		url: "profileUpload.do",
		type: "post",
		data: formData,
		contentType: false,
		processData: false,
		success: function(data) {
			$('div.profile-picture').html("<img src='" + data + "' width='160px'>");
			$('input[name=profileSrc]').val(data);
		}
	});
	
}

function profileReset() {
	$('#profile')[0].reset();
	$('div.profile-picture').html("<img src='/images/profile_default.png' width='160px'>");
	$('input[name=profileSrc]').val('/images/profile_default.png');
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
		data : "email=" + email + "&memberType=host", // 중복 체크를 일반과 호스트회원 각각 해야하므로 변수로 넣어줌
		success : function(data) {

			if (data == 2) {
				alert('이미 존재하는 이메일입니다.');
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
				$(".email-field2").css("display", "none");
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

function chkPw() {
	var pwReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/;

	pwChecked = false;
	if ($("#pw1").val() == $("#pw2").val() && pwReg.test($("#pw1").val())) {
		pwChecked = true;
		$("span.pwCheck-message").text("");
	} else {
		if($("#pw2").val() != '') {
			
			if ($("#pw1").val() != $("#pw2").val()) {
				$("span.pwCheck-message").text("비밀번호가 일치하지 않습니다.");
			} else if (!pwReg.test($("#pw1").val())) {
				$("span.pwCheck-message").text("영문, 숫자, 기호 포함 8~20자 입력해주세요.");
			}
		}
	}
}

function checkNickAlert(obj) {
	nickChecked = false;
	$(obj).next().addClass("accent-button");
}

const getByteLengthOfString = function(s,b,i,c){
    for(b = i = 0; c = s.charCodeAt(i++); b += c >> 11 ? 3 : c >> 7 ? 2 : 1);
    return b;
};

function checkNickname(obj) {
	var nickname = $("input[name=nickname]").val();

	if (nickname == null || nickname == '') {
		return;
	}
	
	if (getByteLengthOfString(nickname) > 30) {
		alert('닉네임은 한글 10자, 영문 30자 이내로 입력하세요.');
		return;
	}
	
	$(obj).attr("disabled", true);
	$(obj).text("• • •");

	$.ajax({
		type : "post",
		url : "checkNickname.do",
		data : "nickname=" + nickname + "&memberType=host",
		success : function(data) {
			if (data == 1) {
				alert('이미 존재하는 닉네임입니다.');
			} else if (data == 0) {
				alert('사용 가능한 닉네임입니다.')
				$(obj).removeClass("accent-button");
				nickChecked = true;
			}
			$(obj).attr("disabled", false);
			$(obj).text("중복 확인");
		}
	})
}

function nameMaxLengthCheck(input) {
	var name = $(input).val();
	if (getByteLengthOfString(name) > 20) {
		
		$(input).val(name.getStringFromByteLength(20));
	}
}

String.prototype.getStringFromByteLength = function( length ) {
	const contents = this;
	let str_character;
	let int_char_count = 0;
	let int_contents_length = contents.length;
	
	let returnValue = '';
	
	for (k = 0; k < int_contents_length; k++) {
	    str_character = contents.charAt(k);
	    if (escape(str_character).length > 4)
	        int_char_count += 2;
	    else
	        int_char_count++;
	
	    if ( int_char_count > length ) {
	        break;
	    }
	    returnValue += str_character;
	}
	return returnValue;
}

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
		data : "tel=" + tel + "&regkey=" + key,
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

function resetAllForms() {
	$('form').each(function() {
		this.reset();
	});
}

function submitAllForms(obj) {
	if (!emailChecked) {
		alert('이메일 인증이 필요합니다.');
		return;
	}
	if (!pwChecked) {
		alert('비밀번호를 확인해 주세요.');
		return;
	}
	if (!nickChecked) {
		alert('닉네임 중복 확인이 필요합니다.');
		return;
	}
	if (!telChecked) {
		alert('휴대폰 인증이 필요합니다.');
		return;
	}
	if (!$("#term-1").is(":checked") || !$("#term-2").is(":checked")) {
		alert('약관에 동의가 필요합니다.');
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

	$(obj).text("• • •");
	
	$.ajax({
		type: "post",
		url: "hjoin.do",
		data: $('form.joinform').serialize(),
		success: function(data) {
			if (data > 0) {
				// 성공
				alert("회원가입이 완료되었습니다.");
				location.href='/';
				
			} else {
				// 실패
				alert("가입에 실패했습니다. 다시 시도해 주세요.");
				location.href='/';
			}
		}
	})
	
}

function viewTerms(idx) {
	$("#term-wrap-" + idx).css("display", "flex");
	$("#term-wrap-" + idx).animate({opacity: "100%"}, 200);
}

function closeTerms(obj) {
	$(obj).parent().animate({opacity: "0%"}, 200);
	setTimeout(function() {
		$(obj).parent().css("display", "none");
	}, 200);
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
		<div id="page-title">호스트 회원가입</div>
		<div id="page-content">

			<div class="inner-box inner-box-emailpw" style="margin-bottom: 50px;">
				<div class="inner-box-content">
					<form class="joinform joinform-emailpw">
						
							<div class="join-row join-row-title">사업자등록번호</div>
							<div class="join-row join-row-content with-button">
								<input class="narrow" type="text" name="brn"
									onchange="checkNickAlert(this)" placeholder="" required>
								<button type="button" class="normal-button join-button nickname-button"
									onclick="checkBrn(this)">중복 확인</button>
							</div>	
						<div class="join-row join-row-title password-title"><span>비밀번호</span><span class="pwCheck-message"></span></div>
						<div class="join-row join-row-content" style="margin: 0px;">
							<input id="pw1" type="password" name="password" onchange="chkPw()" required><br>
							<input id="pw2" type="password" placeholder="한 번 더 입력" onchange="chkPw()" required>
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
									width='160px' class="profile-picture-img">
							</div>

							<div class="file-upload">
								<form id="profile">
									<div class="filebox">
										<input type="file" id="file" name="profilePicture" accept="image/*"
											onchange="profileUpload()">
										<div id="profile-buttons">
											<label for="file">파일 선택</label>
											<button type="button" class="normal-button" onclick="profileReset()">초기화</button>
										</div>
									</div>
								</form>
							</div>
						</div>

					</div>
					<form class="joinform joinform-rest">
					
						<div class="join-row join-row-title">이메일</div>
						<div class="join-row join-row-content with-button email-field">
							<input class="narrow" type="email" name="email"
								onchange="chkEmail(this)" required>
							<button type="button" class="normal-button join-button email-button"
								onclick="sendEmail(this)">이메일 인증</button>
						</div>
						<div class="join-row join-row-content with-button email-field email-field2">
							<input class="narrow" id="email-key" type="text" placeholder="30분 안에 입력해주세요.">
							<button type="button"
								class="normal-button join-button email-button accent-button"
								onclick="checkEmailKey()">인증키 입력</button>
						</div>
						<div class="join-row join-row-title"></div>
						<div class="join-row join-row-content with-button">
							<input type="hidden" name="profileSrc"
								value="<%=request.getContextPath()%>/images/profile_default.png">
							<input class="narrow" type="text" name="nickname"
								onchange="checkNickAlert(this)" placeholder="닉네임" required>
							<button type="button" class="normal-button join-button nickname-button"
								onclick="checkNickname(this)">중복 확인</button>
						</div>

						<div class="join-row join-row-title">이름</div>
						<div class="join-row join-row-content">
							<input type="text" name="name" onkeyup="nameMaxLengthCheck(this)" required>
						</div>
						<div class="join-row join-row-title">주소</div>
						<div class="join-row join-row-content">
							<input type="hidden" name="addr1">
							<input type="hidden" name="addr2">
							<input type="text" name="address" readonly onclick="searchAddr()"
								placeholder="주소 검색" required>
							<input type="text" name="addressDetail" placeholder="상세 주소">
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
						<br>
						<div class="join-row join-row-content" style="margin-bottom: 0px;">
							<div class="check-wrap">
								<div class="form-check">
								  <input class="form-check-input t2" type="checkbox" value="" id="term-1">
								  <span class="terms-link" onclick="viewTerms(1)">이용약관</span>
								  <label class="form-check-label" for="term-1">
								    에 동의
								  </label>
								</div>
							</div>
							<div class="check-wrap">
								<div class="form-check">
								  <input class="form-check-input t2" type="checkbox" value="" id="term-2">
								  <span class="terms-link" onclick="viewTerms(2)">개인정보 처리방침</span>
								  <label class="form-check-label" for="term-2">
								    에 동의
								  </label>
								</div>
							</div>
						</div>
						
					</form>
				</div>
			</div>
			
		<div class="outter-buttons">
		
				<button class="normal-button" onclick="resetAllForms()">초기화</button>
				<button class="normal-button accent-button" style="margin-left: 20px;" onclick="submitAllForms(this)">회원가입</button>
		</div>
				
		</div>
	</div>
	
	<div id="term-wrap-1" class="terms-wrap">
		<div class="term-background" onclick="closeTerms(this)"></div>
		<div class="inner-box terms-box">
			<div class="terms-title">
				${info.get("1").title}
			</div>
			<div class="terms-content">
				${info.get("1").content}
			</div>
			<div class="terms-button">
				<button class="normal-button accent-button" onclick="closeTerms($(this).parent().parent())">확인</button>
			</div>
		</div>
	</div>
	<div id="term-wrap-2" class="terms-wrap">
		<div class="term-background" onclick="closeTerms(this)"></div>
		<div class="inner-box terms-box">
			<div class="terms-title">
				${info.get("2").title}
			</div>
			<div class="terms-content">
				${info.get("2").content}
			</div>
			<div class="terms-button">
				<button class="normal-button accent-button" onclick="closeTerms($(this).parent().parent())">확인</button>
			</div>
		</div>
	</div>

</body>
</html>