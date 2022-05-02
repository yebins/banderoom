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
		justify-content: space-between;
		align-items: center;
		margin-bottom: 20px;
	}
	.filter-select-wrap {
		display: flex;
		align-items: center;
	}
	
	.form-select {
    margin-right: 20px;
    width: 160px;
    height: 50px;
    border-radius: 25px;
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
		align-items: center;
	}
	.filter-buttons button {
		margin-left: 20px;
	}
	
	.search-text {
		width: 100%;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.search-name-input {
		flex: 1;	
    margin-right: 20px;
    width: 160px;
    height: 50px;
    border-radius: 25px;
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
	
	.space-restinfo-restinfo {
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-size: 14px;
		font-weight: normal;
	}
		
</style>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a8d83e76596a6e93d144575566c3d5ae&libraries=services"></script>
<script>

	var locations;
	
	$(function() {
		
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
		geocoder.addressSearch('${login.getAddr1()} ${login.getAddr2()}', function(result, status) {
		
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
		            content: '<div class="map-popup" style="width:150px;text-align:center;padding:6px 0;" onclick="window.open(\'https://map.kakao.com/link/search/${spacesVO.getAddress()}\')">${spacesVO.getName()}</div>'
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
				<div class="inner-box">
					<div class="inner-box-content">
						<div class="filters">
							<div class="filter-select-wrap"> 
								<select id="addr1" class="form-select form-select-sm" name="addr1" onchange="showAddr2()">
									<option value="">지역</option>
									<option id="addr1-loading" value="">로드 중..</option>
								</select>
								<select id="addr2" class="form-select form-select-sm" name="addr2" style="display: none;" onchange="listFilter()">
								</select>
								<select id="space-type" class="form-select form-select-sm" name="type" onchange="listFilter()">
									<option value="">분류</option>
									<option>녹음실</option>
									<option>밴드연습실</option>
									<option>댄스연습실</option>
								</select>
							</div>
							<div class="filter-buttons">
								<button type="button" class="normal-button map-button" onclick="showMap()">&nbsp;지도<img src="/images/map_pin.png" style="height: 20px; margin-left: 0px;"></button>
								<button type="button" class="normal-button search-button reset-filter" onclick="resetFilter()">필터 초기화</button>
							</div>
						</div>
						<div class="search-text">
							<input type="text" class="search-name-input" name="name" placeholder="공간 이름">
							<button class="normal-button accent-button search-button">검색</button>
						</div>
					</div>
				</div>
			</form>
			
			<div class="container">
			  <div class="row row-cols-1 row-cols-sm-3">
					<c:forEach var="i" begin="0" end="${spaceList.size() - 1}">
						<div class="col spacecol">
							<div class="inner-box spacebox" onclick="location.href='details.do?idx=${spaceList[i].getIdx()}'">
							
							<c:if test="${likedStatus.get(spaceList[i].getIdx()) == 1 }">
							<img class="liked-space" src="/images/heart-filled.png">
							</c:if>
								<div class="space-thumb">
									<img src="${spaceList[i].thumb}" width="100%">
								</div>
								<div class="space-info">
									<div class="space-name">${spaceList[i].getName()}</div>
									<div class="space-restinfo">
										<div class="space-type">${spaceList[i].getType()}</div>
										<div class="space-restinfo-restinfo">
											<div class="space-addr">${spaceList[i].getAddr1()} ${spaceList[i].getAddr2()}</div>
											<div class="space-score">
												⭐ ${reviewAvg.get(spaceList[i].getIdx())} (${reviewCount.get(spaceList[i].getIdx())})
											</div>
										</div>
									</div>
								</div>
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