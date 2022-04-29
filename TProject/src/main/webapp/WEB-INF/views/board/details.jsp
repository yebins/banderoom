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
	.board-header{
		display:flex;
		font-size:20px;
	}
	.board-header-title{
		flex:1;
		width:90%;
	}
	.board-header-date{
	}
	.board-middle{
		display:flex;
		font-size:15px;
	}
	.board-middle-nickname{
		flex:1;
	}
	.board-middle-count{
	}
	div.inner-box{
		height:500px;
	}
	.board-content{
		height:300px;
	}
	.board-content-like{
		height:290px;
		display:flex;
		justify-content: center;
		align-items: flex-end;
	}
	.board-content-likebutton{
	}
	.details-button{
		display:flex;
		flex-direction: row-reverse;
	}
	.board-recommand{
		margin-top:15px;
	}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div class="inner-box" style="margin-top:30px;">
			<div class="inner-box-content">
				<div class="board-header">
					<div class="board-header-title">제목 : ${vo.title }</div>
					<div class="board-header-date"><fmt:formatDate value="${vo.regDate }" pattern="yyyy-MM-dd hh:mm"/></div>
				</div><hr>
				<div class="board-middle">
					<div class="board-middle-nickname">${vo.mNickname}</div><div class="board-middle-count">조회수 : ${vo.readCount}&nbsp;&nbsp;추천수 : </div>
				</div><hr>
				<div class="board-content">
					${vo.content}
					<div class="board-content-like">
						<div class="board-content-likebutton">
						<button class="normal-button" style="width:70px;">추천</button>&nbsp;<span>추천수</span>
						</div>
					</div>
				</div>
			</div>
			<div class="details-button">
			<form action="update.do" method="get">
				<c:if test="${login.mIdx == vo.mIdx}">
					<button class="normal-button accent-button" id="update" style="margin-left: 15px;">수정</button>
					<button class="normal-button" id="delete" style="margin-left: 15px;">삭제</button>
				</c:if>	
			</form>
			</div>
		</div>
		<div class="board-recommand">
			<input class="normal-button" value="프사" style="width:50px;" readonly><input type="text" class="normal-button" style="width:500px;" placeholder="댓글을 입력하세요.">
			<button class="normal-button accent-button" id="update">등록</button>
		</div>
		
	</div>
</body>
</html>