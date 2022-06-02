<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>공간 대여</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/space/list.css">

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a8d83e76596a6e93d144575566c3d5ae&libraries=services"></script>
<script>

	var locations;
	var page = 1;
	var loading = false;
	var allLoaded = false;
	var orderType = "review";
	if (${param.orderType != null}) {
		orderType = '${param.orderType}';		
	}
	
	var liked = 0;
	if (${param.liked != null}) {
		liked = '${param.liked}';
	}

	var searchParam = 0;
	if (${param.search != null}) {
		searchParam = '${param.search}';
	}
	
	var param = {
			addr1: '${param.addr1}',
			addr2: '${param.addr2}',
			type: '${param.type}',
			name: '${param.name}'			
	}

<c:if test="${login != null}">
	var myAddress = '${login.getAddr1()} ${login.getAddr2()}';
</c:if>
<c:if test="${login == null}">
	var myAddress = '서울시 중구';
</c:if>


</script>

<script src="<%=request.getContextPath() %>/js/space/list.js"></script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			공간 대여
		</div>
		<div id="page-content">
			<form id="search-form">
			<input type="hidden" name="search" value="1">
				<div class="inner-box">
					<div class="inner-box-content">
						<div class="filters">
							<div class="filter-select-wrap"> 
								<select id="addr1" class="form-select form-select-sm" name="addr1" onchange="showAddr2()">
									<option value="">지역</option>
									<option id="addr1-loading" value="">로드 중..</option>
								</select>
								<select id="addr2" class="form-select form-select-sm" name="addr2" style="display: none;">
								</select>
								<select id="space-type" class="form-select form-select-sm" name="type">
									<option value="">분류</option>
									<option>녹음실</option>
									<option>밴드연습실</option>
									<option>댄스연습실</option>
								</select>
							</div>
							<div class="filter-buttons">
								<input type="hidden" name="liked" value="0">
								<c:if test="${login != null}">
								<button type="button" class="normal-button liked-button" onclick="searchLiked()">
									<img src="<%=request.getContextPath() %>/images/heart-empty.png">
								</button>
								</c:if>
								<button type="button" class="normal-button map-button" onclick="showMap()">&nbsp;지도<img src="<%=request.getContextPath() %>/images/map_pin.png" style="height: 20px; margin-left: 0px;"></button>
								<button type="button" class="normal-button search-button reset-filter" onclick="location.href='list.do'">필터 초기화</button>
							</div>
						</div>
						<div class="search-text">
							<select id="space-orderType" class="form-select form-select-sm" name="orderType">
								<option value="review">리뷰 많은 순</option>
								<option value="score">별점 높은 순</option>
							</select>
							<input type="text" class="search-name-input" name="name" placeholder="공간 이름">
							<button class="normal-button accent-button search-button">검색</button>
						</div>
					</div>
				</div>
			</form>
			
			<c:if test="${spaceList.size() != 0}">
				<div class="container">
				  <div class="row row-cols-1 row-cols-sm-3 spacerow">
						<c:forEach var="i" begin="0" end="${spaceList.size() - 1}">
							<div class="col spacecol">
								<div class="inner-box spacebox" onclick="location.href='details.do?idx=${spaceList[i].getIdx()}'">
								<input type="hidden" name="idx" value="${spaceList[i].getIdx()}">
								<input type="hidden" name="address" value="${spaceList[i].getAddress()}">
								<c:if test="${spaceList[i].liked == 1 }">
								<img class="liked-space" src="<%=request.getContextPath() %>/images/heart-filled.png">
								</c:if>
									<div class="space-thumb">
										<img src="<%=request.getContextPath() %>${spaceList[i].thumb}" width="100%">
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
			</c:if>
			<c:if test="${spaceList.size() == 0}">
				등록된 공간이 없습니다.
			</c:if>
		</div>
		
	</div>
	
	<div id="mapBackOveray">
		<div id="mapBackground" onclick="closeMap()"></div>
		<div id="map"></div>
	</div>
	<c:import url="/footer.do" />
	
	<div id="ajax" style="display: none"></div>
</body>
</html>