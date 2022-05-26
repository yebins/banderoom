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

	.inner-box-content {
		width: 100%;
		padding: 10px;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: flex-start;
	}
	
	.filters {
		width: 100%; 	
		display: flex;
		flex-wrap: wrap;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 20px;
	}
	.filter-select-wrap {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
	}
	
	.form-select {
    margin-right: 20px;
    width: 160px;
    height: 36px;
    border-radius: 18px;
    padding: 0px 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		border: none;
	}
	.form-select:focus {
		outline: none;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		border: none;
	}
	.form-select:active {
		filter: brightness(90%);
	}
	
	.filter-buttons {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
	}
	.filter-buttons button {
		margin-left: 20px;
	}
	
	.search-text {
		width: 100%;
		display: flex;
		flex-wrap: wrap;
		justify-content: space-between;
		align-items: center;
	}
	
	.search-name-input {
		flex: 1;	
    margin-right: 20px;
    width: 160px;
    height: 36px;
    border-radius: 18px;
    padding: 0px 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		border: none;
	}
	
	.search-button {
		width: 120px;
	}
	
	.map-button {
		width: 80px;
		margin-left: 20px;
	}
	
	form#search-form {
		margin-bottom: 40px;
	}
	
	div.spacecol {
		padding-bottom: 24px;
	}
	@media (max-width: 576px) {
		div.spacecol {
			padding: 0px 0px 24px 0px;
		}
	}
	
	div.spacebox {
		position: relative;
		width: 100%;
		height: 300px;
		display: flex;
		flex-direction: column;
		padding: 0px;
		overflow: hidden;
	}
	div.spacebox:hover {
		cursor: pointer;
		outline: 3px solid #fb6544;
	}
	div.spacebox:active {
		filter: brightness(90%);
	}
	
	.liked-space {
		width: 20px;
		position: absolute;
		top: 15px;
		right: 15px;
	}
	
	div.space-thumb {
		height: 50%;
		display: flex;
		justify-content: center;
		align-items: center;
		overflow: hidden;
		box-shadow: 0px 2px 7px rgba(0,0,0,0.4);
	}
	
	div.space-info {
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		padding: 15px;
		height: 50%;
	}
	
	.space-name {
		font-size: 20px;
		font-weight: bold;
	}
	
	.space-restinfo {
		font-size: 13px;
		font-weight: bold;
	}
	
	.space-cost span {
		font-size: 20px;
	}
	
	.space-type-cost-wrap {
		display: flex;
		justify-content: space-between;
		align-items: flex-end;
	}
	
	.space-restinfo-restinfo {
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-size: 14px;
		font-weight: normal;
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
		opacity: 0%;
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
	
	.spinner-border {
		width: 100px;
		height: 100px;
		margin: 40px;
		border-width: 10px;
		color: #FB6544;
	}
	
	.liked-button {
		width: 36px;
		display: flex;
		justify-content: center;
		align-items: center;
		padding: 0px;
	}
	
	.liked-button img {
		width: 18px;
	}
	
	@media screen and (max-width: 576px) {
		#wrapper {
			padding: 60px 10px 100px;
		}
		.colleft, .colright {
			padding: 10px 0px;
		}
		.filter-buttons {
			margin-top: 15px;
		}
		select, input {
			margin-top: 15px;
			width: 100% !important;
		}
		.filters {
			margin-bottom: 0px;
			align-items: stretch;
		}
		.filter-select-wrap {
			width: 100%;
		}
		
		.liked-button {
			margin-left: 0px !important;
		}
		.accent-button {
			margin-top: 15px;
		}
		
	
	}
</style>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a8d83e76596a6e93d144575566c3d5ae&libraries=services"></script>
<script>

	var locations;
	var page = 1;
	var loading = false;
	var allLoaded = false;
	var orderType = "review";
	if (${param.orderType != null}) {
		orderType = '${param.orderType}';		
	}
	
	var liked = 0;
	if (${param.liked != null}) {
		liked = '${param.liked}';
	}
	
	function searchLiked() {
		if (liked == 0) {
			liked = 1;
			$("input[name=liked]").val(1);
			$(".liked-button img").attr("src", "/images/heart-filled.png");
		} else {
			liked = 0;
			$("input[name=liked]").val(0);
			$(".liked-button img").attr("src", "/images/heart-empty.png");
		}
	}
	
	function addList() {
		if (loading || allLoaded) {
			return;
		}
		
		var loadingDiv = $('<div class="spinner-border" role="status"></div>');
		$('#wrapper').append(loadingDiv);
		
		loading = true;
		page++;
		var searchData = 'page=' + page + '&';
		
		if ('${param.search}' == 1) {
			searchData += $('form#search-form').serialize();
		}
		
		$.ajax({
			type: "get",
			url: "addlist.do",
			data: searchData,
			success: function(data) {
				
				var html = $("<div>").html(data);
				var spacecol = $(html).find(".spacecol");
				
				$(spacecol).css("opacity", "0%");
				
				$(".spacerow").append(spacecol);
				
				$(spacecol).animate({opacity: "100%"}, 200);
				
				if (spacecol.length < 12) {
					
					allLoaded = true;
				}
				
				drawMap();
				$(loadingDiv).remove();
				loading = false;
				
				
			}
		})
	}
	
	$(function() {
		
		
		window.onscroll = function(e) {
			if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
				addList();
			}
		}
		
		$.ajax({
			type: "get",
			url: "getlocations.do",
			success: function(data) {
				locations = data;
				var addr1 = [];
				
				for (var i = 0; i < data.length ; i++) {
					addr1[i] = data[i].addr1;
				}
				
				addr1 = addr1.filter((v, i) => addr1.indexOf(v) === i);
				
				$("#addr1-loading").remove();
				
				for (var i = 0; i < addr1.length ; i++) {
					var html = "<option>" + addr1[i] + "</option>"
					$("#addr1").append(html);
				}
				

				$("select[name=addr1]").val("${param.addr1}");
				
				if ($("select[name=addr1]").val() != '') {
					showAddr2();
				}
				
				$("select[name=addr2]").val("${param.addr2}");
				$("select[name=type]").val("${param.type}");
				$("input[name=name]").val("${param.name}");
				$("select[name=orderType]").val(orderType);
				if (liked == 1) {
					$("input[name=liked]").val(1);
					$(".liked-button img").attr("src", "/images/heart-filled.png");
				} else {
					$("input[name=liked]").val(0);
					$(".liked-button img").attr("src", "/images/heart-empty.png");
				}

				drawMap();
			}
		})
		

		
	})
	
	function showAddr2() {
		
		
		if ($("#addr1").val() == "") {
			$("#addr2").css("display", "none");
			$("#addr2").val("");
			return;
		}
		
		$("#addr2").children().each(function() {
			$(this).remove();
		});
	
		
		$("#addr2").append("<option value=''>지역 소분류</option>")	;
		
		for (var i = 0; i < locations.length; i++) {
			if (locations[i].addr1 == $("#addr1").val()) {
				var html = "<option>" + locations[i].addr2 + "</option>";
				$("#addr2").append(html);
			}
		}
		$("#addr2").css("display", "block");
		
	}

	var mapContainer;
	
	function drawMap() {
		
		$("#map").children().remove();
		
		var level = 9;
		
		if ($("select[name=addr1]").val() != '') {
			level = 6;
		}
	
		mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: level // 지도의 확대 레벨
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
		
		$(".spacebox").each(function(idx, item) {
			

			geocoder.addressSearch($(item).children('input[name=address]').val(), function(result, status) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div class="map-popup" onclick="location.href=\'details.do?idx=' + $(item).children('input[name=idx]').val() + '\'">' + $(item).find('.space-name').text() + '</div>'
		        });
		        infowindow.open(map, marker);
		
			});
			
		})
		
		

		// 주소로 좌표를 검색합니다
		<c:if test="${login != null}">
			var myAddress = '${login.getAddr1()} ${login.getAddr2()}';
		</c:if>
		<c:if test="${login == null}">
			var myAddress = '서울시 중구';
		</c:if>
		
		if ($("select[name=addr1]").val() != "") {
			myAddress = $("select[name=addr1]").val() + " " + $("select[name=addr2]").val();
		}
		
		geocoder.addressSearch(myAddress, function(result, status) {
		
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        setTimeout(function() {
			        map.setCenter(coords);
		        }, 500)
		    } 
		});

	}
	
	function showMap() {
		//$("#map").children().remove();
	    //drawMap();
		$("#mapBackOveray").css("visibility", "visible");
		$("#mapBackOveray").animate({opacity: "100%"}, 200);
    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	}
	
	function closeMap() {
		$("#mapBackOveray").animate({opacity: "0%"}, 200);
		setTimeout(() => {
			$("#mapBackOveray").css("visibility", "hidden");			
		}, 200);
	}

</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			공간 대여
		</div>
		<div id="page-content">
			<form id="search-form">
			<input type="hidden" name="search" value="1">
				<div class="inner-box">
					<div class="inner-box-content">
						<div class="filters">
							<div class="filter-select-wrap"> 
								<select id="addr1" class="form-select form-select-sm" name="addr1" onchange="showAddr2()">
									<option value="">지역</option>
									<option id="addr1-loading" value="">로드 중..</option>
								</select>
								<select id="addr2" class="form-select form-select-sm" name="addr2" style="display: none;">
								</select>
								<select id="space-type" class="form-select form-select-sm" name="type">
									<option value="">분류</option>
									<option>녹음실</option>
									<option>밴드연습실</option>
									<option>댄스연습실</option>
								</select>
							</div>
							<div class="filter-buttons">
								<input type="hidden" name="liked" value="0">
								<c:if test="${login != null}">
								<button type="button" class="normal-button liked-button" onclick="searchLiked()">
									<img src="/images/heart-empty.png">
								</button>
								</c:if>
								<button type="button" class="normal-button map-button" onclick="showMap()">&nbsp;지도<img src="/images/map_pin.png" style="height: 20px; margin-left: 0px;"></button>
								<button type="button" class="normal-button search-button reset-filter" onclick="location.href='list.do'">필터 초기화</button>
							</div>
						</div>
						<div class="search-text">
							<select id="space-orderType" class="form-select form-select-sm" name="orderType">
								<option value="review">리뷰 많은 순</option>
								<option value="score">별점 높은 순</option>
							</select>
							<input type="text" class="search-name-input" name="name" placeholder="공간 이름">
							<button class="normal-button accent-button search-button">검색</button>
						</div>
					</div>
				</div>
			</form>
			
			<c:if test="${spaceList.size() != 0}">
				<div class="container">
				  <div class="row row-cols-1 row-cols-sm-3 spacerow">
						<c:forEach var="i" begin="0" end="${spaceList.size() - 1}">
							<div class="col spacecol">
								<div class="inner-box spacebox" onclick="location.href='details.do?idx=${spaceList[i].getIdx()}'">
								<input type="hidden" name="idx" value="${spaceList[i].getIdx()}">
								<input type="hidden" name="address" value="${spaceList[i].getAddress()}">
								<c:if test="${spaceList[i].liked == 1 }">
								<img class="liked-space" src="/images/heart-filled.png">
								</c:if>
									<div class="space-thumb">
										<img src="${spaceList[i].thumb}" width="100%">
									</div>
									<div class="space-info">
										<div class="space-name">${spaceList[i].getName()}</div>
										<div class="space-restinfo">
											<div class="space-type-cost-wrap">
												<div class="space-type">${spaceList[i].getType()}</div>
												<div class="space-cost">
													<span>
														<fmt:formatNumber value="${spaceList[i].getCost()}" pattern="#,###" /> 
													</span>
													원 / 시간
												</div>
											</div>
											<div class="space-restinfo-restinfo">
												<div class="space-addr">${spaceList[i].getAddr1()} ${spaceList[i].getAddr2()}</div>
												<div class="space-score">
													⭐ <fmt:formatNumber value="${spaceList[i].getReviewAvg()}" pattern="0.0" /> (${spaceList[i].getReviewCnt()})
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
				  </div>
				</div>
			</c:if>
			<c:if test="${spaceList.size() == 0}">
				등록된 공간이 없습니다.
			</c:if>
		</div>
		
	</div>
	
	<div id="mapBackOveray">
		<div id="mapBackground" onclick="closeMap()"></div>
		<div id="map"></div>
	</div>
	<c:import url="/footer.do" />
	
	<div id="ajax" style="display: none"></div>
</body>
</html>