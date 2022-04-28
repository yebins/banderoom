<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>

<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>

<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">

<script>
	function count(type)  {
		var result = $("#result").text();
		result = parseInt(result);
		if(type == 'plus'){
			result = result+1;
		}else if(type == 'minus'){
			if(result>1){
				result = result-1;
			}
		}console.log(result);
		$("#result").text(result);
	}
	
	$(function(){
		$('#summernote').summernote({
	         toolbar: [
	             // [groupName, [list of button]]
	             ['fontname', ['fontname']],
	             ['fontsize', ['fontsize']],
	             ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	             ['color', ['forecolor','color']],
	             ['para', ['ul', 'ol', 'paragraph']],
	             ['height', ['height']],
	             ['insert',['link','picture', 'video']],
	             ['view', ['help']]
	           ],
	         fontNames: ['맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
	         fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
	        height: 500,                 // 에디터 높이
	        minHeight: null,             // 최소 높이
	        maxHeight: null,             // 최대 높이
	        focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
	        lang: "ko-KR",               // 한글 설정
	        dialogsInBody: true,
	        maximumImageFileSize: 10 * 1024 * 1024,
	        callbacks: {
	           onImageUpload: function(files, editor, welEditable) {
	              var alerted = false;
	              for (var i = files.length - 1; i >= 0; i--) {
	                  if (files[i].size > 10 * 1024 * 1024) {
	                     if(!alerted) {
	                        alert('10MB 이하의 파일만 업로드 가능합니다.');
	                        alerted = true;
	                     }
	                     continue;
	                  }
	                 uploadImage(files[i], this);
	              }
	           }
	        }
	   });
	   $('#summernote').summernote('fontName', '맑은 고딕');

	});
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<style>
.form-select{
	margin-right:10px;
	width: 130px;
	height: 35px;
	border-radius:17.5px;
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
.search-bottom{
    justify-content: space-between;
}
.people-num{
	height:35px;
}
.people-num>button{
	background: #fff;
	border: 1px solid #ced4da;
}
.left-btn{
	border-top-left-radius: 17.5px;
    border-bottom-left-radius: 17.5px;
}
.right-btn{
	border-top-right-radius: 17.5px;
    border-bottom-right-radius: 17.5px;
}
.person{
	line-height: 35px;
}
.inner-box{
	margin-bottom: 100px;
}
.list-content{
	width:100%;
	height:470px;
}
.list-title{
	width:100%;
}
</style>
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			팀원 모집하기
		</div>
		<div id="page-content">
			<form action="#">
				<div class="team-option">
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
							<option>그 외</option>
						</select>
						<!--select class="form-select form-select-sm col"> 댄스
							<option>장르</option>
							<option>힙합</option>
							<option>팝핑</option>
							<option>락킹</option>
							<option>K-Pop</option>
							<option>그 외</option>
						</select -->
						<input class="form-control form-control-sm" type="text" value="모집 기간 선택">
					</div><br>
					
					<div class="mb-3 d-inline-flex search-bottom">
						<select class="form-select form-select-sm col part"><!-- 밴드-락 -->
							<option>파트</option>
							<option>보컬</option>
							<option>일렉기타</option>
							<option>드럼</option>
							<option>베이스</option>
							<option>키보드</option>
							<option>그 외</option>
						</select>
						<div class="person">인원</div>
						<div class="btn-group people-num">
							<button type="button" class="btn btn-outline-secondary left-btn" onclick='count("minus")'>-</button>
							<button type="button" class="btn btn-outline-secondary" id="result">1</button>
							<button type="button" class="btn btn-outline-secondary right-btn"onclick="count('plus')">+</button>
						</div>
					
					</div>
				</div>
				<div class="inner-box" style="height:700px;">
					<div>
						<input type="text" name="title" class="form-control list-title" placeholder="제목을 입력하세요.">
					</div>
					<div class="inner-box-content">
						<form method="post">
							<textarea name="content" class="form-control" id="summernote" style="width:100%;"></textarea>
						</form>
					</div>
					<div class="inner-box-button-wrap">
						<button type="submit" class="normal-button accent-button" style="margin-right: 8px;">등록하기</button> 
						<button type="button" class="normal-button" onclick="location.href='/teams/main.do'">취소하기</button>
					</div>
				</div>
			</form>
			
		</div>
		
	</div>
	
</body>
</html>