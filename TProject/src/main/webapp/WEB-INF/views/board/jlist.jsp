<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>중고거래 게시판</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
	.notice-page{
		width:600px;
		height:50px;
	}
	.JlistSearch{
		border-radius:25px;
	}
	div.JArticle{
		width:300px;
		height:200px;
		margin:13px;
	}
	.JArticle:hover{
		outline:3px solid #fb6544;
	}
	.JBoard{
		display:flex;
		flex-flow:row wrap;
		margin-top:20px;
	}
	.inner-box-content-thumbnail{
		margin:0;
		height:80%;
		border-radius:10px;
		display: flex;
		justify-content: center;
		align-items: center;
		overflow: hidden;
		
	}	
	.inner-box-content-thumbnail>img{
		cursor:pointer;		
	}
	.inner-box-content-state-title{
		border-bottom:2px solid lightgray;
		font-weight:600;
		max-width: 270px;
   	 	overflow: hidden;
    	text-overflow: ellipsis;
   		white-space: nowrap;
	}
	.inner-box-content-state-title:hover{
		cursor:pointer;
	}
	.inner-box-content-articleInfo{
		display:flex;
		justify-content:end;
		font-size:12px;
	}
	
	.content-write{
		display:flex;
		width:100%;
		justify-content:end;
		margin:30px;
	}
	.pageNum{
		display:flex;
		width:100%;
		justify-content:center;
		align-items:center;
		
	}
	.pageNum button{
		margin:5px;
	}
	.pageNum a{
		margin:5px;
	}
	
	.inner-box-content-thumbnail img{
		width:100%;
	}
	[type="search"] + button{
		height:50px;
		border-radius:25px;
	}
	
	.jlist-status{
		border-radius:25px;
		border: 1px solid #ced4da;
		height:50px;
		text-align:center;
		margin-right:10px;
		font-size:1rem;
		width:90px;
		
	}
    .jListPageButton{
    	width:70px;
    	background-color:#f5f5f5;
    }
    .sold {
    	opacity:0.6;
    }
    .sold::before{
    	position:absolute;
    	content:'거래완료';
    	color:white;
    	background-color: rgba(0,0,0,.7);
    	font-size:1rem;
    	font-weight:bold;
    	border:3px solid black;
    	border-radius:15px;
    	transform:translate(90px,50px);
    	padding:10px;
    	
    }
    .search-button{
    	align-self:center;
    }
    .page-nav-button {
   		border:none;
		width: 40px;
		height: 40px;
		border-radius: 20px;
		margin: 7.5px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		display: flex;
		justify-content: center;
		align-items: center;
		background-color:white;
	}
	.page-nav-button:not(.current-page) {
		cursor: pointer;
	}
	.page-nav-button.current-page {
		background-color: #2A3F6A;
		font-weight: bold;
		color: #F5F5F5;
	}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			<a href="jlist.do">중고거래 게시판</a>
		</div>
		<div>
			<form action="/board/jlist.do" class="d-flex notice-page" method="get">
				<select name="status" class="jlist-status">
					<option <c:if test="${status eq '97'}">selected</c:if> value="97">판매</option>
					<option <c:if test="${status eq '98'}">selected</c:if> value="98">구매</option>
					<option <c:if test="${status eq '99'}">selected</c:if> value="99">거래완료</option>
				</select>
				<select name="searchType" class="jlist-status">
					<option <c:if test="${param.searchType eq 'title'}">selected</c:if> value="title">제목</option>
					<option <c:if test="${param.searchType eq 'mNickname'}">selected</c:if> value="mNickname">작성자</option>
				</select>
				<input type="hidden" name="page" value="1">
				<input type="hidden" name="bIdx" value="3">
       	 		<input class="form-control me-3 JlistSearch" name="searchValue" id="searchtitle" type="text" placeholder="Search" aria-label="Search" value="${param.searchValue}">
        			<button class="accent-button normal-button search-button">검색</button>
     		 </form>
		</div>
		<div id="page-content" class="JBoard">
			<c:if test="${fn:length(list) gt 0}">
				<c:forEach var="item" begin="0" end="${fn:length(list) -1}" varStatus="st">
					<div class="inner-box JArticle ${(list.get(item).status == 99)?'sold':''}" onclick="location.href='/board/details.do?bIdx=${list.get(item).bIdx}&aIdx=${list.get(item).aIdx}'">
						<div class="inner-box-content-thumbnail ">
							<c:choose>
								<c:when test="${imgsrc.get(item) ne ''}">
									<img src="${imgsrc.get(item)}"/>
								</c:when>
								<c:otherwise>
									<img src="/images/no_image.png">
								</c:otherwise>
							</c:choose>
						</div>
						<div class="inner-box-content-state-title">
								<c:choose>
									<c:when test="${list.get(item).status eq '97'}"><span>[판매]</span></c:when>
									<c:when test="${list.get(item).status eq '98'}"><span>[구매]</span></c:when>
									<c:when test="${list.get(item).status eq '99'}"><span>[거래완료]</span></c:when>
									<c:otherwise>[거래상태 등록해주세요]</c:otherwise>
								</c:choose>
							<span>${list.get(item).title}</span>
							<c:if test="${fn:length(cmt) gt 0}">
							<span>[${cmt.get(item)}]</span>
							</c:if>
						</div>
						<div class="inner-box-content-articleInfo">
						<span><fmt:formatDate pattern="yyyy.MM.dd" value="${list.get(item).regDate}"/></span>&nbsp;<span> 조회수 ${list.get(item).readCount} </span><span class="miniprofile" style="margin-left:auto;" onclick="profileOpen('${list.get(item).mIdx}')">${list.get(item).mNickname}</span>
						</div>
					</div>
				</c:forEach>
			</c:if>
			<div class="content-write">
				<c:if test="${login != null}">
				<button class="normal-button accent-button" onclick="location.href='/board/register.do?bIdx=3'">글쓰기</button>
				</c:if>
			</div>
				<c:set var="articlesTotal" value="${articlesTotal}"/>
				<c:set var="page" value="${(param.page == null)?1:param.page}"/>
				<c:set var="startNum" value="${page-(page-1)%5}"/>	
				<c:set var="lastNum" value="${fn:substringBefore(Math.ceil(articlesTotal/6),'.')}"/>
			검색된 게시물 수 : ${articlesTotal}
			<div class="pageNum">
						<c:if test="${page>5}">
						<a class="page-nav-button" href="jlist.do?page=1&status=${status}&searchtitle=${searchtitle}">
							1
						</a>
						<a class="page-nav-button" href="jlist.do?page=${startNum-5}&status=${status}&searchtitle=${searchtitle}">
							◀
						</a>
						</c:if>
						<c:forEach var="i" begin="0" end="4">
							<c:if test="${(startNum+i)<= lastNum}">
							<c:choose>
									<c:when test="${(startNum+i) == page }">
									<a class="page-nav-button current-page" href="jlist.do?page=${startNum+i}&status=${status}&searchtitle=${searchtitle}">
										${startNum+i}
									</a>
									</c:when>
									<c:otherwise>
									<a class="page-nav-button" href="jlist.do?page=${startNum+i}&status=${status}&searchtitle=${searchtitle}">
										${startNum+i}
									</a>
									</c:otherwise>
								</c:choose>
							</c:if>
						</c:forEach>
						<c:if test="${(startNum+5) < lastNum}" >
						<a class="page-nav-button" href="jlist.do?page=${startNum+5}&status=${status}&searchtitle=${searchtitle}">
							▶
						</a>
						</c:if>
						<c:if test="${(startNum+5) <= lastNum}">
						<a class="page-nav-button" href="jlist.do?page=${lastNum}&status=${status}&searchtitle=${searchtitle}">
							${lastNum}
						</a>
						</c:if>
			</div>
		</div>
	</div>
	<c:import url="/footer.do" />
</body>
</html>