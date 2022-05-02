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
<title>팀원 모집 main</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
#page-content{
	position: relative;
    height: 700px;
}
.form-select{
	margin-right:10px;
	width: 130px;
	height: 35px;
	border-radius:17.5px;
}
.part{
	margin:0px;
}
.form-control{
	margin-right:10px;
	width:200px;
	height: 35px;
	border-radius:17.5px;
}
.search{
	width:600px;
	margin-right:10px;
}
.form{
    width: 100%;
    text-align: center;
    margin: auto;
    padding: 30px 50px 14px;
    border-radius: 15px;
    background: white;
    box-shadow: 0px 5px 10px rgb(0 0 0 / 20%);
}
.search-top{
	width: 100%;
}
.search-bottom{
    justify-content: space-between;
    display: flex;
    width: 100%;
}
.teams{
	margin-top:100px;
	position:relative;
}
.team-list{
	width:280px;
	border-radius:25px;
	overflow:hidden;
	box-shadow: 0px 5px 10px rgb(0 0 0 / 20%);
	border:2px solid #FBE6B2;
	position:absolute;
}
.team-list:hover{
	border:2px solid #FB6544;
}
.team-title{
	padding: 10px;
	width:280px;
	height:61px;
	background:#FB6544;
	color:white;
	font-size: 15px;
}
.team-content{
	width:280px;
	height:200px;
	background:#FBE6B2;
	color:#303030;
	text-align: center;
	font-size: 13px;
}
table{
	height:100%;
	width:100%;
}
tr{
	border-bottom:1px solid #FB6544;
}
tr:last-of-type{
	border:none;
}
td{
	padding:3px;
}
.team-btn{
	position: absolute;
    bottom: 50px;
    right: 0px;
    width: 130px;
}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			팀원 모집
		</div>
		<div id="page-content">
			<form action="#">
				<div class="form">
					<div class="mb-3 d-inline-flex search-top">
						<select class="form-select form-select-sm col">
							<option>지역</option>
							<option>서울특별시</option>
							<option>전라북도</option>
						</select>
						<select class="form-select form-select-sm col">
							<option>세부지역</option>
							<option>전주시 덕진구</option>
							<option>전주시 완산구</option>
							<option>군산시</option>
						</select>
						<select class="form-select form-select-sm col">
							<option>팀 레벨</option>
							<option>초급</option>
							<option>중급</option>
							<option>고급</option>
						</select>
						<select class="form-select form-select-sm col">
							<option>분야</option>
							<option>밴드</option>
							<option>댄스</option>
						</select>
						<select class="form-select form-select-sm col"><!-- 밴드 -->
							<option>장르</option>
							<option>락</option>
							<option>팝</option>
							<option>재즈</option>
							<option>그 외 장르</option>
						</select>
						<!--select class="form-select form-select-sm col"> 댄스
							<option>장르</option>
							<option>힙합</option>
							<option>팝핑</option>
							<option>락킹</option>
							<option>K-Pop 댄스</option>
							<option>그 외 장르</option>
						</select -->
						<select class="form-select form-select-sm col part"><!-- 밴드-락 -->
							<option>파트</option>
							<option>보컬</option>
							<option>일렉기타</option>
							<option>드럼</option>
							<option>베이스</option>
							<option>키보드</option>
							<option>그 외</option>
						</select>
					</div>
					<br>
					<div class="mb-3 search-bottom">
						<input class="form-control form-control-sm" type="text" value="모집 기간 선택">
						<div class="search-btn d-inline-flex">
							<input class="form-control form-control-sm search" type="text" placeholder="검색어를 입력하세요.">
							<button type="submit" class="accent-button normal-button">검색하기</button>
						</div>
					</div>
				</div>
			</form>
			<div class="teams">
				<div class="team-list">
					<div class="team-title">
					코스모스 락밴드에서 함께할 팀원을 모집합니다.
					</div>
					<div class="team-content">
						<table>
							<tr>
								<td style="width: 75px;">지역</td>
								<td>전라북도 전주시 덕진구</td>
							</tr>
							<tr>
								<td>수준</td>
								<td>초급</td>
							</tr>
							<tr>
								<td>장르</td>
								<td>락</td>
							</tr>
							<tr>
								<td>파트</td>
								<td>보컬 1명, 드럼 1명, 베이스 1명, 키보드 1명</td>
							</tr>
							<tr>
								<td>모집기간</td>
								<td>2022년 04월 25일까지</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="team-list" style="right:360px;">
					<div class="team-title">
					제목
					</div>
					<div class="team-content">
					내용
					</div>
				</div>
				<div class="team-list" style="right:0px;">
					<div class="team-title">
					제목
					</div>
					<div class="team-content">
					내용
					</div>
				</div>
			</div>
		<button class="accent-button normal-button team-btn" onclick="location.href='/teams/getTeams.do'">팀원 모집하기</button>
		</div>
		
		
	</div>
	
</body>
</html>