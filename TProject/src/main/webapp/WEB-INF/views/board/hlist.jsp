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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
	.notice-page{
		width:600px;
		height:50px;
	}
	.HlistSearch{
		border-radius:25px;
	}
	div.HArticle{
		width:300px;
		height:200px;
		margin:13px;
	}
	.HArticle:hover{
		outline:3px solid #fb6544;
	}
	.HBoard{
		display:flex;
		flex-flow:row wrap;
		margin-top:20px;
	}
	.inner-box-content-thumbnail{
		margin:0;
		height:80%;
		
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
		height:100%;
		border-radius:10px;
	}
	[type="search"] + button{
		height:50px;
		border-radius:25px;
	}
	
    .HListPageButton{
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
    .Hlist-status{
		border-radius:25px;
		border: 1px solid #ced4da;
		height:50px;
		text-align:center;
		margin-right:10px;
		font-size:1rem;
		
	}
	   .search-button{
    	align-self:center;
    }
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			<a href="hlist.do">홍보 게시판</a>
		</div>
		<div>
			<form action="/board/hlist.do" class="d-flex notice-page" method="get">
				<select name="searchType" class="Hlist-status">
					<option <c:if test="${searchType eq 'title'}">selected</c:if> value="title">제목</option>
					<option <c:if test="${searchType eq 'mNickname'}">selected</c:if> value="mNickname">작성자</option>
				</select>
				<input type="hidden" name="page" value="1">
				<input type="hidden" name="bIdx" value="4">
				<input type="hidden" name="status" value="0">
       	 		<input class="form-control me-3 HlistSearch" name="searchValue" id="searchtitle" type="text" placeholder="Search" aria-label="Search" value="${searchValue}">
        			<button class="accent-button normal-button search-button">검색</button>
     		 </form>
		</div>
		<div id="page-content" class="HBoard">
			<c:if test="${fn:length(list) gt 0}">
				<c:forEach var="item" begin="0" end="${fn:length(list) -1}" varStatus="st">
					<div class="inner-box HArticle ${(list.get(item).status == 99)?'sold':''}" onclick="location.href='/board/details.do?bIdx=${list.get(item).bIdx}&aIdx=${list.get(item).aIdx}'">
						<div class="inner-box-content-thumbnail ">
							<c:choose>
								<c:when test="${imgsrc.get(item) ne ''}">
									<img src="${imgsrc.get(item)}"/>
								</c:when>
								<c:otherwise>
									<img src="https://images.unsplash.com/photo-1651579293356-ec8c360a3bf8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8Q0R3dXdYSkFiRXd8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60">
								</c:otherwise>
							</c:choose>
						</div>
						<div class="inner-box-content-state-title">
							<span>${list.get(item).title}</span>
						</div>
						<div class="inner-box-content-articleInfo">
						<span><fmt:formatDate pattern="yyyy.MM.dd" value="${list.get(item).regDate}"/></span>&nbsp;<span> 조회수 ${list.get(item).readCount} </span><span class="miniprofile" style="margin-left:auto;" onclick="profileOpen('${list.get(item).mIdx}')">${list.get(item).mNickname}</span>
						</div>
					</div>
				</c:forEach>
			</c:if>
			<div class="content-write">
			<c:if test="${login != null}">>
				<button class="normal-button accent-button" onclick="location.href='/board/register.do?bIdx=4'">글쓰기</button>
			</c:if>
			</div>
				<c:set var="articlesTotal" value="${articlesTotal}"/>
				<c:set var="page" value="${(param.page == null)?1:param.page}"/>
				<c:set var="startNum" value="${page-(page-1)%5}"/>	
				<c:set var="lastNum" value="${fn:substringBefore(Math.ceil(articlesTotal/6),'.')}"/>
			검색된 게시물 수 : ${articlesTotal}
			<div class="pageNum">	
						<button class="normal-button accent-button hListPageButton" style="visibility:${(startNum<=1)?'hidden':'visible'};">
							<a href="hlist.do?page=${startNum-5}&status=${status}&searchtitle=${searchtitle}">이전</a>
						</button>
						<c:forEach var="i" begin="0" end="4">
							<c:if test="${(startNum+i)<= lastNum}">
								<a href="hlist.do?page=${startNum+i}&status=${status}&searchtitle=${searchtitle}" style="color:${page==(startNum+i)?'lightgreen; border:1px solid lightgray; padding:5px; border-radius:10px;':''}">${startNum+i}</a>
							</c:if>
						</c:forEach>
						<button class="normal-button accent-button hListPageButton" style="visibility:${(startNum+5<=lastNum)?'visible':'hidden'};">
							<a href="hlist.do?page=${startNum+5}&status=${status}&searchtitle=${searchtitle}">다음</a>
						</button>
			</div>
		</div>
	</div>
	<script>
		(function(){
			console.log(112);
		})()
	</script>
	<c:import url="/footer.do" />
</body>
</html>