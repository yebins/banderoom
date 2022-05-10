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
	#page-content {
		max-width: 700px;
	}
	
	.pay-content {
		padding: 20px;
	}
	
	.rsv-info {
		font-size: 20px;
	}
	
	.big-title {
		font-size: 28px;
		font-weight: bold;
		margin: 40px 0px 20px 0px;
	}
	
	.small-title {
		font-size: 14px;
		font-weight: bold;
		margin-top: 20px;
	}
	
	.content {
		font-size: 20px;
	}
	
	.space-thumb {
		width: 200px;
		height: 150px;
		border-radius: 10px;
		overflow: hidden;
		box-shadow: 0px 4px 8px rgba(0,0,0,0.4);
	}
	
	.big-title-wrap {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.big-title-button {
		margin: 40px 0px 20px 0px;
		width: fit-content;
		padding: 0px 20px;
	}
	
	.rsv-input {
		min-width: 80%;
		height: 36px;
		border: 1px solid lightgray;
		border-radius: 18px;
		padding: 0px 20px;
		font-size: 18px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		margin-top: 10px;
	}
	
	button.pay-method {
		width: fit-content;
		padding: 0px 20px;
		font-size: 16px;
		margin: 10px 15px 0px 0px;
	}
	
	.point-wrap {
		margin-top: 10px;
		display: flex;
		align-items: center;
	}
	
	.rsv-input.point {
		margin: 0px 10px 0px 0px;
		width: 104px;
		min-width: unset;
		text-align: right;
	}
	.rsv-input.point::-webkit-outer-spin-button,
	.rsv-input.point::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
	}
	
	.point-button {
		font-size: 16px;
		margin-left: 20px;
	}
	
	.total-cost, .total-cost * {
		font-size: 30px;
		font-weight: bold;
		color: #fb6544;
	}
	
	.terms-wrap {
		margin-top: 10px;
	}
	
	.form-check-input:checked {
    background-color: #fb6544;
    border-color: #fb6544;
	}
	.form-check-input:focus {
		outline: none;
		box-shadow: none;
		border-color: #fb6544;
	}
	
	.check-wrap {
		width: 100%;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.term-button {
		width: fit-content;
		padding: 0px 12px;
		height: 24px;
		border-radius: 12px;
		font-size: 12px;
	}
	
	.terms-detail {
		border-radius: 10px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		margin: 5px 0px;
		font-size: 14px;
		padding: 5px;
		display: none;
	}
	
	.terms-detail ol > li {
		margin-top: 5px;
	}
	
	.submit-button-wrap {
		margin-top: 50px;
	}
	
	.submit-button {
		width: 250px;
		height: 60px;
		border-radius: 30px;
		font-size: 28px;
	}
	
</style>

<!-- iamport.payment.js -->
 <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
 
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			예약 상세
		</div>
		<div id="page-content">
			<div class="big-title">
				공간 정보
			</div>
			
			<div class="inner-box">
				<div class="inner-box-content pay-content">
					<div class="space-thumb">
						<img src="${spacesVO.thumb}">
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
						<fmt:formatDate value="${rsvVO.startDate}" pattern="yyyy년 M월 d일 H시"/>
						~ <fmt:formatDate value="${rsvVO.endDate}" pattern="H시"/>, ${rsvVO.rsvHours}시간
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
					<div class="small-title">
						포인트 사용
					</div>
					<div class="content">
						<fmt:formatNumber value="${rsvVO.usedPoint}" pattern="#,###"/>P
					</div>
					<div class="small-title">
						결제 금액
					</div>
					<div class="content total-cost">
						<span><fmt:formatNumber value="${rsvVO.totalCost}" pattern="#,###"/></span>원
					</div>
					<div class="small-title">
						적립 포인트
					</div>
					<div class="content">
						<span id="gettingPoint"><fmt:formatNumber value="${rsvVO.totalCost * 0.01}" pattern="#,###"/></span> P
					</div>
				</div>
			</div>
		</div>
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>