

	$(function() {
		setScore(reviewVO.score);
		
		if (reviewVO.pictureSrc != "") {
			var img = $("#uploaded-image");
      $(img).attr('src', '/banderoom/' + reviewVO.thumbSrc);
      $(img).parent().css("display", "flex");
      $(".review-textarea").css("padding-left", "130px");
		}
		
		setTimeout(() => {

			var divAspect = 1; // div의 가로세로비는 알고 있는 값이다
			var imgAspect = $(img).height() / $(img).width();
			
		
			if (imgAspect <= divAspect) {
			    // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
			    $(img).css("width", "auto");
			    $(img).css("height", "100%");
			} else {
			    // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
			    $(img).css("width", "100%");
			    $(img).css("height", "auto");
			}
			
		}, 100);
	})

	function setScore(score) {
		$('.score-color').css("width", (30 * score) + "px");
		$("input[name=score]").val(score);
	}
	
	function showImg(input) {
		
		var img = $("#uploaded-image");
		
		if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $(img).attr('src', e.target.result);
	            $(img).parent().css("display", "flex");
	            $(".review-textarea").css("padding-left", "130px");
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
        
		setTimeout(() => {

			var divAspect = 1; // div의 가로세로비는 알고 있는 값이다
			var imgAspect = $(img).height() / $(img).width();
			
		
			if (imgAspect <= divAspect) {
			    // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
			    $(img).css("width", "auto");
			    $(img).css("height", "100%");
			} else {
			    // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
			    $(img).css("width", "100%");
			    $(img).css("height", "auto");
			}
			
			$('#fileChanged').val("1");
		}, 100);
	}
	
	function imgReset() {
		$("#file").val("");
		$(".upload-img-box").css("display", "none");
		$(".review-textarea").css("padding-left", "15px");

		$('#fileChanged').val("1");
	}
	
	function reviewSubmit() {
		
		if ($("input[name=score]").val() == '') {
			alert('별점을 입력하세요.');
			return;
		}
		
		if ($(".review-textarea").val() == '') {
			alert('내용을 입력하세요.');
			return;
		}
	
		formData = new FormData($('#reviewForm')[0]);
		
		$.ajax({
			type: "post",
			url: "reviewupdate.do",
			data: formData,
			contentType: false,
			processData: false,
			success: function(result) {
				
				if (result == 0) {
					alert('작성이 완료되었습니다.');
					window.opener.loadReview(opener.reviewPage, opener.orderType);
					window.close();					
				} else if (result == 1) {
					alert('로그인이 필요합니다.');
					window.opener.gotoLogin();
					window.close();
				} else if (result == 2) {
					alert('권한이 없습니다.');				
				} else if (result == 3) {
					alert('작성에 실패했습니다.');
				}
			}
		})
	}