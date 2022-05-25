<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.3/moment.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">

<style>
	#page-content {
		max-width: 900px;
	}

	.big-title {
		font-size: 28px;
		font-weight: bold;
	}
	
	.reglist-box {
		margin-top: 5px;
		padding: 0px 15px !important;
	}
	
	.reglist-wrap {
		padding: 15px 0px;	
		display: flex;
		justify-content: space-between;
		align-items: center;
		border-bottom: 1px solid lightgray;
	}
	
	.reglist-name {
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 5px;
	}
	
	.reglist-info-items {
		display: inline-flex;
	}
	.small-title {
		font-size: 14px;
		font-weight: bold;
	}
	.small-content {
		font-size: 14px;
		margin-left: 5px;
	}
	
	#page-nav, #app-page-nav {
		border-top: 1px solid lightgray;
		width: 100%;
		height: 80px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.page-nav-button {
		width: 40px;
		height: 40px;
		border-radius: 20px;
		margin: 7.5px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.page-nav-button:not(.current-page) {
		cursor: pointer;
	}
	.page-nav-button.current-page {
		background-color: #fbe6b2;
		font-weight: bold;
	}
	
	.reglist-info-wrap {
		flex:1;
	}
	.reglist-button:not(.current-page) {
		cursor: pointer;
	}
	.reglist-button.current-page {
		font-weight: bold;
	}
	.applist-box {
		margin-top: 20px;
		padding:15px !important;
	}
	#appCount{
		color: #FB6544;
	}
	.content{
		border:1px solid lightgray;
		border-radius: 5px;
		padding:5px;
		margin:10px 0px;
	}
	.textarea{
	    border: none;
	    width: 100%;
	    height: 300px;
	    resize: none;
	}
	.endYN{
		background: white;
	    width: 150px;
	    padding: 5px;
	    border-radius: 30px;
	    box-shadow: 0px 0px 5px rgb(0 0 0 / 20%);
	    text-align: center;
	    margin-top: 20px;
	    font-size: 14px;
	}
	.del-btn{
		width: 70px;
	}
</style>

<script type="text/javascript">
	
	function finish(teamidx){
		if(confirm('마감하시겠습니까?')){
			$.ajax({
				url:"finish.do",
				type:"post",
				data:"teamIdx="+teamidx,
				success:function(data){
					if(data == 'ok'){
						alert('마감되었습니다.');
						location.replace('myteams.do');
					}else{
						alert('마감에 실패하였습니다.');
					}
				}
			});
		}	
	}
	
	function roadContent(appIdx){
		
		$("#update-form" + appIdx).css("display","block");
		$("#update-content" + appIdx).css("display","none");
		
		var ta = $(".textarea");
		ta.focus();
		
	}
	
	function updateApp(appIdx){
		
		var content = $("#textarea"+appIdx).val();
		
		if(content == ""){
			alert('지원서 내용을 입력해주세요.');
			return false;
		}
		
		if(confirm('수정하시겠습니까?')){
			$.ajax({
				url:"updateApp.do",
				type:"post",
				data:"content="+content+"&appIdx="+appIdx,
				success:function(data){
					if(data == 1){
						alert('수정이 완료되었습니다.');
						location.reload();
					}
				}
			})
		}
	}
	
	function cancel(appIdx){
		$("#update-form" + appIdx).css("display","none");
		$("#update-content" + appIdx).css("display","block");
	}
	
	function deleteApp(appIdx){
		if(confirm('지원서를 삭제하시겠습니까?')){
			$.ajax({
				url:"deleteApp.do",
				type:"post",
				data:"appIdx="+appIdx,
				success:function(data){
					if(data == 1){
						alert('삭제가 완료되었습니다.');
						location.reload();
					}
				}
			})
			
		}
	}
	
	function deletePost(teamIdx){
		if(confirm('정말 삭제하시겠습니까?')){
			$.ajax({
			url:"delete.do",
			type:"post",
			data:"teamIdx="+teamIdx,
			success:function(data){
					if(data = "ok"){
						alert('삭제되었습니다.');
						location.replace('myteams.do');
					}else{
						alert('글 삭제가 완료되지 않았습니다.');
					}
				}
			});
		}
	}
	
	$(function() {
		if("${param.endYN}" == 1){
			$("#endYN").prop('checked',true);
		} 
		
		$("#endYN").change(function(){
	        if($("#endYN").is(":checked")){
	        	document.endYNform.submit();
	        }else{
	        	document.endYNform.submit();
	        }
	    });
	});
	
	
	var endYN = "";
	
	if(${param.endYN != null}){
		endYN = "&endYN=${param.endYN}";
	}
	
	function reglistPaging(page){
		$.ajax({
			url:"reglistPaging.do",
			type:"get",
			data:"page="+page+endYN,
			success:function(data){
				var html = '';
				
				var reglist = data.reglist;
				
				for (i in reglist) {
					html += '<div class="reglist-wrap">';
					html += '<div class="reglist-info-wrap">';
					html += '<div class="reglist-name"><a id="teamIdx" href="details.do?teamIdx='+reglist[i].teamIdx+'">';
					
					if(reglist[i].status == 0){
						html += '[모집중] ';
					}else if(reglist[i].status == 2){
						html += '[마감] ';
					}
						
					html += reglist[i].title +'<span id="appCount"> ('+reglist[i].appCount+')</span></a></div>';
					html += '<div class="reglist-info"><div class="reglist-info-items">';
					html += '<div class="small-title">지역</div><div class="small-content">'+reglist[i].addr1+' '+reglist[i].addr2+'</div></div>&nbsp;&nbsp;';
					html += '<div class="reglist-info-items"><div class="small-title">팀 레벨</div><div class="small-content">'+reglist[i].teamLevel+'</div></div>&nbsp;&nbsp;';
					html += '<div class="reglist-info-items"><div class="small-title">분야</div><div class="small-content">'+reglist[i].type+'</div></div>&nbsp;&nbsp;';
					html += '<div class="reglist-info-items"><div class="small-title">장르</div><div class="small-content">'+reglist[i].genre+'</div></div></div>';
					html += '<div class="reglist-info"><div class="reglist-info-items"><div class="small-title">파트/인원</div><div class="small-content">';

					var partslist = data.partsMap[reglist[i].teamIdx];
					for(j in partslist){
						html += partslist[j].name+' '+partslist[j].capacity+'명';
						//i가 마지막일 때 빼고 , 붙이기
						if(j != partslist.length-1){
							html += ', '
						}
					}
					
					html += '</div></div>&nbsp;&nbsp;';
					html += '<div class="reglist-info-items"><div class="small-title">마감날짜</div>';
					html += '<div class="small-content">';
					
					var endDate = moment(reglist[i].endDate);
					html += moment(endDate).format("YYYY년 M월 D일");
					
					html += '</div></div></div></div><div class="reglist-buttons">';
					
					if(reglist[i].status == 0){
						html += '<button class="normal-button" onclick="finish('+reglist[i].teamIdx+')">마감하기</button>&nbsp;&nbsp;';
					}
					if(reglist[i].status == 2){
						html += '<button type="button" class="normal-button del-btn" onclick="deletePost('+reglist[i].teamIdx+')">삭제</button>&nbsp;&nbsp;';
					}
					if(reglist[i].appCount != 0){
						html += '<button class="normal-button accent-button" style="width:110px;" onclick="location.href=\'myapp.do?teamIdx='+reglist[i].teamIdx+'&mIdx='+reglist[i].mIdx+'\'">지원서 보기</button>';
					}
					
					html += '</div></div>';
				}
				
				$("#reglist").html(html);
				
				//페이지네비게이션
				
				var currPage = data.regPageUtil.nowPage;//현재페이지
				var startPage = data.regPageUtil.startPage;
				var endPage = data.regPageUtil.endPage;
				var lastPage = data.regPageUtil.lastPage;
				
				html = '';
				
				if(lastPage < 6){
					for(var i=startPage; i <= endPage; i++){
						if(i == currPage){
							html += '<div class="page-nav-button current-page">'+i+'</div>';
						}else{
							html += '<div class="page-nav-button" onclick="reglistPaging('+i+')">'+i+'</div>';
						}
					}
				}
				
				if(lastPage>5){
					if(startPage > 5){
						html += '<div class="page-nav-button" onclick="reglistPaging(1)">1</div>';
						html += '<div class="page-nav-button" onclick="reglistPaging('+(startPage-1)+')">◀</div>';
					}
					for(var i=startPage; i <= endPage; i++){
						if(i == currPage){
							html += '<div class="page-nav-button current-page">'+i+'</div>';
						}else{
							html += '<div class="page-nav-button" onclick="reglistPaging('+i+')">'+i+'</div>';
						}
					}
					
					if(endPage < lastPage){
						html += '<div class="page-nav-button" onclick="reglistPaging('+(endPage+1)+')">▶</div>';
						html += '<div class="page-nav-button" onclick="reglistPaging('+lastPage+')">'+lastPage+'</div>';
					}
				}
				
				$("#page-nav").html(html);
			}
		})
		
	}
	
	
	function applistPaging(page){
		$.ajax({
			url:"applistPaging.do",
			type:"get",
			data:"page="+page,
			success:function(data){

				html = '';
				
				var applist = data.applist;
				
				for (i in applist) {
					
					if(applist[i].status != 1){
						html += '<div class="inner-box applist-box"><div class="reglist-name">';
						html += '<a href="details.do?teamIdx='+applist[i].teamIdx+'">';
						if(applist[i].status == 0){
							html += ' [모집중] ';
						}else if(applist[i].status == 2){
							html += ' [마감] ';
						}
						html += applist[i].title+'</a></div>';
						
						html += '<div class="reglist-info-items d-flex justify-content-between" style="margin-top:10px;"><div>';
						
						if(applist[i].partname != ''){
							html += '<span class="small-title">지원한 파트</span>';
							html += '<span class="small-content">'+applist[i].partname+'</span>';
						}
						if(applist[i].partname == ''){
							html += '<span class="small-title">모집 인원</span>';
							html += '<span class="small-content">'+applist[i].partcapacity+'명</span>';
						}
						
						html += '</div><div><span class="small-title">작성일자</span><span class="small-content">';
						
						var regdate = moment(applist[i].regdate);
						html += moment(regdate).format("YYYY년 M월 D일 H시 m분");
						
						html += '</span></div></div>';
						
						html += '<div class="small-title" style="margin:10px 0px;">내용</div>';
						html += '<div id="update-content'+applist[i].appIdx+'">';
						html += '<div class="content"><pre id="pre-app'+applist[i].appIdx+'" style="font-family:\'맑은 고딕\';">'+applist[i].content+'</pre></div>';
						html += '<div class="inner-box-button-wrap">';
						
						if(applist[i].status == 0){
							html += '<button class="normal-button" onclick="roadContent('+applist[i].appIdx+')">수정</button>';
						}
						
						html += '<button class="normal-button" onclick="deleteApp('+applist[i].appIdx+')" style="margin-left: 15px;">삭제</button></div></div>';
						html += '<div id="update-form'+applist[i].appIdx+'" style="display: none;">';
						html += '<div class="content"><textarea class="textarea" id="textarea'+applist[i].appIdx+'" name="content">'+applist[i].content+'</textarea></div>';
						html += '<div class="inner-box-button-wrap">';
						html += '<button class="normal-button" onclick="updateApp('+applist[i].appIdx+')">수정하기</button>';
						html += '<button class="normal-button" onclick="cancel('+applist[i].appIdx+')" style="margin-left: 15px;">취소</button></div></div></div>';
						
					}
					
				}
				$("#applist").html(html);
				
				//페이지네비게이션
				
				var currPage = data.appPageUtil.nowPage;//현재페이지
				var startPage = data.appPageUtil.startPage;
				var endPage = data.appPageUtil.endPage;
				var lastPage = data.appPageUtil.lastPage;
				
				html = '';
				
				if(lastPage < 6){
					for(var i=startPage; i <= endPage; i++){
						if(i == currPage){
							html += '<div class="page-nav-button current-page">'+i+'</div>';
						}else{
							html += '<div class="page-nav-button" onclick="applistPaging('+i+')">'+i+'</div>';
						}
					}
				}
				
				if(lastPage>5){
					if(startPage > 5){
						html += '<div class="page-nav-button" onclick="applistPaging(1)">1</div>';
						html += '<div class="page-nav-button" onclick="applistPaging('+(startPage-1)+')">◀</div>';
					}
					for(var i=startPage; i <= endPage; i++){
						if(i == currPage){
							html += '<div class="page-nav-button current-page">'+i+'</div>';
						}else{
							html += '<div class="page-nav-button" onclick="applistPaging('+i+')">'+i+'</div>';
						}
					}
					
					if(endPage < lastPage){
						html += '<div class="page-nav-button" onclick="applistPaging('+(endPage+1)+')">▶</div>';
						html += '<div class="page-nav-button" onclick="applistPaging('+lastPage+')">'+lastPage+'</div>';
					}
				}
				
				$("#app-page-nav").html(html);
			}
		});
		
	}
	
</script>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			내 팀 목록
		</div>
		<div id="page-content">
		<div class="big-title">
			작성한 글 목록
		</div>
			<c:if test="${reglist.size() == 0}">
				<div class="inner-box" style="height:50px; margin-top:20px;">작성한 글이 없습니다.</div>
			</c:if>
			
			<c:if test="${reglist.size() > 0}">
			<form action="myteams.do" method="post" name="endYNform">
				<div class="endYN">
					<input type="checkbox" id="endYN" name="endYN" value="1"> 마감 글 제외하기
					
				</div>
			</form>
			<div class="inner-box reglist-box">
				<div id="reglist">
					<c:forEach var="reglists" items="${reglist}">
						<div class="reglist-wrap">
							<div class="reglist-info-wrap" >
								<div class="reglist-name"><a id="teamIdx" href="details.do?teamIdx=${reglists.teamIdx}">
								<c:if test="${reglists.status == 0}">[모집중]</c:if>
								<c:if test="${reglists.status == 2}">[마감]</c:if>
								${reglists.title} <span id="appCount">(${reglists.appCount})</span></a></div> 
								<div class="reglist-info">
									<div class="reglist-info-items">
										<div class="small-title">지역</div>
										<div class="small-content">${reglists.addr1} ${reglists.addr2}
										</div>
									</div>&nbsp;&nbsp;
									<div class="reglist-info-items">
										<div class="small-title">팀 레벨</div>
										<div class="small-content">${reglists.teamLevel}
										</div>
									</div>&nbsp;&nbsp;
									<div class="reglist-info-items">
										<div class="small-title">분야</div>
										<div class="small-content">${reglists.type}
										</div>
									</div>&nbsp;&nbsp;
									<div class="reglist-info-items">
										<div class="small-title">장르</div>
										<div class="small-content">${reglists.genre}
										</div>
									</div>
								</div>
								<div class="reglist-info">
									<div class="reglist-info-items">
										<div class="small-title">파트/인원</div>
										<div class="small-content">
											<c:forEach var="parts" items="${partsMap.get(reglists.teamIdx)}" varStatus="lastPart">
												${parts.name} ${parts.capacity}명<c:if test="${!lastPart.last}">, </c:if>
											</c:forEach>
										</div>
									</div>&nbsp;&nbsp;
									<div class="reglist-info-items">
										<div class="small-title">마감날짜</div>
										<div class="small-content">
											<fmt:parseDate value="${reglists.endDate}" var="endDate" pattern="yyyy-MM-dd"/>
											<fmt:formatDate value="${endDate}" pattern="yyyy년 M월 d일"/>
										</div>
									</div>
								</div>
							</div>
							<div class="reglist-buttons">
								<c:if test="${reglists.status == 0}">
									<button class="normal-button" onclick="finish(${reglists.teamIdx})">마감하기</button>&nbsp;
								</c:if>
								<c:if test="${reglists.status == 2}">
									<button type="button" class="normal-button del-btn" onclick="deletePost(${reglists.teamIdx})">삭제</button>&nbsp;
								</c:if>
								<c:if test="${reglists.appCount != 0}">
									<button class="normal-button accent-button" style="width:110px;" onclick="location.href='myapp.do?teamIdx=${reglists.teamIdx}&mIdx=${reglists.mIdx}'">지원서 보기</button>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>
				</c:if>
					<div id="page-nav"><!-- 페이지 시작 -->					
						<c:if test="${regPageUtil.lastPage < 6}">
							<c:forEach var="i" begin="${regPageUtil.startPage}" end="${regPageUtil.endPage}">
								<c:choose>
									<c:when test="${i == 1}">
										<div class="page-nav-button current-page">${i}</div>
									</c:when>
									<c:otherwise>
										<div class="page-nav-button" onclick="reglistPaging(${i})">${i}</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
						<c:if test="${regPageUtil.lastPage > 5}">
							<c:if test="${regPageUtil.startPage > 5}">
								<div class="page-nav-button" onclick="reglistPaging(1)">1</div>
								<div class="page-nav-button" onclick="reglistPaging(${regPageUtil.startPage - 1})">◀</div>
							</c:if>
							
							<c:forEach var="i" begin="${regPageUtil.startPage}" end="${regPageUtil.endPage}">
								<c:choose>
									<c:when test="${i == 1}">
										<div class="page-nav-button current-page">${i}</div>
									</c:when>
									<c:otherwise>
										<div class="page-nav-button" onclick="reglistPaging(${i})">${i}</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<c:if test="${regPageUtil.endPage < regPageUtil.lastPage}">
								<div class="page-nav-button" onclick="reglistPaging(${regPageUtil.endPage + 1})">▶</div>
								<div class="page-nav-button" onclick="reglistPaging(${regPageUtil.lastPage})">${regPageUtil.lastPage}</div>
							</c:if>
						</c:if>
					</div>
				</div>
				
			<div class="big-title" style="margin-top:100px;">
				작성한 지원서 목록
			</div>
			<div id="applist">
				<c:forEach var="applists" items="${applist}">
				<c:if test="${applists.status != 1}">
					<div class="inner-box applist-box">
						<div class="reglist-name"><a href="details.do?teamIdx=${applists.teamIdx}">
							<c:if test="${applists.status == 0}">[모집중]</c:if>
							<c:if test="${applists.status == 2}">[마감]</c:if>
							${applists.title}</a>
						</div>
						
						<div class="reglist-info-items d-flex justify-content-between" style="margin-top:10px;">
							<div>
								<c:if test="${applists.partname != ''}">
									<span class="small-title">지원한 파트</span>
									<span class="small-content">${applists.partname}</span>
								</c:if>
								<c:if test="${applists.partname == ''}">
									<span class="small-title">모집 인원</span>
									<span class="small-content">${applists.partcapacity}명</span>
								</c:if>
							</div>
							<div>
								<span class="small-title">작성일자</span>
								<span class="small-content">
									<fmt:formatDate value="${applists.regdate}" pattern="yyyy년 M월 d일 H시 m분"/>
								</span>
							</div>
						</div>
					
						<div class="small-title" style="margin:10px 0px;">내용</div>
						<div id="update-content${applists.appIdx}">
							<div class="content"><pre id="pre-app${applists.appIdx}" style="font-family:'맑은 고딕';">${applists.content}</pre></div>
							
							<div class="inner-box-button-wrap">
								<c:if test="${applists.status == 0}">
								<button class="normal-button" onclick="roadContent(${applists.appIdx})">수정</button>
								</c:if>
								<button class="normal-button" onclick="deleteApp(${applists.appIdx})" style="margin-left: 15px;">삭제</button>
							</div>
							
						</div>
						<div id="update-form${applists.appIdx}" style="display: none;">
							<div class="content"><textarea class="textarea" id='textarea${applists.appIdx}' name='content'>${applists.content}</textarea></div>
							<div class="inner-box-button-wrap">
								<button class="normal-button" onclick="updateApp(${applists.appIdx})">수정하기</button>
								<button class="normal-button" onclick="cancel(${applists.appIdx})" style="margin-left: 15px;">취소</button>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
			</div>
			<div id="app-page-nav"><!-- 페이지 시작 -->					
				<c:if test="${appPageUtil.lastPage < 6}">
					<c:forEach var="i" begin="${appPageUtil.startPage}" end="${appPageUtil.endPage}">
						<c:choose>
							<c:when test="${i == 1}">
								<div class="page-nav-button current-page">${i}</div>
							</c:when>
							<c:otherwise>
								<div class="page-nav-button" onclick="applistPaging(${i})">${i}</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
				<c:if test="${appPageUtil.lastPage > 5}">
					<c:if test="${appPageUtil.startPage > 5}">
						<div class="page-nav-button" onclick="applistPaging(1)">1</div>
						<div class="page-nav-button" onclick="applistPaging(${appPageUtil.startPage - 1})">◀</div>
					</c:if>
					
					<c:forEach var="i" begin="${appPageUtil.startPage}" end="${appPageUtil.endPage}">
						<c:choose>
							<c:when test="${i == 1}">
								<div class="page-nav-button current-page">${i}</div>
							</c:when>
							<c:otherwise>
								<div class="page-nav-button" onclick="applistPaging(${i})">${i}</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:if test="${appPageUtil.endPage < appPageUtil.lastPage}">
						<div class="page-nav-button" onclick="applistPaging(${appPageUtil.endPage + 1})">▶</div>
						<div class="page-nav-button" onclick="applistPaging(${appPageUtil.lastPage})">${appPageUtil.lastPage}</div>
					</c:if>
				</c:if>
			</div>
		</div>
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>