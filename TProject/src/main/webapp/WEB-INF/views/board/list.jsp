<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>
	<c:choose>
		<c:when test="${param.bIdx == 1}">공지사항</c:when>
		<c:when test="${param.bIdx == 2}">자유게시판</c:when>
		<c:when test="${param.bIdx == 3}">중고거래 게시판</c:when>
		<c:when test="${param.bIdx == 4}">홍보게시판</c:when>
		<c:when test="${param.bIdx == 5}">자주 묻는 질문</c:when>
		<c:when test="${param.bIdx == 6}">이벤트</c:when>
	</c:choose>
</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
	.freeBoard-list{
		width:90%;
		align:center;
		padding: 0px !important;
		overflow: hidden;
		margin: 40px auto;
	}
	.freeBoard-list-table{
		width:100%;
	}
	table{
		border-collapse: collapse;
	}
	tr{
		text-align:center;
		background-color:white;
	}
	tr:not(tr:first-child) {
		border-top: 1px solid #D8D8D8;
	}
	
	th{
		text-align:center;
		background-color: white;
		color: black;
		font-size: 12px;
		height: 30px;
	}
	td{
		font-size:14px;
		height:50px;
	}
	#register{
		position:relative;
		left:350px;
		top:10px;
	}
	.bestArticles{
		color: #FB6544;
		font-weight:bold;
	}
	.title-area{
		display:flex;
		justify-content:flex-start;
		align-items: center;
		
	}
	a img{
		margin-left: 5px;
		margin-bottom: 2px;
	}
	.bestArticles-tr{
		background-color:#f2f2f2;
	}
	#page-nav {
		width: 100%;
		height: 80px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.page-nav-button {
		width: 40px;
		height: 40px;
		border-radius: 20px;
		margin: 7.5px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		display: flex;
		justify-content: center;
		align-items: center;
		background: white;
	}
	.page-nav-button:not(.current-page) {
		cursor: pointer;
	}
	.page-nav-button.current-page {
		background-color: #2A3F6A;
		color: #F5F5F5;
		font-weight: bold;
		cursor: default;
	}
	.search-name-input {	
	    margin-right: 20px;
	    width: 350px;
	    height: 36px;
	    border-radius: 25px;
	    padding: 0px 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		border: none;
	}
	.form-select {
	    margin-right: 10px;
	    width: 100px;
	    height: 36px;
	    border-radius: 25px;
	    padding: 0px 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		border: none;
	}
	span.profile:hover {
		cursor: pointer;
	}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			<a href="list.do?bIdx=2&page=1">자유게시판</a>
		</div>
		<div>
			<form action="list.do" class="d-flex notice-page" method="get">
				<select name="searchType" class="form-select">
					<option <c:if test="${searchType eq 'title'}">selected</c:if> value="title">제목</option>
					<option <c:if test="${searchType eq 'mNickname'}">selected</c:if> value="mNickname">작성자</option>
					<option <c:if test="${searchType eq 'content'}">selected</c:if> value="content">내용</option>
				</select>
				<input type="hidden" name="bIdx" value="2">
				<input type="hidden" name="page" value="1">
       	 		<input class="search-name-input" name="searchValue" id="searchtitle" type="search" placeholder="검색어를 입력하세요." aria-label="Search" value="${searchValue}">
        			<button class="normal-button accent-button">검색</button>
     		 </form>
		</div>
		<div class="freeBoard-list inner-box">
			<table class="freeBoard-list-table">
				<tr>
					<th width="10%">글번호</th>
					<th width="40%">제목</th>
					<th width="20%">작성자</th>
					<th width="14%">작성일</th>
					<th width="8%">조회</th>
					<th width="8%">추천</th>
				</tr>
				<c:if test="${bestArticles.size()>0}">
					<c:forEach var="i" begin="0" end="${bestArticles.size()-1}">
						<tr class="bestArticles-tr">
							<td class="bestArticles">추천</td>
							<td class="title-area"><a style="color: #FB6544; font-weight:bold;" href="details.do?bIdx=${param.bIdx}&aIdx=${bestArticles.get(i).aIdx}&page=${param.page}">
							&nbsp;&nbsp;&nbsp;${bestArticles.get(i).title }</a>
								<c:if test="${cSize.get(bestArticles.get(i).aIdx) != 0}">
									<span style="color:red;">&nbsp;[${cSize.get(bestArticles.get(i).aIdx)}]</span>
								</c:if>
							</td>
							<td class="bestArticles"><span class="bestArticles profile" onclick="profileOpen(${bestArticles.get(i).mIdx})">${bestArticles.get(i).mNickname }</span></td>
							<td class="bestArticles">
								<fmt:formatDate value="${bestArticles.get(i).regDate }" pattern="yyyy-MM-dd"/>
							</td>
							<td class="bestArticles">${bestArticles.get(i).readCount }</td>
							<td class="bestArticles">${bestArticles.get(i).likeCount }</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list.size() > 0 }">
					<c:forEach var="i" begin="0" end="${list.size()-1}">
						<tr>
							<td>${list.get(i).aIdx }</td>
							<td class="title-area"><a href="details.do?bIdx=${param.bIdx}&aIdx=${list.get(i).aIdx}&page=${param.page}">
								&nbsp;&nbsp;&nbsp;${list.get(i).title}</a>
								<c:if  test="${cSize.get(list.get(i).aIdx) != 0 }">
									<span style="color:red;">&nbsp;[${cSize.get(list.get(i).aIdx)}]</span>
								</c:if>
								</td>
							<td><span class="profile" onclick="profileOpen(${list.get(i).mIdx})">${list.get(i).mNickname }</span></td>
							<td>
								<fmt:formatDate value="${list.get(i).regDate }" pattern="yyyy-MM-dd"/>
							</td>
							<td>${list.get(i).readCount }</td>
							<td>${likeList.get(list.get(i).aIdx)}</td>
						</tr>
					</c:forEach>
					
						<tr>
							<td colspan="6">
								<div id="page-nav"><!-- 페이징 -->
									<c:if test="${pu.getLastPage() < 6}">
										<c:forEach var="i" begin="${pu.getStartPage()}" end="${pu.getLastPage()}">
											<c:choose>
												<c:when test="${i == param.page}">
													<b class="page-nav-button current-page">${i}</b>
												</c:when>
												<c:otherwise>
													<a class="page-nav-button" href="list.do?bIdx=${param.bIdx}&page=${i}&searchType=${param.searchType}&searchValue=${param.searchValue}">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:if>
									<c:if test="${pu.getLastPage() > 5}">
										<c:if test="${pu.getStartPage() > 5}">
											<a class="page-nav-button" href="list.do?bIdx=2&page=1&searchType=${param.searchType}&searchValue=${param.searchValue}">1</a>&nbsp;
											<a class="page-nav-button" href="list.do?bIdx=2&page=${pu.getStartPage() - 1}&searchType=${param.searchType}&searchValue=${param.searchValue}">◀</a>&nbsp;
										</c:if>
										<c:forEach var="i" begin="${pu.getStartPage()}" end="${pu.getEndPage()}">
											<c:choose>
												<c:when test="${i == param.page}">
													<b class="page-nav-button current-page">${i}</b>
												</c:when>
												<c:otherwise>
													<a class="page-nav-button" href="list.do?bIdx=${param.bIdx}&page=${i}&searchType=${param.searchType}&searchValue=${param.searchValue}">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<c:if test="${pu.getEndPage() < pu.getLastPage()}">
											<a class="page-nav-button" href="list.do?bIdx=${param.bIdx}&page=${pu.getEndPage() + 1}&searchType=${param.searchType}&searchValue=${param.searchValue}">▶</a>
											<a class="page-nav-button" href="list.do?bIdx=${param.bIdx}&page=${pu.getLastPage()}&searchType=${param.searchType}&searchValue=${param.searchValue}">${pu.getLastPage()}</a>
										</c:if>
									</c:if>
								</div>
							</td>
						</tr>
				</c:if>
				<c:if test="${list.size() == 0 }">
					<tr>
						<td colspan="6">등록된 게시글이 없습니다.</td>
					</tr>
				</c:if>
			</table>
		</div>
		

		<c:if test="${login != null}">
			<form action="register.do" method="get">
			<input type="hidden" name="bIdx" value="${param.bIdx}">
				<button class="normal-button accent-button" id="register" style="margin-left: 15px;">글쓰기</button>
			</form>
		</c:if>
	</div>
	<c:import url="/footer.do" />
</body>
</html>