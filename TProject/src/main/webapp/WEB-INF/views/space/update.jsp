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
<title>공간 수정하기</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/space/update.css">


<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<script>

var uploadCount = 0;

$(function(){
	
	 
	 // 기존 내용 넣어주기
	 $("input[name=idx]").val("${spacesVO.getIdx()}");
	 $("select[name=type]").val("${spacesVO.getType()}");
	 $("input[name=name]").val("${spacesVO.getName()}");
	 $("input[name=address]").val("${spacesVO.getAddress()}");
	 $("input[name=addressDetail]").val("${spacesVO.getAddressDetail()}");
	 $("input[name=addr1]").val("${spacesVO.getAddr1()}");
	 $("input[name=addr2]").val("${spacesVO.getAddr2()}");	 
	 $("textarea[name=info]").summernote('code', '${spacesVO.getInfo()}');
	 $("textarea[name=facility]").summernote('code', '${spacesVO.getFacility()}');
	 $("textarea[name=caution]").summernote('code', '${spacesVO.getCaution()}');
	 $("input[name=capacity]").val("${spacesVO.getCapacity()}");
	 $("input[name=cost]").val("${spacesVO.getCost()}");
	 
	 // 기존 사진 넣어주기
		<c:if test="${spacePicturesVOs.size() != 0}">
			<c:forEach var="i" begin="0" end="${spacePicturesVOs.size() - 1}">
				
				var html = "";
				html += "<div class='picture-upload uploaded'>";
				html += "<img src='${spacePicturesVOs[i].getThumbSrc()}' width='100%'>";
				html += "<input type='hidden' name='src' value='${spacePicturesVOs[i].getSrc()}'>";
				html += "<input type='hidden' name='thumbSrc' value='${spacePicturesVOs[i].getThumbSrc()}'>";
				html += "</div>"
				$('.row-pictures').prepend(html);
				uploadCount++;
				
			</c:forEach>
			

			if (uploadCount == 4) {
				$('.upload-button').css('display', 'none');
				$('.uploaded').eq(3).css('margin', '0px');
			}
			
		</c:if>
	
	$('.summernote').each(function() {
		
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
			공간 수정하기
		</div>
		<div id="page-content">
		<form id="picture-upload-form">
			<input type="hidden" name="thumbWidth" value="200">
			<input type="hidden" name="thumbHeight" value="150">
			<input type="file" id="picture-upload" name="picture" style="display: none;" onchange="spacePictureUpload()">
		</form>
		<form action="update.do" method="post">
			<input type="hidden" name="idx">
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
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>