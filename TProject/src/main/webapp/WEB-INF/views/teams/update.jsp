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

<script src="<%=request.getContextPath() %>/js/summernote/summernote-lite.js"></script>
<script src="<%=request.getContextPath() %>/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/summernote/summernote-lite.css">

<link href="<%=request.getContextPath() %>/css/air-datepicker/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<!-- Air datepicker css -->
<script src="<%=request.getContextPath() %>/js/air-datepicker/datepicker.js"></script> <!-- Air datepicker js -->
<script src="<%=request.getContextPath() %>/js/air-datepicker/datepicker.ko.js"></script> <!-- 달력 한글 추가를 위해 커스텀 -->

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
	      url: "<%=request.getContextPath() %>/uploadPicture.do",
	      success: function(data) {
	         $(el).summernote('editor.insertImage', '<%=request.getContextPath() %>' + data.trim());
	      }
	   })
	   
	}
	
	

	
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<style>
.form{
    margin-bottom:10px;
    padding: 15px;
    border-radius: 15px;
    background: white;
    box-shadow: 0px 5px 10px rgb(0 0 0 / 20%);
}
.terms-list{
    padding-left: 5px;
}
.terms{
    padding: 6px;
    font-size: 14px;
    margin-right:5px;
}
.inner-box{
	margin-bottom: 100px;
}
.inner-box-content{
	margin:10px 0px;
}
.dropdown-toggle::after {
	display:none;
}
#datepicker{
	width: 150px;
    height: 30px;
    background: white;
    font-size: 14px;
}
</style>
<title>팀원 모집글 수정</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			팀원 모집글 수정
		</div>
		<div id="page-content">
			<form action="update.do" method="post" name="updateForm">
			<input type="hidden" name="mNickname" value="${login.nickname}">
			<input type="hidden" name="teamIdx" value="${details.teamIdx}">
				
				<div class="form" style="text-align: left;">
				
					<div class="terms-list" style="margin-bottom: 7px;">
						<span class='terms'><b>지역</b> ${details.addr1} ${details.addr2}</span>
						<span class='terms'><b>팀 레벨</b> ${details.teamLevel}</span>
						<span class='terms'><b>분야</b> ${details.type}</span>
						<span class='terms'><b>장르</b> ${details.genre}</span>
					</div>
					<div class="terms-list">
						<span class='terms'><b>파트/인원</b> 
							<c:forEach var="parts" items="${parts}" varStatus="lastPart">
							${parts.name} ${parts.capacity}명<c:if test="${!lastPart.last}">, </c:if>
							</c:forEach>
						</span>
					</div>
					<div class="terms-list">
						<span class='terms' style="display: flex;align-items: baseline;"><b>마감날짜</b> &nbsp;
							<input type="text" class="form-control" id="datepicker" name="endDate" readonly
							value='<fmt:parseDate value="${details.endDate}" var="endDate" pattern="yyyy-MM-dd"/><fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>'>
						</span>
					</div>
				</div>
			
				<div class="inner-box" style="height:700px;">
					<div>
						<input type="text" name="title" class="form-control list-title" value="${details.title}">
					</div>
					<div class="inner-box-content">
						<form method="post">
							<textarea name="content" class="form-control" id="summernote" style="width:100%;">${details.content}</textarea>
						</form>
					</div>
					<div class="inner-box-button-wrap">
						<button type="submit" class="normal-button accent-button" style="margin-right: 8px;">수정하기</button> 
						<button type="button" class="normal-button" onclick="location.href='<%=request.getContextPath() %>/teams/main.do'">취소하기</button>
					</div>
				</div>
			</form>
			
		</div>
		
	</div>
	<c:import url="/footer.do" />
</body>
</html>