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
	.freeBoard-list{
		width:70%;
		align:center;
	}
	.freeBoard-list-table{
		margin-top: 20px;
		width:100%;
	}
	td,th{
		text-align:center;
	}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			자유게시판
		</div>
		<div>
			<form class="d-flex notice-page">
       	 		<input class="form-control me-3" type="search" placeholder="Search" aria-label="Search">
        			<button class="accent-button">검색</button>
     		 </form>
		</div>
		<div class="freeBoard-list">
			<table class="freeBoard-list-table">
				<tr>
					<th width="10%">번호</th>
					<th width="40%">제목</th>
					<th width="20%">작성자</th>
					<th width="10%">작성일</th>
					<th width="10%">조회수</th>
					<th width="10%">추천수</th>
				</tr>
				<c:if test="${freeBoardList.size() > 0 }">
					<c:forEach var="item" items="${freeBoardList}">
						<tr>
							<td>${item.aIdx }</td>
							<td><a href="view.do?aIdx=${item.aIdx}">${item.title }</a></td>
							<td>${item.mNickname }</td>
							<td>${item.regDate }</td>
							<td>${item.readCount }</td>
							<td>1</td><!-- 추천수 어떻게 가져옴니까... -->
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list.size() == 0 }">
					<tr>
						<td colspan="6">등록된 게시글이 없습니다.</td>
					</tr>
				</c:if>
			</table>
		</div>
		
	</div>
	
</body>
</html>