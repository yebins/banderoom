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
	width:580px;
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
.container{
	margin-top:80px;
}
.team-col{
	width:33.3%;
	padding-bottom:24px;
}
.team-list{
	width:100%;
	border-radius:15px;
	overflow:hidden;
	box-shadow: 0px 5px 10px rgb(0 0 0 / 20%);
}
.team-list:hover{
	cursor: pointer;
	outline:3px solid #FB6544;
}
.team-list:active {
	filter: brightness(90%);
}
.team-title{
	padding: 15px;
	width:100%;
	height:73px;
	background:#FBE6B2;
	color:#303030;
	font-size: 15px;
}
.team-content{
	width:100%;
	height:220px;
	background:white;
	color:#303030;
	text-align: center;
	font-size: 13px;
	padding:0px 5px;
}
table{
	height:100%;
	width:100%;
}
tr{
	border-bottom:1px solid #FBE6B2;
}
tr:last-of-type{
	border:none;
}
td{
	padding:3px;
}
.team-btn{
	position: absolute;
    top: 170px;
    right: 12px;
    width: 150px;
}
@font-face {
    font-family: 'SuncheonB';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2202-2@1.0/SuncheonB.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'establishRoomNo703OTF';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2112@1.0/establishRoomNo703OTF.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'KOTRAHOPE';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2110@1.0/KOTRAHOPE.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
*{
	font-family:'SuncheonB';
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
			
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-3">
					<c:if test="${teamsList.size()>0}">
					<c:forEach var="item" items="${teamsList}">
						<div class="col team-col" onclick="location.href='details.do?teamidx=${item.teamIdx}'">
							<input type="hidden" name="teamIdx" value="${item.teamIdx}">
							<div class="team-list">
								<div class="team-title">
									<c:if test="${item.type == 'band'}">[밴드]</c:if>
									<c:if test="${item.type == 'dance'}">[댄스]</c:if>
									${item.title}
								</div>
								<div class="team-content">
									<table>
										<tr>
											<td style="width: 75px;">지역</td>
											<td>${item.addr1} ${item.addr2}</td>
										</tr>
										<tr>
											<td>수준</td>
											<td>${item.teamLevel}</td>
										</tr>
										<tr>
											<td>장르</td>
											<td>${item.genre}</td>
										</tr>
										<tr>
										<c:if test="${item.type == 'band'}">
											<td>파트</td>
											<td>
												
												<c:forEach var="parts" items="${partsMap.get(item.teamIdx)}" varStatus="lastPart">
													${parts.name} ${parts.capacity}명<c:if test="${!lastPart.last}">, </c:if>
												</c:forEach>
											</td>
										</c:if>
										<c:if test="${item.type == 'dance'}">
											<td>인원</td>
											<td>
												<c:forEach var="parts" items="${partsMap.get(item.teamIdx)}">
													${parts.capacity}명
												</c:forEach>
											</td>
										</c:if>
										</tr>
										<tr>
											<td>모집기간</td>
											<td>
											<fmt:parseDate value="${item.endDate}" var="endDate" pattern="yyyy-MM-dd"/>
											<fmt:formatDate value="${endDate}" pattern="yyyy년 MM월 dd일 마감"/>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						</c:forEach>
					</c:if>
					<c:if test="${list.size()==0}">
					작성된 글이 존재하지 않습니다.
					</c:if>
				</div>
			</div>
			<c:if test="${login.mIdx ne null}">
				<button class="normal-button team-btn" onclick="location.href='/teams/register.do'">팀원모집 글작성</button>
			</c:if>
		</div>
		
		
	</div>
	<c:import url="/footer.do" />
</body>
</html>