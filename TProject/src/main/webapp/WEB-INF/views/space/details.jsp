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
	
	.map-popup:hover {
		cursor: pointer;
	}
	
	.space-content {
		width: 100%;
	}
	
	.space-info {
		padding: 40px !important;
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
	
	iframe {
		max-width: 100%;
	}
	
</style>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a8d83e76596a6e93d144575566c3d5ae&libraries=services"></script>
	
	<script>
	
	var liked;
	var mIdx = 0;
	
	<c:if test="${login != null}">
	mIdx = ${login.getmIdx()};
	</c:if>
	
	$(function() {
		
		getLikedStatus();
		
	})
	
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
	
	function deleteSpace() {
		if (confirm('정말 이 공간을 삭제하시겠습니까?')) {
			location.href='delete.do?idx=${spacesVO.getIdx()}';
		}
	}
	
	function drawImage(obj) {

		var div = $("#img"); // 이미지를 감싸는 div
		var img = $("<img>"); // 이미지
		
	  $(div).css("width", "80%");
	  $(div).css("height", "80vh");
	    
		$("#img").children().remove();
		$("#imgBackOveray").css("visibility", "visible");
		
		$(div).append(img);
		
		$(img).attr("src", $(obj).attr("src"));
		
		var divAspect = $(div).height() / $(div).width(); // div의 가로세로비는 알고 있는 값이다
		var imgAspect = $(img).height() / $(img).width();
		
		console.log($(img).height() + ", " + $(img).width())
		console.log(divAspect + ", " + imgAspect);
	
		if (imgAspect >= divAspect) {
		    // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
		    $(img).css("width", "auto");
		    $(img).css("height", "100%");
		    $(div).css("width", $(img).width() + "px");
		} else {
		    // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
		    $(img).css("width", "100%");
		    $(img).css("height", "auto");
			  $(div).css("height", $(img).height() + "px");
		}
	}
	
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
						      <img src="${spacePicturesVOs[i].getSrc()}" class="d-block w-100" onclick="drawImage(this)">
						    </div>
				  		</c:if>
				  		<c:if test="${!status.first}">
				  			<div class="carousel-item">
						      <img src="${spacePicturesVOs[i].getSrc()}" class="d-block w-100" onclick="drawImage(this)">
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
			
			<br>
			
			<div class="container space-content">
				<div class="row">
					<div class="col-sm-8 colleft">
						<div class="inner-box space-info">
							<div class="inner-box-content">
									<div class="space-info-subject">기본정보</div>
									${spacesVO.getInfo()}
								
									<div class="space-info-subject">보유 장비 / 시설</div>
									${spacesVO.getFacility()}
								
									<div class="space-info-subject">주의사항</div>
									${spacesVO.getCaution()}
								
							</div>
						</div>
					</div>
					
					<c:if test="${login != null}">
						
					
					<div class="col-sm colright">
						<div class="inner-box space-rsv">
							<div class="inner-box-content">
								여기는 예약 정보가 들어갈 공간입니다.
								<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
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