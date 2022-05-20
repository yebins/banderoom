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
<link href="/css/air-datepicker/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<!-- Air datepicker css -->
<script src="/js/air-datepicker/datepicker.js"></script> <!-- Air datepicker js -->
<script src="/js/air-datepicker/datepicker.ko.js"></script> <!-- 달력 한글 추가를 위해 커스텀 -->

<style>
	.point-title-wrap {
		margin-top: 30px;
		display: flex;
		justify-content: space-between;
	}
	.total-point {
		font-size: 28px;
		font-weight: bold;
	}
	#point-box {
		padding: 0px 15px;
		margin-top: 30px;
	}
	.elements-wrap {
		display: flex;
		align-items: center;
		padding: 15px 0px;
		height: 80px;
	}
	.elements-wrap:not(.elements-wrap:first-child) {
		border-top: 1px solid lightgray;
	}
	.point-content-wrap {
		flex: 1;
	}
	.point-display {
		height: 100%;
		width: 120px;
		border-left: 1px solid lightgray;
		margin-left: 15px;
		display: flex;
		flex-direction: column;
		justify-content: center;
		padding-left: 15px;
	}
	
	.point-content {
		font-size: 20px;
		font-weight: bold;
	}
	.point-resDate {
		text-align: right;
		color: darkgray;
	}
	
	.small-title {
		font-size: 14px;
		font-weight: bold;
	}
	
	.point-amount {
		font-size: 22px;
		text-align: right;
	}
	.point-amount.acheieved {
		color: #fb6544;
	}
	.point-amount.used {
		color: #00BFFF;
	}
	.point-amount.balance {
		font-weight: bold;
	}
	
	.filters-wrap {
		display: flex;
		justify-content: flex-end;
		align-items: center;
		margin-top: 20px;
	}
	.dateInput {
		margin-left: 10px;
		width: 250px;
		text-align: center;
		border: 1px solid lightgray;
		height: 40px;
		border-radius: 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
	}
	.dateInput-button {
		margin-left: 10px;
	}
	
	#page-nav {
		border-top: 1px solid lightgray;
		width: 100%;
		height: 80px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.page-nav-button {
		width: 40px;
		height: 40px;
		border-radius: 20px;
		margin: 7.5px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.page-nav-button:not(.current-page) {
		cursor: pointer;
	}
	.page-nav-button.current-page {
		background-color: #fbe6b2;
		font-weight: bold;
	}
</style>

<script src="https://cdn.jsdelivr.net/npm/moment@2.29.3/moment.min.js"></script>
<script>
	
	var currentPage = 1;
	var startPage = ${startPage};
	var endPage = ${endPage};
	var lastPage = ${lastPage};
	var dateRange = "";
	
	if (${param.dateRange != null}) {
		dateRange = "${param.dateRange}";
	}
	
	function loadMyPoint(page) {
		$.ajax({
			type: "get",
			url: "loadmypoint.do",
			data: "page=" + page + "&dateRange=" + dateRange,
			success: function(data) {

				var pointVO = data.pointVO;
				
				var html = "";
				
				for (var i = 0; i < pointVO.length; i++) {
					html += '<div class="elements-wrap">';
					html += '<div class="point-content-wrap">';
					html += '<div class="point-content">';
					html += '<a href="rsvdetails.do?resIdx=' + pointVO[i].resIdx + '">' + pointVO[i].content + '</a>';
					html += '</div>';
					html += '<div class="point-resDate">';
					
					var date = new Date(pointVO[i].resDate);
					var dateString = moment(date).format("YYYY.MM.DD HH:mm:ss");
					
					html += dateString;
					html += '</div></div>';
					html += '<div class="point-amount-wrap point-display">';
					
					if (pointVO[i].amount > 0) {
						html += '<div class="small-title">획득</div>';
						html += '<div class="point-amount acheieved">';
						html += pointVO[i].amount.toLocaleString();
						html += '</div>';
					} else {
						html += '<div class="small-title">사용</div>';
						html += '<div class="point-amount used">';
						html += pointVO[i].amount.toLocaleString();
						html += '</div>';
					}
					
					html += '</div>';
					html += '<div class="point-balance-wrap point-display">';
					html += '<div class="small-title">잔액</div>';
					html += '<div class="point-amount balance">';
					html += pointVO[i].balance.toLocaleString();
					html += '</div></div></div>';
					
				}
				
				$("#point-wrap").html(html);
				
				html = "";
				
				currentPage = page;
				startPage = data.startPage;
				endPage = data.endPage;
				lastPage = data.lastPage;


				if (lastPage < 6) {
					for (var i = startPage; i <= endPage; i++) {
						if (i == currentPage) {
							html += '<div class="page-nav-button current-page">' + i + '</div>';
						} else {
							html += '<div class="page-nav-button" onclick="loadMyPoint(' + i + ')">' + i + '</div>';
						}
					}
				}
				
				if (lastPage > 5) {
					if (startPage > 5) {
						html += '<div class="page-nav-button" onclick="loadMyPoint(1)">1</div>';
						html += '<div class="page-nav-button" onclick="loadMyPoint(startPage - 1)">◀</div>';
					}

					for (var i = startPage; i <= endPage; i++) {
						if (i == currentPage) {
							html += '<div class="page-nav-button current-page">' + i + '</div>';
						} else {
							html += '<div class="page-nav-button" onclick="loadMyPoint(' + i + ')">' + i + '</div>';
						}
					}
					
					if (endPage < lastPage) {
						html += '<div class="page-nav-button" onclick="loadMyPoint(endPage + 1)">▶</div>';
						html += '<div class="page-nav-button" onclick="loadMyPoint(lastPage)">' + lastPage + '</div>';
					}
				}
				
				$("#page-nav").html(html);
				
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
			포인트 내역
		</div>
		<div id="page-content">
			<div class="point-title-wrap">
				<div class="point-info inner-box">
					<div class="small-title">현재 포인트</div>
					<div class="total-point">
						<fmt:formatNumber value="${login.point}" pattern="#,###" />
					</div>
				</div>
				<div class="filters-wrap">
					<form action="mypoint.do">
						<input class="datepicker-here dateInput" name="dateRange"
							data-language="ko" data-range="true" data-multiple-dates-separator=" ~ "
							type="text" id="dateRange" autocomplete="false" placeholder="기간 선택" value="${param.dateRange}" readonly>
						<button type="button" class="normal-button dateInput-button" onclick="location.href='mypoint.do'">전체보기</button>
						<button class="normal-button accent-button dateInput-button">검색</button>
					</form>
				</div>
			</div>
			<div id="point-box" class="inner-box">
				<div id="point-wrap">
					<c:forEach var="pointVO" items="${pointVO}">
					<div class="elements-wrap">
						<div class="point-content-wrap">
							<div class="point-content">
								<a href="rsvdetails.do?resIdx=${pointVO.resIdx}">${pointVO.content}</a>
							</div>
							<div class="point-resDate">
								<fmt:formatDate value="${pointVO.resDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
							</div>
						</div>
						<div class="point-amount-wrap point-display">
						<c:choose>
							<c:when test="${pointVO.amount > 0}">
								<div class="small-title">획득</div>
								<div class="point-amount acheieved">
								  <fmt:formatNumber value="${pointVO.amount}" pattern="#,###" />
								</div>
							</c:when>
							<c:otherwise>
								<div class="small-title">사용</div>
								<div class="point-amount used">
								  <fmt:formatNumber value="${pointVO.amount}" pattern="#,###" />
								</div>
							</c:otherwise>
						</c:choose>
						</div>
						<div class="point-balance-wrap point-display">
							<div class="small-title">잔액</div>
							<div class="point-amount balance">
							  <fmt:formatNumber value="${pointVO.balance}" pattern="#,###" />
							</div>
						</div>
					</div>
					</c:forEach>
				</div>
				<div id="page-nav">
					<c:if test="${lastPage < 6}">
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${i == 1}">
									<div class="page-nav-button current-page">${i}</div>
								</c:when>
								<c:otherwise>
									<div class="page-nav-button" onclick="loadMyPoint(${i})">${i}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
					<c:if test="${lastPage > 5}">
						<c:if test="${startPage > 5}">
							<div class="page-nav-button" onclick="loadMyPoint(1)">1</div>
							<div class="page-nav-button" onclick="loadMyPoint(${startPage - 1})">◀</div>
						</c:if>
						
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${i == param.page}">
									<div class="page-nav-button current-page">${i}</div>
								</c:when>
								<c:otherwise>
									<div class="page-nav-button" onclick="loadMyPoint(${i})">${i}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:if test="${endPage < lastPage}">
							<div class="page-nav-button" onclick="loadMyPoint(${endPage + 1})">▶</div>&nbsp;
							<div class="page-nav-button" onclick="loadMyPoint(${lastPage})">${lastPage}</div>&nbsp;
						</c:if>
					</c:if>
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