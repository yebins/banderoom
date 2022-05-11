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
 
	.form-select {
    margin-right: 10px;
    width: 130px;
    height: 50px;
    border-radius: 25px;
    padding: 0px 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
	}
	
	.inner-box select:focus {
		outline: none;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		border: 1px solid #ced4da;
		}
	.inner-box select:active {
		filter: brightness(90%);
		}
	
	.inner-box-row {
		width: 100%;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.form-input {
		width: 100%;
		height: 50px;
		border: 1px solid lightgray;
		border-radius: 25px;
		padding: 0px 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
	}
	
	.form-input.narrow {
		width: 650px;
	}
	
	.row-title {
		margin: 10px;
		font-size: 14px;
		font-weight: bold;
	}
	.row-title:not(.row-title:first-child) {
		margin-top: 40px;
	}
	
	.inner-box-row:not(.inner-box-row:last-child) {
		margin-bottom: 20px;
	}
	
	.form-inputnum {
		width: 50%;
		display: flex;
		align-items: center;
		padding: 0px 40px;
	}
	.form-inputnum:last-child {
		justify-content: flex-end;
	}
	.form-inputnum div {
		font-size: 18px;
	}
	
	.inputnum {
		width: 60%;
		margin: 0px 10px;
		font-size: 18px;
	}
	.input-capacity {
		text-align: center;
	}
	.input-cost {
		text-align: right;
	}
	input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
		{
		-webkit-appearance: none;
		margin: 0;
	}
	.outter-buttons {
		width: 100%;
		margin: 50px 0px;
		display: flex;
		justify-content: flex-end;	
	}
	
	.row-pictures {
		justify-content: flex-start;
	}
	.picture-upload {
		min-width: 200px;
		width: 200px;
		height: 150px;
		background: white;
		border-radius: 10px;
		box-shadow: 0px 5px 10px rgba(0,0,0,0.2);
		display: flex;
		justify-content: center;
		align-items: center;
		margin-right: 20px;
		overflow: hidden;
	}
	.upload-button {
		border: 3px solid #fb6544;
	}
	.picture-upload:last-child {
		margin-right: 0px;
	}
	.picture-upload:hover {
		cursor: pointer;
	}
	.picture-upload:active {
		filter: brightness(90%);
	}
	.dropdown-toggle::after {
    display:none;
	}
	.note-editor.note-frame, .note-editor.note-airframe {
    width: 100%;
	}
	#thumbnail-info {
		margin-left: 50px;
		color: #fb6544;
		font-weight: normal;
	}
</style>


<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<script>

var notecount = 0;
var uploadCount = 0;

$(function(){
	$('.summernote').each(function() {
		notecount++;
		
		$(this).summernote({
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
	        height: 300,                 // 에디터 높이
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
		
		if (notecount != 1) {
		 $(this).summernote('code', '<ol><li><span style="font-family: &quot;맑은 고딕&quot;;">﻿</span><br></li></ol>');			
		 $(this).summernote('height', '3.0');
		}
		 $(this).summernote('fontName', '맑은 고딕');
	})

	window.scrollTo({top: 0});
	
	$(document).on("click", ".uploaded", function() {
		$(this).remove();
		if (uploadCount == 4) {
			$('.uploaded').css('margin-right', '20px');
			$('.upload-button').css('display', 'flex');
		}
		uploadCount--;
	})
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

function searchAddr() {
	new daum.Postcode({
		oncomplete : function(data) {
			$('input[name=address]').val(
					data.address + " ("
							+ data.bname + ")");
			$('input[name=addressDetail]').val(
					data.buildingName);
			$('input[name=addr1]').val(data.sido);
			$('input[name=addr2]').val(data.sigungu);
		}
	}).open();
}

function spacePictureUpload() {

	var formData = new FormData($('#picture-upload-form')[0]);
	
	$.ajax({
		url: "uploadPicture.do",
		type: "post",
		data: formData,
		contentType: false,
		processData: false,
		success: function(data) {
			
			var html = "";
			html += "<div class='picture-upload uploaded'>";
			html += "<img src='" + data.thumb + "' width='100%'>";
			html += "<input type='hidden' name='src' value='" + data.original + "'>";
			html += "<input type='hidden' name='thumbSrc' value='" + data.thumb + "'>";
			html += "</div>"
			$('.row-pictures').prepend(html);
			uploadCount++;
			
			if (uploadCount == 4) {
				$('.upload-button').css('display', 'none');
				$('.uploaded').eq(3).css('margin', '0px');
			}
		}
	});
}

</script>
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