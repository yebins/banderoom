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
<title>후기 작성</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/space/review.css">
<script src="/js/space/review.js"></script>
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