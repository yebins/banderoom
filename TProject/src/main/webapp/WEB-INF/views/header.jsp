<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 100%;
	height: 80px;
	background: white;
	border-bottom: 1px solid darkgray;
	box-shadow: 0px 5px 10px rgba(0,0,0,0.2);
	position: fixed;
}

#header-logo {
	width: 240px;
	height: 80px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#header-button {
	width: 80px;
	height: 80px;
	display: flex;
	justify-content: center;
	align-items: center;
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

.sm-open-button {
	width: 25px;
	height: 25px;
	border-collapse: collapse;
}

.sm-open-button-el {
	border-top: 3px solid black;
}
.sm-open-button-el:last-child {
	border-bottom: 3px solid black;
}

#sm-close-button {
	position: absolute;
	top: 0px;
	right: 0px;
	width: 80px;
	height: 80px;
	border: 1px solid gray;
}

#sm-profile {
	border: 1px solid gray;
	height: 150px;
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
	<div id="header-logo">
		<img src="<%=request.getContextPath() %>/images/logo.png" width="200px">
	</div>
	<div id="header-button" onclick="openSm()">
			<table class="sm-open-button">
				<tr>
					<td class="sm-open-button-el"></td>
				</tr>
				<tr>
					<td class="sm-open-button-el"></td>
				</tr>
			</table>
	</div>
	<div id="sidemenu">
		<div id="sm-close-button" onclick="closeSm()">닫기
		</div>
		<div id="sm-profile">
			프로필 영역
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
    "memberId": null, //fill with user id
    "profile": {
      "name": null, //fill with user name
      "mobileNumber": null, //fill with user phone number
      "email": null, //any other custom meta data
      "CUSTOM_VALUE_2": "VALUE_2"
    }
  });
</script>
<!-- End Channel Plugin -->
</header>