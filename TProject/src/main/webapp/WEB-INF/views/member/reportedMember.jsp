<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>신고글 목록</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
table{
	width:100%;
	text-align: center;
}
tr{
	border-bottom: 1px solid lightgray;
	height:40px;
}
#page-nav, #app-page-nav {
	border-top: 1px solid lightgray;
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
}
.page-nav-button:not(.current-page) {
	cursor: pointer;
}
.page-nav-button.current-page {
	background-color: #2A3F6A;
	font-weight: bold;
	color:#F3F3F3;
}
#title{
	height: 50px;
    font-size: 18px;
    font-weight: bold;
}
.detail{
	width:45px;
	height:30px;
	box-shadow: 0px 0px 3px rgb(0 0 0 / 20%);
	font-size:14px;
}
.accent-button{
	width:60px;
}
.form-select{
    margin-bottom:10px;
	height: 35px;
	border-radius:17.5px;
	border: none;
    box-shadow: 0px 0px 5px rgb(0 0 0 / 20%);
    width: 120px;
}
.form-control{
	margin-right:6px;
	width:200px;
	height: 35px;
	border-radius:17.5px;
	border: none;
    box-shadow: 0px 0px 5px rgb(0 0 0 / 20%);
}
#listsize0{
	text-align: center;
    margin: 30px;
    font-size: 20px;
}
.miniprofile{
	cursor: pointer;
}

</style>
<script>
$(function(){
	
	var searchField = "${param.searchField}";
	if(searchField == ""){
		searchField = "target";
	}
	
	var sort = "${param.sort}";
	if(sort == ""){
		sort = "rIdx";
	}
	
	$("select[name=searchField]").val(searchField);
	$("select[name=sort]").val(sort);
	$("input[name=searchWord]").val("${param.searchWord}");
	
})
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			신고글 관리
		</div>
		<div id="page-content">
			<form action="reportedMember.do" id="search-form">
				<input type="hidden" name="search" value="1">
				<div class="d-flex justify-content-between">
					<div>
						<select class="form-select form-select-sm" name="sort" onchange="$('#search-form').submit()">
							<option value="rIdx">신고번호순</option>
							<option value="reportCount">신고횟수순</option>
						</select>
					</div>
					<div class="d-flex">
						<select class="form-select form-select-sm" name="searchField">
							<option value="target">닉네임</option>
							<option value="reporter">신고자</option>
							<option value="content">내용</option>
						</select>&nbsp;
						<input class="form-control form-control-sm" type="text" name="searchWord" placeholder="검색어를 입력해주세요.">
						<button type="submit" class="normal-button accent-button">검색</button> &nbsp;
						<button type="button" class="normal-button" style="width:75px;" onclick="location.href='reportedMember.do'">초기화</button>
					</div>
				</div>
			</form>
			<c:if test="${reportedMember.size() > 0}">
			<div class="inner-box reglist-box">
				<div id="reglist">
					<table>
						<tr id="title">
							<td style="width:10%;">신고번호</td>
							<td style="width:20%;">닉네임</td>
							<td style="width:10%;">신고횟수</td>
							<td style="width:20%;">신고자</td>
							<td>신고날짜/시간</td>
							<td style="width:10%;"></td>
						</tr>
						<c:forEach var="reportedMember" items="${reportedMember}">
						<tr>
							<td>${reportedMember.rIdx}</td>
							<td><a class="miniprofile" onclick="profileOpen('${reportedMember.target}')">${reportedMember.targetname}</a></td>
							<td>${reportedMember.reportCount}</td>
							<td><a class="miniprofile" onclick="profileOpen('${reportedMember.reporter}')">${reportedMember.reportername}</a></td>
							<td>
								<fmt:formatDate value="${reportedMember.repDate}" pattern="yyyy/MM/dd HH:mm:ss"/>
							</td>
							<td>
								<button class="normal-button detail" 
								onclick="window.open('reportedDetail.do?rIdx=${reportedMember.rIdx}', 
								'_blank',
								'top=140, left=300, width=600, height=500, menubar=no,toolbar=no, location=no,directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');">
								관리
								</button>
							</td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			
			<div id="page-nav"><!-- 페이지 시작 -->					
				<c:if test="${PagingUtil.lastPage < 6}">
					<c:forEach var="i" begin="${PagingUtil.startPage}" end="${PagingUtil.endPage}">
						<c:choose>
							<c:when test="${i == PagingUtil.nowPage}">
								<div class="page-nav-button current-page">${i}</div>
							</c:when>
							<c:otherwise>
								<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${i}'">${i}</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
				<c:if test="${PagingUtil.lastPage > 5}">
					<c:if test="${PagingUtil.startPage > 5}">
						<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=1'">1</div>
						<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${PagingUtil.startPage - 1}'">◀</div>
					</c:if>
					
					<c:forEach var="i" begin="${PagingUtil.startPage}" end="${PagingUtil.endPage}">
						<c:choose>
							<c:when test="${i == 1}">
								<div class="page-nav-button current-page">${i}</div>
							</c:when>
							<c:otherwise>
								<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${i}'">${i}</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:if test="${PagingUtil.endPage < PagingUtil.lastPage}">
						<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${PagingUtil.endPage + 1}">▶</div>
						<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${PagingUtil.lastPage}">${PagingUtil.lastPage}</div>
					</c:if>
				</c:if>
			</div>
			</c:if>
			
			<c:if test="${reportedMember.size() == 0}">
			<div id="listsize0">신고글이 존재하지 않습니다.</div>
			</c:if>
			
		</div>
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>