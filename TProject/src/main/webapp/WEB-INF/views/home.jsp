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
	.section-title {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.space-section-title {
		font-size: 28px;
		font-weight: bold;
	}
	
	.section-content {
		position: relative;
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
	
	.space-cost span {
		font-size: 20px;
	}
	
	.space-type-cost-wrap {
		display: flex;
		justify-content: space-between;
		align-items: flex-end;
	}
	
	.space-restinfo-restinfo {
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-size: 14px;
		font-weight: normal;
	}
	
	.content-cover {
		overflow: hidden;
		position: relative;
	}
	
	.content-wrap {
		width: 3920px;
		display: flex;
		position: relative;
		top: 0px;
		left: 0px;
	}
	
	.spacecol {
		width: 33.3%;
		margin: 20px 20px 0px;
	}
	
	#space-page-nav {
		display: flex;
		justify-content: center;
		align-items: center;	
	}
	
	.page-button {
		width: 30px;
		height: 30px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.page-button-element {
		width: 15px;
		height: 15px;
		border-radius: 7.5px;
		background-color: white;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
	}
	
	.current-page .page-button-element {
		background-color: #fb6544;
	}
	
	.page-button:not(.current-page):hover {
		cursor: pointer;
	}
	
	.more-wrap {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.more-button {
		width: 36px;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-left: 10px;
	}
	
	.button-arrow {
		width: 10px;
		height: 10px;
		transform: translateX(-20%) rotate(45deg);
		border-top: 3px solid darkgray;
		border-right: 3px solid darkgray;
	}
	
	.side-page-button {
		width: 36px;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-left: 10px;
		position: absolute;
		top: 154px;
	}
	.side-page-button:hover {
		cursor: pointer;
	}
	
	.prev-page-button {
		left:-45px;
	}
	
	.next-page-button {
		right: -36px;
	}
	
	.prev-page-arrow {
		transform: translateX(20%) rotate(225deg);
	}
	
	.button-disabled {
		display: none;
	}
</style>
<script>

	var spacePage = 1;
	
	function space(page) {
		spacePage = page;
		$(".content-wrap").animate({left: ((spacePage - 1) * -980) + "px"}, 300);
		$(".page-button").removeClass("current-page");
		$(".page-button").eq(spacePage - 1).addClass("current-page");
		$(".side-page-button").removeClass("button-disabled");
		if (page == 1) {
			$(".prev-page-button").addClass("button-disabled");
		} else if (page == 4) {
			$(".next-page-button").addClass("button-disabled");
		}
	}

</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
		</div>
		<div id="page-content">
			<div class="section-title">
				<div class="space-section-title">
					요즘 핫한 공간
				</div>
				<div class="more-wrap">
					<span>
					공간 더 보기
					</span>
					<button class="normal-button more-button" onclick="location.href='/space/list.do'">
						<div class="button-arrow"></div>
					</button>
				</div>
			</div>
			<div class="section-content">
				<div class="content-cover">
					<div class="content-wrap">
							<c:forEach var="i" begin="0" end="${spaceList.size() - 1}">
								<div class="spacecol">
									<div class="inner-box spacebox" onclick="location.href='details.do?idx=${spaceList[i].getIdx()}'">
									<input type="hidden" name="idx" value="${spaceList[i].getIdx()}">
									<input type="hidden" name="address" value="${spaceList[i].getAddress()}">
									<c:if test="${spaceList[i].liked == 1 }">
									<img class="liked-space" src="/images/heart-filled.png">
									</c:if>
										<div class="space-thumb">
											<img src="${spaceList[i].thumb}" width="100%">
										</div>
										<div class="space-info">
											<div class="space-name">${spaceList[i].getName()}</div>
											<div class="space-restinfo">
												<div class="space-type-cost-wrap">
													<div class="space-type">${spaceList[i].getType()}</div>
													<div class="space-cost">
														<span>
															<fmt:formatNumber value="${spaceList[i].getCost()}" pattern="#,###" /> 
														</span>
														원 / 시간
													</div>
												</div>
												<div class="space-restinfo-restinfo">
													<div class="space-addr">${spaceList[i].getAddr1()} ${spaceList[i].getAddr2()}</div>
													<div class="space-score">
														⭐ <fmt:formatNumber value="${spaceList[i].getReviewAvg()}" pattern="0.0" /> (${spaceList[i].getReviewCnt()})
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
					</div>
				</div>
				
				<div id="space-page-nav">
					<div class="page-button current-page" onclick="space(1)">
						<div class="page-button-element"></div>
					</div>
					<div class="page-button" onclick="space(2)">
						<div class="page-button-element"></div>
					</div>
					<div class="page-button" onclick="space(3)">
						<div class="page-button-element"></div>
					</div>
					<div class="page-button" onclick="space(4)">
						<div class="page-button-element"></div>
					</div>
				</div>
				
				<div class="normal-button side-page-button prev-page-button button-disabled" onclick="space(spacePage - 1)">
					<div class="button-arrow prev-page-arrow"></div>
				</div>
				<div class="normal-button side-page-button next-page-button" onclick="space(spacePage + 1)">
					<div class="button-arrow next-page-arrow"></div>
				</div>
					
			</div>
			
		</div>
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>