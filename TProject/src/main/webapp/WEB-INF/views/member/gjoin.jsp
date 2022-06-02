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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/member/gjoin.css">
<script src="<%=request.getContextPath()%>/js/member/gjoin.js"></script>
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

			<div class="inner-box inner-box-emailpw" style="margin-bottom: 50px;">
				<div class="inner-box-content">
					<form class="joinform joinform-emailpw">
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
						<div>
							<div style="height: 30px;"></div>
						</div>
						<div class="join-row join-row-title password-title"><span>비밀번호</span><span class="pwCheck-message"></span></div>
						<div class="join-row join-row-content" style="margin: 0px;">
							<input id="pw1" type="password" name="password" onchange="chkPw()" required><br>
							<input id="pw2" type="password" placeholder="한 번 더 입력" onchange="chkPw()" required>
						</div>
					</form>
					
					<c:if test="${kakao != null}">
					
						<style>
							div.inner-box-emailpw {
								background-color: #FEE500;
								padding: 40px 80px;
							}
						
							form.joinform-emailpw {
								display: none;
							}
							
							
						</style>
						
						<script>
							emailChecked = true;
							pwChecked = true;
							$('input[name=email]').val('${kakao.email}');
						</script>
						
						<div id="kakao-account">
							카카오 계정으로 회원가입 중입니다.
						</div>
						<div>
							사이트 로그아웃 시 카카오 계정은 로그아웃되지 않습니다.
						</div>
					
					</c:if>
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
						<input type="hidden" name="isKakao" value="${param.isKakao}">
						<div class="join-row join-row-title"></div>
						<div class="join-row join-row-content with-button">
							<input type="hidden" name="profileSrc"
								value="<%=request.getContextPath()%>/images/profile_default.png">
							<input class="narrow" type="text" name="nickname"
								onchange="checkNickAlert(this)" placeholder="닉네임" required>
							<button type="button" class="normal-button join-button nickname-button"
								onclick="checkNickname(this)">중복 확인</button>
						</div>
						
						<c:if test="${kakao != null}">
							<script>
								$('img.profile-picture-img').attr("src", "${kakao.profileSrc}");
								$('input[name=profileSrc]').val('${kakao.profileSrc}');
								$('input[name=nickname]').val('${kakao.nickname}');
							</script>
						</c:if>

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