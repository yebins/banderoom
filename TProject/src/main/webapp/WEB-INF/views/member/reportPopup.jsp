<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>신고하기</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
#reportContent{
	width:100%;
	height:300px;
	padding:20px;
}
textarea {
	width:100%;
	height:100%;
	resize: none;
	border-radius:10px;
	padding:7px;
}
#receiver{
	padding:10px;
	border-bottom:1px solid lightgray;
}
 
#reportBox{
	width:100%;
}
#reportButton{
	display:flex;
	justify-content:flex-end;
	align-items:center;
}
#reportButton button{
	margin-right:20px;
}
</style>
<script>
	function report(mIdx){
		var msg = document.querySelector("textarea").value;
		var targetname = $("#targetname").text();

		data = {
			"content" : msg,
			"target" : mIdx,
			"targetname" : targetname
		};
		
		$.ajax({
			url:"sendReport.do",
			type:"post",
			data:data,
			success:function(data){
				if(data > 0){
					alert('신고를 완료했습니다.');
					window.close();
				} else if(data == -1){					
					alert('본인을 신고할 수 없습니다.');
					window.close();
				} else if(data == -2){
					alert('내용을 입력해주세요.');
				} else if(data == 0){
					alert('로그인하세요.');
					window.close();
				}
			}
		});
	}
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<div id="reportBox">
		<div id="receiver">
			<span style="font-weight:bold; color:#F3F3F3;">신고할 회원</span>
			<span style="color:#F3F3F3;" id="targetname">${vo.nickname}</span>
		</div>
		<div id="reportContent">
			<textarea placeholder="url을 입력해주시면 빠른 처리에 도움이 됩니다."></textarea>
		</div>
		<div id="reportButton">
			<button class="normal-button accent-button" onclick="report('${vo.mIdx}')">신고하기</button>
			<button class="normal-button" onclick="window.close()">닫기</button>
		</div>
	</div>

</body>
</html>