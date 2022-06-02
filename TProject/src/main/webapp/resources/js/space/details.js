
	$(function() {
	
		$(".score-color").css("width", scoreColor + "px");
		
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
	    	data: "spaceIdx=" + spacesVO.idx + "&nowDate=" + nowString + "&afterMonth=" + nextDayString,
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
				spaceIdx: spacesVO.idx
			},
			success: function(result) {
				if (result == 0) {					// 찜하지 않았음
					$(".like-space img").attr("src", "/banderoom/images/heart-empty.png");
					liked = 0;
				} else if (result == 1) {		// 찜했음
					$(".like-space img").attr("src", "/banderoom/images/heart-filled.png");
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
					spaceIdx: spacesVO.idx
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
					spaceIdx: spacesVO.idx
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
		geocoder.addressSearch(spacesVO.address, function(result, status) {
		
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
		            content: '<div class="map-popup" onclick="window.open(\'https://map.kakao.com/link/search/' + spacesVO.address + '\')">' + spacesVO.name + '</div>'
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
		$("#mapBackOveray").animate({opacity: "100%"}, 200);
	    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	}
	
	function closeMap() {
		$("#mapBackOveray").animate({opacity: "0%"}, 200);
		setTimeout(() => {
			$("#mapBackOveray").css("visibility", "hidden");			
		}, 200);
	}
	
	function deleteSpace() {
		if (confirm('정말 이 공간을 삭제하시겠습니까?')) {
			location.href='delete.do?idx=' + spacesVO.idx;
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
			$("#imgBackOveray").animate({opacity: "100%"}, 200);
		}, 200);

		
	}
	
	function closeImage() {
		$("#imgBackOveray").animate({opacity: "0%"}, 200);
		setTimeout(() => {
			$("#imgBackOveray").css('visibility', 'hidden');			
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
		$(".rsv-cost span").text((spacesVO.cost * timeCount).toLocaleString());
		
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
				spaceIdx: spacesVO.idx,
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
		$(".rsv-cost span").text((spacesVO.cost * timeCount).toLocaleString());
		cost = spacesVO.cost * timeCount;
		
	}
	
	function changePeopleNum(num) {
		
		var currentNum = +$("#rsv-input-peopleNum").val();
		currentNum += num;
		
		if (currentNum > spacesVO.capacity) {
			currentNum = spacesVO.capacity;
		} else if (currentNum < 1) {
			currentNum = 1;
		}
		
		$("#rsv-input-peopleNum").val(currentNum);
		
	}
	
	function checkPeopleNum() {
		var currentNum = +$("#rsv-input-peopleNum").val();
		if (currentNum > spacesVO.capacity) {
			currentNum = spacesVO.capacity;
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
		var spaceIdxInput = $("<input type='text' name='spaceIdx' value='" + spacesVO.idx + "'>");
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
  
	function loadReview(page, order, buttonObj) {
		
		if ($(buttonObj).hasClass("nav-disabled")) {
			return;
		}
		
		$.ajax({
			type: "get",
			data: "reviewPage=" + page + "&orderType=" + order + "&idx=" + spacesVO.idx,
			url: "loadReview.do",
			success: function(data) {
				
				var html = $("<div>").html(data);
				var reviewList = $(html).find("#reviewList").html();
				$("#reviewList").html(reviewList);

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
		})
	}
	
	$(function() {
		$(".review-page-prev").addClass("nav-disabled");
		if (reviewLastPage == 1) {
			$(".review-page-next").addClass("nav-disabled");
		}
	})
	
	
	function qnaQSubmit() {
		
		if ($("#qna-textarea").val() == '') {
			alert('내용을 입력해 주세요.');
			return;
		}
		
		var formData = $("#qna-form").serialize();

		$.ajax({
			type: "post",
			url: "insertqnaq.do",
			data: formData,
			success: function(data) {
				
				if (data == 0) {
					alert('입력이 완료되었습니다.');
					qnaList(1);
					$("#qna-textarea").val('');
				} else if (data == 1) {
					alert('로그인이 필요합니다.');
					location.href='/banderoom/member/glogin.do';
				} else if (data == 2) {
					alert('작성에 실패했습니다.');
				}
				
			}
		})
	}
  
	function qnaList(page) {
		
		$.ajax({
			type: "get",
			url: "qnalist.do",
			data: "idx=" + spacesVO.idx + "&page=" + page,
			success: function(data) {
				
				qnaCurrentPage = page;
				qnaStartPage = data.qnaStartPage;
				qnaEndPage = data.qnaEndPage;
				qnaLastPage = data.qnaLastPage;
				
				var html = $("<div>").html(data);
				var qnaList = $(html).find("#qna-elements");
				$("#qna-elements").html($(qnaList).html());
					
				var pageNav = $(html).find("#qna-page-nav");
				$("#qna-page-nav").html($(pageNav).html());
			
			}
		})
		
	}
	
	function qnaAnswer(qnaIdx, spaceIdx, buttonObj) {
		$("#answer-form-wrap").remove();
		
		if ($(buttonObj).hasClass("accent-button")) {
			$(".show-answer-button").removeClass('accent-button');
			return;
		}

		$(".show-answer-button").removeClass('accent-button');
		
		var answerForm = $("<div id='answer-form-wrap'>");
		$(answerForm).append("<form id='answer-form'>");
		$(buttonObj).parent().parent().parent().append(answerForm);
		$("#answer-form").append("<input type='hidden' name='qnaIdx' value='" + qnaIdx + "'>");
		$("#answer-form").append("<input type='hidden' name='spaceIdx' value='" + spaceIdx + "'>");
		$("#answer-form").append("<div id='answer-textarea-wrap'>");
		$("#answer-form").append("<div id='answer-buttons'>");
		$('#answer-textarea-wrap').append('<textarea id="answer-textarea" name="answer" placeholder="답변을 입력하세요.">');
		$("#answer-buttons").append('<input type="reset" class="normal-button answer-button" value="초기화">');
		$("#answer-buttons").append('<button type="button" class="normal-button accent-button answer-button" onclick="submitAnswer()">등록</button>');
		
		$(buttonObj).addClass('accent-button');
	}
	
	function submitAnswer() {
		if ($("#answer-textarea").val() == '') {
			alert('답변을 입력해 주세요.');
			return;
		}
		
		var formData = $("#answer-form").serialize();

		$.ajax({
			type: "post",
			url: "insertqnaanswer.do",
			data: formData,
			success: function(result) {
				if (result == 0) {
					alert('답변이 정상적으로 등록되었습니다.');
					qnaList(qnaCurrentPage);
				} else if (result == 1) {
					alert('호스트 로그인이 필요합니다.');
					location.href = '/banderoom/member/hlogin.do';
				} else if (result == 2) {
					alert('등록 권한이 없습니다.');
				} else if (result == 3) {
					alert('등록에 실패했습니다.');
				}
			}
		})
	}
	
	function qnaAnswerModify(qnaIdx, spaceIdx, buttonObj) {
		$("#answer-modify-form-wrap").remove();
		
		if ($(buttonObj).hasClass("accent-button")) {
			$(".qna-answer-modify-button").removeClass('accent-button');
			return;
		}

		$(".qna-answer-modify-button").removeClass('accent-button');
		
		var answerForm = $("<div id='answer-modify-form-wrap'>");
		$(answerForm).append("<form id='answer-modify-form'>");
		$(buttonObj).parent().parent().parent().append(answerForm);
		$("#answer-modify-form").append("<input type='hidden' name='qnaIdx' value='" + qnaIdx + "'>");
		$("#answer-modify-form").append("<input type='hidden' name='spaceIdx' value='" + spaceIdx + "'>");
		$("#answer-modify-form").append("<div id='answer-modify-textarea-wrap'>");
		$("#answer-modify-form").append("<div id='answer-modify-buttons'>");
		$('#answer-modify-textarea-wrap').append('<textarea id="answer-modify-textarea" name="answer" placeholder="답변을 입력하세요.">');
		$('#answer-modify-textarea').val($(buttonObj).parent().prev().text().trim());
		$("#answer-modify-buttons").append('<input type="reset" class="normal-button answer-button" value="초기화">');
		$("#answer-modify-buttons").append('<button type="button" class="normal-button accent-button answer-button" onclick="updateAnswer()">등록</button>');
		
		$(buttonObj).addClass('accent-button');
	}
	
	function updateAnswer() {
		if ($("#answer-modify-textarea").val() == '') {
			alert('답변을 입력해 주세요.');
			return;
		}
		
		var formData = $("#answer-modify-form").serialize();

		$.ajax({
			type: "post",
			url: "insertqnaanswer.do",
			data: formData,
			success: function(result) {
				if (result == 0) {
					alert('답변이 정상적으로 수정되었습니다.');
					qnaList(qnaCurrentPage);
				} else if (result == 1) {
					alert('호스트 로그인이 필요합니다.');
					location.href = '/banderoom/member/hlogin.do';
				} else if (result == 2) {
					alert('수정 권한이 없습니다.');
				} else if (result == 3) {
					alert('수정에 실패했습니다.');
				}
			}
		})
	}
	
	function qnaAnswerDelete(qnaIdx, spaceIdx) {
		
		if (!confirm("정말 답변을 삭제하시겠습니까?")) {
			return;
		}

		$.ajax({
			type: "post",
			url: "deleteqnaanswer.do",
			data: "qnaIdx=" + qnaIdx + "&spaceIdx=" + spaceIdx,
			success: function(result) {
				if (result == 0) {
					alert('답변이 삭제되었습니다.');
					qnaList(qnaCurrentPage);
				} else if (result == 1) {
					alert('호스트 로그인이 필요합니다.');
					location.href = '/banderoom/member/hlogin.do';
				} else if (result == 2) {
					alert('삭제 권한이 없습니다.');
				} else if (result == 3) {
					alert('삭제에 실패했습니다.');
				}
			}
		})
		
	}
	
	function qnaDelete(qnaIdx) {
		if (!confirm('정말 삭제하시겠습니까?')) {
			return;
		}
		
		$.ajax({
			type: "post",
			url: "deleteqna.do",
			data: "qnaIdx=" + qnaIdx,
			success: function(result) {
				if (result == 0) {
					alert('답변이 삭제되었습니다.');
					qnaList(qnaCurrentPage);
				} else if (result == 1) {
					alert('로그인이 필요합니다.');
					location.href = '/banderoom/member/glogin.do';
				} else if (result == 2) {
					alert('삭제 권한이 없습니다.');
				} else if (result == 3) {
					alert('삭제에 실패했습니다.');
				}
			}
		})
		
	}
	
	function qnaUpdate(qnaIdx, buttonObj) {
		$("#qna-update-form").remove();
		
		if ($(buttonObj).hasClass("accent-button")) {
			$(".qna-update-button").removeClass('accent-button');
			return;
		}

		$(".qna-update-button").removeClass('accent-button');

		var updateForm = $('<form id="qna-update-form">');
		$(buttonObj).parent().parent().parent().append(updateForm);	
		$(updateForm).append('<input type="hidden" name="qnaIdx" value="' + qnaIdx + '">');
		$(updateForm).append('<div id="qna-update-input-wrap" class="qna-input-wrap">');
		$("#qna-update-input-wrap").append('<textarea id="qna-update-textarea" class="qna-textarea" name="content" placeholder="질문을 입력하세요.">');
		$("#qna-update-textarea").val(
				$(buttonObj).parent().parent().prev().find(".review-content").html().replaceAll(
						"<br>", "\r\n").replace(
								'<img src="/banderoom/images/lock.png" style="margin-bottom: 4px; height: 16px;">', '').trim());
		$("#qna-update-input-wrap").append('<div id="qna-update-input-button-wrap" class="qna-input-button-wrap">');
		$("#qna-update-input-button-wrap").append('<div id="update-form-check" class="form-check">');
		$("#update-form-check").append('<input class="form-check-input" name="privateChecked" type="checkbox" value="1" id="update-public-check">');
		$("#update-form-check").append('<label class="form-check-label" for="update-public-check"> 비공개</label>');
		$("#qna-update-input-button-wrap").append('<button type="button" class="normal-button accent-button qna-update-button" onclick="qnaQUpdateSubmit()">등록</button>');

		if ($(buttonObj).parent().parent().prev().find(".review-content img").length == 1) {
			$("#update-public-check").prop("checked", true);
		}
		
		
		$(buttonObj).addClass('accent-button');
	}
	

	function qnaQUpdateSubmit() {
		
		if ($("#qna-update-textarea").val() == '') {
			alert('내용을 입력해 주세요.');
			return;
		}
		
		var formData = $("#qna-update-form").serialize();
		console.log(formData)

		$.ajax({
			type: "post",
			url: "updateqnaq.do",
			data: formData,
			success: function(data) {
				
				if (data == 0) {
					alert('수정이 완료되었습니다.');
					qnaList(qnaCurrentPage);
					$("#qna-update-textarea").val('');
				} else if (data == 1) {
					alert('로그인이 필요합니다.');
					location.href='/banderoom/member/glogin.do';
				} else if (data == 2) {
					alert('수정 권한이 없습니다.');
				} else if (data == 3) {
					alert('수정에 실패했습니다.');
				}
				
			}
		})
	}
	
	function reload() {
		location.reload();
	}
	
	function updateReview(resIdx) {
		window.open('reviewupdate.do?resIdx=' + resIdx, '_blank', 
        'top=140, left=200, width=800, height=500, menubar=no,toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');
	}
	
	function deleteReview(resIdx) {
		if (!confirm('정말 삭제하시겠습니까?')) {
			return;
		}
		
		$.ajax({
			type: "post",
			url: "deletereview.do",
			data: "resIdx=" + resIdx,
			success: function(data) {
				
				if (data == 0) {
					alert('삭제가 완료되었습니다.');
					reload();
				} else if (data == 1) {
					alert('로그인이 필요합니다.');
					location.href='/banderoom/member/glogin.do';
				} else if (data == 2) {
					alert('삭제 권한이 없습니다.');
				} else if (data == 3) {
					alert('삭제에 실패했습니다.');
				}
			}
		})
	}