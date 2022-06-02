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
<title>예약 상세</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/space/rsvdetails.css">

<script>

	var hostIdx = ${hostVO.mIdx};
	var guestIdx = ${gMemberVO.mIdx};

	function cancelRsv(resIdx) {
		
		if (!confirm('예약을 취소하시겠습니까?')) {
			return;
		}
		
		$.ajax({
			type: "post",
			url: "cancelRsv.do",
			data: "resIdx=" + resIdx,
			success: function(result) {
				if (result == 0) {
					alert('정상적으로 취소되었습니다.');
					location.reload();
				} else if (result == 1) {
					location.reload();
				} else if (result == 2) {
					alert('권한이 없습니다.');
				}
				
			}
			
		})
	}
	

	function messageToHost() {
		var option = "width = 500, height = 400, top = 100, left = 200, location = no"
		window.open("/messagePopup.do?type=host&mIdx="+hostIdx,"쪽지 보내기",option);
	}
	
	function messageToGuest() {
		var option = "width = 500, height = 400, top = 100, left = 200, location = no"
		window.open("/messagePopup.do?type=general&mIdx="+guestIdx,"쪽지 보내기",option);
	}

</script>
 
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
				<c:if test="${hlogin != null}">
				<button class="normal-button" onclick="messageToGuest()">쪽지 보내기</button>
				</c:if>
			</div>
			
			<div class="inner-box">
				<div class="inner-box-content pay-content">
					<div class="small-title" style="margin-top: 0px;">
						예약자 이름
					</div>
					<div class="content">
						${gMemberVO.name}
					</div>
					<div class="small-title">
						연락처
					</div>
					<div class="content">
						${gMemberVO.tel}
					</div>
					<div class="small-title">
						이메일
					</div>
					<div class="content">
						${gMemberVO.email}
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
			
			<div class="rsv-buttons-wrap">
				<div class="rsv-cancel-info">
					<c:choose>
						<c:when test="${rsvVO.rsvStatus == 0}">
						예약 취소는 사용 시작 24시간 전까지 가능합니다.
						</c:when>
						<c:otherwise>
						이 예약은 취소되었습니다.
						</c:otherwise>
					</c:choose>
				</div>
				<c:if test="${(rsvVO.startDate > nextDay && rsvVO.rsvStatus == 0) || (hlogin.mIdx == hostVO.mIdx && rsvVO.rsvStatus == 0 && rsvVO.startDate > today)}">
					<button class="normal-button accent-button" onclick="cancelRsv(${rsvVO.resIdx})">
						예약 취소
					</button>
				</c:if>
			</div>
		</div>
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>