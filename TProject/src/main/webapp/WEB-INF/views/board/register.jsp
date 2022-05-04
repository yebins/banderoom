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
	.list-content{
		width:100%;
		height:370px;
	}
	.list-title{
		width:100%;
	}
	 .dropdown-toggle::after {
    display:none;
   }
   .select-board{
   	display:flex;
   	flex-direction: row-reverse;
   }
   .inner-box-select{
   		flex:0.15;
   }
   .form-control{
   		flex:1;
   }
   .inner-box-content, .inner-box-button-wrap{
   		margin-top:20px;
   }
</style>

<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<script>
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
	   $('#summernote').summernote('fontName', '맑은 고딕');

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
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			글쓰기
		</div>
		<form action="register.do" method="post">
			<input type="hidden" name="bIdx" value="${param.bIdx}"> 
			<input type="hidden" name="mIdx" value="${login.getmIdx()}">
			<input type="hidden" name="mNickname" value="${login.nickname}">
			<div id="page-content">
				<div class="inner-box" style="height:500px;">
					<div class="select-board">	
						<input type="text" name="title" class="list-title form-control me-3" placeholder="제목을 입력하세요">
					</div>
					<div class="inner-box-content">
						<form method="post">
							<textarea name="content" id="summernote" style="width: 100%;"></textarea>
						</form>
					</div>
					<div class="inner-box-button-wrap">
						<button class="normal-button accent-button" style="margin-left: 15px;">저장</button>
						<button class="normal-button" style="margin-left: 10px;">취소하기</button>
					</div>
				</div>
			</div>
		</form>
	</div>
	<c:import url="/footer.do" />
</body>
</html>