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
    background: #2A3F6A;
    margin-right:5px;
}
.parts{
	display:inline-block;
	margin: 7px 0px;
}
.x{
	font-size: 5px;
    height: 20px;
    width: 20px;
    border: 1px solid lightgray;
    border-radius: 10px;
	margin-right: 15px;
}
#datepicker{
	background:white;
}
</style>

<script>


	function selectType(obj){ //obj:분야
		var band = ["장르 선택", "락", "팝", "재즈"];
		var dance = ["장르 선택", "힙합", "브레이킹", "팝핑", "왁킹", "락킹", "K-POP"];
		var target = document.getElementById("genre");
	
		if(obj.value == "밴드") {
			var type = band;
			$("#write-genre").val("");
			$("#part").prop('disabled',false);
			$(".parts").remove();
			$("#result").html("1");
		}
		else if(obj.value == "댄스") {
			var type = dance;
			$("#write-genre").val("");
			$("#write-genre").prop('readonly',true);
			$("#part").prop('disabled',true);
			$("#write-part").prop('disabled',true);
			$("#write-part").val("");
			$(".parts").remove();
			$("#result").html("1");
		}
	
		target.options.length = 0;
	
		for (x in type) {
			var opt = document.createElement("option");
			opt.value = type[x];
			opt.innerHTML = type[x];
			target.appendChild(opt);
		}
		
		var opt = document.createElement("option");
		opt.value = "";
		opt.innerHTML = "직접 입력";
		target.appendChild(opt);
	
	}

	function selectGenre(obj){ //obj:장르
		var rock = ["보컬", "일렉 기타", "드럼", "베이스", "키보드", "직접 입력"];
		var pop = ["보컬", "일렉 기타", "드럼", "베이스", "키보드", "어쿠스틱 기타", "피아노", "신디사이저", "직접 입력"];
		var jazz = ["보컬", "어쿠스틱 기타", "드럼", "피아노", "베이스", "더블베이스", "콘트라베이스", "트럼펫", "색소폰", "직접 입력"];
		var target = document.getElementById("part");
		
		var genreVal = $("#genre").val();
		
		if($("#type").val() == "밴드"){
			if(obj.value != ""){ //직접 입력 x
				$("#write-genre").prop('readonly',true);
				$("#write-part").prop('disabled',true);
				$("#part").prop('disabled',false);
				
				if(obj.value == "락") {
					$("#write-genre").val(genreVal);
					var genre = rock;
				}else if(obj.value == "팝") {
					$("#write-genre").val(genreVal);
					var genre = pop;
				}else if(obj.value == "재즈") {
					$("#write-genre").val(genreVal);
					var genre = jazz;
				}
			}
			else if(obj.value == "") { //직접 입력
				$("#write-genre").val("");
				$("#write-genre").prop('readonly',false);
				$("#write-part").prop('disabled',false);
				$("#part").prop('disabled',true);
				
			}
			
		}else if($("#type").val() == "댄스"){
			
			if(obj.value == "") { //직접 입력
				$("#write-genre").val("");
				$("#write-genre").prop('readonly',false);
				$("#write-part").prop('disabled',true);
				$("#part").prop('disabled',true);
				$("#part").html("sdf");
				
			}else{
				$("#write-genre").val("");
				$("#write-genre").val(genreVal);
				$("#write-genre").prop('readonly',true);
				$("#write-part").prop('disabled',true);
				$("#part").html("sdf");
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
		}
		$("#result").text(result);
		
	}
	
	function addPart(){
		var type = $("#type").val();
		var part = $("#part").val();
		var people = $("#result").text();
		var writePart = $("#write-part").val();
		
		var div = $("<div class='parts'>");
		
		if(type == "밴드" && part != "장르를 선택하세요."){
			if((part == null || part == "직접 입력") && writePart == ""){
				alert("파트를 입력해주세요.");
			}else if((part == null || part == "직접 입력") && writePart != ""){
				var partExist = false;
				
				$("input[name=name]").each(function() {
					if ($(this).val().trim() == writePart.trim()) {
						partExist = true;
					}
				})
				
				if (partExist) {
					return;
				}
				
				$(".select-parts").append(div);
				$(div).append("<span class='select-part' name='part'>"+writePart+" "+people+"명</span>");
				$(div).append("<button type='button' class='x' onclick='remove(this)'>x</button>");
				$(div).append("<input type='hidden' name='name' value='"+writePart+"'>");
				$(div).append("<input type='hidden' name='capacity' value='"+people+"'>");
			}else{
				
				var partExist = false;
				
				$("input[name=name]").each(function() {
					if ($(this).val().trim() == part.trim()) {
						partExist = true;
					}
				})
				
				if (partExist) {
					return;
				}
				
				$(".select-parts").append(div);
				$(div).append("<span class='select-part' name='part'>"+part+" "+people+"명</span>");
				$(div).append("<button type='button' class='x' onclick='remove(this)'>x</button>");
				$(div).append("<input type='hidden' name='name' value='"+part+"'>");
				$(div).append("<input type='hidden' name='capacity' value='"+people+"'>");
			}
		}else if(type == "댄스"){
			$(".select-parts").empty();
			$(".select-parts").append(div);
			
			$(div).append("<span class='select-part' name='capacity'>"+people+"명</span>");
			$(div).append("<input type='hidden' name='capacity' value='"+people+"'>");
			
		}
		$("#write-part").val("");
		$("#result").text("1");
		
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
		   minDate: new Date(),
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
	
	$(function() {
		
		$.ajax({
			type: "get",
			url: "/space/getlocations.do",
			success: function(data) {
				locations = data;
				var addr1 = [];
				
				for (var i = 0; i < data.length ; i++) {
					addr1[i] = data[i].addr1;
				}
				
				addr1 = addr1.filter((v, i) => addr1.indexOf(v) === i);
				
				
				for (var i = 0; i < addr1.length ; i++) {
					var html = "<option>" + addr1[i] + "</option>"
					$("#addr1").append(html);
				}
				

				$("select[name=addr1]").val("${param.addr1}");
				
				if ($("select[name=addr1]").val() != '') {
					showAddr2();
				}
			}
		})
	})
	
	function showAddr2() {
		
		if ($("#addr1").val() == "") {
			$("#addr2").val("");
			return;
		}
		
		$("#addr2").children().each(function() {
			$(this).remove();
		});
	
		
		$("#addr2").append("<option value=''>지역 소분류</option>")	;
		
		for (var i = 0; i < locations.length; i++) {
			if (locations[i].addr1 == $("#addr1").val()) {
				var html = "<option>" + locations[i].addr2 + "</option>";
				$("#addr2").append(html);
			}
		}
	}
	
	
	
	
	function regFormCheck(){
		
		var addr1 = document.getElementById("addr1");
		var addr2 = document.getElementById("addr2");
		var teamLevel = document.getElementById("teamLevel");
		var type = document.getElementById("type");
		var genre = document.getElementById("genre");
		var writeGenre = document.getElementById("write-genre");
		var part = document.getElementsByClassName("select-part");
		var endDate = document.getElementById("datepicker");
		var title = document.getElementById("title");
		var content = document.getElementById("summernote");
		
		if(addr1.value == ""){
			alert("지역을 선택해주세요.");
			return false;
		}
		
		if(addr2.value == ""){
			alert("세부지역을 선택해주세요.");
			return false;
		}
		
		if(teamLevel.value == ""){
			alert("팀 레벨을 선택해주세요.");
			return false;
		}
		
		if(type.value == ""){
			alert("분야를 선택해주세요.");
			return false;
		}
		
		if(genre.value == "장르 선택"){
			alert("장르를 선택해주세요.");
			return false;
		}else if(genre.value == ""){
			if(writeGenre.value == ""){
				alert("장르를 직접 입력해주세요.");
				return false;
			}
		}
		
		if(part.value == undefined && part.length == 0){
			alert("파트 및 인원을 선택해주세요.");
			return false;
		}
		
		if(endDate.value == ""){
			alert("마감날짜를 선택해주세요.");
			return false;
		}
		
		if(title.value == ""){
			alert("제목을 입력해주세요.");
			return false;
		}
		
		if(content.value == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		if(confirm("글을 등록하시겠습니까? \n모집 조건은 수정하실 수 없습니다.")){
			document.regForm.submit();
		}
		
	}
	
</script>

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
			<form action="register.do" method="post" name="regForm">
			<input type="hidden" name="mIdx" value="${login.mIdx}">
			<input type="hidden" name="mNickname" value="${login.nickname}">
				<div class="form">
					<div class="search-top">
						<select class="form-select form-select-sm" name="addr1" id="addr1" onchange="showAddr2()">
							<option value="" selected hidden>지역</option>
						</select>
						<select class="form-select form-select-sm" name="addr2" id="addr2">
							<option value="" selected hidden>세부지역</option>
						</select>
						<select class="form-select form-select-sm" name="teamLevel" id="teamLevel">
							<option value="" selected hidden>팀 레벨</option>
							<option>초급</option>
							<option>중급</option>
							<option>고급</option>
						</select>
						<select class="form-select form-select-sm" name="type" id="type" onchange="selectType(this)">
							<option value="" selected hidden>분야 선택</option>
							<option>밴드</option>
							<option>댄스</option>
						</select>
						<select class="form-select form-select-sm" id="genre" onchange="selectGenre(this)">
							<option value="">분야를 선택하세요.</option>
						</select>
						<input class="form-control form-control-sm" id="write-genre" type="text" name="genre" placeholder="장르 입력" readonly>
					</div><br>
					
					<div class="mb-3 d-flex search-bottom">
						<select class="form-select form-select-sm part" id="part" onchange="selectPart(this)">
							<option value="">장르를 선택하세요.</option>
						</select>
						<input class="form-control form-control-sm" id="write-part" type="text" name="part" placeholder="파트 입력" disabled>
						<div class="btn-group people-num">
							<button type="button" class="btn btn-outline-secondary left-btn" onclick='count("minus")' disabled="disabled">-</button>
							<button type="button" class="btn btn-outline-secondary"><span id="result">1</span>명</button>
							<button type="button" class="btn btn-outline-secondary right-btn"onclick="count('plus')">+</button>
						</div>
						<button type="button" class="normal-button add-part" style="width:40px; margin-right:10px;" onclick="addPart()">추가</button>
						<input class="form-control form-control-sm" placeholder="마감 날짜 선택" name="endDate" id="datepicker" readonly>
					</div>
						<div class="select-parts">
					</div>
				</div>
			
			
				<div class="inner-box" style="height:700px;">
					<div>
						<input type="text" id="title" name="title" class="form-control list-title" placeholder="제목을 입력하세요.">
					</div>
					<div class="inner-box-content">
						<form method="post">
							<textarea name="content" class="form-control" id="summernote" style="width:100%;" maxlength="200"></textarea>
						</form>
					</div>
					<div class="inner-box-button-wrap">
						<button type="button" class="normal-button accent-button" style="margin-right: 8px;" onclick="regFormCheck()">등록하기</button> 
						<button type="button" class="normal-button" onclick="location.href='/teams/main.do'">취소하기</button>
					</div>
				</div>
			</form>
			
		</div>
		
	</div>
	<c:import url="/footer.do" />
</body>
</html>