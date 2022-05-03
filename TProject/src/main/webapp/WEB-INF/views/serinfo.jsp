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
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
<style>
	div.inner-box {
		height:600px;
	}

	.sendInfo{
		display:flex;
			justify-content:flex-end;
		}
	
	.sendInfo button{
		margin-top:20px;
		margin-right:20px;
	}
	
	.note-frame {
		display:none;
	}
	
	.dropdown-toggle::after {
    display:none;
   }
   
   .note-statusbar{
		display:none;
	}
	
	.sendInfo button:nth-of-type(2){
		display:none;
	}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
		${vo.title}
		</div>
		<div id="page-content">
			<form action="infoupdate.do" method="post">
				<input type="hidden" name="idx" value="${vo.idx}">
				<div class="inner-box">
					<div class="inner-box-content">
						${vo.content}
					</div>
					<textarea id="summernote" name="content"></textarea>
				</div>
				<div class="sendInfo">
					<c:if test="${login.auth==3}">
						<button type="button" class="normal-button accent-button" onclick="modify(this)">수정하기</button>
						<button type="submit" class="normal-button accent-button">수정완료</button>
					</c:if>
				</div>
			</form>
		</div>		
	</div>
<script>

	function modify(obj){
		$(obj).css("display","none");
		$(obj).next().css("display","block");
		document.querySelector(".inner-box-content").style.display='none';
		
		$('.note-frame').css("display","block");
		$('.note-editable').html('${vo.content}');
		
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
		        }//callbacks end
		   });
		   $('#summernote').summernote('fontName', '맑은 고딕');
		})
		
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
<c:import url="/footer.do" />
</body>
</html>