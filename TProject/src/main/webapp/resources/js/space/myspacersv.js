
	function loadMyRsv(page) {
		$.ajax({
			type: "get",
			url: "loadMySpaceRsv.do",
			data: "idx=" + spaceIdx + "&page=" + page + "&dateType=" + dateType + "&dateRange=" + dateRange,
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