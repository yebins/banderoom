<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<style>
.terms-list{
    padding-left: 5px;
}
.terms{
    padding: 6px;
    font-size: 14px;
    margin-right:5px;
}
#title{
	font-size: 25px;
    padding: 10px;
}
#writer{
    padding: 10px;
    position: relative;
}
#deadline{
	color: #303030;
    /* border: 1px solid #FB6544; */
    background: #FBE6B2;
    border-radius: 20px;
    padding: 6px;
    font-size: 13px;
    margin-left: 10px;
    box-shadow: 1px 1px 4px 0px rgb(0 0 0 / 20%);
}
#content{
	width:100%;
	height:500px;
	margin:30px 0px;
}
.inner-box{
	margin-bottom: 50px;
}
.normal-button{
	margin-right: 8px;
}
.date{
	position: absolute;
	right: 0px;
}
.midx:hover{
	cursor: pointer;
}
</style>

<script type="text/javascript">

	function deleteFn(){
		
		if(confirm('정말 삭제하시겠습니까?')){
			$.ajax({
			url:"delete.do",
			type:"post",
			data:"teamIdx="+$("#teamIdx").val(),
			success:function(data){
					if(data = "ok"){
						alert('삭제되었습니다.');
						location.replace('main.do');
					}else{
						alert('글 삭제가 완료되지 않았습니다.');
					}
				}
			});
		}
	}
	
	function loginAlert(){
		alert('로그인해주세요.');
		location.href = "/member/glogin.do";
	}
	
</script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			팀원 모집
		</div>
		<div id="page-content">
			<div class="inner-box" style="height:820px;">
				<input type="hidden" name="teamIdx" id="teamIdx" value="${details.teamIdx}">
				<div id="title">[${details.type}] ${details.title}</div>
				<div id="writer">
					<span class="midx" onclick="profileOpen(${details.mIdx})">${details.mNickname}</span>
					<span class="terms date"><b>작성일자</b> <fmt:formatDate value="${details.regDate}" pattern="yyyy년 MM월 dd일 HH시 mm분"/></span>
				</div>
				<hr style="margin-top: 0px; margin-bottom:25px;">
				
				<div class="terms-list">
					<span class='terms'><b>지역</b> ${details.addr1} ${details.addr2}</span>
					<span class='terms'><b>팀 레벨</b> ${details.teamLevel}</span>
					<span class='terms'><b>장르</b> ${details.genre}</span>
				</div>
				<div class="terms-list">
					<span class='terms'><b>파트/인원</b> 
						<c:forEach var="parts" items="${parts}" varStatus="lastPart">
						${parts.name} ${parts.capacity}명<c:if test="${!lastPart.last}">, </c:if>
						</c:forEach>
					</span>
					<span class='terms'><b>마감날짜</b> 
						<fmt:parseDate value="${details.endDate}" var="endDate" pattern="yyyy-MM-dd"/>
						<fmt:formatDate value="${endDate}" pattern="yyyy년 MM월 dd일"/>
					</span>
				</div>
				<div class="inner-box-content">
					<div id="content" class="form-control" style="width:100%; height:500px;">${details.content}</div>
				</div>
				<div class="inner-box-button-wrap">
					<c:if test="${details.mIdx == login.mIdx}">
						<button type="button" class="normal-button" onclick="location.href='update.do?teamIdx=${details.teamIdx}'">수정</button> 
						<button type="button" class="normal-button" onclick="deleteFn()">삭제</button>
					</c:if>
					<c:if test="${login == null}">
						<button type="button" class="normal-button accent-button" onclick="loginAlert()">지원하기</button>
					</c:if>
					<c:if test="${login != null}">
						<button type="button" class="normal-button accent-button" 
						onclick="window.open('application.do?teamIdx=${details.teamIdx}', '_blank', 
                       'top=140, left=300, width=600, height=600, menubar=no,toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');">지원하기</button> 
					</c:if>
				</div>
			</div>
		</div>
		
	</div>
	<c:import url="/footer.do" />
</body>
</html>