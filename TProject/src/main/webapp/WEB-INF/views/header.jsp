<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 100%;
	height: 60px;
	background: white;
	border-bottom: 1px solid darkgray;
	box-shadow: 0px 5px 10px rgba(0,0,0,0.2);
	position: fixed;
	z-index: 9999;
}

#header-logo {
	width: 240px;
	height: 60px;
	display: flex;
	justify-content: center;
	align-items: center;
}
#header-logo:hover {
	cursor: pointer;
}

#header-button {
	width: 80px;
	height: 60px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#header-button:hover {
	cursor: pointer;
}

#sidemenu {
	display: flex;
	position: fixed;
	background: #2A3F6A;
	width: 300px;
	height: 100vh;
	right: -300px;
	top: 0px;
	flex-direction: column;
}

.sm-open-button, .sm-close-button {
	width: 25px;
	height: 25px;
}

#sm-close-button {
	position: absolute;
	top: 0px;
	right: 0px;
	width: 80px;
	height: 60px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#sm-close-button:hover {
	cursor: pointer;
}

#sm-profile {
	min-height: 150px;
	height: 150px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	background: white;
	padding: 0px 40px;
}

.notlogin {
	width: 160px;
	height: 30px;
	border-radius: 15px;
	font-size: 14px;
	margin: 10px;
}

#sm-profile-buttons {
	width: 100%;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

#sm-profile-buttons button {
	width: 66px;
	height: 30px;
	border-radius: 15px;
	font-size: 12px;
}

#sm-buttons {
	display: flex;
	align-items: center;
}

.sm-button-wrap {
	width: 150px;
	height: 100px;
	display: flex;
	justify-content: center;
	border-right: 3px solid lightgray;
	border-left: none;
	align-items: center;
	background-color: #fb6544;
	color: rgb(242,242,242);
	font-weight: bold;
}
.sm-button-wrap:last-child {
	border-right: none;
}
.sm-button-wrap:hover {
	cursor: pointer;
}
.sm-button-wrap:active {
		filter: brightness(90%);
}

#sm-profile-info {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

#sm-profile-picture-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 60px;
	height: 60px;
	border-radius: 30px;
	box-shadow: 0px 0px 5px rgba(0,0,0,0.3);
	overflow: hidden;
	margin-right: 20px;
}

#sm-profile-picture-wrap-modal {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 60px;
	height: 60px;
	border-radius: 30px;
	box-shadow: 0px 0px 5px rgba(0,0,0,0.3);
	overflow: hidden;
	margin-right: 20px;
}

#sm-profile-point-value {
	font-size: 14px;
}

#sidemenu button.accordion-button:focus {
	outline: none;
	box-shadow: none;
}
#sidemenu .accordion-button:not(.collapsed)::after {
}

#sidemenu .accordion-button {
		height: 50px;
	background-color: rgb(245, 245, 245);
    color: black;
    font-weight: normal;
    font-size: 16px;
}
#sidemenu .accordion-button:not(.collapsed)::after {
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='%23212529'%3e%3cpath fill-rule='evenodd' d='M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z'/%3e%3c/svg%3e");
    transform: rotate(-180deg);
}
#sidemenu .accordion-button:not(.collapsed) {
    color: black;
    background-color: rgb(245, 245, 245);
		box-shadow: none;
}
#sidemenu .accordion-body {
	padding: 0px;
	display: flex;
	flex-direction: column;
}

#sidemenu .accordion-body div{
	padding: 0.5rem 1.25rem;
	border-top: 1px solid lightgray;
}
#sidemenu .accordion-item:last-of-type {
  border-bottom-right-radius: 0px;
  border-bottom-left-radius: 0px;
}
#sidemenu .accordion-item:first-of-type {
  border-top-left-radius: 0px;
  border-top-right-radius: 0px;
}
#sidemenu .accordion-item {
	border: none;
	border-bottom: 1px solid lightgray;
}

#sidemenu .sm-innerlist {
	background: white;
}
#sidemenu .sm-innerlist:hover {
	cursor: pointer;
}
#sidemenu .sm-innerlist:active {
	filter: brightness(90%);
}

#sidemenu .sm-list-area {
	overflow: auto;
}

#sidemenu .sm-list-area::-webkit-scrollbar {
	display: none;
}

.miniprofile:hover{
	cursor:pointer;
}
.profile-close:focus {
	box-shadow: none;
	outline: none;
}
#sm-profile-nickname{
	word-break: break-all;
    width: 130px;
}
#sm-profile-nickname-modal{
	word-break: break-all;
    width: 135px;
}

</style>

<script>
	function closeSm() {
		$("#sidemenu").animate({right: "-300px"}, 200);
		setTimeout(function() {
			$("#sidemenu").css("box-shadow", "none");
		}, 200);
		
	}
	function openSm() {
		$("#sidemenu").css("box-shadow", "-5px 0px 10px rgba(0,0,0,0.2)");
		$("#sidemenu").animate({right: "0px"}, 200);
		
	}
</script>


<header>

	<div id="header-logo" onclick="location.href='<%=request.getContextPath()%>/'">
		<img src="<%=request.getContextPath() %>/images/logo.png" width="200px">
	</div>
	<div id="header-button" onclick="openSm()">
			<img src="<%=request.getContextPath() %>/images/sidemenu-open-button.png" class="sm-open-button">
	</div>
	<div id="sidemenu">
		<div id="sm-close-button" onclick="closeSm()">
			<img src="<%=request.getContextPath() %>/images/sidemenu-close-button.png" class="sm-close-button">
		</div>
		<div id="sm-profile">
			<c:if test="${login == null && hlogin == null}">
				<style>
					#sm-profile {
						align-items: center;
					}
				</style>
				<button class="normal-button accent-button notlogin" onclick="location.href='<%=request.getContextPath()%>/member/glogin.do'">일반회원 로그인</button>
				<button class="normal-button accent-button notlogin" onclick="location.href='<%=request.getContextPath()%>/member/hlogin.do'">호스트 로그인 </button>
			</c:if>
			<c:if test="${sessionScope.login != null}">
				<div id="sm-profile-info">
					<div id="sm-profile-picture-wrap">
						<img src="${login.getProfileSrc()}" width="100%">
					</div>
					<div id="sm-profile-nickname-wrap">
						<div id="sm-profile-nickname">
							${login.getNickname()}
						</div>
						<div id="sm-profile-point">
							<span id="sm-profile-point-value">℗ <fmt:formatNumber value="${login.getPoint()}" type="number" pattern="#,###" /></span>
						</div>
					</div>
				</div>
				<div id="sm-profile-buttons">
					<button class="normal-button" onclick = "location.href='<%=request.getContextPath() %>/member/ginfo.do'">내 정보</button>
					<c:choose>
						<c:when test="${noReadMsg gt 0}">
							<button class="normal-button accent-button" onclick = "location.href='<%=request.getContextPath() %>/member/myMessage.do?page=1'">쪽지함</button>
						</c:when>
						<c:otherwise>
							<button class="normal-button" onclick = "location.href='<%=request.getContextPath() %>/member/myMessage.do?page=1'">쪽지함</button>
						</c:otherwise>
					</c:choose>
					<button class="normal-button" onclick = "location.href='<%=request.getContextPath() %>/member/logout.do'">로그아웃</button>
				</div>
			</c:if>
			<c:if test="${hlogin != null}">
				<div id="sm-profile-info">
					<div id="sm-profile-picture-wrap">
						<img src="${hlogin.getProfileSrc()}" width="100%">
					</div>
					<div id="sm-profile-nickname-wrap">
						<div id="sm-profile-nickname">
							${hlogin.getNickname()}
						</div>
						<div id="sm-profile-point">
							<span id="sm-profile-point-value">호스트 로그인 중</span>
						</div>
					</div>
				</div>
				<div id="sm-profile-buttons">
					<button class="normal-button" onclick = "location.href='<%=request.getContextPath() %>/member/hinfo.do'">내 정보</button>
					<c:choose>
						<c:when test="${noReadMsg gt 0}">
							<button class="normal-button accent-button" onclick = "location.href='<%=request.getContextPath() %>/member/myMessage.do?page=1'">쪽지함</button>
						</c:when>
						<c:otherwise>
							<button class="normal-button" onclick = "location.href='<%=request.getContextPath() %>/member/myMessage.do?page=1'">쪽지함</button>
						</c:otherwise>
					</c:choose>
					<button class="normal-button" onclick = "location.href='<%=request.getContextPath() %>/member/logout.do'">로그아웃</button>
				</div>
			</c:if>
		</div>
		<c:if test="${sessionScope.login != null}">
		<div id="sm-buttons">
			<div class="sm-button-wrap" onclick="location.href='<%=request.getContextPath() %>/space/list.do'">
				공간 대여
			</div>
			<div class="sm-button-wrap" onclick="location.href='<%=request.getContextPath() %>/teams/main.do'">
				팀원 모집
			</div>
		</div>
		</c:if>
		<c:if test="${hlogin != null}">
		<div id="sm-buttons">
			<div class="sm-button-wrap" onclick="location.href='<%=request.getContextPath() %>/space/myspace.do'">
				내 공간 관리
			</div>
			<div class="sm-button-wrap" onclick="location.href='<%=request.getContextPath() %>/space/register.do'">
				공간 등록하기
			</div>
		</div>
		</c:if>
		
			<div class="sm-list-area">
			
		
		<c:if test="${sessionScope.login.getAuth() == 3}">
			<div class="accordion-item">
		<h2 class="accordion-header" id="headingOne">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#c0" aria-expanded="true" aria-controls="collapseOne">
        관리자 메뉴
      </button>
    </h2>
    <div id="c0" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
      <div class="accordion-body">
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/member/adminCheck.do?num=0'">
       	공간 관리
       	</div>
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/member/adminCheck.do?num=1'">
       	신고글 관리
       	</div>
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/member/adminCheck.do?num=2'">
       	일반회원 관리
       	</div>
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/member/adminCheck.do?num=3'">
       	호스트회원 관리
       	</div>
      </div>
    </div>
    </div>
		</c:if>
			
		<c:if test="${sessionScope.login != null}">
			<div class="accordion-item">
		<h2 class="accordion-header" id="headingOne">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#c1" aria-expanded="true" aria-controls="collapseOne">
        공간 이용 내역
      </button>
    </h2>
    <div id="c1" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
      <div class="accordion-body">
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/space/myrsv.do'">
       	공간 예약 내역
       	</div>
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/space/mypoint.do'">
       	포인트 획득 / 사용 내역
       	</div>
      </div>
    </div>
    </div>
		</c:if>
		
			<div class="accordion-item">
    <h2 class="accordion-header" id="headingOne">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#c2" aria-expanded="true" aria-controls="collapseOne">
        새소식
      </button>
    </h2>
    <div id="c2" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
      <div class="accordion-body">
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/serlist.do?bIdx=1&page=1'">
       	공지사항
       	</div>
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/serlist.do?bIdx=6&page=1'">
       	이벤트
       	</div>
      </div>
    </div>
  </div>
			
		<c:if test="${sessionScope.login != null}">
			
			
				<div class="accordion-item">
    <h2 class="accordion-header" id="headingOne">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#c3" aria-expanded="true" aria-controls="collapseOne">
        커뮤니티
      </button>
    </h2>
    <div id="c3" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
      <div class="accordion-body">
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/board/list.do?bIdx=2&page=1'">
       	자유게시판
       	</div>
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/board/hlist.do?page=1'">
       	홍보게시판
       	</div>
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/board/jlist.do?page=1'">
       	중고거래
       	</div>
      </div>
    </div>
  </div>
			
		</c:if>
		
				<div class="accordion-item">
    <h2 class="accordion-header" id="headingOne">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#c4" aria-expanded="true" aria-controls="collapseOne">
        고객센터
      </button>
    </h2>
    <div id="c4" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
      <div class="accordion-body">
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/serlist.do?bIdx=5&page=1'">
       	자주 묻는 질문
       	</div>
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/serinfo.do?idx=1'">
       	이용약관
       	</div>
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/serinfo.do?idx=2'">
       	개인정보처리방침
       	</div>
       	<div class="sm-innerlist" onclick="location.href='<%=request.getContextPath() %>/serinfo.do?idx=3'">
       	운영정책
       	</div>
      </div>
    </div>
  </div>
			</div>
	</div>
	
	
	<div class="inner-box mini-profile" style="width: 300px; height: 200px; display: flex; position: fixed; visibility: hidden; top: 10px; left: 0px; background-color: rgb(245, 245, 245); opacity: 0%;">
		<div id="mini-profile-content" class="inner-box-content " style="padding: 15px 20px;position:relative; display: flex; flex-direction: column; justify-content: space-between; align-items: center;">
			<button type="button" class="btn-close profile-close" style="position: absolute; top: 0px; right: 0px;" onclick="profileClose()"></button>
				<div class="mini-profile-wrap" style="width: 100%; display: flex; align-items: center; ">
					<div id="sm-profile-picture-wrap-modal">
						<img src="" width="100%">
					</div>
					<div id="sm-profile-nickname-wrap-modal">
						<div id="sm-profile-nickname-modal">
						</div>
					</div>
					<input type="hidden" id="sm-profile-mIdx" value="">
				</div>
			<div class="mini-profile-buttons" style="width: 100%; display: flex; justify-content: space-between; align-items: center;">
				<button id="profile-report-button" class="normal-button mini-profile-button" style="font-size: 12px;width: 100px;" onclick="reportPopup()">신고</button>
				<button id="profile-message-button" class="normal-button mini-profile-button" style="font-size: 12px;width: 100px;" onclick="messagePopup()">쪽지보내기</button>
			</div>
		</div>
		<div id="mini-profile-unreg" class="inner-box-content" style="display: flex; flex-direction: column; justify-content: space-between; align-items: center;">
			<div style="margin-top: 20px;">탈퇴한 회원입니다.</div>
			<button type="button" class="btn-close profile-close" style="position: absolute; top: 15px; right: 15px;" onclick="profileClose()"></button>
		</div>
			
	</div>
<!-- Channel Plugin Scripts -->
<script>
  (function() {
    var w = window;
    if (w.ChannelIO) {
      return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
    }
    var ch = function() {
      ch.c(arguments);
    };
    ch.q = [];
    ch.c = function(args) {
      ch.q.push(args);
    };
    w.ChannelIO = ch;
    function l() {
      if (w.ChannelIOInitialized) {
        return;
      }
      w.ChannelIOInitialized = true;
      var s = document.createElement('script');
      s.type = 'text/javascript';
      s.async = true;
      s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
      s.charset = 'UTF-8';
      var x = document.getElementsByTagName('script')[0];
      x.parentNode.insertBefore(s, x);
    }
    if (document.readyState === 'complete') {
      l();
    } else if (window.attachEvent) {
      window.attachEvent('onload', l);
    } else {
      window.addEventListener('DOMContentLoaded', l, false);
      window.addEventListener('load', l, false);
    }
  })();
  ChannelIO('boot', {
    "pluginKey": "7076be12-5620-4a8e-b360-e2c6dfd55265", //please fill with your plugin key
    "memberId": "${login.getEmail()}", //fill with user id
    "profile": {
      "name": "${login.getNickname()}", //fill with user name
      "mobileNumber": "${login.getTel()}", //fill with user phone number
      "email": "${login.getEmail()}", //any other custom meta data
      "CUSTOM_VALUE_2": "VALUE_2"
    }
  });
</script>
<!-- End Channel Plugin -->
<script>
	function profileOpen(mIdx) {
		var X=window.event.clientX;
		var Y=window.event.clientY-10;
		
		$(".mini-profile-button").css("display", "block");
		$(".mini-profile-buttons").css("justify-content", "space-between");
		
		document.querySelector('.mini-profile').style.transform='translate('+X+'px,'+Y+'px)';
		
		$.ajax({
			url:'<%=request.getContextPath() %>/member/miniProfile.do',
			type:'post',
			data:{mIdx:mIdx},
			success:function(vo){
				
				var gmIdx = 0;
				<c:if test="${login != null}">
					gmIdx = ${login.mIdx};
				</c:if>

				console.log(vo);
				$("#mini-profile-content").css("display", "none");
				$("#mini-profile-unreg").css("display", "none");
				$('div.mini-profile').css('visibility', 'visible');
				
				if (vo.auth == 2) {
					$("#mini-profile-unreg").css("display", "flex");
				} else {

					$('#sm-profile-picture-wrap-modal img').attr('src', vo.profileSrc);
					$('#sm-profile-nickname-modal').text(vo.nickname);
					$('#sm-profile-mIdx').val(mIdx);
					$("#mini-profile-content").css("display", "flex");
				}
					$('div.mini-profile').animate({opacity: "100%"}, 200);
				if (vo.auth == 3 || vo.mIdx == gmIdx) {
					$("#profile-report-button").css("display", "none")
					$(".mini-profile-buttons").css("justify-content", "center");
				}
			}
		})
		
		
	}
	
	function profileClose() {
		$('div.mini-profile').animate({opacity: "0%"}, 200);
		setTimeout(() => {
			$('div.mini-profile').css('visibility', 'hidden');
		}, 200);
	}
	
	function messagePopup(){
		var option = "width = 500, height = 400, top = 100, left = 200, location = no"
		var mIdx=document.querySelector("#sm-profile-mIdx").value;
		console.log(mIdx);
		window.open("<%=request.getContextPath() %>/messagePopup.do?type=general&mIdx="+mIdx,"쪽지보내기",option);
	}
	
	
	function reportPopup(){
		var option = "width = 500, height = 400, top = 100, left = 200, location = no";
		var mIdx = document.querySelector("#sm-profile-mIdx").value; //받는사람(target)의 midx
		
		window.open("<%=request.getContextPath() %>/member/reportPopup.do?mIdx="+mIdx, "신고하기", option);
	}
</script>
</header>