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
<title>
	<c:choose>
		<c:when test="${param.bIdx == 1}">공지사항</c:when>
		<c:when test="${param.bIdx == 5}">자주 묻는 질문</c:when>
		<c:when test="${param.bIdx == 6}">이벤트</c:when>
	</c:choose>
</title>
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
	.
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
	
	.header-button:focus{
		background-color:white;
		box-shadow:none;
	}

	.header-button:not(.collapsed){
		background-color:white;
		border-bottom:1px solid #e0e0e0;
		box-shadow:none;
		border-left:3px solid #fb6544;
		border-top:3px solid #fb6544;
		border-right:3px solid #fb6544;
	}
	
	div#page-title{
		font-size:2rem;
	}
	
	h2 .accordion-header{
		background-color:#f6f6f6;
		border-radius:20px;
		box-shadow: 0px 5px 10px rgba(0,0,0,0.2);
	}
	input[type='search']{
		border-radius:25px;
	}
</style>
<script>
	function accordionClick(obj) {
		
		$(obj).css('border-top-left-radius','30px');
		$(obj).css('border-top-right-radius','30px');
		$(obj).parent().parent().css('background-color','transparent');
		$(obj).parent().next().children('div').css('background-color','white');
		$(obj).parent().next().children('div').css({"border-bottom-left-radius":"30px","border-bottom-right-radius":"30px"});
		$(obj).parent().next().children('div').css({"border-style":"solid","border-top":"none","border-color":"#fb6544"});
		$(obj).css({'border':'3px solid #fb6544','border-bottom':'1px solid lightgray'});
		
		obj.addEventListener('blur',(e)=>{
			$(obj).css("border-style","none");
			$(obj).parent().next().children('div').css({"border-bottom-left-radius":"0","border-bottom-right-radius":"0"});
			$(obj).parent().next().children('div').css({"border-style":"none","border-top":"none","border-color":"#fb6544"});
			
			var item=document.querySelectorAll('.accordion-item-serlist')
			
			for(let i=0; i<item.length; i++){
				if( i == 0){
					item[i].children[0].children[0].style.borderTopRadius='30px';
				} else if(i == (item.length-1)){
					item[i].children[0].children[0].style.borderBottomRadius='30px';
					item[i].children[0].children[0].style.borderTopLeftRadius='0';
					item[i].children[0].children[0].style.borderTopRightRadius='0';	
				} else {
					item[i].children[0].children[0].style.borderTopLeftRadius='0';
					item[i].children[0].children[0].style.borderTopRightRadius='0';	
				} 
			}
			
		})
	
	}
	
	
</script>
</head>

<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
		<c:if test="${bIdx==1}">
			<a href="/serlist.do?bIdx=1">공지사항</a>
		</c:if>
		<c:if test="${bIdx==5}">
			<a href="/serlist.do?bIdx=5">자주 묻는 질문</a>
		</c:if>
		<c:if test="${bIdx==6}">
			<a href="/serlist.do?bIdx=6">이벤트</a>
		</c:if>
		</div>
		<div>
			<form action="serlist.do" class="d-flex notice-page" method="get">
				<input type="hidden" name="bIdx" value="${bIdx}">
       	 		<input class="form-control me-3" name="searchtitle" type="search" placeholder="Search" aria-label="Search">
        			<button class="accent-button normal-button">검색</button>
     		 </form>
		</div>
		<br>
		<div class="container">
			<div id="page-content">
				<div class="accordion accordion-flush" id="accordionFlushExample">
				<c:forEach var="notice" items="${list}" varStatus="st">
					  <div class="accordion-item accordion-item-serlist">
					    <h2 class="accordion-header">
					      <button class="accordion-button header-button collapsed" type="button" data-bs-toggle="collapse" 
					      		data-bs-target="#a${notice.aIdx}"
							 aria-expanded="false" onclick="accordionClick(this)"
							 <c:if test="${st.first}">style="border-top-left-radius:30px; border-top-right-radius:30px;"</c:if>
							 >
					      	<div class="accordion-button-title">${notice.title}</div>
					      </button>
					    </h2>
					    <div id="a${notice.aIdx}" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
					      <div class="accordion-body body-button">
					      	<div>${notice.content}</div>
						    <div class="accordion-body-buttons">
						    	<c:if test="${login.auth == 3}">
							      <button class="accent-button normal-button body-buttons" onclick="location.href='serlistModify.do?aIdx=${notice.aIdx}&bIdx=${bIdx}'">수정</button>
							      <button class="accent-button normal-button body-buttons" onclick="remove('${notice.aIdx}','${notice.bIdx}')">삭제</button>
							    </c:if>					    
						    </div>
					      </div>
					    </div>
					  </div>
				 </c:forEach> 
				  </div>
				  <div class="content-write">
				  	<c:if test="${login.auth == 3}">
						<button class="normal-button accent-button"><a href="serinfoupdate.do">글쓰기</a></button>
				  	</c:if>	
				  </div>
			</div>
		</div>	
		
	</div>
	
<script>
	/* function st(obj){
    // window.scrollTo(x,y);
    var offset=$(obj).offset();
    var body=document.querySelector('html').offsetHeight;
    console.log(body-offset.top);
    console.log(body);
    window.scrollTo({top:body-offset.top, behavior:'smooth'});
    // behavior:smooth 부드럽게이동
} */
		
		let search=document.querySelector("input[type='search']");
		console.log(search);
		search.addEventListener("keyup",(e)=>{
			console.log(e.key);
			console.log(e.target.value);
				let inputValue=e.target.value;
			const items=document.querySelectorAll(".accordion-button-title");
			console.log(items);			
			items.forEach((el)=>{
				let str=el.innerText;
				console.log(str);
				if(str.includes(inputValue)){
					el.parentNode.parentNode.parentNode.style.display='block';
				} else {
					console.log(el.parentNode.parentNode.parentNode.style.display='none');
				}
			})
		})
		
		
		
		function remove(aIdx,bIdx){
			var data={
					'aIdx':aIdx,
					'bIdx':bIdx
					}
			if(confirm('삭제하시겠습니까?')){
				$.ajax({
					url:"serlistDelete.do",
					type:"post",
					data:data,
					success:function(result){
						if(result>0) {
							alert('삭제성공');
							location.href='serlist.do?bIdx='+bIdx;
						} else if(result = 0){
							alert('삭제실패');						
							location.href='serlist.do?bIdx='+bIdx;
						} else if(result = -1){
							alert('권한없음');
							location.href='serlist.do?bIdx='+bIdx;
						} else{
							alert('로그인하세요');
							location.href='/member/glogin.do?';
						} 
					}
					
				})
			}
		}
</script>
<c:import url="/footer.do" />
</body>
</html>