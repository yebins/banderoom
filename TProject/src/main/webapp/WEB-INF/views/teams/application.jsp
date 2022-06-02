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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>지원하기</title>
<style>
#title {
    width: 100%;
    font-weight: bold;
    font-size: 25px;
    margin: 20px 0px;
}
#app-part{
	font-size: 18px;
	font-weight: bold;
}
#wrapper{
	padding-top: 0px!important;	
	height: 700px;
}
textarea{
    resize: none;
}
.form-check{
	font-size:14px;
}
</style>
<script>
	function apply(){
		
		var part = document.querySelector('input[name="partIdx"]:checked');
		var content = document.getElementById("content");
		
		if(!document.getElementById('partIdx')){
			if(part == null){
				alert("파트를 선택해주세요.");
				return false;
			}
		}
		
		if(content.value == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		if(confirm('지원서를 작성하시겠습니까? \n지원 파트는 수정하실 수 없습니다.')){
			$.ajax({
				url:"application.do",
				type:"post",
				data:$("#application").serialize(),
				success:function(data){
					if(data == 1){
						alert('지원서 작성이 완료되었습니다.');
						window.close();
					}else{
						alert('지원서 작성이 완료되지 않았습니다.');
					}
				}
			})
		}
	}
	
</script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<form id="application">
	<input type="hidden" name="teamIdx" value="${details.teamIdx}">
	<input type="hidden" name="mIdx" value="${login.mIdx}">
	<input type="hidden" name="mNickname" value="${login.nickname}">
	<div id="wrapper" style="width:580px;">
		<div id="title">
			지원하기
		</div>
		<div id="page-content">
			<c:if test="${details.type == '밴드'}">
				<div class="inner-box" style="margin-bottom: 10px;">
					<div class="inner-box-content">
						<div class="app-title"><b>지원 파트</b></div><br>
						<c:forEach var="parts" items="${parts}">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="partIdx" id="part" value="${parts.partIdx}">${parts.name}
							</div>
						</c:forEach>
					</div>
				</div>
			</c:if>
			<c:if test="${details.type == '댄스'}">
				<c:forEach var="parts" items="${parts}">
					<input type="hidden" name="partIdx" id="partIdx" value="${parts.partIdx}">
				</c:forEach>
			</c:if>
			<div class="inner-box" style="height: 410px; margin-bottom: 20px;">
				<div class="app-title"><b>지원 내용</b></div><br>
				<textarea class="form-control" id="content" rows="13" cols="77" name="content"></textarea>
			</div>
			<div class="inner-box-button-wrap">
				<button type="button" class="normal-button accent-button" style="margin-bottom: 15px;" onclick="apply()">지원하기</button>
			</div>
		</div>
	</div>
</form>
</body>
</html>