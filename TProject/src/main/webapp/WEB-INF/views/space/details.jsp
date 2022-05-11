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
<link rel="stylesheet" type="text/css" href="/css/space/calendar.css">
<style>

	.page-content {
		height: fit-content;
	}
	.space-status {
		width: 100%;
		background-color: #FBE6B2 !important;
		padding: 40px 80px !important;
		height: unset !important;
		margin-top: 40px;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.space-status-content {
		font-size: 24px;
		font-weight: bold;
	}
	
	.space-status button{
		margin-left: 10px;
	}
	
	.space-status-refused {
		background-color: #FB6544 !important;
		color: white;
	}
	
	.space-status-deleted {
		background-color: #FD7F7F !important;
	}
	
	.pictures {
		overflow: hidden;
		padding: 0px !important;
		height: unset !important;
		margin-top: 40px;
	}
	
	.carousel-inner {
		height: 500px;
		display: flex;
		align-items: center;
	}
	
	img.d-block:hover {
		cursor: pointer;
	}
	
	
	#imgBackOveray {
		width: 100%; 
		height: 100vh; 
		display: flex; 
		visibility: hidden;
		justify-content: center; 
		align-items: center; 
		background-color: rgba(0,0,0,0.7); 
		position: fixed; 
		top: 0px; 
		left: 0px; 
		z-index: 99999;
	}
	
	#imgBackground {
		width: 100%;
		height: 100%;
		position: absolute;
	}
	
	#img {
		width: 80%;
		height: 80vh;
		z-index: 999999;
		border-radius: 15px;
		overflow: hidden;
	}
	
	.title {
		margin-top: 40px;
		padding-bottom: 20px;
		border-bottom: 1px solid lightgray;
	}
	
	.outter-buttons {
		width: 100%;
		margin: 50px 0px;
		display: flex;
		justify-content: flex-end;	
	}
	
	.space-name {
		font-size: 30px;
		font-weight: bold;
		margin-bottom: 20px;
		
		display: flex;
		align-items: center;
	}
	
	.like-space {
		margin-left: 20px;
		width: 40px;
		height: 40px;
		background: white;
		border-radius: 25px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.like-space:hover {
		cursor: pointer;
	}
	.like-space:active {
		filter: brightness(90%);
	}
	
	.like-space img {
		width: 20px;
	}
	
	.address {
		display: flex;
		align-items: center;
	}
	
	.map-button {
		width: 80px;
		margin-left: 20px;
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
	
	.space-content {
		margin-top: 40px;
		width: 100%;
	}
	
	.space-info {
		padding: 40px !important;
		position: relative;
	}
	
	.space-info li {
		margin-bottom: 16px;
	}
	
	.colleft {
		padding-left: 0px;
	}
	
	.colright {
		padding-right: 0px;		
	}
	
	@media screen and (max-width: 576px) {
		.carousel-inner {
			height: 50vh;
		}
		.space-info {
			padding: 15px !important;
		}
		.colleft, .colright {
			padding: 10px 0px;
		}
	}
	
	.space-info-subject {
		font-size: 24px;
		font-weight: bold;
		margin-bottom: 10px;
	}
	
	.space-info-subject:not(.space-info-subject:first-child) {
		margin-top: 40px;
	}

	.space-rsv .space-info-subject{
		margin: 25px 10px 0px 10px;
	}
	
	.rsv-info {
		font-size: 14px;
		margin: 10px 0px 0px 10px;
	}

	.space-rsv-subject {
		font-size: 14px;
		font-weight: bold;
		margin-top: 20px;
	}

	.space-rsv input[type=text] {
		width: 100%;
    flex: 1;
    height: 40px;
    border-radius: 20px;
    padding: 0px 20px;
    box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
    border: none;
		margin-top: 10px;
	}
	.day.current:hover {
		cursor: pointer;
	}
	.day.current.selected {
		background-color: #fb6544;
		color: white !important;
	}
	.day.rsv-full {
		background-color: darkgray;
		color: white !important;
	}
	
	.rsv-cal-info {
		display: flex;
		align-items: center;
		margin-top: 20px;
		padding-left: 10px;
	}
	.dayex {
		width: 30px;
		height: 30px;
		border-radius: 15px;
	}
	.dayinfo {
		margin: 0px 20px 0px 10px;
	}

	#timeselect {
		display: none;
		height: 341px;
	}
	#timetable {
		display: flex;
		flex-direction: column;
		flex-wrap: wrap;
		height: 300px;
		overflow: auto;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		border-radius: 10px;
		margin-top: 20px;
	}
	.timeselector {
		height: calc(100% / 8);
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.timeselector:nth-child(8n) {
		border: none;
	}
	.timeselector:hover {
		cursor: pointer;
	}
	.time-selected {
		background-color: #fb6544;
		color: white;
	}
	.time-disabled {
		background-color: darkgray;
		color: white;
	}

	.loadingDiv {
		height: 341px;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 20px;
	}
	.spinner-border {
		width: 100px;
		height: 100px;
		margin: 40px;
		border-width: 10px;
		color: #FB6544;
	}
	
	#rsv-form-wrap {
		display: none;
    margin-top: 40px;
	}
	#rsv-date {
    margin-left: 10px;
    font-size: 28px;
    font-weight: bold;
	}
	#rsv-time {
		margin-left: 10px;
		height: 20px;
	}
	#rsv-peopleNum {
		margin-top: 40px;
	}
	
	.peopleNum-buttons-wrap {
	  display: flex;
    justify-content: center;
    align-items: center;
	}
	
	.peopleNum-buttons {
	  display: flex;
    height: 36px;
    border-radius: 18px;
    overflow: hidden;
    box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
  }
	.peopleNum-buttons * {
		margin: 0px;
	}
	
	.peopleNum-button {
	  border: none;
    background: white;
    width: 36px;
	}
	.peopleNum-button:active {
		filter: brightness(90%); 
	}
	
	#rsv-input-peopleNum {
    border: none;
    border-left: 1px solid lightgray;
    border-right: 1px solid lightgray;
    text-align: center;
	}
	#rsv-input-peopleNum::-webkit-outer-spin-button,
	#rsv-input-peopleNum::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
	}
	
	.rsv-costs-wrap {
		margin-top: 40px;
	}
	
	iframe {
		max-width: 100%;
	}
	
	.space-cost, .rsv-cost {
		text-align: right;
	}
	.space-cost span {
		font-size: 28px;
	}
	.rsv-cost span {
		font-size: 28px;
		font-weight: bold;
	}
	
	.submit-button-wrap {
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 40px;
	}
	
	.rsv-submit {
		width: 100%;
		font-size: 20px;
		height: 50px;
		border-radius: 25px;
	}
	
	.menu {
		height: 60px;
		display: flex;
		justify-content: center;
		align-items: center;
		position: sticky;
		top: 0px;
		margin: 20px auto 0px auto;
		width: 100%;
		background: transparent !important;
		z-index: 99990;
	}
	.menu button {
		margin: 0px 10px;
	}
	.space-info:not(.space-info:first-child) {
		margin-top: 40px;
	}
	
	.score-wrap {
		display: flex;
		align-items: center;
		position: absolute;
		top: 43px;
		right: 40px;
	}
	.score-avg {
		font-size: 20px;
	}
	.score-stars {
		display: flex;
		width: calc(30 * 5)px;
		height: 30px;
		background-color: lightgray;
		position: relative;
		margin-right: 10px;
	}
	.score-color {
		position: absolute;
		top: 0px;
		left: 0px;
		width: ${reviewCntAvg.get("avg") * 30}px;
		height: 100%;
		background-color: #fb6544;
		z-index: 8;
	}
	.score-stars img {
		width: 30px;
		z-index: 9;
	}
	
	.review-wrap {
		border-top: 1px solid lightgray;
		padding-top: 15px;
		margin-top: 15px;
	}
	
	.review-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.review-score-stars {
		display: flex;
		width: calc(24 * 5)px;
		height: 24px;
		background-color: lightgray;
		position: relative;
		margin-left: 10px;
	}
	.review-score-color {
		position: absolute;
		top: 0px;
		left: 0px;
		height: 100%;
		background-color: #fb6544;
		z-index: 8;
	}
	.review-score-stars img {
		width: 24px;
		z-index: 9;
	}
	
	.review-member {
		display: flex;
		align-itmes: center;
	}
	
	.review-profile-img {
		width: 24px;
		height: 24px;
		border-radius: 12px;
		overflow: hidden;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		margin-right: 10px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.review-profile-img img {
		height: 24px;
	}
	
	.review-nickname {
		display: flex;
		justify-content: center;
		align-items: center;
		font-weight: bold;
	}
	.review-nickname:hover {
		cursor: pointer;
	}
	
	.review-score-wrap {
		display: flex;
		align-items: center;
	}
	
	.review-body {
		display: flex;
		margin-top: 15px;
	}
	
	.review-content {
		flex: 1;
		padding-right: 15px;
		word-break: break-all; 
	}
	
	.review-thumb {
		width: 100px;
		border-radius: 10px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.4);
	}
	
	.review-thumb:hover {
		cursor: pointer;
	}
	.review-thumb:active {
		filetr: brightness(90%);
	}
	
	.review-orders {
		margin-top: 30px;
	}
	.review-order-button {
		margin-right: 10px;
		width: 120px;
	}
	.review-nav {
		border-top: 1px solid lightgray;
		margin-top: 10px;
		padding-top: 35px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.review-nav div {
		width: 30px;
		height: 30px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.review-nav img {
		height: 15px;
	}
	.review-nav div:hover {
		cursor: pointer;
	}
	.review-nav div.nav-disabled {
		filter: opacity(20%);
	}
	.review-nav div.nav-disabled:hover {
		cursor: default;
	}
	
</style>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a8d83e76596a6e93d144575566c3d5ae&libraries=services"></script>
	
	<script>
	
	var liked;
	var mIdx = 0;
	
	<c:if test="${login != null}">	//로그인 안되어있으면 mIdx = 0 으로 초기화
	mIdx = ${login.getmIdx()};
	</c:if>
	
	$(function() {
		
		getLikedStatus();
    calendarInit();
    
    for (i = 0; i < 16; i++) {
    	if (i < 8) {
    		$(".timeselector").eq(i).css("border-right", "1px solid lightgray");
    	}
    	if (i % 8 != 7) {
    		$(".timeselector").eq(i).css("border-bottom", "1px solid lightgray");    		
    	}
    }
    

	});
	
	function getRsvFullDates() {

	    // 다음 한 달간 예약정보 조회 (날짜별 총 예약 시간)
	    var now = new Date();
	    var nextDay = new Date(new Date().setMonth(new Date().getMonth() + 1));
	    
			var nowString="";
			nowString += now.getFullYear() + "-";
			if (now.getMonth() + 1 < 10) {
				nowString += "0";
			}
			nowString += (now.getMonth() + 1) + "-";
			if (now.getDate() < 10) {
				nowString += "0";
			}
			nowString += now.getDate();

			var nextDayString="";
			nextDayString += nextDay.getFullYear() + "-";
			if (nextDay.getMonth() + 1 < 10) {
				nextDayString += "0";
			}
			nextDayString += (nextDay.getMonth() + 1) + "-";
			if (nextDay.getDate() < 10) {
				nextDayString += "0";
			}
			nextDayString += nextDay.getDate();
			
	    $.ajax({
	    	type: "get",
	    	url: "getrsvfulldates.do",
	    	data: "spaceIdx=${spacesVO.idx}&nowDate=" + nowString + "&afterMonth=" + nextDayString,
	    	success: function(data) {
					disableFullDates(data);
	    	}
	    })
	}
	
	function disableFullDates(dates) {
		
		for (idx in dates) {
			var disableDate = new Date(dates[idx]);
			
			var disableYear = disableDate.getFullYear();
			var disableMonth = disableDate.getMonth() + 1;
			var disableDay = disableDate.getDate();
			
			$(".year-" + disableYear + ".month-" + disableMonth + ".day-" + disableDay).addClass("rsv-full");
		}
	}
	
	function getLikedStatus() {
		$.ajax({
			type: "post",
			url: "getlikedstatus.do",
			data: {
				mIdx: mIdx,
				spaceIdx: ${spacesVO.getIdx()}
			},
			success: function(result) {
				if (result == 0) {					// 찜하지 않았음
					$(".like-space img").attr("src", "/images/heart-empty.png");
					liked = 0;
				} else if (result == 1) {		// 찜했음
					$(".like-space img").attr("src", "/images/heart-filled.png");
					liked = 1;
				}
			}
		});
	}
	
	function likeSpace() {
		if (liked == 0) {					// 찜하지 않았음
			$.ajax({
				type: "post",
				url: "likespace.do",
				data: {
					mIdx: mIdx,
					spaceIdx: ${spacesVO.getIdx()}
				},
				success: function(result) {
					if (result == -1) {
						console.log("-1: 이미 찜했음");
					} else if (result == 0) {
						console.log("0: 오류");
					} else if (result == 1) {
						console.log("1: 찜하기 완료");
					}
					
					getLikedStatus();
				}
				
			});
			
		} else if (liked == 1) {	// 찜했음
			$.ajax({
				type: "post",
				url: "unlikespace.do",
				data: {
					mIdx: mIdx,
					spaceIdx: ${spacesVO.getIdx()}
				},
				success: function(result) {
					if (result == -1) {
						console.log("-1: 찜하지 않음");
					} else if (result == 0) {
						console.log("0: 오류");
					} else if (result == 1) {
						console.log("1: 찜하기 해제 완료");
					}
					
					getLikedStatus();
				}
			});
		}
		
	}
	
	var mapContainer;
	
	function drawMap() {
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
		geocoder.addressSearch('${spacesVO.getAddress()}', function(result, status) {
		
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
		            content: '<div class="map-popup" onclick="window.open(\'https://map.kakao.com/link/search/${spacesVO.getAddress()}\')">${spacesVO.getName()}</div>'
		        });
		        infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});   

	}
	
	function showMap() {
		$("#map").children().remove();
	    drawMap();
		$("#mapBackOveray").css("visibility", "visible");
    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	}
	
	function deleteSpace() {
		if (confirm('정말 이 공간을 삭제하시겠습니까?')) {
			location.href='delete.do?idx=${spacesVO.getIdx()}';
		}
	}
	
	function drawImage(src) {

		var div = $("#img"); // 이미지를 감싸는 div
		var img = $("<img>"); // 이미지
		
	  $(div).css("width", "80%");
	  $(div).css("height", "80vh");
	    
		$("#img").children().remove();
		
		$(div).append(img);
		
		$(img).attr("src", src);

		setTimeout(() => {
		var divAspect = $(div).height() / $(div).width(); // div의 가로세로비는 알고 있는 값이다
		var imgAspect = $(img).height() / $(img).width();
		
			if (imgAspect >= divAspect) {
			    $(img).css("width", "auto");
			    $(img).css("height", $(div).height());
			} else {
			    $(img).css("width", "100%");
			    $(img).css("height", "auto");
			}

			if (imgAspect >= divAspect) {
			    $(div).css("width", $(img).width() + "px");
			} else {
				  $(div).css("height", $(img).height() + "px");
			}

			$("#imgBackOveray").css("visibility", "visible");
		}, 200);

		
	}


	// 달력
	
	var selectedDate;
	
	/*
	    달력 렌더링 할 때 필요한 정보 목록 
	
	    현재 월(초기값 : 현재 시간)
	    금월 마지막일 날짜와 요일
	    전월 마지막일 날짜와 요일
	*/
	

	var rsvLoading = false;
	
	function calendarInit() {
	
	    // 날짜 정보 가져오기
	    var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
	    var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
	    var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
	    var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
	  
	    var thisMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());
	    // 달력에서 표기하는 날짜 객체
	  
	    
	    var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
	    var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
	    var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일
	
	    // kst 기준 현재시간
	    // console.log(thisMonth);
	
	    // 캘린더 렌더링
	    renderCalender(thisMonth);
	
	    function renderCalender(thisMonth) {
	
	        // 렌더링을 위한 데이터 정리
	        currentYear = thisMonth.getFullYear();
	        currentMonth = thisMonth.getMonth();
	        currentDate = thisMonth.getDate();
	
	        // 이전 달의 마지막 날 날짜와 요일 구하기
	        var startDay = new Date(currentYear, currentMonth, 0);
	        var prevDate = startDay.getDate();
	        var prevDay = startDay.getDay();
	
	        // 이번 달의 마지막날 날짜와 요일 구하기
	        var endDay = new Date(currentYear, currentMonth + 1, 0);
	        var nextDate = endDay.getDate();
	        var nextDay = endDay.getDay();
	
	        // console.log(prevDate, prevDay, nextDate, nextDay);
	
	        // 현재 월 표기
	        $('.year-month').text(currentYear + '년 ' + (currentMonth + 1) + '월');
	
	        // 렌더링 html 요소 생성
	        calendar = document.querySelector('.dates');
	        calendar.innerHTML = '';
	        
	        // 지난달
	        for (var i = prevDate - prevDay; i <= (prevDay == 6 ? 0 : prevDate); i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day prev disable">' + i + '</div>'
	        }
	        // 이번달
	        for (var i = 1; i <= nextDate; i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div id="day-' + i 
	            	+ '" class="day current year-' + currentYear + ' month-' + (currentMonth + 1) + ' day-' + i + '">' + i + '</div>';
	        }
	        // 다음달
	        for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay - 1); i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day next disable">' + i + '</div>'
	        }
					
	        // 오늘 날짜 표기
	        if (today.getMonth() == currentMonth) {
	            todayDate = today.getDate();
	            var currentMonthDate = document.querySelectorAll('.dates .current');
	            currentMonthDate[todayDate -1].classList.add('today');
	        }
	        
	        getRsvFullDates();
	        
	        $('.day.current').on('click', function() {
	        	if ($(this).hasClass('rsv-full')) {
	        		return;
	        	}
	        	
		        if (!rsvLoading) {
		        	selectedDate = new Date('' + currentYear + '-' + (currentMonth + 1) + '-' + $(this).attr('id').slice(4));
		        	nextMonthDate = new Date().setMonth(new Date().getMonth() + 1);
		        	
		        	if (selectedDate >= new Date().setHours(0,0,0,0) && selectedDate < nextMonthDate) {
			        	$('.day.current').removeClass('selected');
			        	$("#rsv-date").text(selectedDate.getFullYear() + "년 " 
			        			+ (selectedDate.getMonth() + 1) + "월 " + selectedDate.getDate() + "일");
			        	$(this).addClass('selected');
			        	
			        	
			        	
			        	showTimeSelect(selectedDate);
		        	}
		        }
	        })
	    }
	
	    // 이전달로 이동
	    $('.go-prev').on('click', function() {
	        thisMonth = new Date(currentYear, currentMonth - 1, 1);
	        renderCalender(thisMonth);
	    });
	
	    // 다음달로 이동
	    $('.go-next').on('click', function() {
	        thisMonth = new Date(currentYear, currentMonth + 1, 1);
	        renderCalender(thisMonth); 
	    });
	    
	    
	}

	var startSelected = false;
	var startTime;
	var endTime;
	var startDate;
	var endDate;
	var timeCount = 0;
	var cost = 0;
	
	function showTimeSelect() {
		
		var today = new Date();

		rsvLoading = true;
		
		// 시간 초기화
		$("#timeselect").css("display", "none");
		$(".timeselector").removeClass("time-selected");
		$(".timeselector").removeClass("time-disabled");
		startSelected = false;
		startTime = null;
		endTime = null;
		startDate = null;
		endDate = null;
		timeCount = 0;
		cost = 0;
		$("#rsv-time").text("");
		$(".rsv-cost span").text((${spacesVO.cost} * timeCount).toLocaleString());
		
		// 오늘을 선택했을 경우 지난 시간은 선택 불가
   	if ("" + selectedDate.getFullYear() + selectedDate.getMonth() + selectedDate.getDate()
   			== "" + today.getFullYear() + today.getMonth() + today.getDate()) {
   		
   		for (var i = 9; i <= new Date().getHours(); i++) {   			
   			$(".timeselector[data-starttime=" + i + "]").addClass("time-disabled");   			
   		}
   	}
		
		var loadingDiv = $('<div class="loadingDiv"><div class="spinner-border" role="status"></div></div>');
		$()
		
		$(".calendar").append(loadingDiv);
		
		
		//예약 시간 정보 받아오기
		var date = {
				spaceIdx: '${spacesVO.idx}',
				date: "" + selectedDate.getFullYear() + "-" + (selectedDate.getMonth() + 1) + "-" + selectedDate.getDate()
		}
		
		$.ajax({
			type: "get",
			url: "getrsvhours.do",
			data: date,
			success: function(data) {
				
				for (i in data) {
					if (data[i].end == 0) {
						data[i].end = '24';						
					}
					
					for (var j = +data[i].start; j < +data[i].end; j++) {
						if (j)
						console.log(j);
						$(".timeselector[data-starttime=" + j + "]").addClass("time-disabled");
					}
				}
				
				$(loadingDiv).remove();
				$("#timeselect").css("display", "block");
				rsvLoading = false;

				$("#rsv-form-wrap").css("display", "block");
			}
		})

		
	}
	
	
	function selectTime(time) {
		
		if ($(time).hasClass("time-disabled")) {
			return;
		}

		
		if (!startSelected) {
			timeCount = 1;
			
			$(".timeselector").removeClass("time-selected");
			startTime = +$(time).attr("data-starttime");
			endTime = +$(time).attr("data-endtime");
			startDate = new Date(selectedDate).setHours(startTime, 0, 0, 0);
			endDate = new Date(selectedDate).setHours(endTime, 0, 0, 0);
			$(time).addClass("time-selected");
			startSelected = true;
		} else {
			var timeChanged = false;
			
			endTime = +$(time).attr("data-endtime");
			
			if (endTime <= startTime) {
				var temp = startTime;
				startTime = endTime - 1;
				endTime = temp + 1;
				
				timeChanged = true;
			}
			
			for (var i = startTime; i < endTime; i++) {
				if ($(".timeselector[data-starttime=" + i + "]").hasClass("time-disabled")) {
					if (timeChanged) {
						startTime = endTime - 1;
					}
					return;
				}
			}

			startDate = new Date(selectedDate).setHours(startTime, 0, 0, 0);
			endDate = new Date(selectedDate).setHours(endTime, 0, 0, 0);
			timeCount = 0;
			
			for (var i = startTime; i < endTime; i++) {
				$(".timeselector[data-starttime=" + i + "]").addClass("time-selected");
				timeCount++;
			}

			startSelected = false;
		}
		
		$("#rsv-time").text(startTime + "시 ~ " + endTime + "시, " + timeCount + "시간");
		$(".rsv-cost span").text((${spacesVO.cost} * timeCount).toLocaleString());
		cost = ${spacesVO.cost} * timeCount;
		
	}
	
	function changePeopleNum(num) {
		
		var currentNum = +$("#rsv-input-peopleNum").val();
		currentNum += num;
		
		if (currentNum > ${spacesVO.capacity}) {
			currentNum = ${spacesVO.capacity};
		} else if (currentNum < 1) {
			currentNum = 1;
		}
		
		$("#rsv-input-peopleNum").val(currentNum);
		
	}
	
	function rsvSubmit() {
		if (
			startTime == null ||
			endTime == null ||
			timeCount == 0 ||
			cost == 0
		) {
			alert('결제 정보를 입력해 주세요.');
			return;
		}
		
		
		var startDateObj = new Date(startDate);
		var startDateString = "";
		startDateString += startDateObj.getFullYear() + "-";
		if (startDateObj.getMonth() + 1 < 10) {
			startDateString += "0";
		}
		startDateString += (startDateObj.getMonth() + 1) + "-";
		if (startDateObj.getDate() < 10) {
			startDateString += "0";
		}
		startDateString += startDateObj.getDate() + "-";
		if (startDateObj.getHours() < 10) {
			startDateString += "0";
		}
		startDateString += startDateObj.getHours();
		

		var endDateObj = new Date(endDate);
		var endDateString = "";
		endDateString += endDateObj.getFullYear() + "-";
		if (endDateObj.getMonth() + 1 < 10) {
			endDateString += "0";
		}
		endDateString += (endDateObj.getMonth() + 1) + "-";
		if (endDateObj.getDate() < 10) {
			endDateString += "0";
		}
		endDateString += endDateObj.getDate() + "-";
		if (endDateObj.getHours() < 10) {
			endDateString += "0";
		}
		endDateString += endDateObj.getHours();
		
		
		var rsvForm = $("<form action='payment.do' method='post' display='none'></form>");
		var spaceIdxInput = $("<input type='text' name='spaceIdx' value='" + ${spacesVO.idx} + "'>");
		var peopleNumInput = $("<input type='text' name='peopleNum' value='" + $("#rsv-input-peopleNum").val() + "'>");
		var startDateInput = $("<input type='text' name='startDate' value='" + startDateString + "'>");
		var endDateInput = $("<input type='text' name='endDate' value='" + endDateString + "'>");
		var rsvHoursInput = $("<input type='text' name='rsvHours' value='" + timeCount + "'>");
		var costInput = $("<input type='text' name='cost' value='" + cost + "'>");
		
		$("body").append(rsvForm);
		
		$(rsvForm).append(spaceIdxInput);
		$(rsvForm).append(peopleNumInput);
		$(rsvForm).append(startDateInput);
		$(rsvForm).append(endDateInput);
		$(rsvForm).append(rsvHoursInput);
		$(rsvForm).append(costInput);
		
		$(rsvForm).submit();
		
		
	}
	
	var reviewPage = 1;
	var reviewLastPage = ${reviewLastPage};
	var orderType = "regDateDesc";
	
	function loadReview(page, order, buttonObj) {
		
		if ($(buttonObj).hasClass("nav-disabled")) {
			return;
		}
		
		$.ajax({
			type: "get",
			data: "reviewPage=" + page + "&orderType=" + order + "&idx=" + ${param.idx},
			url: "loadReview.do",
			success: function(data) {
				
				var html = "";

				for (var i = 0; i < data.length; i++) {
					html += '<div class="review-wrap">';
					html += '<div class="review-header">';
					html += '<div class="review-member">';
					html += '<div class="review-profile-img">';
					html += '<img src="' + data[i].profileSrc + '">';
					html += '</div>';
					html += '<div class="review-nickname">';
					html += data[i].mNickname;
					html += '</div></div>';
					html += '<div class="review-score-wrap">';
					
					var regDate = new Date(data[i].regDate);
					var regDateString = "";
					
					regDateString += regDate.getFullYear() + ".";
					if ((regDate.getMonth() + 1) < 10) {
						regDateString += "0";
					}
					regDateString += (regDate.getMonth() + 1) + ".";
					if (regDate.getDate() < 10) {
						regDateString += "0";
					}
					regDateString += regDate.getDate();
					
					html += '작성일 ' + regDateString;
					html += '<div class="review-score-stars">';
					html += '<div class="review-score-color" style="width: ' + (data[i].score * 24) + 'px"></div>';
					html += '<img src="/images/score-star.png">';
					html += '<img src="/images/score-star.png">';
					html += '<img src="/images/score-star.png">';
					html += '<img src="/images/score-star.png">';
					html += '<img src="/images/score-star.png">';
					html += '</div></div></div>';
					html += '<div class="review-body">';
					html += '<div class="review-content">';
					html += data[i].content;
					html += '</div>';
					
					if (data[i].pictureSrc != null) {
						html += '<img class="review-thumb" src="' + data[i].thumbSrc + '" onclick="drawImage(\'' + data[i].pictureSrc + '\')">';
					}
					html += '</div></div>';
					
					$("#reviewList").html(html);
					
					reviewPage = page;
					orderType = order;
					
					$(".review-order-button").removeClass("accent-button");
					$("#" + orderType).addClass("accent-button");
					
					$(".nav-disabled").removeClass("nav-disabled");
					
					if (page == 1) {
						$(".review-page-prev").addClass("nav-disabled");
					}
					if (page == reviewLastPage) {
						$(".review-page-next").addClass("nav-disabled");
					}
					
				}
				
			}
		})
	}
	
	$(function() {
		$(".review-page-prev").addClass("nav-disabled");
		if (reviewLastPage == 1) {
			$(".review-page-next").addClass("nav-disabled");
		}
	})
	
	</script>
	
</head>

<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<c:if test="${spacesVO.getStatus() == 0}">
			<div class="inner-box space-status space-status-waiting">
				<span class="space-status-content">등록 대기중인 공간입니다.</span>
				
				<c:if test="${login.getAuth() == 3}">
				<div class="space-accept-buttons">
					<button class="normal-button" onclick="location.href='refuseSpace.do?idx=${spacesVO.getIdx()}'">등록 거부</button>
					<button class="normal-button accent-button" onclick="location.href='acceptSpace.do?idx=${spacesVO.getIdx()}'">등록 승인</button>
				</div>
				</c:if>
				
			</div>
		</c:if>
		<c:if test="${spacesVO.getStatus() == 2}">
			<div class="inner-box space-status space-status-refused">
				<div>
					<span class="space-status-content" style="color: white;">등록 거부된 공간입니다.<br></span>
					<span style="color: white; font-size: 17px;">수정 후 등록 재요청이 가능합니다.</span>
				</div>
				
				<c:if test="${spacesVO.getHostIdx() == hlogin.getmIdx()}">
				<div class="space-accept-buttons">
					<button class="normal-button" style="width: 120px;" onclick="location.href='requestaccept.do?idx=${spacesVO.getIdx()}'">등록 재요청</button>
				</div>
				</c:if>
				
			</div>
		</c:if>
		<c:if test="${spacesVO.getStatus() == 3}">
			<div class="inner-box space-status space-status-deleted">
				삭제된 공간입니다.
			</div>
		</c:if>
		
		<c:if test="${spacesVO.getStatus() != 3}"> <!-- 삭제된 공간은 데이터를 출력하지 않음 -->
		
		<div id="page-content">
		<c:if test="${spacePicturesVOs.size() != 0}">
			<div class="inner-box pictures">
				
				<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
				  <div class="carousel-indicators">
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
						<c:forEach var="i" begin="1" end="${spacePicturesVOs.size() - 1}">
				    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${i}" aria-label="Slide ${i}"></button>
						</c:forEach>
				  </div>
				  <div class="carousel-inner">
				  	<c:forEach var="i" begin="0" end="${spacePicturesVOs.size() - 1}" varStatus="status">
				  		<c:if test="${status.first}">
						    <div class="carousel-item active">
						      <img src="${spacePicturesVOs[i].getSrc()}" class="d-block w-100" onclick="drawImage('${spacePicturesVOs[i].getSrc()}')">
						    </div>
				  		</c:if>
				  		<c:if test="${!status.first}">
				  			<div class="carousel-item">
						      <img src="${spacePicturesVOs[i].getSrc()}" class="d-block w-100" onclick="drawImage('${spacePicturesVOs[i].getSrc()}')">
						    </div>
				  		</c:if>
				    </c:forEach>
				  </div>
				  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </button>
				  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
				</div>
			</div>
			</c:if>
			
			<div class="title">
				<div class="space-type">
					${spacesVO.getType()}
				</div>
				<div class="space-name">
					<span>${spacesVO.getName()}</span>
					<c:if test="${login != null}">
					<div class="like-space" onclick="likeSpace()">
						<img src="/images/heart-empty.png">
					</div>
					</c:if>
				</div>
				<div class="address">
					${spacesVO.getAddress()} ${spacesVO.getAddressDetail()}
					<button class="normal-button map-button" onclick="showMap()">&nbsp;지도<img src="/images/map_pin.png" style="height: 20px; margin-left: 0px;"></button>
				</div>
			</div>
			
			<div class="menu">
				<button class="normal-button" onclick="document.querySelector('#scroll-to-info').scrollIntoView({behavior: 'smooth', block: 'center'});">정보</button>
				<button class="normal-button" onclick="document.querySelector('#scroll-to-review').scrollIntoView({behavior: 'smooth', block: 'center'});">후기</button>
				<button class="normal-button" onclick="document.querySelector('#scroll-to-qna').scrollIntoView({behavior: 'smooth', block: 'center'});">Q&amp;A</button>
				<button class="normal-button" onclick="document.querySelector('#scroll-to-rsv').scrollIntoView({behavior: 'smooth', block: 'center'});">예약</button>
			</div>
			<div class="container space-content">
				<div class="row">
					<div class="col-sm-8 colleft">
						<div class="inner-box space-info">
							<div class="inner-box-content">
									<div class="space-info-subject">기본정보</div>
					
									<div id="scroll-to-info"></div>
			
								
									${spacesVO.getInfo()}
									<div class="space-info-subject">보유 장비 / 시설</div>
									${spacesVO.getFacility()}
								
									<div class="space-info-subject">주의사항</div>
									${spacesVO.getCaution()}
								
							</div>
						</div>
						
						<div class="inner-box space-info">
							<div class="inner-box-content">
								<div class="space-info-subject">후기 ${reviewCntAvg.get("count")}개</div>
								<div id="scroll-to-review"></div>
								
								<c:if test="${reviewCntAvg.get('count') != 0}">
								
								<div class="score-wrap">
									<div class="score-stars">
										<div class="score-color"></div>
										<img src="/images/score-star.png">
										<img src="/images/score-star.png">
										<img src="/images/score-star.png">
										<img src="/images/score-star.png">
										<img src="/images/score-star.png">
									</div>
									<div class="score-avg"><fmt:formatNumber value="${reviewCntAvg.get('avg')}" pattern="#.0" /> </div>
								</div>
								<div class="review-orders">
									<button id="regDateDesc" class="normal-button accent-button review-order-button" onclick="loadReview(1, 'regDateDesc')">최근 작성 순</button>
									<button id="scoreDesc" class="normal-button review-order-button" onclick="loadReview(1, 'scoreDesc')">별점 높은 순</button>
									<button id="scoreAsc" class="normal-button review-order-button" onclick="loadReview(1, 'scoreAsc')">별점 낮은 순</button>
								</div>
								<div id="reviewList">
								<c:forEach var="review" items="${reviewList}">
									<div class="review-wrap">
										<div class="review-header">
											<div class="review-member">
												<div class="review-profile-img">
													<img src="${review.profileSrc}">
												</div>
												<div class="review-nickname" onclick="profileOpen(${review.mIdx})">
													${review.mNickname}
												</div>
											</div>
											<div class="review-score-wrap">
												작성일 <fmt:formatDate value="${review.regDate}" pattern="yyyy.MM.dd" />
												<div class="review-score-stars">
													<div class="review-score-color" style="width: ${review.score * 24}px"></div>
													<img src="/images/score-star.png">
													<img src="/images/score-star.png">
													<img src="/images/score-star.png">
													<img src="/images/score-star.png">
													<img src="/images/score-star.png">
												</div>
											</div>
										</div>
										<div class="review-body">
											<div class="review-content">
												${review.content}
											</div>
											<c:if test="${review.pictureSrc != null}">
												<img class="review-thumb" src="${review.thumbSrc}" onclick="drawImage('${review.pictureSrc}')">
											</c:if>
										</div>
									</div>
								</c:forEach>
								</div>
								
								<div class="review-nav">
									<div class="review-page-prev" onclick="loadReview(1, orderType, this)">
										<img src="/images/page-first.png">
									</div>
									<div class="review-page-prev" onclick="loadReview((reviewPage - 1), orderType, this)">
										<img src="/images/page-prev.png">
									</div>
									<div class="review-page-next" onclick="loadReview((reviewPage + 1), orderType, this)">
										<img src="/images/page-next.png">
									</div>
									<div class="review-page-next" onclick="loadReview(reviewLastPage, orderType, this)">
										<img src="/images/page-last.png">
									</div>
								</div>
								
								
								</c:if>
							</div>
						</div>
						
						<div class="inner-box space-info">
							<div class="inner-box-content">
								<div class="space-info-subject">Q&amp;A</div>
								<div id="scroll-to-qna"></div>
							</div>
						</div>
						
					</div>
					
					<c:if test="${login != null}">
						
					
					<div class="col-sm colright">
						<div class="inner-box space-rsv">
							<div class="inner-box-content">
								<div class="space-info-subject">예약</div>
								<div id="scroll-to-rsv"></div>
								<div class="rsv-info">
									예약은 오늘 날짜부터 한 달간 가능합니다.
								</div>
								<div class="rsv-cal-info">
									<div class="day current today dayex"></div>
									<div class="dayinfo">오늘</div>
									<div class="day current rsv-full dayex"></div>
									<div class="dayinfo">예약 불가</div>
								</div>
								
								<div class="calendar">
									<div class="sec_cal">
									  <div class="cal_nav">
									    <a href="javascript:;" class="nav-btn go-prev">prev</a>
									    <div class="year-month"></div>
									    <a href="javascript:;" class="nav-btn go-next">next</a>
									  </div>
									  <div class="cal_wrap">
									    <div class="days">
									      <div class="day">일</div>
									      <div class="day">월</div>
									      <div class="day">화</div>
									      <div class="day">수</div>
									      <div class="day">목</div>
									      <div class="day">금</div>
									      <div class="day">토</div>
									    </div>
									    <div class="dates"></div>
									  </div>
									</div>
									
									<div id="timeselect">
										<div class="space-rsv-subject">
										시간 선택
										</div>
										<div id="timetable">
											<c:forEach var="i" begin="9" end="23">
											<div class="timeselector" data-starttime="${i}" data-endtime="${i + 1}"
													onclick="selectTime(this)">
												<c:if test="${i == 9}">0</c:if>${i}시 ~ ${i + 1}시
											</div>
											</c:forEach>
											<div class="timeselector-blank"></div>
										</div>
									</div>
								</div>
								
								<div id="rsv-form-wrap">
									<div class="space-rsv-subject">
										예약 날짜와 시간
									</div> 
									<div id="rsv-date">
									
									</div>
									<div id="rsv-time">
										
									</div>
									<div id="rsv-peopleNum">
										<div class="space-rsv-subject">
											예약 인원
										</div>
										<div class="peopleNum-buttons-wrap">
											총&nbsp;&nbsp;
											<div class="peopleNum-buttons">
												<button class="peopleNum-button" onclick="changePeopleNum(-1)">-</button>
												<input id="rsv-input-peopleNum" type="number" name="peopleNum" min="1" max="${spacesVO.capacity}" value="1">
												<button class="peopleNum-button" onclick="changePeopleNum(1)">+</button>
											</div>
											&nbsp;&nbsp;명
										</div>
									</div>
								</div>
							
								<div class="rsv-costs-wrap">
									<div class="space-rsv-subject">
										시간당 이용료
									</div>					
									<div class="space-cost">
										<span><fmt:formatNumber value="${spacesVO.cost}" pattern="#,###"/></span>
										 원 / 시간
									</div>
									<div class="space-rsv-subject">
										총 이용료
									</div>
									<div class="rsv-cost">
										<span>0</span>
										 원 / 시간
									</div>
									
								</div>
								
								<div class="submit-button-wrap">
									<button class="normal-button accent-button rsv-submit" onclick="rsvSubmit()">결제하기</button>
								</div>
							</div>
						</div>
					</div>
					
					
					</c:if>
				
				</div>
			</div>
		</div>
				
			<c:if test="${spacesVO.getHostIdx() == hlogin.getmIdx()}">
				<div class="outter-buttons">
					<button type="button" class="normal-button" onclick="deleteSpace()">삭제</button>
					<button class="normal-button accent-button" style="margin-left: 20px;" onclick="location.href='update.do?idx=${spacesVO.getIdx()}'">수정</button>
				</div>
			</c:if>
		
		</c:if>
		</div>
		
		
	<div id="imgBackOveray">
		<div id="imgBackground" onclick="$(this).parent().css('visibility', 'hidden')"></div>
		<div id="img"></div>
	</div>
	
	<div id="mapBackOveray">
		<div id="mapBackground" onclick="$(this).parent().css('visibility', 'hidden')"></div>
		<div id="map"></div>
	</div>
	
	
	<c:import url="/footer.do" />
</body>
</html>