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
	.container {
		padding:0;
	}
	
	.accordion-button{
		height:75px;
		font-size:20px;
		font-weight:bold;
	}
	
	.accordion-button-title{
		font-size:20px;
		margin-left:30px;
		font-weight:normal;
	}
	.notice-page{
		width:600px;
		height:50px;
	}
	.notice-page>input{
		border-radius:25px;
	}
	
	#accordionFlushExample>div .accordion-button {
		background-color:#f6f6f6;
	}
	
	#accordionFlushExample>div:nth-child(2n) .accordion-button{
		background-color:white;
	}
	
	.accordion-body-buttons{
		display:flex;
		justify-content:flex-end;
	}
	.body-buttons{
		margin-left:10px;
	}
	[type="search"] + button{
		height:50px;
		border-radius:25px;
	}
	.content-write {
		display:flex;
		justify-content:flex-end;
		margin-top:50px;
		margin-bottom:100px;
	}
	
	.content-write a:visited{
		color:white;
	}
	
	
	.accordion-flush{
		border-radius:30px;
		overflow:hidden;
		box-shadow: 0px 5px 10px rgb(0 0 0 / 20%);
	}
	
	.accordion-button:focus{
		background-color:white;
		border-bottom:1px solid gray;
		box-shadow:none;
	}

	.accordion-button:not(.collapsed){
		background-color:white;
		border-bottom:1px solid #e0e0e0;
		box-shadow:none;
		border-left:3px solid #fb6544;
		border-top:3px solid #fb6544;
		border-right:3px solid #fb6544;
	}
	
	.accordion-body{
		border-bottom:3px solid #fb6544;
		border-left:3px solid #fb6544;
		border-right:3px solid #fb6544;
	}
</style>
<script>
	function accordionClick(obj) {
		if ($(obj).hasClass("collapsed")) {
			$(obj).parent().next().children(".accordion-body").css("border", "none");
			$(obj).parent().parent(".accordion-item").css("border-top-left-radius", "none");
			$(obj).parent().parent(".accordion-item").css("border-top-right-radius", "none");
			$(obj).css("border-top-left-radius","0px");
			$(obj).css("border-top-right-radius","0px");
		} else {
			$(obj).parent().next().children(".accordion-body").css("border-bottom", "3px solid #fb6544");
			$(obj).parent().next().children(".accordion-body").css("border-left", "3px solid #fb6544");
			$(obj).parent().next().children(".accordion-body").css("border-right", "3px solid #fb6544");
			$(obj).parent().next().children(".accordion-body").css("border-bottom-left-radius", "20px");
			$(obj).parent().next().children(".accordion-body").css("border-bottom-right-radius", "20px");
			$(obj).css("border-top-right-radius", "20px");
			$(obj).css("border-top-left-radius", "20px");
			$(obj).parent().css("border-top-left-radius","20px");
			$(obj).parent().css("border-top-right-radius","20px");
			$(obj).parent().next(".accordion-collapse").css("border-bottom-left-radius","20px");
			$(obj).parent().next(".accordion-collapse").css("border-bottom-right-radius","20px");
			$(obj).parent().parent(".accordion-item").css("border-bottom-left-radius","20px");
			$(obj).parent().parent(".accordion-item").css("border-bottom-right-radius","20px");
			$(obj).parent().parent(".accordion-item").css("border-top-left-radius","20px");
			$(obj).parent().parent(".accordion-item").css("border-top-right-radius","20px");
			$(obj).parent().parent().parent(".accordion-flush").css("overflow","visible");
		}
	}
	
</script>
</head>

<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
		<c:if test="${param.bidx==1}">
			<a href="/serlist.do?bidx=1">공지사항</a>
		</c:if>
		<c:if test="${param.bidx==5}">
			<a href="/serlist.do?bidx=5">자주묻는질문</a>
		</c:if>
		<c:if test="${param.bidx==6}">
			<a href="/serlist.do?bidx=6">이벤트</a>
		</c:if>
		</div>
		<div>
			<form action="serlist.do" class="d-flex notice-page" method="get">
				<input type="hidden" name="bidx" value="${param.bidx}">
       	 		<input class="form-control me-3" name="searchtitle" type="search" placeholder="Search" aria-label="Search">
        			<button class="accent-button normal-button">검색</button>
     		 </form>
		</div>
		<br>
		<div class="container">
			<div id="page-content">
				<div class="accordion accordion-flush" id="accordionFlushExample">
				<c:forEach var="notice" items="${list}" varStatus="st">
					
					  <div class="accordion-item" 
					  <%-- <c:if test="${st.first}">style='border-top-left-radius:30px; border-top-right-radius:30px;'</c:if>
					  <c:if test="${st.last}">style='border-bottom-left-radius:30px; border-bottom-right-radius:30px;'</c:if>					   --%>
					  >
					    <h2 class="accordion-header">
					      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
					      		data-bs-target="#a${notice.aIdx}"
							 aria-expanded="false" onclick="accordionClick(this)"
							 <c:if test="${st.first}">style='border-top-left-radius:30px; border-top-right-radius:30px;'</c:if>
							 >
					      	<div class="accordion-button-title">${notice.title}</div>
					      </button>
					    </h2>
					    <div id="a${notice.aIdx}" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
					      <div class="accordion-body">
					      	<div>${notice.content}</div>
						    <div class="accordion-body-buttons">
						    	<c:if test="${login.auth == 3}">
							      <button class="accent-button normal-button body-buttons">수정</button>
							      <button class="accent-button normal-button body-buttons">삭제</button>
							    </c:if>					    
						    </div>
					      </div>
					    </div>
					  </div>
				 </c:forEach> 
				  </div>
				  <div class="content-write">
					<button class="normal-button accent-button"><a href="serinfoupdate.do">글쓰기</a></button>
				  </div>
			</div>
		</div>	
		
	</div>
	
<script>

</script>
</body>
</html>