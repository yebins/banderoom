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
<title>결제 완료</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/space/paysuccess.css">
<script>

	var hostIdx = ${hostVO.mIdx};
	
	function messageToHost() {
		var option = "width = 500, height = 400, top = 100, left = 200, location = no"
		var mIdx=document.querySelector("#sm-profile-mIdx").value;
		console.log(mIdx);
		window.open("<%=request.getContextPath()%>/messagePopup.do?type=host&mIdx="+hostIdx,"쪽지보내기",option);
	}
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			결제 완료
		</div>
		<div id="page-content">
			<div class="inner-box">
				<div class="inner-box-content pay-content">
					<div class="rsv-info">
						결제가 완료되었습니다.
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
				<c:if test="${login != null}">
				<button class="normal-button" onclick="messageToHost()">쪽지 보내기</button>
				</c:if>
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
			
			<div class="big-title">
				예약자 정보
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
					<div class="small-title" style="margin-top: 0px;">
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