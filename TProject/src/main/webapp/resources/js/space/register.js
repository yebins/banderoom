

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