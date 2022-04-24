<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	background: yellow;
	width: 300px;
	height: 100vh;
	right: 0px;
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
	border: 1px solid gray;
	height: 150px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
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

</style>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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
		<div id="sm-close-button" onclick="closeSm()">
			<img src="<%=request.getContextPath() %>/images/sidemenu-close-button.png" class="sm-close-button">
		</div>
		<div id="sm-profile">
			<c:if test="${login == null}">
				<button style="width: 200px;" onclick="location.href='<%=request.getContextPath()%>/member/glogin.do'">일반회원 로그인</button>
				<button style="width: 200px;" onclick="location.href='<%=request.getContextPath()%>/member/hlogin.do'">사업자 로그인 </button>
			</c:if>
			<c:if test="${login != null}">
				${login.getNickname()} 로그인함 <br>
				${login.getEmail()}				
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