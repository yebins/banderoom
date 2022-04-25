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
		font-size:15px;
		margin-left:30px;
		font-weight:normal;
	}
	.notice-page>input{
		border-radius:19px;
	}
	
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			공지사항
		</div>
		<div>
			<form class="d-flex notice-page">
       	 		<input class="form-control me-3" type="search" placeholder="Search" aria-label="Search">
        			<button class="accent-button">검색</button>
     		 </form>
		</div>
		<br>
		<div class="container">
			<div id="page-content">
				<div class="accordion accordion-flush" id="accordionFlushExample">
				  <div class="accordion-item">
				    <h2 class="accordion-header">
				      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" 
				      		data-bs-target="#d"
						 aria-expanded="false">
				      	<div class="accordion-button-category">공지사항/이벤트</div>
				      	<div class="accordion-button-title">이번 주 그라가스 버프입니다.</div>
				      </button>
				      <span></span>
				    </h2>
				    <div>${param.data}</div>
				    <div id="d" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
				      <div class="accordion-body">Placeholder content for this accordion, which is intended to demonstrate the <code>.accordion-flush</code> class. This is the first item's accordion body.</div>
				    </div>
				  </div>
				  </div>
			</div>
		</div>
		
	</div>
	
<script>

</script>
</body>
</html>