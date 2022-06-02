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
<link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.13.0/themes/smoothness/jquery-ui.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.3/moment.min.js"></script>
<style>
table{
	width:100%;
	text-align: center;
}
tr{
	border-bottom: 1px solid lightgray;
	height:40px;
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
	background-color: #2A3F6A;
	font-weight: bold;
}
#title{
	height: 50px;
    font-size: 18px;
    font-weight: bold;
}
.detail{
	width:45px;
	height:30px;
	box-shadow: 0px 0px 3px rgb(0 0 0 / 20%);
	font-size:14px;
}
.accent-button{
	width:60px;
}
.form-select{
    margin-bottom:10px;
	height: 35px;
	border-radius:17.5px;
	border: none;
    box-shadow: 0px 0px 5px rgb(0 0 0 / 20%);
    width: 140px;
}
.form-control{
	margin-right:6px;
	width:200px;
	height: 35px;
	border-radius:17.5px;
	border: none;
    box-shadow: 0px 0px 5px rgb(0 0 0 / 20%);
}
select[name=searchField]{
	width:100px;
}

.details-wrap {
	width: 100%;
	height: 100vh;
	position: fixed;
	top: 30px;
	left: 0px;
	z-index: 999;
	display: none;
	justify-content: center;
	align-items: center;
	opacity: 0%;
	transition: 0.2s;
}
.details-wrap.animate {
	opacity: 100%;
}

.details {
	max-height: 75vh;
	width: 50%;
	padding: 10px 0px !important;
	background: rgb(245,245,245) !important;
	box-shadow: 0px 10px 20px rgba(0,0,0,0.2) !important;
	position: relative;
	transform: scale(0.95);
	transition: 0.2s;
}
.details.animate {
	transform: scale(1);
}

.scroll-area {
	width: 100%;
	max-height: 70vh;
	padding: 30px 40px 30px 40px;
	overflow: auto;
}

.scroll-area::-webkit-scrollbar {
 		width: 8px;  /* 스크롤바의 너비 */
}

.scroll-area::-webkit-scrollbar-thumb {
	background: #2A3F6A; /* 스크롤바의 색상 */
	border-radius: 10px;
}

.scroll-area::-webkit-scrollbar-track {
	opacity: 0%;  /*스크롤바 뒷 배경 색상*/
}

.details-big-title {
	font-size: 24px;
	font-weight: bold;
}

.small-title {
	font-size: 14px;
	font-weight: bold;
}
.small-title:not(.small-title:first-child) {
	margin-top: 20px;
}

.basic-info {
	margin-top: 20px;
}

.profile-wrap {
	display: flex;
	align-items: center;
}

.nickname {
	margin-left: 15px;
	font-weight: bold;
	font-size: 20px;
}

.profile-picture {
	display: flex;
	justify-content: center;
	align-items: center;
	overflow: hidden;
	width: 40px;
	height: 40px;
	border-radius: 60px;
	box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
}

#profile-picture-img {
	width: 100%;
}

.buttons-wrap {
	margin-top: 20px;
	text-align: right;
}

.details-button {
	margin-left: 10px;
	width: 80px;
	height: 30px;
	font-size: 14px;
}
</style>
<script
  src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"
  integrity="sha256-eTyxS0rkjpLEo16uXTS0uVCS4815lc40K2iVpWDvdSY="
  crossorigin="anonymous"></script>
  
	<script>
	
		$(function() {
			$(".details").draggable();
			 
			 
			var searchField = "${param.searchField}";
			if(searchField == ""){
				searchField = "nickname";
			}
			
			var sort = "${param.sort}";
			if(sort == ""){
				sort = "all";
			}
			
			$("select[name=searchField]").val(searchField);
			$("select[name=sort]").val(sort);
			$("input[name=searchWord]").val("${param.searchWord}");
		 
		});
		
		function showDetails(mIdx) {
			
			$.ajax({
				type: "get",
				url: "miniProfile.do",
				data: "mIdx=" + mIdx,
				success: function(member) {
					
					$("#profile-picture-img").attr("src", member.profileSrc);
					$("#details-nickname").text(member.nickname);
					$("#details-email").text(member.email);
					$("#details-name").text(member.name);
					$("#details-address").text(member.address + " " + member.addressDetail);
					$("#details-tel").text(member.tel);
					
					if (member.gender == "M") {
						$("#details-gender").text("남자");
					} else if (member.gender == "F") {
						$("#details-gender").text("여자");
					}
					
					$("#details-joindate").text(moment(member.joinDate).format("YYYY년 MM월 DD일"));
					
					$("#block-button").attr("data-mIdx", member.mIdx);
					$("#unreg-button").attr("data-mIdx", member.mIdx);

					$("#block-button").text('차단');
					$("#block-button").removeClass("blocked");
					if (member.auth == 1) {
						$("#block-button").text('차단 해제');
						$("#block-button").addClass("blocked");
					}
					
					$(".details").css("left", "0px");
					$(".details").css("top", "0px");
					
					$(".details-wrap").css("display", "flex");
					$(".scroll-area").scrollTop(0);

					$(".details-wrap").addClass("animate");
					$(".details").addClass("animate");
					
				}				
			})
			
		}
		
		function closeDetails() {
			$(".details-wrap").removeClass("animate");
			$(".details").removeClass("animate");
			
			setTimeout(() => {
				$(".details-wrap").css("display", "none");
			}, 200);
		}
		
		function blockUser(button) {
			
			var mIdx = $(button).attr('data-mIdx');
			
			if ($(button).hasClass("blocked")) {
				
				if (!confirm('이 멤버의 차단을 해제하시겠습니까?')) {
					return;
				}
				
				$.ajax({
					type: "post",
					url: "unblock.do",
					data: "target=" + mIdx,
					success: function(result) {
						if (result == 'ok') {
							alert('차단이 해제되었습니다.');
							location.reload();
						}
					}
				})
				
				
				
			} else {
				
				if(!confirm('이 멤버의 글쓰기 권한을 차단하시겠습니까?')) {
					return;
				}
				
				$.ajax({
					type: "post",
					url: "block.do",
					data: "target=" + mIdx,
					success: function(result) {
						if (result == 'ok') {
							alert('글쓰기 권한이 차단되었습니다.');
							location.reload();
						}
					}
				})
			}
			
		}
		
		function unregUser(button) {
			
			var mIdx = $(button).attr('data-mIdx');
			
			if (!confirm('이 멤버를 추방하시겠습니까?')) {
				return;
			}

			$.ajax({
				url:"withdraw.do",
				type:"post",
				data:"mIdx="+mIdx + "&memberType=general",
				success:function(data){
					if(data == "ok"){
						alert('추방이 완료되었습니다.');
						location.reload();
					}else{
						alert('추방이 완료되지 않았습니다.');
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
			일반회원 관리
		</div>
		<div id="page-content">
			
			<form action="gMemberManage.do" id="search-form">
				<input type="hidden" name="search" value="1">
				<div class="d-flex justify-content-between">
					<div>
						<select class="form-select form-select-sm" name="sort" onchange="$('#search-form').submit()">
							<option value="all">전체</option>
							<option value="normal">일반회원 보기</option>
							<option value="block">차단회원 보기</option>
							<option value="admin">관리자 보기</option>
						</select>
					</div>
					<div class="d-flex">
						<select class="form-select form-select-sm" name="searchField">
							<option value="nickname">닉네임</option>
							<option value="name">이름</option>
						</select>&nbsp;
						<input class="form-control form-control-sm" type="text" name="searchWord" placeholder="검색어를 입력해주세요.">
						<button type="submit" class="normal-button accent-button">검색</button> &nbsp;
						<button type="button" class="normal-button" style="width:75px;" onclick="location.href='gMemberManage.do'">초기화</button>
					</div>
				</div>
			</form>
			<div class="inner-box reglist-box">
				<div id="reglist">
					<table>
						<tr id="title">
							<td style="width:10%;">회원번호</td>
							<td style="width:15%;">닉네임</td>
							<td style="width:15%;">이름</td>
							<td>이메일</td>
							<td style="width:20%;">구분</td>
							<td style="width:10%;"></td>
						</tr>
						<c:forEach var="gMember" items="${gMember}">
						<tr>
							<td>${gMember.mIdx}</td>
							<td>${gMember.nickname}</td>
							<td>${gMember.name}</td>
							<td>${gMember.email}</td>
							<td>
								<c:if test="${gMember.auth == 0}">일반</c:if>
								<c:if test="${gMember.auth == 1}">차단</c:if>
								<c:if test="${gMember.auth == 3}">관리자</c:if>
							</td>
							<td>
								<button class="normal-button detail" onclick="showDetails(${gMember.mIdx})">상세</button>
							</td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			
			<div id="page-nav"><!-- 페이지 시작 -->					
				<c:if test="${PagingUtil.lastPage < 6}">
					<c:forEach var="i" begin="${PagingUtil.startPage}" end="${PagingUtil.endPage}">
						<c:choose>
							<c:when test="${i == PagingUtil.nowPage}">
								<div class="page-nav-button current-page">${i}</div>
							</c:when>
							<c:otherwise>
								<div class="page-nav-button" onclick="location.href='gMemberManage.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${i}'">${i}</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
				<c:if test="${PagingUtil.lastPage > 5}">
					<c:if test="${PagingUtil.startPage > 5}">
						<div class="page-nav-button" onclick="location.href='gMemberManage.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=1'">1</div>
						<div class="page-nav-button" onclick="location.href='gMemberManage.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${PagingUtil.startPage - 1}'">◀</div>
					</c:if>
					
					<c:forEach var="i" begin="${PagingUtil.startPage}" end="${PagingUtil.endPage}">
						<c:choose>
							<c:when test="${i == 1}">
								<div class="page-nav-button current-page">${i}</div>
							</c:when>
							<c:otherwise>
								<div class="page-nav-button" onclick="location.href='gMemberManage.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${i}'">${i}</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:if test="${PagingUtil.endPage < PagingUtil.lastPage}">
						<div class="page-nav-button" onclick="location.href='gMemberManage.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${PagingUtil.endPage + 1}">▶</div>
						<div class="page-nav-button" onclick="location.href='gMemberManage.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${PagingUtil.lastPage}">${PagingUtil.lastPage}</div>
					</c:if>
				</c:if>
			</div>
		</div>
	</div>
	
	<div class="details-wrap">
		<div class="inner-box details">
			<button type="button" class="btn-close profile-close" style="position: absolute; top: 15px; right: 15px;" onclick="closeDetails()"></button>
			<div class="scroll-area">
				<div class="profile-wrap">
					<div class="profile-picture">
						<img id="profile-picture-img" src="">
					</div>
					<div id="details-nickname" class="nickname">
					</div>
				</div>				
				
				<div class="inner-box basic-info">
					<div class="info-view">
						<div class="small-title">
							이메일
						</div>
						<div id="details-email" class="info-content">
						</div>
						<div class="small-title">
							이름
						</div>
						<div id="details-name" class="info-content">
						</div>
						<div class="small-title">
							주소
						</div>
						<div id="details-address" class="info-content">
						</div>
						<div class="small-title">
							전화번호
						</div>
						<div id="details-tel" class="info-content">
						</div>
						<div class="small-title">
							성별
						</div>
						<div id="details-gender" class="info-content">
						</div>
						<div class="small-title">
							가입일
						</div>
						<div id="details-joindate" class="info-content">
						</div>
					</div>
				</div>
				
				<div class="buttons-wrap">
					<button id="block-button" class="normal-button details-button" onclick="blockUser(this)">차단</button>
					<button id="unreg-button" class="normal-button details-button" onclick="unregUser(this)">추방</button>
				</div>
				
			</div>
		</div>
	</div>
	<c:import url="/footer.do" />
</body>
</html>