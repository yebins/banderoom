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
	#page-content {
		max-width: 900px;
	}

	.big-title {
		font-size: 28px;
		font-weight: bold;
	}
	
	.reglist-box {
		margin-top: 20px;
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
	#page-nav {
		width: 100%;
		height: 50px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.reglist-button {
	
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
			
			<div class="inner-box reglist-box">
			<c:if test="${reglist.size() > 0}">
				<div id="reglist">
					<c:forEach var="reglists" items="${reglist}">
						<div class="reglist-wrap">
							<div class="reglist-info-wrap">
								<div class="reglist-name"><a href="details.do?teamIdx=${reglists.teamIdx}">
								<c:if test="${reglists.status == 0}">[모집중]</c:if>
								<c:if test="${reglists.status == 2}">[마감]</c:if>
								${reglists.title}</a></div>
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
											<fmt:formatDate value="${endDate}" pattern="yyyy년 MM월 dd일"/>
										</div>
									</div>
								</div>
							</div>
							<div class="reglist-buttons">
								<c:if test="${reglists.status == 0}">
									<button class="normal-button" onclick="finish(${reglists.teamIdx})">마감하기</button>&nbsp;
								</c:if>
								<button class="normal-button accent-button" style="width:110px;" onclick="location.href='myapp.do?teamIdx=${reglists.teamIdx}&mIdx=${reglists.mIdx}'">지원서 보기</button>
							</div>
						</div>
						</c:forEach>
					</div>
			</c:if>
					<!--  div id="page-nav">					
						<c:if test="${lastPage < 6}">
							<c:forEach var="i" begin="${startPage}" end="${endPage}">
								<c:choose>
									<c:when test="${i == 1}">
										<div class="page-nav-button current-page">[${i}]</div>&nbsp;
									</c:when>
									<c:otherwise>
										<div class="page-nav-button" onclick="loadMySpaceRsv(${i})">[${i}]&nbsp;</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
						<c:if test="${lastPage > 5}">
							<c:if test="${startPage > 5}">
								<div class="page-nav-button" onclick="loadMySpaceRsv(1)">[1]</div>&nbsp;
								<div class="page-nav-button" onclick="loadMySpaceRsv(${startPage - 1})">◀</div>&nbsp;
							</c:if>
							
							<c:forEach var="i" begin="${startPage}" end="${endPage}">
								<c:choose>
									<c:when test="${i == param.page}">
										<div class="page-nav-button current-page">[${i}]</div>&nbsp;
									</c:when>
									<c:otherwise>
										<div class="page-nav-button" onclick="loadMySpaceRsv(${i})">[${i}]&nbsp;</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<c:if test="${endPage < lastPage}">
								<div class="page-nav-button" onclick="loadMySpaceRsv(${endPage + 1})">▶</div>&nbsp;
								<div class="page-nav-button" onclick="loadMySpaceRsv(${lastPage})">[${lastPage}]</div>&nbsp;
							</c:if>
						</c:if>
					</div>-->
				</div>
				
		<div class="big-title" style="margin-top:60px;">
			작성한 지원서 목록
		</div>
				<c:forEach var="applists" items="${applist}">
					<div class="inner-box applist-box">
						<div class="reglist-name"><a href="details.do?teamIdx=${applists.teamIdx}">
							<c:if test="${applists.status == 0}">[모집중]</c:if>
							<c:if test="${applists.status == 2}">[마감]</c:if>
							${applists.title}</a></div>
						<c:if test="${applists.partname != ''}">
						<div class="reglist-info-items" style="margin:10px 0px;">
							<div class="small-title">지원한 파트</div>
							<div class="small-content">${applists.partname}</div>
						</div>
						</c:if>
					
						<div class="small-title">내용</div>
						<div id="update-content${applists.appIdx}">
							<div class="content"><pre id="pre-app${applists.appIdx}" style="font-family:'맑은 고딕';">${applists.content}</pre></div>
							<c:if test="${applists.status == 0}">
							<div class="inner-box-button-wrap">
								<button class="normal-button" onclick="roadContent(${applists.appIdx})">수정</button>
								<button class="normal-button" onclick="deleteApp(${applists.appIdx})" style="margin-left: 15px;">삭제</button>
							</div>
							</c:if>
						</div>
						<div id="update-form${applists.appIdx}" style="display: none;">
							<div class="content"><textarea class="textarea" id='textarea${applists.appIdx}' name='content'>${applists.content}</textarea></div>
							<div class="inner-box-button-wrap">
								<button class="normal-button" onclick="updateApp(${applists.appIdx})">수정하기</button>
								<button class="normal-button" onclick="cancel(${applists.appIdx})" style="margin-left: 15px;">취소</button>
							</div>
						</div>
					
				</div>
				
			</c:forEach>
		</div>
		
		<!-- 여기까지 틀이고 밑에는 요소 공통사항
		<div>
			위까지는 틀이고 밑에는 요소 공통사항
			<br><br><br>
			버튼 세로 크기 수정시 border-radius도 수정해야함<br>
			<br>
			<button class="normal-button">버튼</button> 
			일반 버튼 (button class="normal-button") (버튼이 여러개 줄줄이 배치될 시 하나만 강조 컬러 넣을것)<br><br>
			<button class="normal-button accent-button">버튼</button> 강조 버튼 (button class="normal-button accent-button")<br><br>
			<br><br><br>
			내부 박스 틀과 예시
			<div class="inner-box">
				<div class="inner-box-content">
				박스에 들어갈 내용
				</div>
				<div class="inner-box-button-wrap">
					<button class="normal-button">일반버튼</button>
					<button class="normal-button accent-button" style="margin-left: 15px;">강조버튼</button>
				</div>
			</div>
			<br><br>
		</div>
		<!-- 여기까지 -->
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>