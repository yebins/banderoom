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
	.freeBoard-list{
		width:80%;
		align:center;
	}
	.freeBoard-list-table{
		margin-top: 20px;
		width:100%;
	}
	table{
		border-collapse: collapse;
	}
	td,th{
		text-align:center;
		border-top: 1px solid #444444;
		background-color:white;
	}
	th{
		background-color: #FFDAC4;
		color: black;
		height:50px;
	}
	td{
		height:30px;
		font-size:12px;
	}
	#register{
		position:relative;
		left:350px;
		top:10px;
	}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
		<c:if test="${param.bIdx==2 }">
			자유게시판
		</c:if>
		</div>
		<div>
			<form action="list.do" class="d-flex notice-page" method="get">
				<input type="hidden" name="bIdx" value="${param.bIdx}">
       	 		<input class="form-control me-3" name="searchtitle" type="search" placeholder="Search" aria-label="Search">
        			<button class="normal-button accent-button">검색</button>
     		 </form>
		</div>
		<div class="freeBoard-list">
			<table class="freeBoard-list-table">
				<tr>
					<th width="10%">번호</th>
					<th width="40%">제목</th>
					<th width="20%">작성자</th>
					<th width="14%">작성일</th>
					<th width="8%">조회수</th>
					<th width="8%">추천수</th>
				</tr>
				<c:if test="${list.size() > 0 }">
					<c:forEach var="i" begin="0" end="${list.size()-1}">
						<tr>
							<td>${list.get(i).aIdx }</td>
							<td><a href="details.do?bIdx=${param.bIdx}&aIdx=${list.get(i).aIdx}">${list.get(i).title }</a></td>
							<td onclick="profileOpen(${list.get(i).mIdx})">${list.get(i).mNickname }</td>
							<td>
								<fmt:formatDate value="${list.get(i).regDate }" pattern="yyyy-MM-dd"/>
							</td>
							<td>${list.get(i).readCount }</td>
							<td>${likeList.get(list.get(i).aIdx)}</td>
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
		<form action="register.do" method="get">
		<input type="hidden" name="bIdx" value="${param.bIdx}">
			<button class="normal-button accent-button" id="register" style="margin-left: 15px;">글쓰기</button>
		</form>
	</div>
	<c:import url="/footer.do" />
</body>
</html>