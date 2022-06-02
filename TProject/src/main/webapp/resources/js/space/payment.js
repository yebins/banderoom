
	// 결제 설정
	var IMP = window.IMP;
	IMP.init("imp34520606");

	var payMethod = "";
	var point = 0;
	var cost = rsvVO.cost;
	var total = cost;
	var loginPoint = login.point;
	
	
	function setPayMethod(button) {
		$("button.pay-method").removeClass("accent-button");
		payMethod = $(button).attr("data-method");
		$(button).addClass("accent-button");
	}
	
	function checkPoint() {
		point = $(".rsv-input.point").val();
		
		if (point < 0) {
			point = 0;
		} else if (point > loginPoint) {
			point = loginPoint;
		}
		
		$(".rsv-input.point").val(point);
		
		calcTotal();
	}
	
	function useAllPoint() {
		point = loginPoint;
		$(".rsv-input.point").val(point);
		
		calcTotal();
	}
	
	function calcTotal() {
		total = cost - point;
		if (total < 0) {
			point += total;
			total = 0;			

			$(".rsv-input.point").val(point);
		}
				
		$("#gettingPoint").text(Math.round(total * 0.01));
		$(".total-cost span").text(total.toLocaleString());
	}
	
	function viewTerms(button) {
		var terms;
		
		if ($(button).hasClass("accent-button")) {
			$(button).removeClass("accent-button");
			terms = $(button).attr("data-terms");
			$(".terms-detail[data-terms=" + terms + "]").css("display", "none");
		}	else {
			$(button).addClass("accent-button");
			terms = $(button).attr("data-terms");
			$(".terms-detail[data-terms=" + terms + "]").css("display", "block");
		}
	}
	
	function paySubmit() {
		if (
				!$("#term-1").is(":checked") ||
				!$("#term-2").is(":checked") ||
				!$("#term-3").is(":checked")
				) {
			
			alert('약관에 동의해 주세요.');
			
			return;
		}
		
		payWithCard();
	}

	function payWithCard() {
		
		if (total == 0) {

			var rsvForm = $("<form action='paysuccess.do' method='post' display='none'>");

			var mIdxInput = $("<input type='text' name='mIdx' value='" + login.mIdx + "'>");
			var spaceIdxInput = $("<input type='text' name='spaceIdx' value='" + spacesVO.idx + "'>");
			var peopleNumInput = $("<input type='text' name='peopleNum' value='" + rsvVO.peopleNum + "'>");
			var startDateInput = $("<input type='text' name='startDate' value='" + $("textarea#startDate").val().trim() + "'>");
			var endDateInput = $("<input type='text' name='endDate' value='" + $("textarea#endDate").val().trim() + "'>");
			var rsvHoursInput = $("<input type='text' name='rsvHours' value='" + rsvVO.rsvHours + "'>");
			var costInput = $("<input type='text' name='cost' value='" + rsvVO.cost + "'>");
			var usedPointInput = $("<input type='text' name='usedPoint' value='" + point + "'>");
			var totalCostInput = $("<input type='text' name='totalCost' value='" + total + "'>");
			
			$("body").append(rsvForm);
			
			$(rsvForm).append(mIdxInput);
			$(rsvForm).append(spaceIdxInput);
			$(rsvForm).append(peopleNumInput);
			$(rsvForm).append(startDateInput);
			$(rsvForm).append(endDateInput);
			$(rsvForm).append(rsvHoursInput);
			$(rsvForm).append(costInput);
			$(rsvForm).append(usedPointInput);
			$(rsvForm).append(totalCostInput);
			
			$(rsvForm).submit();
		} else {
			
			IMP.request_pay({ // param
				pg: "html5_inicis",
				pay_method: "card",
				name: "공간 예약_" + spacesVO.name,
				amount: total,
				buyer_email: login.email,
				buyer_name: login.name,
				buyer_tel: login.tel
			}, function (rsp) { // callback
				if (rsp.success) {
					
							var rsvForm = $("<form action='paysuccess.do' method='post' display='none'>");
	
							var mIdxInput = $("<input type='text' name='mIdx' value='" + login.mIdx + "'>");
							var spaceIdxInput = $("<input type='text' name='spaceIdx' value='" + spacesVO.idx + "'>");
							var peopleNumInput = $("<input type='text' name='peopleNum' value='" + rsvVO.peopleNum + "'>");
							var startDateInput = $("<input type='text' name='startDate' value='" + $("textarea#startDate").val().trim() + "'>");
							var endDateInput = $("<input type='text' name='endDate' value='" + $("textarea#endDate").val().trim() + "'>");
							var rsvHoursInput = $("<input type='text' name='rsvHours' value='" + rsvVO.rsvHours + "'>");
							var costInput = $("<input type='text' name='cost' value='" + rsvVO.cost + "'>");
							var usedPointInput = $("<input type='text' name='usedPoint' value='" + point + "'>");
							var totalCostInput = $("<input type='text' name='totalCost' value='" + total + "'>");
							
							$("body").append(rsvForm);
							
							$(rsvForm).append(mIdxInput);
							$(rsvForm).append(spaceIdxInput);
							$(rsvForm).append(peopleNumInput);
							$(rsvForm).append(startDateInput);
							$(rsvForm).append(endDateInput);
							$(rsvForm).append(rsvHoursInput);
							$(rsvForm).append(costInput);
							$(rsvForm).append(usedPointInput);
							$(rsvForm).append(totalCostInput);
							
							$(rsvForm).submit();
					
				} else {
					alert('결제에 실패했습니다.');
				}
			});
		}
			
	}