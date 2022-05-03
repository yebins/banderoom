<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<style>
.terms-list{
    padding: 5px;
    margin-bottom: 10px;
}
.terms{
	border:1px solid #ced4da;
    border-radius: 17.5px;
    padding: 6px;
    font-size: 12px;
    background: white;
    margin-right:5px;
}
#title{
	font-size: 25px;
    padding: 10px;
}
#writer{
    padding: 10px;
}
#deadline{
	color: #303030;
    /* border: 1px solid #FB6544; */
    background: #FBE6B2;
    border-radius: 20px;
    padding: 6px;
    font-size: 13px;
    margin-left: 10px;
    box-shadow: 0px 4px 10px rgb(0 0 0 / 20%);
}
#content{
	width:100%;
	height:500px;
	margin-bottom:10px;
}
.inner-box{
	margin-bottom: 50px;
}
.normal-button{
	margin-right: 8px;
}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			팀원 모집
		</div>
		<div id="page-content">
			<div class="inner-box" style="height:750px;">
					<div id="title">제목</div>
					<div id="writer">작성자명
						<span id="deadline">마감날짜 | 2022년 05월 12일</span>
					</div>
					
					<div class="terms-list">
						<span class='terms'>전라북도</span>
						<span class='terms'>전주시 덕진구</span>
						<span class='terms'>초급</span>
						<span class='terms'>밴드</span>
						<span class='terms'>락</span>
						<span class='terms'>일렉기타 1명</span>
						<span class='terms'>보컬 1명</span>
					</div>
					<div class="inner-box-content">
						<div id="content" class="form-control" style="width:100%; height:500px;">내용</div>
					</div>
					<div class="inner-box-button-wrap">
						<button type="button" class="normal-button">수정</button> 
						<button type="button" class="normal-button">삭제</button> 
						<button type="button" class="normal-button accent-button" 
						onclick="window.open('application.do', '_blank', 
                       'top=140, left=300, width=500, height=500, menubar=no,toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');">지원하기</button> 
					</div>
				</div>
		</div>
		
	</div>
	
</body>
</html>