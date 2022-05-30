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
<title>쪽지보내기</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>

	#messageContent{
		width:100%;
		height:300px;
		padding:20px;
	}
	
	 textarea {
	width:100%;
    height:100%;
    resize: none;
    border-radius:10px;
  }
  #receiver{
  	padding:10px;
  	border-bottom:1px solid lightgray;
  }
  
  #messageBox{
  	width:100%;
  }
  #messageButton{
  	display:flex;
  	justify-content:flex-end;
  	align-items:center;
  }
  #messageButton button{
  	margin-right:20px;
  }
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<div id="messageBox">
		<div id="receiver">
			<span style="font-weight:bold;">받는사람</span>
			<c:choose>
			<c:when test="${vo.mIdx == login.mIdx}">
			<span>나</span>
			</c:when>
			<c:otherwise>
			<span>${vo.nickname}</span>
			</c:otherwise>
			</c:choose>
		</div>
		<div id="messageContent">
			<textarea></textarea>
		</div>
		<div id="messageButton">
			<button class="normal-button" onclick="sendMessage('${vo.mIdx}','${type}')">전송</button>
			<button class="normal-button" onclick="window.close()">닫기</button>
		</div>
	</div>
<script>
	function sendMessage(mIdx,type){
		var msg=document.querySelector("textarea").value;
		console.log(type);
		data={
			"content":msg,
			"receiver":mIdx,
			"receiverType":type
		};
		
		console.log(msg);
		console.log(mIdx);
		
		$.ajax({
			url:"messageSend.do",
			type:"post",
			data:data,
			success:function(result){
				console.log(result);
				if(result>0){
					alert('메시지보내기에 성공했습니다.');
					window.close();
				} else if(result==0){					
					alert('메시지보내기에 실패했습니다.');
				} else {
					alert('로그인하세요');
					window.close();
				}
			}
		});
	}
</script>
</body>
</html>