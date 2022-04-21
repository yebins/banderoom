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
}
.team-list{
	width:280px;
	border-radius:25px;
	overflow:hidden;
	box-shadow: 0px 5px 10px rgb(0 0 0 / 20%);
}
.team-title{
	width:280px;
	height:50px;
	background:#FB6544;
}
.team-content{
	width:280px;
	height:200px;
	background:#FBE6B2;
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
							<button type="submit" class="accent-button">검색하기</button>
						</div>
					</div>
				</div>
			</form>
			<div class="teams">
				<div class="team-list">
					<div class="team-title">
					제목
					</div>
					<div class="team-content">
					내용
					</div>
				</div>
			</div>
		</div>
		
		<!-- 여기까지 틀이고 밑에는 요소 공통사항 -->
		<div>
			위까지는 틀이고 밑에는 요소 공통사항
			<br><br><br>
			버튼 세로 크기 수정시 border-radius도 수정해야함<br>
			<br>
			<button>버튼</button> 
			일반 버튼 (버튼이 여러개 줄줄이 배치될 시 하나만 강조 컬러 넣을것)<br><br>
			<button class="accent-button">버튼</button> 강조 버튼 (button class="accent-button")<br><br>
			<br><br><br>
			내부 박스 틀과 예시
			<div class="inner-box">
				<div class="inner-box-content">
				박스에 들어갈 내용
				</div>
				<div class="inner-box-button-wrap">
					<button>일반버튼</button>
					<button class="accent-button" style="margin-left: 15px;">강조버튼</button>
				</div>
			</div>
			<br><br>
		</div>
		<!-- 여기까지 -->
		
	</div>
	
</body>
</html>