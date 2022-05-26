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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/space/register.css">


<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<script src="/js/space/register.js"></script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			공간 등록하기
		</div>
		<div id="page-content">
		<form id="picture-upload-form">
			<input type="hidden" name="thumbWidth" value="200">
			<input type="hidden" name="thumbHeight" value="150">
			<input type="file" id="picture-upload" name="picture" style="display: none;" onchange="spacePictureUpload()">
		</form>
		<form action="register.do" method="post">
			<div class="inner-box" style="height: fit-content; padding: 50px 70px;">
				<div class="inner-box-content">
					<input type="hidden" name="hostIdx" value="${hlogin.getmIdx()}">
					<div class="inner-box-row row-title">
						분류와 이름
					</div>
					<div class="inner-box-row">
						<select class="form-select form-select-sm col" name="type">
							<option value="">분류</option>
							<option>녹음실</option>
							<option>밴드연습실</option>
							<option>댄스연습실</option>
						</select>
						<div style="width: 50px;"></div>
						<input type="text" class="form-input narrow" name="name" placeholder="공간 이름" required>
					</div>
					
					<div class="inner-box-row row-title">
						사진<span id="thumbnail-info">마지막에 업로드한 사진이 썸네일이 됩니다.</span>
					</div>
					<div class="inner-box-row row-pictures">
						<label class="picture-upload upload-button" for="picture-upload">
							사진 업로드
						</label>
					</div>
					<div class="inner-box-row row-title">
						주소
					</div>
					<div class="inner-box-row">
						<input type="hidden" name="addr1"><input type="hidden" name="addr2">
						<input type="text" class="form-input" name="address" placeholder="주소 검색" onclick="searchAddr()" readonly required>
					</div>
					<div class="inner-box-row">
						<input type="text" class="form-input" name="addressDetail" placeholder="상세 주소">
					</div>
					<div class="inner-box-row row-title">
						기본정보
					</div>
					<div class="inner-box-row">
						<textarea class="summernote" name="info"></textarea>
					</div>
					<div class="inner-box-row row-title">
						장비 / 편의시설
					</div>
					<div class="inner-box-row">
						<textarea class="summernote" name="facility"></textarea>
					</div>
					<div class="inner-box-row row-title">
						주의사항
					</div>
					<div class="inner-box-row">
						<textarea class="summernote" name="caution"></textarea>
					</div>
					<div class="inner-box-row row-title">
						수용인원과 가격
					</div>
					<div class="inner-box-row">
						<div class="form-inputnum">
							<div>총</div> <input type="number" class="form-input inputnum input-capacity" name="capacity" min="1" value="1"> <div>명</div>
						</div>
						<div class="form-inputnum input-cost">
							<input type="number" class="form-input inputnum input-cost" name="cost" min="0"> <div>원 / 시간</div>
						</div>
					</div>
				</div>
			</div>
		<div class="outter-buttons">
		
				<button type="button" class="normal-button" onclick="location.reload()">초기화</button>
				<button class="normal-button accent-button" style="margin-left: 20px;">등록</button>
		</div>
		
		</form>	
		</div>
		
		<!--  
			<br><br>
			분류, 공간 이름, 주소12, 기본정보, 시설, 주의사항, 수용인원, 시간당가격
			(숨김: 주소12, 호스트idx)
			
			 -->
		<!-- 여기까지 틀이고 밑에는 요소 공통사항 
		<div>
			위까지는 틀이고 밑에는 요소 공통사항
			<br><br><br>
			버튼 세로 크기 수정시 border-radius도 수정해야함<br>
			<br>
			<button class="normal-button">버튼</button> 
			일반 버튼 (button class="normal-button") (버튼이 여러개 줄줄이 배치될 시 하나만 강조 컬러 넣을것)<br><br>
			<button class="normal-button accent-button">버튼</button> 강조 버튼 (button class="normal-button accent-button")<br><br>
			<br><br><br>
			내부 박스 틀과 예시
			<div class="inner-box">
				<div class="inner-box-content">
				박스에 들어갈 내용
				</div>
				<div class="inner-box-button-wrap">
					<button class="normal-button">일반버튼</button>
					<button class="normal-button accent-button" style="margin-left: 15px;">강조버튼</button>
				</div>
			</div>
			<br><br>
		</div>
		<!-- 여기까지 -->
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>