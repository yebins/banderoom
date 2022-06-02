<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제 확인</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/space/payment.css">

<!-- iamport.payment.js -->
 <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
 
<script>

	var login = {
			mIdx: ${login.mIdx},
			point: ${login.point},
			email: '${login.email}',
			name: '${login.name}',
			tel: '${login.tel}'
	}
	
	var rsvVO = {
			peopleNum: ${rsvVO.peopleNum},
			rsvHours: ${rsvVO.rsvHours},
			cost: ${rsvVO.cost}
	}
	
	var spacesVO = {
			idx: ${spacesVO.idx},
			name: '${spacesVO.name}'
	}

</script>

<script src="<%=request.getContextPath() %>/js/space/payment.js"></script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			결제 확인
		</div>
		<div id="page-content">
			<div class="inner-box">
				<div class="inner-box-content pay-content">
					<div class="rsv-info">
						아래 항목을 확인하신 후 결제를 진행해 주세요.
					</div>		
				</div>
			</div>
			
			<div class="big-title">
				공간 정보
			</div>
			
			<div class="inner-box">
				<div class="inner-box-content pay-content">
					<div class="space-thumb">
						<img src="<%=request.getContextPath() %>${spacesVO.thumb}">
					</div>
					<div class="small-title">
						공간 이름
					</div>
					<div class="content">
						${spacesVO.name}
					</div>
					<div class="small-title">
						공간 분류
					</div>
					<div class="content">
						${spacesVO.type}
					</div>
					<div class="small-title">
						주소
					</div>
					<div class="content">
						${spacesVO.address}<br>${spacesVO.addressDetail}
					</div>
					<div class="small-title">
						시간당 이용료
					</div>
					<div class="content">
						<fmt:formatNumber value="${spacesVO.cost}" pattern="#,###"/>원
					</div>
				</div>
			</div>
			
			
			<div class="big-title">
				호스트 정보
			</div>
			
			<div class="inner-box">
				<div class="inner-box-content pay-content">
					<div class="small-title" style="margin-top: 0px;">
						호스트 이름
					</div>
					<div class="content">
						${hostVO.name}
					</div>
					<div class="small-title">
						사업자등록번호
					</div>
					<div class="content">
						${hostVO.brn}
					</div>
					<div class="small-title">
						전화번호
					</div>
					<div class="content">
						${hostVO.tel}
					</div>
					<div class="small-title">
						이메일
					</div>
					<div class="content">
						${hostVO.email}
					</div>
				</div>
			</div>
			
			<div class="big-title-wrap">
				<div class="big-title">
					예약자 정보
				</div>
				<!-- <button class="normal-button big-title-button">내 정보에서 가져오기</button> -->
			</div>
			
			<div class="inner-box">
				<div class="inner-box-content pay-content">
					<div class="small-title" style="margin-top: 0px;">
						예약자 이름
					</div>
					<div class="content">
						${login.name}
					</div>
					<div class="small-title">
						연락처
					</div>
					<div class="content">
						${login.tel}
					</div>
					<div class="small-title">
						이메일
					</div>
					<div class="content">
						${login.email}
					</div>
				</div>
			</div>
			
			<div class="big-title">
				예약 정보
			</div>
			
			<div class="inner-box">
				<div class="inner-box-content pay-content">
					<div class="small-title" style="margin-top: 0px;">
						예약 날짜 / 시간
					</div>
					<div class="content">
						<fmt:formatDate value="${rsvVO.startDate}" pattern="yyyy년 M월 d일 k시"/>
						~ <fmt:formatDate value="${rsvVO.endDate}" pattern="k시"/>, ${rsvVO.rsvHours}시간
					</div>
					<textarea id="startDate" style="display: none" readonly>
						<fmt:formatDate value="${rsvVO.startDate}" pattern="yyyy-MM-dd-HH"/>
					</textarea>
					<textarea id="endDate" style="display: none" readonly>
						<fmt:formatDate value="${rsvVO.endDate}" pattern="yyyy-MM-dd-HH"/>
					</textarea>
					<div class="small-title">
						예약 인원
					</div>
					<div class="content">
						${rsvVO.peopleNum}명
					</div>
					<div class="small-title">
						이용료 합계
					</div>
					<div class="content">
						<b><fmt:formatNumber value="${rsvVO.cost}" pattern="#,###"/>원</b>
					</div>
				</div>
			</div>
			
			<div class="big-title">
				결제 정보
			</div>
			
			<div class="inner-box">
				<div class="inner-box-content pay-content">
					<div class="small-title" style="margin-top: 0px">
						포인트 사용 (<fmt:formatNumber value="${login.point}" pattern="#,###"/>P 사용 가능)
					</div>
					<div class="content">
						<div class="point-wrap">
							<input class="rsv-input point" type="number" min="0" max="${login.point}" value="0" onblur="checkPoint()">
							P
							<button class="normal-button point-button" onclick="useAllPoint()">전액 사용</button>		
						</div>
					</div>
					<div class="small-title">
						결제 금액
					</div>
					<div class="content total-cost">
						<span><fmt:formatNumber value="${rsvVO.cost}" pattern="#,###"/></span>원
					</div>
					<div class="small-title">
						적립 예정 포인트
					</div>
					<span id="gettingPoint"><fmt:formatNumber value="${rsvVO.cost * 0.01}" pattern="#,###"/></span> P
					<div class="small-title">
						약관 동의
					</div>
					<div class="content">
						<div class="terms-wrap">
							<div class="form-check">
							  <input class="form-check-input t1" type="checkbox" value="" id="term-1">
							  <label class="form-check-label" for="term-1">
							    위 공간의 예약조건 확인 및 결제 진행 동의
							  </label>
							</div>
							<div class="check-wrap">
								<div class="form-check">
								  <input class="form-check-input t2" type="checkbox" value="" id="term-2">
								  <label class="form-check-label" for="term-2">
								    개인정보 제3자 제공 동의
								  </label>
								</div>
								<button class="normal-button term-button" data-terms="2" onclick="viewTerms(this)">내용 보기</button>
							</div>
							<div class="terms-detail" data-terms="2">
								<ol>
									<li>개인정보를 제공받는 자: 해당 공간의 호스트</li>
									<li>제공하는 개인정보 항목
										<ul>
											<li>필수항목: 네이버 아이디, 이름, 연락처, 결제정보(결제방식 및 결제금액)</li>
											<li>선택항목: 이메일 주소</li>
										</ul>
									</li>
									<li>개인정보의 제공목적: 공간예약 및 이용 서비스 제공, 환불처리</li>
									<li>개인정보의 제공기간: 서비스 제공기간(단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 및 사전 동의를 득한 경우에는 해당 기간 동안 보관합니다.)</li>
									<li>개인정보의 제공을 거부할 권리: 개인정보 주체는 개인정보의 제공을 거부할 권리가 있으나, 공간 예약을 위해 반드시 필요한 개인정보의 제공으로서 이를 거부할 시 공간 예약이 어려울 수 있습니다.</li>
								</ol>
							</div>
							<div class="check-wrap">
								<div class="form-check">
								  <input class="form-check-input t3" type="checkbox" value="" id="term-3">
								  <label class="form-check-label" for="term-3">
								    개인정보 수집 및 이용 동의
								  </label>
								</div>
								<button class="normal-button term-button" data-terms="3" onclick="viewTerms(this)">내용 보기</button>
							</div>
							<div class="terms-detail" data-terms="3">
								<ol>
									<li>수집하는 개인정보의 항목
										<ul>
											<li>예약정보(성명, 이메일주소, 휴대전화번호), 결제정보(신용카드 번호 및 은행계좌정보 일부 등)</li>
										</ul>
									</li>
									<li>개인정보의 이용목적
										<ul>
											<li>공간 예약 및 이용</li>
										</ul>
									</li>
									<li>개인정보의 보관기간
										<ul>
											<li>예약 완료 후 관련 법령에 따라 5년간 개인정보를 보관합니다.</li>
										</ul>
									</li>
									<li>개인정보의 수집 및 이용을 거부할 권리
										<ul>
											<li>개인정보 주체는 개인정보의 수집 및 이용을 거부할 권리가 있으나, 공간 예약을 위한 최소한의 개인정보 수집으로서 이를 거부할 시 공간 예약이 어려울 수 있습니다.</li>
										</ul>
									</li>
								</ol>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="submit-button-wrap">
			<button class="normal-button accent-button submit-button" onclick="paySubmit()">결제하기</button>
		</div>
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>