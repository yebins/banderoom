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
	#title {
		font-size: 36px;
		font-weight: bold;
		margin: 20px;
	}
	#content {
		padding: 0px 20px;
	}
	.inner-box {
		height: 396px;
	}
	.rsv-info-wrap {
		border-bottom: 1px solid lightgray;
		padding-bottom: 15px;
	}
	
	.past-rsv-wrap {	
		height: 90px;
		display: flex;
		align-items: center;
	}
	.past-rsv-wrap:not(.past-rsv-wrap:first-child) {
		border-top: 1px solid lightgray;
	}
	
	.past-rsv-name {
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 5px;
	}
	
	.past-rsv-info-items {
		display: inline-flex;
	}
	.small-title {
		font-size: 14px;
		font-weight: bold;
	}
	.small-content {
		font-size: 14px;
		margin-left: 5px;
	}
	.rsv-thumb {
		width: 120px;
		height: 90px;
		border-radius: 10px;
		overflow: hidden;
		margin-right: 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.4);
	}
	.rsv-thumb img {
		width: 100%;
	}
	
	.review-buttons-wrap {
		margin-top: 15px;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	.review-textarea {
		margin-top: 15px;
		border: 1px solid lightgray;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		border-radius: 10px;
		height: 195px;
		width: 100%;
		resize: none;
		padding: 15px;
		font-family: '맑은 고딕';
	}
	
	.review-buttons {
		display: flex;
		align-items: center;
	
	}
	
	.upload-pic {
		width: 36px;
		margin-left: 10px;
		border: 1px solid lightgray;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.upload-pic img {
		width: 50%;
	}
	.upload-pic:hover {
		cursor: pointer;
	}
	.upload-pic:active {
		filter: brightness(90%);
	}
	
	.score-stars {
		display: flex;
		width: calc(30 * 5)px;
		height: 30px;
		background-color: lightgray;
		position: relative;
	}
	.score-color {
		position: absolute;
		top: 0px;
		left: 0px;
		width: 0px;
		height: 100%;
		background-color: #fb6544;
		z-index: 8;
	}
	.score-stars img {
		width: 30px;
		z-index: 9;
	}
	.score-stars img:hover {
		cursor: pointer;
	}
	#file {
		display: none;
	}
	.review-content-wrap {
		position: relative;
	}
	.upload-img-box {
		position: absolute;
		top: 30px;
		left: 16px;
		width: 100px;
		height: 100px;
		border-radius: 7px;
		display: none;
		overflow: hidden;
		justify-content: center;
		align-items: center;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.4);
	}
	.upload-img-box:hover {
		filter: brightness(90%);
		cursor: pointer;
	}
	
</style>
<script>
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
		}, 100);
	}
	
	function imgReset() {
		$("#file").val("");
		$(".upload-img-box").css("display", "none");
		$(".review-textarea").css("padding-left", "15px");
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
		
		var formData = new FormData($('#reviewForm')[0]);
		
		$.ajax({
			type: "post",
			url: "review.do",
			data: formData,
			contentType: false,
			processData: false,
			success: function(result) {
				
				if (result == 0) {
					alert('작성이 완료되었습니다.');
					window.opener.reload();
					window.close();					
				} else if (result == 1) {
					alert('로그인이 필요합니다.');
					window.opener.gotoLogin();
					window.close();
				} else if (result == 2) {
					alert('작성에 실패했습니다.');
				}
			}
		})
	}
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

		<div id="title">
			후기 작성
		</div>
		<div id="content">
			<div class="inner-box">
			
				<div class="rsv-info-wrap">
					<div class="past-rsv-wrap">
						<div class="rsv-thumb">
							<img src="${rsvVO.thumb}">
						</div>
						<div class="past-rsv-info-wrap">
							<div class="past-rsv-name">${rsvVO.name}</div>
							<div class="past-rsv-info">
								<div class="past-rsv-info-items">
									<div class="small-title">공간 사용일</div>
									<div class="small-content">
										<fmt:formatDate value="${rsvVO.startDate}" pattern="yyyy/MM/dd H시~"/>
										<fmt:formatDate value="${rsvVO.endDate}" pattern="k시"/>, ${rsvVO.rsvHours}시간
									</div>
								</div>&nbsp;&nbsp;
								<div class="past-rsv-info-items">
									<div class="small-title">예약일</div>
									<div class="small-content">
										<fmt:formatDate value="${rsvVO.resDate}" pattern="yyyy/MM/dd"/>
									</div>
								</div>
							</div>
							<div class="past-rsv-info">
								<div class="past-rsv-info-items">
									<div class="small-title">이용료</div>
									<div class="small-content">
										<fmt:formatNumber value="${rsvVO.cost}" pattern="#,###" />원
									</div>
								</div>&nbsp;&nbsp;
								<div class="past-rsv-info-items">
									<div class="small-title">결제 금액</div>
									<div class="small-content">
										<fmt:formatNumber value="${rsvVO.totalCost}" pattern="#,###" />원
									</div>
								</div>&nbsp;&nbsp;
							</div>
						</div>
					</div>
				</div>
				
				<form id="reviewForm" action="review.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="resIdx" value="${rsvVO.resIdx}">
					<input type="hidden" name="spaceIdx" value="${rsvVO.spaceIdx}">
					<div class="review-buttons-wrap">
						<div class="review-buttons">
							<div class="score-stars">
								<input type="hidden" name="score" value="">
								<div class="score-color"></div>
								<img src="/images/score-star.png" onclick="setScore(1)">
								<img src="/images/score-star.png" onclick="setScore(2)">
								<img src="/images/score-star.png" onclick="setScore(3)">
								<img src="/images/score-star.png" onclick="setScore(4)">
								<img src="/images/score-star.png" onclick="setScore(5)">
							</div>
							<label for="file" class="normal-button upload-pic">
							<img src="/images/picture-button.png"></label>
							<input id="file" type="file" name="picture" onchange="showImg(this)" accept="image/*">
						</div>
						<button type="button" class="normal-button accent-button" onclick="reviewSubmit()">등록</button>
					</div>
					<div class="review-content-wrap">
						<textarea class="review-textarea" name="content" placeholder="내용을 입력하세요."></textarea>
						<div class="upload-img-box">
							<img id="uploaded-image" onclick="imgReset()">
						</div>
					</div>
				</form>
			</div>
		</div>
		
	
</body>
</html>