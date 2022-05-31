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
	.section-title:not(.section-title:first-child) {
		margin-top: 30px;
		margin-bottom: 20px;
	}

	.space-section-title {
		font-size: 28px;
		font-weight: bold;
	}
	
	.section-content {
		position: relative;
	}
	
	div.spacecol {
		padding: 20px 20px 24px;
		width: 33.3%;
		overflow: hidden;
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
	
	.review-section-title {
		margin-top: 30px;
		margin-bottom: 20px;
	}
	
	.reviewes {
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		width: 100%;
	}
	
	.co {
		width: 33.3%;
	}
	
	.review-wrap {
		padding: 10px;
	}
	
	.review-wrap a:active {
		filter: brightness(90%);
	}
	
	.review-box:hover {
		outline: 3px solid #fb6544;
	}
	
	.review-header {
		margin-top: 15px;
	}

	.review-space-name {
		font-weight: bold;
		font-size: 20px;
	}				

	.review-score-wrap {
		display: flex;
		justify-content: flex-end;
	}
	
	.review-score-stars {
		display: flex;
		width: calc(24 * 5)px;
		height: 24px;
		background-color: lightgray;
		position: relative;
		margin-left: 10px;
	}
	.review-score-color {
		position: absolute;
		top: 0px;
		left: 0px;
		height: 100%;
		background-color: #fb6544;
		z-index: 8;
	}
	.review-score-stars img {
		width: 24px;
		z-index: 9;
	}
	.review-picture {
		
	}
	.review-picture img {
		width: 100%;
		border-radius: 10px;
	}
	
	.review-content {
		margin-top: 15px;
		word-break: break-all;
	}
	
				
	.team-col{
		width:33.3%;
		padding-bottom:24px;
	}
	.team-list{
		width:100%;
		border-radius:15px;
		overflow:hidden;
		box-shadow: 0px 5px 10px rgb(0 0 0 / 20%);
	}
	.team-list:hover{
		cursor: pointer;
		outline:3px solid #FB6544;
	}
	.team-list:active {
		filter: brightness(90%);
	}
	.team-title{
		padding: 15px;
		width:100%;
		/*height:73px;*/
		background:#2A3F6A;
		color:#303030;
		font-size: 15px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		display:block;
	}
	.team-content{
		width:100%;
		height:240px;
		background:white;
		color:#303030;
		text-align: center;
		font-size: 13px;
		padding:0px 5px;
	}
	table{
		height:100%;
		width:100%;
	}
	tr{
		border-bottom:1px solid #2A3F6A;
	}
	tr:last-of-type{
		border:none;
	}
	td{
		padding:3px;
	}
</style>
<script>

	var spacePage = 1;
	var teamsPage = 1;
	
	function space(page) {
		spacePage = page;
		$(".space-content .content-wrap").animate({left: ((spacePage - 1) * -980) + "px"}, 300);
		$(".space-content .page-button").removeClass("current-page");
		$(".space-content .page-button").eq(spacePage - 1).addClass("current-page");
		$(".space-content .side-page-button").removeClass("button-disabled");
		if (page == 1) {
			$(".space-content .prev-page-button").addClass("button-disabled");
		} else if (page == 4) {
			$(".space-content .next-page-button").addClass("button-disabled");
		}
	}

	function teams(page) {
		teamsPage = page;
		$(".teams-content .content-wrap").animate({left: ((teamsPage - 1) * -980) + "px"}, 300);
		$(".teams-content .page-button").removeClass("current-page");
		$(".teams-content .page-button").eq(teamsPage - 1).addClass("current-page");
		$(".teams-content .side-page-button").removeClass("button-disabled");
		if (page == 1) {
			$(".teams-content .prev-page-button").addClass("button-disabled");
		} else if (page == 4) {
			$(".teams-content .next-page-button").addClass("button-disabled");
		}
	}
	
	
	$(function() {

		$(".review-wrap").each(function() {
			var el = $(this).detach();
			

			var co1h = $("#co1").height();
			var co2h = $("#co2").height();
			var co3h = $("#co3").height();
			
			var minh = Math.min(co1h, co2h, co3h);
			
			if (minh == co1h) {
				$("#co1").append(el);
			} else if (minh == co2h) {
				$("#co2").append(el);
			} else {
				$("#co3").append(el);
			}
			
		})
	})

</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
		</div>
		<div id="page-content">
		
			<div class="point-banner" style="width: 100%;">
				<div style="width: 980px; height: 160px; position: relative; border-radius: 8px; background-color: #FFCC99;">
					<div style="position: absolute; top: 45px; left: 80px;">
						<p style="font-style: normal; font-weight: bold; font-size: 26px; line-height: 42px; letter-spacing: -0.3px;">
						대관비 5% 적립받자
						</p>
					</div>
					<div style="position: absolute; top: 95px; left: 80px;">
						<p onclick="location.href='/serinfo.do?idx=4'" style="font-style: normal; font-weight: 500; font-size: 17px; line-height: 20px; letter-spacing: -0.1px; cursor: pointer;">
						자세히 보기
						</p>
					</div>
				</div>
			</div>
			
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
			<div class="section-content space-content">
				<div class="content-cover">
					<div class="content-wrap">
							<c:forEach var="i" begin="0" end="${spaceList.size() - 1}">
								<div class="spacecol">
									<div class="inner-box spacebox" onclick="location.href='/space/details.do?idx=${spaceList[i].getIdx()}'">
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
			
			
			<div class="section-title review-section-title">
				<div class="space-section-title">
					공간 생생 리뷰
				</div>
			</div>
						
			<div class="section-content reviewes">
				<div id="co1" class="co"></div>
				<div id="co2" class="co"></div>
				<div id="co3" class="co"></div>
			</div>
			
			<c:forEach var="review" items="${recentReview}">
				<div class="review-wrap">
					<a href="/space/details.do?idx=${review.spaceIdx}">
					<div class="inner-box review-box">
						<div class="review-picture">
							<img src="${review.pictureSrc}">
						</div>
						<div class="review-header">
							<div class="review-space-name">
								${review.spaceName}
							</div>
							<div class="review-score-wrap">
								<div class="review-score-stars">
									<div class="review-score-color" style="width: ${review.score * 24}px"></div>
									<img src="/images/score-star.png">
									<img src="/images/score-star.png">
									<img src="/images/score-star.png">
									<img src="/images/score-star.png">
									<img src="/images/score-star.png">
								</div>
							</div>
						</div>
						<div class="review-content">
							${review.content }
						</div>
					</div>
					</a>
				</div>
			</c:forEach>
			
		
			<div class="section-title" style="margin-top: 60px;">
				<div class="space-section-title">
					최근 팀원 모집
				</div>
				<div class="more-wrap">
					<span>
					모집 더 보기
					</span>
					<button class="normal-button more-button" onclick="location.href='/teams/main.do'">
						<div class="button-arrow"></div>
					</button>
				</div>
			</div>
			
			
			<div class="section-content teams-content">
				<div class="content-cover">
					<div class="content-wrap">
						<c:if test="${teamsList.size()>0}">
							<c:forEach var="item" items="${teamsList}">
								<div class="spacecol">
								<div class="inner-box spacebox" onclick="location.href='/teams/details.do?teamIdx=${item.teamIdx}'">
									<input type="hidden" name="teamIdx" value="${item.teamIdx}">
									<div class=""<c:if test="${item.status==2}">style='filter: brightness(50%);'</c:if>>
										<div class="team-title">
											<c:if test="${item.status==2}">[마감]</c:if>
											[${item.type}] ${item.title}
										</div>
										<div class="team-content">
											<table>
												<tr>
													<td style="width: 75px;">지역</td>
													<td>${item.addr1} ${item.addr2}</td>
												</tr>
												<tr>
													<td>팀 레벨</td>
													<td>${item.teamLevel}</td>
												</tr>
												<tr>
													<td>장르</td>
													<td>${item.genre}</td>
												</tr>
												<tr>
												<c:if test="${item.type == '밴드'}">
													<td>파트</td>
													<td>
														
														<c:forEach var="parts" items="${partsMap.get(item.teamIdx)}" varStatus="lastPart">
															${parts.name} ${parts.capacity}명<c:if test="${!lastPart.last}">, </c:if>
														</c:forEach>
													</td>
												</c:if>
												<c:if test="${item.type == '댄스'}">
													<td>인원</td>
													<td>
														<c:forEach var="parts" items="${partsMap.get(item.teamIdx)}">
															${parts.capacity}명
														</c:forEach>
													</td>
												</c:if>
												</tr>
												<tr>
													<td>모집기간</td>
													<td>
														<fmt:parseDate value="${item.endDate}" var="endDate" pattern="yyyy-MM-dd"/>
														<fmt:formatDate value="${endDate}" pattern="yyyy년 M월 d일 마감"/>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
								</div>
							</c:forEach>
							<c:if test="${teamsList.size() < 12}">
								<c:forEach var="i" begin="1" end="${12 - teamsList.size()}">
									<div class="spacecol"></div>
								</c:forEach>
							</c:if>
						</c:if>
					<c:if test="${teamsList.size()==0}">
					작성된 글이 존재하지 않습니다.
					</c:if>
					</div>
				</div>
				
				<div id="space-page-nav">
					<div class="page-button current-page" onclick="teams(1)">
						<div class="page-button-element"></div>
					</div>
					<div class="page-button" onclick="teams(2)">
						<div class="page-button-element"></div>
					</div>
					<div class="page-button" onclick="teams(3)">
						<div class="page-button-element"></div>
					</div>
					<div class="page-button" onclick="teams(4)">
						<div class="page-button-element"></div>
					</div>
				</div>
				
				<div class="normal-button side-page-button prev-page-button button-disabled" onclick="teams(teamsPage - 1)">
					<div class="button-arrow prev-page-arrow"></div>
				</div>
				<div class="normal-button side-page-button next-page-button" onclick="teams(teamsPage + 1)">
					<div class="button-arrow next-page-arrow"></div>
				</div>
					
			</div>
			
			<style>
				#section-wrap {
					display: flex;
					margin-top: 60px;
				}
				.section-element {
					width: 50%;
				}
				.article-title-wrap {
					display: flex;
					align-items: center;
				}
				.article-title {
					margin-left: 20px;
					font-weight: bold;
					font-size: 28px;
				}
				.article-body {
					padding: 20px;
				}
				.article-list {
					padding: 0px 15px !important;
				}
				.article-element {
					padding: 15px 0px;
				}
				.article-element:not(.article-element:first-child) {
					border-top: 1px solid lightgray;
				}
				
			</style>
			<div id="section-wrap">
				<div class="section-element">
					<div class="article-title-wrap">
						<div class="article-title">공지사항</div>
						<button class="normal-button more-button" onclick="location.href='/serlist.do?bIdx=1&page=1'">
							<div class="button-arrow"></div>
						</button>
					</div>
					<div class="article-body">
						<div class="inner-box article-list">
							<c:choose>
								<c:when test="${serList1.size() < 6}">
									<c:forEach var="i" begin="0" end="${serList1.size() - 1}">
										<div class="article-element">
											${serList1.get(i).title}
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="i" begin="0" end="5">
										<div class="article-element">
											${serList1.get(i).title}
										</div>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				
				<div class="section-element">
					<div class="article-title-wrap">
						<div class="article-title">이벤트</div>
						<button class="normal-button more-button" onclick="location.href='/serlist.do?bIdx=6&page=1'">
							<div class="button-arrow"></div>
						</button>		
					</div>
					<div class="article-body">
						<div class="inner-box article-list">
							<c:choose>
								<c:when test="${serList2.size() < 6}">
									<c:forEach var="i" begin="0" end="${serList2.size() - 1}">
										<div class="article-element">
											${serList2.get(i).title}
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="i" begin="0" end="5">
										<div class="article-element">
											${serList2.get(i).title}
										</div>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>