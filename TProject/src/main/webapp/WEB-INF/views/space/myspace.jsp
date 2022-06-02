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
<title>공간 관리</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link rel="stylesheet" type="text/css" href="/css/space/myspace.css">
<script src="/js/space/myspace.js"></script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			공간 관리
		</div>
		<div id="page-content">
			<div class="filter-buttons">
				<select id="addr1" class="form-select form-select-sm" onchange="showAddr2()">
					<option value="">지역</option>
					<option id="addr1-loading" value="">로드 중..</option>
				</select>
				<select id="addr2" class="form-select form-select-sm" style="display: none;" onchange="listFilter()">
				</select>
				<select id="space-type" class="form-select form-select-sm" onchange="listFilter()">
					<option value="">분류</option>
					<option>녹음실</option>
					<option>밴드연습실</option>
					<option>댄스연습실</option>
				</select>
				<select id="space-status" class="form-select form-select-sm" onchange="listFilter()">
					<option value="">등록 상태</option>
					<option value="0">등록 대기</option>
					<option value="1">등록 완료</option>
					<option value="2">등록 거부됨</option>
				</select>
				<button class="normal-button reset-filter" onclick="resetFilter()">필터 초기화</button>
			</div>
			
			<c:forEach var="vo" items="${spacesVOs}">
				<div class="inner-box spacebox" style="height: 120px; margin-bottom: 20px;" onclick="location.href='details.do?idx=${vo.getIdx()}'">
					<input type="hidden" class="addr1-hidden" value="${vo.getAddr1()}">
					<input type="hidden" class="addr2-hidden" value="${vo.getAddr2()}">
					<input type="hidden" class="type-hidden" value="${vo.getType()}">
					<input type="hidden" class="status-hidden" value="${vo.getStatus()}">
					<div class="inner-box-content">
						<div class="space-thumb">
							<c:choose>
								<c:when test="${vo.getThumb() != null}">
									<img src="${vo.getThumb()}" width="100%">
								</c:when>
								<c:otherwise>
									썸네일 없음
								</c:otherwise>
							</c:choose>
						</div>
						<div class="space-info">
							<div class="space-name">
								${vo.getName()} 
								<span class="space-type">
									${vo.getType()}
								</span>
							</div>
							<div class="space-rest-info">
								<div>
									<span class="space-addr">
										${vo.getAddr1()} ${vo.getAddr2()}
									</span>
									|
									<span class="space-regdate">
										등록일 <fmt:formatDate value="${vo.getRegDate()}" pattern="yyyy-MM-dd"/>
									</span>
								</div>
								<div class="space-status">
									<c:choose>
										<c:when test="${vo.getStatus() == 0}">
											<span class="status-waiting">등록 대기</span>
										</c:when>
										<c:when test="${vo.getStatus() == 1}">
											<span class="status-accepted">등록 완료</span>
										</c:when>
										<c:when test="${vo.getStatus() == 2}">
											<span class="status-refused">등록 거부됨</span>
										</c:when>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
					<button class="normal-button myspacersv-button" onclick="mySpaceRsv(${vo.idx})">예약 내역</button>
				</div>
			</c:forEach>
			
		</div>
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>