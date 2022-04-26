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
	display: none;
	position: fixed;
	background: #FBE6B2;
	width: 300px;
	height: 100vh;
	right: 0px;
	top: 0px;
	flex-direction: column;
	box-shadow: -5px 0px 10px rgba(0,0,0,0.2);
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

.sm-close-button:hover {
	cursor: pointer;
}

#sm-profile {
	height: 150px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	background: white;
	padding: 0px 40px;
}

#sm-profile-buttons {
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
	border: 1px solid gray;
	align-items: center;
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

#sm-profile-point-value {
	font-size: 14px;
}

</style>

<script>
	function closeSm() {
		$("#sidemenu").css("display","none");
		
	}
	function openSm() {
		$("#sidemenu").css("display","flex");
		
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
		<div id="sm-close-button">
			<img src="<%=request.getContextPath() %>/images/sidemenu-close-button.png" class="sm-close-button" onclick="closeSm()">
		</div>
		<div id="sm-profile">
			<c:if test="${login == null && hlogin == null}">
				<button style="width: 200px;" onclick="location.href='<%=request.getContextPath()%>/member/glogin.do'">일반회원 로그인</button>
				<button style="width: 200px;" onclick="location.href='<%=request.getContextPath()%>/member/hlogin.do'">사업자 로그인 </button>
			</c:if>
			<c:if test="${login != null}">
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
					<button onclick = "">내정보</button>
					<button onclick = "">쪽지함</button>
					<button onclick = "location.href='/member/logout.do'">로그아웃</button>
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
					<button onclick = "">내정보</button>
					<button onclick = "">쪽지함</button>
					<button onclick = "location.href='/member/logout.do'">로그아웃</button>
				</div>
			</c:if>
		</div>
		<div id="sm-buttons">
			<div class="sm-button-wrap">
				연습실 대여
			</div>
			<div class="sm-button-wrap">
				사람구하는그거
			</div>
		</div>
			<div>
				게시판목록
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
</header>