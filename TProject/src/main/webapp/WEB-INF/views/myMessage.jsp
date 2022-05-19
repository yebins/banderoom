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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
	.message-nav{
		width:220px;
		height:900px;
		border-right:2px solid lightgray;
		background:linear-gradient(to bottom,#fff 0,#f4f4f4 100%);
	}
	.inner-box{
		overflow:hidden;
		border:2px solid lightgray;
	}
	.inner-box-content{
		display:flex;
	}
	#message-nav-write{
		height:100px;
		display:flex;
		justify-content:center;
		align-items:center;
		border-bottom:2px solid lightgray;
		background:inherit;
	}
	#message-nav-write a{
		border-radius:25px;
		padding:10px;
		background-color:#fb6544;
		width:80%;
		text-align:center;
	}
	
	#message-nav-menu-list{
	}
	
	ul{
		list-style: none;
		padding-top:10px;
	}
	
	li{
		padding:10px;
	}
	
	#message-content-list{
	
		width:770px;
	}
	#message-content-list-header{
		height:100px;
		border-bottom:2px solid lightgray;
		background:linear-gradient(to bottom,#fff 0,#f4f4f4 100%);
	}
	#message-content-list-content-top li{
		float:left;
		font-weight:bold;
		border-right:2px solid lightgray;
		height:100%;
	}
	#message-content-list-content-top ul{
		background:linear-gradient(to bottom,#fff 0,#f4f4f4 100%);
		padding:0;
		height:50px;
		margin:0;
	}
	#message-content-list-content-center ul{
		padding:0;
		height:50px;
		margin:0;
	}
	#message-content-list-content-center li{
		float:left;
		border-right:2px solid lightgray;
		border-bottom:2px solid lightgray;
		height:100%;
	}
	#message-content-list-content-center{
		height:700px;
	}
	#message-content-list-content-center li a{
		font-size:13px;
	}	
	#message-content-list-content-footer{
		display:flex;
		justify-content:center;
		align-items:center;
		height:50px;
		border-top:2px solid lightgray;
		background:linear-gradient(to bottom,#fff 0,#f4f4f4 100%);
	}
	#message-content-list-content-top ul{
		border-bottom:2px solid lightgray;
	}
	#message-content-list-content-footer a{
		border:1px solid lightgray;
		border-radius:5px;
		text-align:center;
		padding:5px;
		margin:3px;
	}
	#message-content-top-check{
		display:flex;
		justify-content:center;
		align-items:center;
		width:5%;
	}
	.message-content-center-check{
		display:flex;
		justify-content:center;
		align-items:center;
		width:5%;
	}
	.message-content-list-content-ul a:visited{
		color:lightgray;
	}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			쪽지함
		</div>
		<div id="page-content">
			<div class="inner-box" style="padding:0">
				<div class="inner-box-content">
					<div class="message-nav">
						<div id="message-nav-write">
							<a href=""><span style="color:white;">내게쓰기</span></a>
						</div>
						<div id="message-nav-menu-list">
							<ul>
								<li>
									<a href="">받은쪽지함 
										<b>${receiveCount}</b>
									</a>
								</li>
								<li>
									<a href="">내게쓴쪽지함 
										<b>10</b>
									</a>
								</li>
								<li>
									<a href="">보낸쪽지함 
										<b>#{sendCount}</b>
									</a>
								</li>
							</ul>
						</div>
					</div>
					<div id="message-content-list">
						<div id="message-content-list-header">
							뭔가있는공간
						</div>
						<div id="message-content-list-content-top">
							<ul>
								<li id="message-content-top-check">
									<input type="checkbox">
								</li>
								<li style="width:15%;">
									<span>보낸사람</span>
								</li>
								<li style="width:65%;">
									내용
								</li>
								<li style="border-right:none;">
									날짜
								</li>
							</ul>
						</div>
						<div id="message-content-list-content-center">
							<ul class="message-content-list-content-ul">
								<%-- <c:choose> 
									<c:when test="${list.size > 0}">
										<c:forEach var="item" begin="0" end="13">
										<li class="message-content-center-check">
											<input type="checkbox">
										</li>
										<li style="width:15%;">
											<a href="">에이에이에이</a>
										</li>
										<li style="width:65%;">
											<a href="">안녕하세요 ?? 반갑습니다</a>
										</li>
										<li style="width:15%;border-right:none;padding-right:0;">
											<a>22-02-22 [22:22]</a>
										</li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										글이엄습니다
									</c:otherwise>
								</c:choose> --%>
								<c:forEach var="item" begin="0" end="13">
										<li class="message-content-center-check">
											<input type="checkbox">
										</li>
										<li style="width:15%;">
											<a href="">에이에이에이</a>
										</li>
										<li style="width:65%;">
											<a href="">안녕하세요 ?? 반갑습니다</a>
										</li>
										<li style="width:15%;border-right:none;padding-right:0;">
											<a>22-02-22 [22:22]</a>
										</li>
								</c:forEach>
							</ul>
						</div>
						<div id="message-content-list-content-footer" 
							<c:if test="${list.length>13}">
								style='border-top:none;'
							</c:if>
						>
							<a href=""><<</a>
							<a href=""><</a>
							<a href="">1</a>
							<a href="">2</a>
							<a href="">3</a>
							<a href="">4</a>
							<a href="">5</a>
							<a href="">6</a>
							<a href="">7</a>
							<a href="">8</a>
							<a href="">9</a>
							<a href="">10</a>
							<a href="">>></a>
							<a href="">></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>