
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
		$("#mapBackOveray").animate({opacity: "100%"}, 200);
	    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	}
	
	function closeMap() {
		$("#mapBackOveray").animate({opacity: "0%"}, 200);
		setTimeout(() => {
			$("#mapBackOveray").css("visibility", "hidden");			
		}, 200);
	}
	
	function review(resIdx) {
		window.open('review.do?resIdx=' + resIdx, '_blank', 
        'top=140, left=200, width=800, height=500, menubar=no,toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');
	}
	
	function reload() {	    // 팝업 창에서 호출할 함수
		location.reload();
	}
	function gotoLogin() {
		location.href="/banderoom/member/glogin.do";
	}
	
	
	function loadMyRsv(page) {
		$.ajax({
			type: "get",
			url: "loadMyRsv.do",
			data: "page=" + page + "&dateType=" + dateType + "&dateRange=" + dateRange,
			success: function(result) {
				
				var pastRsv = result.pastRsv;
				
				$("#past-rsv").children().each(function() {
					$(this).remove();
				})
				
				var html = "";
				
				for (var i = 0; i < pastRsv.length; i++) {
					
					html += '<div class="past-rsv-wrap">';
					html += '<div class="past-rsv-info-wrap">';
					html += '<div class="past-rsv-name"><a href="details.do?idx=' + pastRsv[i].idx + '">' + pastRsv[i].name + '</a></div>';
					html += '<div class="past-rsv-info">';
					html += '<div class="past-rsv-info-items">';
					html += '<div class="small-title">공간 사용일</div>';
					html += '<div class="small-content">';
					
					var date = new Date(pastRsv[i].startDate);
					var dateString = "" + date.getFullYear() + "/";
					if ((date.getMonth() + 1) < 10) {
						dateString += "0";
					}
					dateString += (date.getMonth() + 1) + "/";
					if (date.getDate() < 10) {
						dateString += "0";
					}
					dateString += date.getDate() + " ";
					dateString += date.getHours() + "시~";
					
					date = new Date(pastRsv[i].endDate);
					dateString += date.getHours() + "시, ";
					
					dateString += pastRsv[i].rsvHours + "시간";
					
					html += dateString;
					html += '</div></div>&nbsp;&nbsp;';
					html += '<div class="past-rsv-info-items">';
					html += '<div class="small-title">예약일</div>';
					html += '<div class="small-content">';
					
					date = new Date(pastRsv[i].resDate);
					dateString = "" + date.getFullYear() + "/";
					if ((date.getMonth() + 1) < 10) {
						dateString += "0";
					}
					dateString += (date.getMonth() + 1) + "/";
					if (date.getDate() < 10) {
						dateString += "0";
					}
					dateString += date.getDate();
					
					html += dateString;
					html += '</div></div></div>';
					html += '<div class="past-rsv-info">';
					html += '<div class="past-rsv-info-items">';
					html += '<div class="small-title">이용료</div>';
					html += '<div class="small-content">';
					
					var cost = pastRsv[i].cost.toLocaleString();
					
					html += cost + "원";
					html += '</div></div>&nbsp;&nbsp;';
					html += '<div class="past-rsv-info-items">';
					html += '<div class="small-title">결제 금액</div>';
					html += '<div class="small-content">';
					
					cost = pastRsv[i].totalCost.toLocaleString();

					html += cost + "원";
					html += '</div></div>&nbsp;&nbsp;</div></div>';
					html += '<div class="past-rsv-buttons">';
					
					if (pastRsv[i].rsvStatus == 1) {
						html += '<span class="cancelled">취소됨</span>';
					}
					
					if (pastRsv[i].endDate < result.today && result.reviewed[pastRsv[i].resIdx] == 0 && pastRsv[i].rsvStatus == 0) {
						html += '<button class="normal-button accent-button" onclick="review(' + pastRsv[i].resIdx + ')">후기 작성</button>&nbsp;&nbsp;';
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