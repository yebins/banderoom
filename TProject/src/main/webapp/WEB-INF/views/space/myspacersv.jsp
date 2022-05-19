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

	#page-content {
		max-width: 900px;
	}

	.big-title {
		font-size: 28px;
		font-weight: bold;
	}
	.big-title:not(.big-title:first-child) {
		margin-top: 60px;
	}
	
	.inner-box.current-rsv {
		background-color: #FBE6B2;
		margin-top: 30px;
		position: relative;
		z-index: 8;
	}
	.inner-box.current-rsv:hover {
		outline: 3px solid #fb6544;
		cursor: pointer;
	}
	
	.inner-box.current-rsv > .inner-box-content {
		display: flex;
	}
	
	.space-thumb {
		width: 160px;
		height: 120px;
		border-radius: 10px;
		overflow: hidden;
		margin-right: 20px;
	}
	.space-thumb img {
		width: 100%;
	}
	
	.space-name {
		font-size: 24px;
		font-weight: bold;
	}
	
	.rsv-date {
		font-size: 18px;
	}
	
	.rsv-info {
		flex: 1;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
	}
	
	.space-address-wrap {
		width: 100%;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.map-button {
		width: 80px;
		margin-left: 20px;
		position: relative;
		z-index: 9;
	}
	
	#mapBackOveray {
		width: 100%; 
		height: 100vh; 
		display: flex; 
		visibility: hidden;
		justify-content: center; 
		align-items: center; 
		background-color: rgba(0,0,0,0.5); 
		position: fixed; 
		top: 0px; 
		left: 0px; 
		z-index: 99999;
	}
	
	#mapBackground {
		width: 100%;
		height: 100%;
		position: absolute;
	}
	
	#map {
		width: 80%;
		height: 80vh;
		padding: 50px;
		z-index: 999999;
		border-radius: 15px;
		overflow: hidden;
	}
	
	.map-popup {
		width: 150px;
		text-align: center;
		padding: 6px; 
		font-size: 14px;
	}
	.map-popup:hover {
		cursor: pointer;
	}
	.filters-wrap {
		display: flex;
		justify-content: flex-end;
		align-items: center;
		margin-top: 20px;
	}
	.filters-wrap select {
		width: fit-content;
		padding: 0px 15px;
		width: 150px;
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
	
	.search-form {
		display: flex;
		align-items: center;
	}
	
	.form-select:focus {
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		outline: none;
	}
	
	.past-rsv-box {
		margin-top: 20px;
		padding: 0px 15px !important;
	}
	
	.past-rsv-wrap {
		padding: 15px 0px;	
		display: flex;
		justify-content: space-between;
		align-items: center;
		border-bottom: 1px solid lightgray;
	}
	
	.past-rsv-name {
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 5px;
	}
	
	.past-rsv-info-items {
		display: inline-flex;
	}
	.small-title {
		font-size: 14px;
		font-weight: bold;
	}
	.small-content {
		font-size: 14px;
		margin-left: 5px;
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
	.cancelled {
		font-size: 14px;
		font-weight: bold;
		color: #fb6544;
		margin-right: 10px;
	}
</style>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.3/moment.min.js"></script>
<script>
	
	$(function() {
		if (${param.dateRange != null || param.dateAll != null}) {
			if (${param.dateAll == null}) {
				$("select[name=dateType]").val('${param.dateType}');
			}			
			var div = document.getElementById("scroll-here");
			div.scrollIntoView();
		}
	})
	
	var currentPage = 1;
	var startPage = ${startPage};
	var endPage = ${endPage};
	var lastPage = ${lastPage};
	var dateType = "";
	var dateRange = "";
	
	if (${param.dateType != null}) {
		dateType = "${param.dateType}";
	}
	if (${param.dateRange != null}) {
		dateRange = "${param.dateRange}";
	}
	
	function loadMyRsv(page) {
		$.ajax({
			type: "get",
			url: "loadMySpaceRsv.do",
			data: "idx=${param.idx}&page=" + page + "&dateType=" + dateType + "&dateRange=" + dateRange,
			success: function(result) {
				
				var gmVOList = result.gmVOList;
				var pastRsv = result.pastRsv;
				
				$("#past-rsv").children().each(function() {
					$(this).remove();
				})
				
				var html = "";
				
				for (var i = 0; i < pastRsv.length; i++) {
					
					html += '<div class="past-rsv-wrap">';
					html += '<div class="past-rsv-info-wrap">';
					html += '<div class="past-rsv-name">' + gmVOList[pastRsv[i].resIdx].name + '</div>';
					html += '<div class="past-rsv-info">';
					html += '<div class="past-rsv-info-items">';
					html += '<div class="small-title">공간 사용일</div>';
					html += '<div class="small-content">';
					
					var date = new Date(pastRsv[i].startDate);
					var dateString = moment(date).format("YYYY/MM/DD k시~");
					
					date = new Date(pastRsv[i].endDate);
					dateString += moment(date).format("k시, ");
					
					dateString += pastRsv[i].rsvHours + "시간";
					
					html += dateString;
					html += '</div></div>&nbsp;&nbsp;';
					html += '<div class="past-rsv-info-items">';
					html += '<div class="small-title">예약일</div>';
					html += '<div class="small-content">';
					
					date = new Date(pastRsv[i].resDate);
					dateString = moment(date).format("YYYY/MM/DD");
					
					html += dateString;
					html += '</div></div></div>';
					html += '<div class="past-rsv-info">';
					html += '<div class="past-rsv-info-items">';
					html += '<div class="small-title">연락처</div>';
					html += '<div class="small-content">';
					html += gmVOList[pastRsv[i].resIdx].tel;
					html += '</div></div>&nbsp;&nbsp;';
					html += '<div class="past-rsv-info-items">';
					html += '<div class="small-title">이용료</div>';
					html += '<div class="small-content">';
					
					var cost = pastRsv[i].cost.toLocaleString();
					
					html += cost + "원";
					html += '</div></div>&nbsp;&nbsp;</div></div>';
					html += '<div class="past-rsv-buttons">';
					
					if (pastRsv[i].rsvStatus == 1) {
						html += '<span class="cancelled">취소됨</span>';
					}
					
					html += '<button class="normal-button" onclick="location.href=\'rsvdetails.do?resIdx=' + pastRsv[i].resIdx + '\'">예약 상세</button>';
					html += '</div></div>';
				}
				
				$("#past-rsv").html(html);
				
				
				$("#page-nav").children().each(function() {
					$(this).remove();
				})
				
				currentPage = page;
				startPage = result.startPage;
				endPage = result.endPage;
				lastPage = result.lastPage;
				
				html = "";
				
				if (lastPage < 6) {
					for (var i = startPage; i <= endPage; i++) {
						if (i == currentPage) {
							html += '<div class="page-nav-button current-page">' + i + '</div>';
						} else {
							html += '<div class="page-nav-button" onclick="loadMyRsv(' + i + ')">' + i + '</div>';
						}
					}
				}
				
				if (lastPage > 5) {
					if (startPage > 5) {
						html += '<div class="page-nav-button" onclick="loadMyRsv(1)">1</div>';
						html += '<div class="page-nav-button" onclick="loadMyRsv(startPage - 1)">◀</div>';
					}

					for (var i = startPage; i <= endPage; i++) {
						if (i == currentPage) {
							html += '<div class="page-nav-button current-page">' + i + '</div>';
						} else {
							html += '<div class="page-nav-button" onclick="loadMyRsv(' + i + ')">' + i + '</div>';
						}
					}
					
					if (endPage < lastPage) {
						html += '<div class="page-nav-button" onclick="loadMyRsv(endPage + 1)">▶</div>';
						html += '<div class="page-nav-button" onclick="loadMyRsv(lastPage)">' + lastPage + '</div>';
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
			공간 예약 내역
		</div>
		<div id="page-content">
			<c:if test="${currentRsv.size() > 0}">
			<div class="big-title">
				현재 예약중인 공간
			</div>
			
			<c:forEach var="rsvVO" items="${currentRsv}">
				<div class="inner-box current-rsv" onclick="location.href='rsvdetails.do?resIdx=${rsvVO.resIdx}'">
					<div class="inner-box-content">
						<div class="space-thumb"><img src="${rsvVO.thumb}"></div>
						<div class="rsv-info">
							<div class="rsv-info-wrap">
								<div class="space-name">${rsvVO.name}</div>
								<div class="rsv-date">
									<fmt:formatDate value="${rsvVO.startDate}" pattern="yyyy년 MM월 dd일 H시"/>
									~ <fmt:formatDate value="${rsvVO.endDate}" pattern="k시"/>, ${rsvVO.rsvHours}시간
								</div>
							</div>
							<div class="space-address-wrap">
								<div class="space-address">${rsvVO.address} ${rsvVO.addressDetail}</div>
								<button class="normal-button map-button" onclick="showMap('${rsvVO.address}', '${rsvVO.name}')">&nbsp;지도<img src="/images/map_pin.png" style="height: 20px; margin-left: 0px;"></button>			
							</div>
							
						</div>
					</div>
				</div>
			</c:forEach>
			</c:if>
			<div class="big-title">
			<div id="scroll-here"></div>
				예약 내역
			</div>
			<div class="filters-wrap">
				<form class="search-form" action="myspacersv.do">
					<input type="hidden" name="idx" value="${param.idx}">
					<select name="dateType" class="form-select normal-button">
						<option value="resDate">예약일</option>
						<option value="startDate">공간 사용일</option>
					</select>
					<input class="datepicker-here dateInput" name="dateRange"
						data-language="ko" data-range="true" data-multiple-dates-separator=" ~ "
						type="text" id="dateRange" autocomplete="false" placeholder="기간 선택" value="${param.dateRange}" readonly>
					<button type="button" class="normal-button dateInput-button" onclick="location.href='myspacersv.do?idx=${param.idx}&dateAll=1'">전체보기</button>
					<button class="normal-button accent-button dateInput-button">검색</button>
				</form>
			</div>
			<div>
				<div class="inner-box past-rsv-box">
					<div id="past-rsv">
					<c:forEach var="rsvVO" items="${pastRsv}">
						<div class="past-rsv-wrap">
							<div class="past-rsv-info-wrap">
								<div class="past-rsv-name">${gmVOList.get(rsvVO.getResIdx()).getName()}</div>
								<div class="past-rsv-info">
									<div class="past-rsv-info-items">
										<div class="small-title">공간 사용일</div>
										<div class="small-content">
											<fmt:formatDate value="${rsvVO.startDate}" pattern="yyyy/MM/dd H시~"/>
											<fmt:formatDate value="${rsvVO.endDate}" pattern="k시"/>, ${rsvVO.rsvHours}시간
										</div>
									</div>&nbsp;&nbsp;
									<div class="past-rsv-info-items">
										<div class="small-title">예약일</div>
										<div class="small-content">
											<fmt:formatDate value="${rsvVO.resDate}" pattern="yyyy/MM/dd"/>
										</div>
									</div>
								</div>
								<div class="past-rsv-info">
									<div class="past-rsv-info-items">
										<div class="small-title">연락처</div>
										<div class="small-content">${gmVOList.get(rsvVO.resIdx).tel}</div>
									</div>&nbsp;&nbsp;
									<div class="past-rsv-info-items">
										<div class="small-title">이용료</div>
										<div class="small-content">
											<fmt:formatNumber value="${rsvVO.cost}" pattern="#,###" />원
										</div>
									</div>&nbsp;&nbsp;
								</div>
							</div>
							<div class="past-rsv-buttons">
								<c:if test="${rsvVO.rsvStatus == 1}">
									<span class="cancelled">취소됨</span>
								</c:if>
								<button class="normal-button" onclick="location.href='rsvdetails.do?resIdx=${rsvVO.resIdx}'">예약 상세</button>
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
										<div class="page-nav-button" onclick="loadMyRsv(${i})">${i}</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
						<c:if test="${lastPage > 5}">
							<c:if test="${startPage > 5}">
								<div class="page-nav-button" onclick="loadMyRsv(1)">1</div>
								<div class="page-nav-button" onclick="loadMyRsv(${startPage - 1})">◀</div>
							</c:if>
							
							<c:forEach var="i" begin="${startPage}" end="${endPage}">
								<c:choose>
									<c:when test="${i == param.page}">
										<div class="page-nav-button current-page">${i}</div>
									</c:when>
									<c:otherwise>
										<div class="page-nav-button" onclick="loadMyRsv(${i})">${i}</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<c:if test="${endPage < lastPage}">
								<div class="page-nav-button" onclick="loadMyRsv(${endPage + 1})">▶</div>
								<div class="page-nav-button" onclick="loadMyRsv(${lastPage})">${lastPage}</div>
							</c:if>
						</c:if>
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
	
	
	<div id="mapBackOveray">
		<div id="mapBackground" onclick="$(this).parent().css('visibility', 'hidden')"></div>
		<div id="map"></div>
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>