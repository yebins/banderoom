<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	#messageContent{
		width:500px;
		height:300px;
		padding:20px;
	}
	#messageContent2{
		width:500px;
		height:300px;
		padding:20px;
	}
	
	 textarea {
	width:100%;
    height:100%;
    resize: none;
    border-radius:10px;
  }
  #receiver{
  	padding:10px;
  	border-bottom:1px solid lightgray;
  }
  
  #messageBox{
  	width:100%;
  }
  #messageButton{
  	display:flex;
  	justify-content:flex-end;
  	align-items:center;
  }
  #messageButton button{
  	margin-right:20px;
  }

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
	#message-content-list-header>a{
		font-size:12px;
		font-weight:bold;
		padding:10px;
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
	.visitedMessage > a{
		color:lightgray;
	}
		.page-nav-button {
   		border:none;
		width: 40px;
		height: 40px;
		border-radius: 20px;
		margin: 7.5px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		display: flex;
		justify-content: center;
		align-items: center;
		background-color:white;
	}
	.page-nav-button:not(.current-page) {
		cursor: pointer;
	}
	.page-nav-button.current-page {
		background-color: #fbe6b2;
		font-weight: bold;
	}
	a:hover{
		cursor:pointer;
	}
	li{
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap;
	}
	
	html body .messageBox-Extend{
		width: 100%;
  		 z-index: 10000;
 	   display: flex;
	    justify-content: center;
 	   margin: auto;
	    top: 0;
	    left: 0;
 	   position: fixed;
 	   height: 100%;
 	   align-items:center;
	}
	
	.messageBox{
		display:none;
	}
	.innerMessageBOX{
		padding:10px;
		border-radius:15px;
		background:#fbe6b2;
		border:10px solid lightgray;
	}
	.msgDelBtn{
		border-radius:10px;
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
							<input type="hidden" value="${login.mIdx}">
							<a onclick="messagePopups(this)"><span style="color:white;">내게쓰기</span></a>
						</div>
						<div id="message-nav-menu-list">	
							<ul>
								<li>
									<a href="myMessage.do?page=1">받은쪽지함 
										<%-- <b>${msgCount.ct1} /</b> --%>
										<b>${noReadMsg.ct1}</b>
									</a>
								</li>
								<li>
									<a href="sentMessage.do?page=1">보낸쪽지함 
										<%-- <b>${msgCount.ct2}</b> --%>
										<b>${noReadMsg.ct2}</b>
									</a>
								</li>
								<%-- <li>
									<a href="">쪽지보관함
										<b>${msgCount.ct3}</b>
									</a>
								</li> --%>
							</ul>
						</div>
					</div>
					<div id="message-content-list">
						<div id="message-content-list-header">
							<div style="padding-top	:30px;padding-left:10px;">
								<c:choose>
									<c:when test="${sign eq 'receive'}">
									<h4>받은쪽지함 (${noReadMsg.ct1} / ${msgCount.ct1})</h4>
									</c:when>
									<c:otherwise>
									<h4>보낸쪽지함 (${noReadMsg.ct2} / ${msgCount.ct2})</h4>									
									</c:otherwise>
								</c:choose>
							<button class="msgDelBtn" onclick="deleteMsg()">삭제</button>
							</div>
						</div>
						<c:if test="${sign eq 'receive'}">
						<div id="message-content-list-content-top">
							<ul>
								<li id="message-content-top-check">
									<input type="checkbox" id="cbx_chkAll">
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
								<c:forEach var="item" items="${list}">
									<c:choose>
										<c:when test="${item.status eq '1'}">
											<li class="message-content-center-check">
												<input type="checkbox" name="chk" value="${item.msgIdx}">
											</li>
											<li class="visitedMessage" style="width:15%;color:lightgray;">
												<a >${item.senderNickname}</a>
											</li>
											<li class="visitedMessage" style="width:65%;color:lightgray;">
												<a onclick="message('${item.senderNickname}',this,'${item.sender}','${item.msgIdx}','${item.receiver}')">${item.content}</a>
											</li>
											<li class="visitedMessage" style="width:15%;border-right:none;padding-right:0;color:lightgray;">
												<a ><fmt:formatDate value="${item.sentDate}" pattern="YY-MM-dd [hh:mm]"/></a>
											</li>
										</c:when>
										<c:otherwise>
											<li class="message-content-center-check">
												<input type="checkbox" name="chk" value="${item.msgIdx}">
											</li>
											<li style="width:15%;">
												<a >${item.senderNickname}</a>
											</li>
											<li style="width:65%;">
												<a onclick="message('${item.senderNickname}',this,'${item.sender}','${item.msgIdx}','${item.receiver}')">${item.content}</a>
											</li>
											<li style="width:15%;border-right:none;padding-right:0;">
												<a ><fmt:formatDate value="${item.sentDate}" pattern="YY-MM-dd [hh:mm]"/></a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ul>
						</div>
						</c:if>
						<!-- -----------------------------------보낸쪽지함 -->
						<c:if test="${sign eq 'send'}">
						<div id="message-content-list-content-top">
							<ul>
								<li id="message-content-top-check">
									<input type="checkbox" id="cbx_chkAll">
								</li>
								<li style="width:15%;">
									<span>받는사람</span>
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
								<c:forEach var="item" items="${list}">
									<c:choose>
										<c:when test="${item.status eq '1'}">
											<li class="message-content-center-check ">
												<input type="checkbox" name="chk" value="${item.msgIdx}">
											</li>
											<li class="visitedMessage" style="width:15%;color:lightgray;">
												<a >${item.receiverNickname}</a>
											</li>
											<li class="visitedMessage" style="width:65%;color:lightgray;">
												<a onclick="sentMessage('${item.receiverNickname}',this)">${item.content}</a>
											</li>
											<li class="visitedMessage" style="width:15%;border-right:none;padding-right:0;color:lightgray;">
												<a ><fmt:formatDate value="${item.sentDate}" pattern="YY-MM-dd [hh:mm]"/></a>
											</li>
										</c:when>
										<c:otherwise>
											<li class="message-content-center-check">
												<input type="checkbox" name="chk" value="${item.msgIdx}">
											</li>
											<li style="width:15%;">
												<a >${item.receiverNickname}</a>
											</li>
											<li style="width:65%;">
												<a onclick="sentMessage('${item.receiverNickname}',this)">${item.content}</a>
											</li>
											<li style="width:15%;border-right:none;padding-right:0;">
												<a ><fmt:formatDate value="${item.sentDate}" pattern="YY-MM-dd [hh:mm]"/></a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ul>
						</div>
						</c:if>
						<div id="message-content-list-content-footer">
						<c:set var="msgTotal" value="${msgTotal}"/>
						<c:set var="page" value="${page}"/>
						<c:set var="startNum" value="${page-(page-1)%5}"/>	
						<c:set var="lastNum" value="${fn:substringBefore(Math.ceil(msgTotal/14),'.')}"/>
							<c:if test="${fn:length(list) gt 0}">
								<c:if test="${page>5}">
									<button onclick="call('${sign}',1)" class="page-nav-button">1</button>
								</c:if>
								<button onclick="call('${startNum-5}')" class="page-nav-button" style="display:${startNum <= 1?'none':'block'}">◀</button>
									<c:forEach var="i" begin="0" end="4">
										<c:if test="${(startNum+i)<= lastNum}">
											<c:choose>
												<c:when test="${(startNum+i) == page }">
												<button onclick="call('${sign}','${startNum+i}')" class="page-nav-button current-page" >${startNum+i}</button>
												</c:when>
												<c:otherwise>
												<button onclick="call('${sign}','${startNum+i}')" class="page-nav-button" >${startNum+i}</button>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:forEach>
								<button onclick="call('${sign}','${startNum+5}')" class="page-nav-button" style="display:${(startNum+5)>lastNum?'none':'block'}">▶</button>
								<c:if test="${(lastNum-5) >= page}">
									<button onclick="call('${sign}',${page})" class="page-nav-button">${lastNum}</button>
								</c:if>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="messageBox" class="messageBox">
		<div class="innerMessageBOX">
			<div>
				<span style="font-weight:bold;">보낸사람</span>
				<span id="messageSender"></span>
			</div>
			<div id="messageContent">
				<textarea style="resize:none" readonly></textarea>
			</div>
			<div id="messageButton">
				<input type="hidden" id="toIdx">
				<button class="normal-button" onclick="messagePopups(this)">답장하기</button>
				<button class="normal-button" onclick="closePop(this)">닫기</button>
			</div>
		</div>
	</div>
	<div id="messageBox2" class="messageBox">
		<div class="innerMessageBOX">
		<div>
			<span style="font-weight:bold;">받는사람</span>
			<span id="messageReceiver"></span>
		</div>
		<div id="messageContent2">
			<textarea style="resize:none" readonly></textarea>
		</div>
		<div id="messageButton">
			<button class="normal-button" onclick="closePop(this)">닫기</button>
		</div>
		</div>
	</div>
	<script>
		function call(sign,page){
			console.log(sign);
			if(sign == 'receive'){
				location.href='myMessage.do?page='+page;
			} else if (sign == 'send'){
				location.href='sentMessage.do?page='+page;
			} else{
				
			}
		}
		
		function messagePopups(obj){
			var option = "width = 500, height = 400, top = 100, left = 200, location = no"
			var mIdx=$(obj).prev().val();
			console.log(mIdx);
			window.open("/messagePopup.do?type=general&mIdx="+mIdx,"쪽지보내기",option);
		}
		
		function message(nickname,content,mIdx,msgIdx,receiver){
			$('#toIdx').val(mIdx);
			$('#messageSender').text(nickname);
			$('#messageContent textarea').val(content.text);
			$('#messageBox').addClass('messageBox-Extend');
			
			$.ajax({
				url:"/readMsg.do",
				type:"post",
				data:{msgIdx:msgIdx
					,receiver:receiver},
				success:function(){
					
				}
			})
		}
		
		function sentMessage(nickname,content){
			$('#messageReceiver').text(nickname);
			$('#messageContent2 textarea').val(content.text);
			$('#messageBox2').addClass('messageBox-Extend');		
		}
		
		function closePop(obj){
			var a=$(obj).parent().parent().parent().removeClass('messageBox-Extend');
		}
		
		$(document).ready(function() {
			
			$("#cbx_chkAll").click(function() {
				if($("#cbx_chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
				else $("input[name=chk]").prop("checked", false);
			});
			
			$("input[name=chk]").click(function() {
				var total = $("input[name=chk]").length;
				var checked = $("input[name=chk]:checked").length;
				
				if(total != checked) $("#cbx_chkAll").prop("checked", false);
				else $("#cbx_chkAll").prop("checked", true); 
			});
		});
		
		function deleteMsg(){
			var msgIdx=new Array();
			console.log($("input:checkbox[name='chk']:checked").length);
			$("input:checkbox[name='chk']:checked").each(function(){
					msgIdx.push(this.value);
				});
			
			$.ajax({
				type:"post",
				url:"/deleteMsg.do",
				data:{msgIdx:msgIdx},
				success:function(){
					alert('삭제되었습니다.')
					location.reload();
				}
			})
			console.log(msgIdx);
		}
	</script>
	<c:import url="/footer.do" />
</body>
</html>