
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