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
	
	.past-rsv-box {
		margin-top: 20px;
		padding: 0px 15px !important;
	}
	
	.past-rsv-wrap {
		padding: 15px 0px;	
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	.past-rsv-wrap:not(.past-rsv-wrap:first-child) {
		border-top: 1px solid lightgray;
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
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a8d83e76596a6e93d144575566c3d5ae&libraries=services"></script>
<script>
	
	var mapContainer;
	
	function drawMap(address, name) {
		mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
	
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();
	
		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	
		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(address, function(result, status) {
		
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div class="map-popup" onclick="window.open(\'https://map.kakao.com/link/search/' + address + '\')">' + name + '</div>'
		        });
		        infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});   
	
	}
	
	function showMap(address, name) {
		event.stopPropagation();
		$("#map").children().remove();
	    drawMap(address, name);
		$("#mapBackOveray").css("visibility", "visible");
	// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	}
	
	$(function() {
		if (${param.dateRange != null || param.dateAll != null}) {
			$("select[name=dateType]").val('${param.dateType}');
			var div = document.getElementById("scroll-here");
			div.scrollIntoView();
		}
	})
	
	function review(resIdx) {
		

		window.open('review.do?resIdx=' + resIdx, '_blank', 
        'top=140, left=200, width=800, height=500, menubar=no,toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');
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
			<div id="scroll-here"></div>
			<div class="big-title" style="margin-top: 60px;">
				예약 내역
			</div>
			<div class="filters-wrap">
				<form action="myspacersv.do">
					<select name="dateType" class="normal-button">
						<option value="resDate">예약일</option>
						<option value="startDate">공간 사용일</option>
					</select>
					<input class="datepicker-here dateInput" name="dateRange"
						data-language="ko" data-range="true" data-multiple-dates-separator=" ~ "
						type="text" id="dateRange" autocomplete="false" placeholder="기간 선택" value="${param.dateRange}" readonly>
					<button type="button" class="normal-button dateInput-button" onclick="location.href='myspacersv.do?dateAll=1'">전체보기</button>
					<button class="normal-button accent-button dateInput-button">검색</button>
				</form>
			</div>
			<div>
				<div class="inner-box past-rsv-box">
					<c:forEach var="rsvVO" items="${pastRsv}">
						<div class="past-rsv-wrap">
							<div class="past-rsv-info-wrap">
								<div class="past-rsv-name"><a href="details.do?idx=${rsvVO.idx}">${rsvVO.name}</a></div>
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
										<div class="small-title">이용료</div>
										<div class="small-content">
											<fmt:formatNumber value="${rsvVO.cost}" pattern="#,###" />원
										</div>
									</div>&nbsp;&nbsp;
									<div class="past-rsv-info-items">
										<div class="small-title">결제 금액</div>
										<div class="small-content">
											<fmt:formatNumber value="${rsvVO.totalCost}" pattern="#,###" />원
										</div>
									</div>&nbsp;&nbsp;
								</div>
							</div>
							<div class="past-rsv-buttons">
								<c:if test="${rsvVO.endDate < today}">
									<button class="normal-button accent-button" onclick="review(${rsvVO.resIdx})">후기 작성</button>&nbsp;
								</c:if>
								<button class="normal-button" onclick="location.href='rsvdetails.do?resIdx=${rsvVO.resIdx}'">예약 상세</button>
							</div>
						</div>
					</c:forEach>
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