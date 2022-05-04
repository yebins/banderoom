<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	.JlistSearch{
		border-radius:25px;
	}
	div.JArticle{
		width:300px;
		height:200px;
		margin:13px;
	}
	.JArticle:hover{
		border:3px solid #FB6544;
	}
	.JBoard{
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
		border-radius:10px;
	}
	[type="search"] + button{
		height:50px;
		border-radius:25px;
	}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			<a href="jlist.do">중고거래게시판</a>
		</div>
		<div>
			<form action="jlist.do" class="d-flex notice-page" method="get">
				<input type="hidden" name="bIdx" value="3">
       	 		<input class="form-control me-3 JlistSearch" name="searchtitle" type="search" placeholder="Search" aria-label="Search">
        			<button class="accent-button normal-button search-button">검색</button>
     		 </form>
		</div>
		<div id="page-content" class="JBoard">
			<c:forEach var="item" items="${list}" begin="0" varStatus="st">
				<div class="inner-box JArticle">
					<div class="inner-box-content-thumbnail">
						<img style="width:100%;height:100%"src="https://images.unsplash.com/photo-1593642702909-dec73df255d7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80">
					</div>
					<div class="inner-box-content-state-title">
					<span>[거래중] </span><span>${item.title}</span>
					</div>
					<div class="inner-box-content-articleInfo">
					<span><fmt:formatDate pattern="yyyy.MM.dd" value="${item.regDate}"/></span>&nbsp;<span> 조회수 ${item.readCount} </span><span class="miniprofile" style="margin-left:auto;" onclick="profileOpen('${item.mIdx}')">${item.mNickname}</span>
					</div>
				</div>
			</c:forEach>
			<div class="content-write">
				<button class="normal-button accent-button">글쓰기</button>
			</div>
			<div class="pageNum">
				<button class="normal-button accent-button">이전</button>
				<a href="">1</a>
				<a href="">2</a>
				<a href="">3</a>
				<a href="">4</a>
				<a href="">5</a>
				<button class="normal-button accent-button">다음</button>
			</div>
		</div>
	</div>
	<c:import url="/footer.do" />
</body>
</html>