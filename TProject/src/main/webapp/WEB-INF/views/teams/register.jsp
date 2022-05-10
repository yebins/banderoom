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

<link href="/css/air-datepicker/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<!-- Air datepicker css -->
<script src="/js/air-datepicker/datepicker.js"></script> <!-- Air datepicker js -->
<script src="/js/air-datepicker/datepicker.ko.js"></script> <!-- 달력 한글 추가를 위해 커스텀 -->

<script>


	function selectField(obj){ //obj:분야
		var band = ["장르 선택", "락", "팝", "재즈", "직접 입력"];
		var dance = ["장르 선택", "힙합", "브레이킹", "팝핑", "왁킹", "락킹", "K-POP", "직접 입력"];
		var target = document.getElementById("genre");
	
		if(obj.value == "band") {
			var field = band;
			$("#part").prop('disabled',false);
		}
		else if(obj.value == "dance") {
			var field = dance;
			$("#part").prop('disabled',true);
			$("#write-part").prop('disabled',true);
		}
	
		target.options.length = 0;
	
		for (x in field) {
			var opt = document.createElement("option");
			opt.value = field[x];
			opt.innerHTML = field[x];
			target.appendChild(opt);
		}	
	
	}

	function selectGenre(obj){ //obj:장르
		var rock = ["보컬", "일렉 기타", "드럼", "베이스", "키보드", "직접 입력"];
		var pop = ["보컬", "일렉 기타", "드럼", "베이스", "키보드", "어쿠스틱 기타", "피아노", "신디사이저", "직접 입력"];
		var jazz = ["보컬", "어쿠스틱 기타", "드럼", "피아노", "베이스", "더블베이스", "콘트라베이스", "트럼펫", "색소폰", "직접 입력"];
		var target = document.getElementById("part");
		
		if($("#field").val() == "band"){
			if(obj.value != "직접 입력"){
				$("#write-genre").prop('disabled',true);
				$("#write-part").prop('disabled',true);
				$("#part").prop('disabled',false);
				
				if(obj.value == "락") {
					var genre = rock;
				}else if(obj.value == "팝") {
					var genre = pop;
				}else if(obj.value == "재즈") {
					var genre = jazz;
				}
			}
			else if(obj.value == "직접 입력") {
				$("#write-genre").prop('disabled',false);
				$("#write-part").prop('disabled',false);
				$("#part").prop('disabled',true);
				
			}
			
		}else if($("#field").val() == "dance"){
			
			if(obj.value == "직접 입력") {
				$("#write-genre").prop('disabled',false);
				$("#write-part").prop('disabled',true);
				$("#part").prop('disabled',true);
				
			}else{
				$("#write-genre").prop('disabled',true);
				$("#write-part").prop('disabled',true);
			}
		}
		
		target.options.length = 0;
	
		for (x in genre) {
			var opt = document.createElement("option");
			opt.value = genre[x];
			opt.innerHTML = genre[x];
			target.appendChild(opt);
		}	

	}
	
	function selectPart(obj){ //obj:파트
		
		if(obj.value == "직접 입력"){
			$("#write-part").prop('disabled',false);
		}
		else if(obj.value != "직접 입력") {
			$("#write-part").prop('disabled',true);
			
		}
		
	}
	
	
	function count(type)  {
		var result = $("#result").text();
		if(type == 'plus'){
			$(".left-btn").attr("disabled", false);
			result = parseInt(result)+1;
		}else if(type == 'minus'){
			if(result == 1){
				$(".left-btn").attr("disabled", true);
			}else{
			$(".left-btn").attr("disabled", false);
			result = parseInt(result)-1;
			}
		}$("#result").text(result);
	}
	
	function addPart(){
		var field = $("#field").val();
		var part = $("#part").val();
		var people = $("#result").text();
		
		
		if(field == "band" && part != "장르를 선택하세요."){
			if(part == null || part == "직접 입력"){
				var div = $("<div class='parts'>");
				$(".select-parts").append(div);
				$(div).append("<span class='select-part' name='part'>"+$('#write-part').val()+" "+people+"명</span>");
				$(div).append("<button type='button' class='x' onclick='remove(this)'>x</button>");
				$(div).append("<input type='hidden' name='name' value='"+$('#write-part').val()+"'>");
				$(div).append("<input type='hidden' name='capacity' value='"+people+"'>");
			}else{
				var div = $("<div class='parts'>");
				$(".select-parts").append(div);
				$(div).append("<span class='select-part' name='part'>"+part+" "+people+"명</span>");
				$(div).append("<button type='button' class='x' onclick='remove(this)'>x</button>");
				$(div).append("<input type='hidden' name='name' value='"+part+"'>");
				$(div).append("<input type='hidden' name='capacity' value='"+people+"'>");
			}
		}else if(field == "dance"){
			$(".select-parts").empty();
			$(".select-parts").append("<span class='select-part' name='capacity'>"+people+"명</span>");
			$(".select-parts").append("<input type='hidden' name='capacity' value='"+people+"'>");
			
		}
		$("#write-part").val("");
		
	}
	
	function remove(obj){
		$(obj).parent().remove();
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
	   
	   $("#datepicker").datepicker({
			language: 'ko'
		}); 
	   
	});
	
	function uploadImage(file, el) {
	   var formData = new FormData();
	   formData.append("file", file);
	   $.ajax({
	      type: "post",
	      data: formData,
	      contentType: false,
	      processData: false,
	      url: "/uploadPicture.do",
	      success: function(data) {
	         $(el).summernote('editor.insertImage', data.trim());
	      }
	   })
	   
	}
	
	
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<style>
.form-select{
	margin-right:10px;
	width: 170px;
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
.form{
    width: 100%;
    text-align: center;
    margin: auto;
    margin-bottom:5px;
    padding: 30px 50px 14px;
    border-radius: 15px;
    background: white;
    box-shadow: 0px 5px 10px rgb(0 0 0 / 20%);
}
.search-top{
	display:flex;
}
.people-num{
	height:35px;
	margin-right:10px;
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
.add-part{
    font-size: 13px;
}
.inner-box{
	margin-bottom: 100px;
}
.inner-box-content{
	margin:10px 0px;
}
.list-content{
	width:100%;
	height:470px;
}
.list-title{
	width:100%;
}
.dropdown-toggle::after {
	display:none;
}
.select-parts{
	text-align: left;
	margin-bottom: 15px;
}
.select-part{
	border:1px solid #ced4da;
    border-radius: 17.5px;
    padding: 6px;
    font-size: 12px;
    background: #FBE6B2;
    margin-right:5px;
}
.parts{
	display:inline-block;
}
.x{
	font-size: 5px;
    height: 20px;
    width: 20px;
    border: 1px solid lightgray;
    border-radius: 10px;
	margin-right: 15px;
}
</style>
<title>팀원구하기 글등록</title>
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
			<form action="register.do" method="post">
			<input type="hidden" name="mIdx" value="${login.mIdx}">
			<input type="hidden" name="mNickname" value="${login.nickname}">
				<div class="form">
					<div class="search-top">
						<select class="form-select form-select-sm" name="addr1">
							<option>지역</option>
							<option>서울특별시</option>
							<option>전라북도</option>
						</select>
						<select class="form-select form-select-sm" name="addr2">
							<option>세부지역</option>
							<option>전주시 덕진구</option>
							<option>전주시 완산구</option>
							<option>군산시</option>
						</select>
						<select class="form-select form-select-sm" name="teamLevel">
							<option>팀 레벨</option>
							<option>초급</option>
							<option>중급</option>
							<option>고급</option>
						</select>
						<select class="form-select form-select-sm" name="type" id="field" onchange="selectField(this)">
							<option selected hidden>분야 선택</option>
							<option value="band">밴드</option>
							<option value="dance">댄스</option>
						</select>
						<select class="form-select form-select-sm" name="genre" id="genre" onchange="selectGenre(this)">
							<option>분야를 선택하세요.</option>
						</select>
						<input class="form-control form-control-sm" id="write-genre" type="text" name="genre" placeholder="장르 입력" disabled>
					</div><br>
					
					<div class="mb-3 d-flex search-bottom">
						<select class="form-select form-select-sm part" id="part" onchange="selectPart(this)">
							<option>장르를 선택하세요.</option>
						</select>
						<input class="form-control form-control-sm" id="write-part" type="text" name="part" placeholder="파트 입력" disabled>
						<div class="btn-group people-num">
							<button type="button" class="btn btn-outline-secondary left-btn" onclick='count("minus")' disabled="disabled">-</button>
							<button type="button" class="btn btn-outline-secondary"><span id="result">1</span>명</button>
							<button type="button" class="btn btn-outline-secondary right-btn"onclick="count('plus')">+</button>
						</div>
						<button type="button" class="normal-button add-part" style="width:40px; margin-right:10px;" onclick="addPart()">추가</button>
						<input class="form-control form-control-sm" placeholder="마감 날짜 선택" name="endDate" id="datepicker">
					</div>
						<div class="select-parts">
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
	<c:import url="/footer.do" />
</body>
</html>