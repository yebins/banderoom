<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
	.board-content-like{
		display:flex;
		justify-content: center;
		align-items: center;
	}
	h4 {
		margin:0;
	}
	.board-area-toparea h4> span:nth-of-type(2){
		float:right;
		line-height:30px;
	}
	.board-area-toparea {
		padding:10px;
		border-bottom:2px solid lightgray;
		
	}
	.board-area-btmarea {
		padding:10px;
		border-bottom:2px solid lightgray;
		display:flex;
		justify-content:space-between;
		margin-bottom:30px;
		font-size
	}
	.board-area-toparea-date{
		font-size:13px;
		
	}
	.board-area-btmarea-left{
		font-size:15px;
		display:flex;
		align-items:center;
	}
	.board-area-btmarea-right{
		display:flex;
		align-items:center;
	}
	.board-area-btmarea-right span{
		padding-left:10px;
	}
	.comment-area-total{
		height:65px;
		border-radius:20px;
		display:flex;
		padding:20px;
		border: 1px solid #ccc;
		background: linear-gradient(to bottom,#fff 0,#f4f4f4 100%);
	}
	
	.comment-area-total span{
		align-self:center;
	}
	.comment-area{
		margin-top:30px;
	}
	.comment-area-content-toparea{
		display:flex;
		justify-content:space-between;
		
	}
	.comment-area-content-contentarea{
		padding-top:10px;
	}
	.comment-area-content{
		padding:10px;
	}
	.comment-area-ul{
		list-style: none;
	    margin: 0;
	    padding: 0;
	}
	.comment-area-ul-li{
	    border-top: 1px solid #eee;
 	    border-bottom: 1px solid #eee;
	}
	.comment-area-write{
		margin-top: 40px;
	    padding: 20px;
	    border: 1px solid #ccbb;
	    background: linear-gradient(to bottom,#fff 0,#f4f4f4 100%);
	    border-radius: 20px;
	}
	
	.comment-area-write-content{
		padding:0;
		height:65px;
		display:flex;
		background: linear-gradient(to bottom,#fff 0,#f4f4f4 100%);
	}
	.comment-area-write-content-area{
		border: 1px solid #ccbb;
	    width: 100%;
	    height: 100%;
	    margin-right: 5px;
	    border-radius: 10px;
   		resize: none;
   		overflow: hidden;
	}
	textarea {
		outline:none;
		height:auto;
	}
	.comment-area-write-content-button{
		border: 1px solid #ccbb;
	    border-radius: 10px;
	}
	#uploaded-file img{
		width:100px;
		height:100px;
	}
	#uploaded-file {
		align-items:center;
		display:none;
		border:3px solid #ccbb;
		margin-top:20px;
	}
	
	#uploaded-file span{
	    margin: 20px;
	    border-radius: 5px;
	}
	a:hover{
		cursor:pointer;
	}
	.pageNum{
		display:flex;
		width:100%;
		justify-content:center;
		align-items:center;
		
	}
	.pageNum button{
		margin:5px;
	}
	.jListPageButton{
    	width:70px;
    	background-color:#f5f5f5;
    }
    .details-button{
    	display: felx;
    	flex-direction: row-reverse;
    }
</style>
<script>

	var liked;
	var mIdx = 0;
	
	<c:if test="${login != null}">
	mIdx = ${login.getmIdx()};
	</c:if>
	
	function adjustHeight() {
		  var textEle = $('textarea');
		  
		  $.each(textEle,function(index,item){
			  
		  var textEleHeight = $(item).prop('scrollHeight');
		  $(item).css('height', textEleHeight);
			  
		  })
		};	
	
	(function() {
		likedStatus();
		likeCount();
		adjustHeight();
	})()
	
	function likeCount(){
		$.ajax({
			type: "post",
			url: "likeCount.do",
			data:{
				aIdx:${vo.aIdx}
			},
			success : function(result){
				console.log(result);
				document.querySelector('#likeCount').innerText=result;
			}
		});
	}
	
	function likedStatus(){
		$.ajax({
			type: "post",
			url: "likedStatus.do",
			data:{
				mIdx: mIdx,
				aIdx:${vo.aIdx}
			},
			success: function(result) {
				if(result == 0){
					$(".board-content-like input").attr("class","normal-button");
					liked = 0;
				}else if(result == 1){
					$(".board-content-like input").attr("class","normal-button accent-button");
					liked = 1;
				}
			}
		});
	}
	
	function likedArtilces(){
		if(liked == 0){
			$.ajax({
				type: "post",
				url: "likedArticles.do",
				data: {
					mIdx: mIdx,
					bIdx: ${param.bIdx},
					aIdx: ${param.aIdx}
				},
				success: function(result){
					if (result == -1){
						console.log("이미 좋아요");
					}else if(result == 0){
						console.log("요류");
					}else if(result == 1){
						console.log("좋아요");
					}
					
					likedStatus();
					likeCount();
				}
			});
			
		} else if(liked == 1){
			$.ajax({
				type: "post",
				url: "unLikedArticles.do",
				data: {
					mIdx: mIdx,
					aIdx: ${param.aIdx}
				},
				success: function(result) {
					if (result == -1) {
						console.log("-1: 좋아요 안누름");
					} else if (result == 0) {
						console.log("0: 오류");
					} else if (result == 1) {
						console.log("1: 좋아요 취소");
					}
					
					likedStatus();
					likeCount();
				}
			});
		}
	}
	
	function commentList(obj){
		var page = 1;
		if(obj != null && obj != ''){
			page=obj;
			console.log(page);
		}
		
		var data2={
			bIdx:${param.bIdx},
			aIdx:${vo.aIdx},
			page:page
		}
		
		$.ajax({
			url:"commentList.do",
			type:"post",
			data:data2,
			success:function(list){
				console.log(list[0]);
				console.log(list[1]);
				var htmls="";
				
				if(list[1].length <1){
					htmls+="무플";
				} else {
					$.each(list[1],function(index,el){
						htmls+='<li class="comment-area-ul-li">'
						htmls+='<div class="comment-area-content">'
						htmls+='<div class="comment-area-content-toparea">'
						htmls+='<div class="comment-area-content-toparea-left">'
						htmls+='<a class="miniprofile" onclick="profileOpen('+el.mIdx+')"><img src="'+el.mProfileSrc+'" style="width:22.5px; height:100%;"/>'+el.mNickname+ " "+'</a>'
						htmls+='<a>'+el.regDate+" "+'</a><a onclick="commentReply('+el.cIdx+')">답글달기</a>';
						htmls+='</div>'
						htmls+='<div class="comment-area-content-toparea-right">'
						htmls+='<span></b></span>'
						htmls+='<span></b></span>'
						htmls+='</div>'
						htmls+='</div>'
						htmls+='<div class="comment-area-content-contentarea">'
						htmls+='<div style="resize: none;border:none;width:100%;word-break:break-all;" readonly >'+el.content+'<br>'
						if(el.picSrc != null){
						htmls+='<img src="'+el.picSrc+'" style="width:200px; height:100%; border:2px solid lightgray"/>'	
						}
						htmls+='</div>'
						htmls+='</div>'
						htmls+='</div>'
						htmls+='</li>'
						htmls+=''
					})
					var htmlss="";
					
					var cmtCount=list[0];
					var page=list[2];
					var startNum=page-(page-1)%5;
					var lastNum=Math.ceil(cmtCount/10);
					console.log(cmtCount);
					console.log(startNum);
					console.log(lastNum);
					
					if(startNum <= 1){
						var prev="none";
					} else {
						var prev="block";
					}
					if(startNum+5<=lastNum){
						var next="block";
					} else{
						var next="none";
					}
					
					
					htmlss+='<button onclick="commentList(1)" style="border-radius:10px;">첫페이지</button>'
					htmlss+='<button onclick="commentList('+(startNum-5)+')" style="border-radius:10px;display:'+prev+';">이전</button>'
					for(var i=0;i<5;i++){						
						if((startNum+i)<= lastNum){
							if(startNum+i == page){
							htmlss+='<button onclick="commentList('+(startNum+i)+')" style="color:lightgreen; border:2px solid lightgray; border-radius:10px;">'+(startNum+i)+'</button>'															
							} else{
							htmlss+='<button onclick="commentList('+(startNum+i)+')" style="color:#3796e8;border-radius:10px;";>'+(startNum+i)+'</button>'															
							}						
						}
					}
					htmlss+='<button onclick="commentList('+(startNum+5)+')" style="border-radius:10px;display:'+next+'";>다음</button>'
					htmlss+='<button onclick="commentList('+lastNum+')" style="border-radius:10px;">끝페이지</button>'
					
						/* <div>
							<form id="commentfile">
							<input type="hidden" name="aIdx" value="${param.aIdx}">
							<input type="hidden" name="bIdx" value="${param.bIdx}">
							<input type="hidden" name="mIdx" value="${login.mIdx}">
							<input type="hidden" name="mNickname" value="${login.nickname}">
							<label style="margin-bottom:10px">
								<strong style="padding-left:5px;">댓글 쓰기</strong>
							</label>
							<label style="margin-bottom:10px">
								<input type="file" id="file" name="commentSrc" style='display:none' onchange="bbbb(event)" accept="image/*">
								<label for="file">
									<a><strong>사진 올리기</strong></a>
								</label>
							</label>
							<div class="comment-area-write-content">
								<c:choose>
									<c:when test="${login.mIdx != null}">
										<textarea id="comment-write-content" name="content" class="comment-area-write-content-area"></textarea>
										<input id="comment-write-button" type="button" value="등록" class="comment-area-write-content-button" onclick="commentWrite('${login.mIdx}')">
									</c:when>
									<c:otherwise>
										<textarea id="comment-write-content"  class="comment-area-write-content-area" placeholder="댓글은 로그인 후 작성 가능합니다" onclick="location.href='/member/glogin.do'"></textarea>
										<input id="comment-write-button" type="button" value="등록" class="comment-area-write-content-button" disabled>
									</c:otherwise>
								</c:choose>
							</div>
							</form>
						</div>*/
				}
	
				$("#commentUl").html(htmls);
				$("#cmtPageNum").html(htmlss);
				$("#cmtTotal").html(list[0]);
			}
		});
		
		
	}
		
		
		
	function commentWrite(mIdx){
		var formData = new FormData($('#commentfile')[0]);
		
		var mIdx=0;
		
			if(mIdx != null){
				mIdx=mIdx;
			}
			
			console.log(formData);
		/* var data={
			bIdx:${param.bIdx},
			mIdx:mIdx,
			mNickname:"${login.nickname}",
			content:content,
			aIdx:${vo.aIdx},
			picsrc:"${login.profileSrc}"	
		} */
		
		$.ajax({
			url:"commentWrite.do",
			type:"post",
			data:formData,
			contentType: false,
			processData: false,
			success:function(result){
				if(result.result > 0){
					alert('댓글쓰기성공');
					$("#comment-write-content").val('');
					$("#uploaded-file").css('display','none');
					$("#uploaded-file>img").remove();
					commentList(result.lastPage);
				} else {
					console.log(result);
					alert('내용을 적어주세요');	
				}
			}
		});
		
		
	}
		
		function bbbb(event){
			var reader=new FileReader(); //파일리더 객체생성 
			
			reader.onload=function(event){ //onload 됐을 시 발생할 이벤트 추가
				var img=document.createElement("img");//요소생성
				img.setAttribute("src",event.target.result);//이 이벤트를 발생한 곳의 값을 따와서 설정
				document.querySelector("div#uploaded-file").appendChild(img);
				document.querySelector("div#uploaded-file").style.display='inline-flex';
				
			};
			
			reader.readAsDataURL(event.target.files[0]);

		}
		
		function commentReply(obj){
			console.log(obj);
		}
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-content">
			<div class="inner-box" style="margin-top:20px;">
				<div class="inner-box-content">
					<div class="board-area">
						<div class="board-area-toparea">
							<h4>
								<span>${vo.title }</span>
		  						<span class="board-area-toparea-date"><fmt:formatDate value="${vo.regDate}" pattern="yyyy-MM-dd hh:mm"/></span>
							</h4>
						</div>
						<div class="board-area-btmarea">
							<div class="board-area-btmarea-left">
								<a class="miniprofile" onclick="profileOpen('${vo.mIdx}')">
									<img src="${profileSrc}" style="width:22.5px; height:100%;"/>
									${vo.mNickname}							
								</a>
							</div>
							<div class="board-area-btmarea-right">
								<span>조회수: <b>${vo.readCount}</b></span>
								<span>추천수: <b id="likeCount"></b></span>
							</div>
						</div>
					</div>
					<div class="board-area-content">
						${vo.content}
						<div class="board-content-like">
							<input type="button" id="like-button" class="normal-button" style="width:70px;" onclick="likedArtilces()" value="추천">
						</div>
					</div>
				</div>
				<div class="details-button">
					<form action="delete.do">
						<input type="hidden" name="aIdx" value="${param.aIdx}">
						<input type="hidden" name="bIdx" value="${param.bIdx}">
						<input type="hidden" name="mIdx" value="${vo.mIdx}">
						<c:if test="${login.mIdx == vo.mIdx}">
							<button class="normal-button" id="delete" style="margin-left: 15px;">삭제</button>
						</c:if>	
					</form>
					<form action="update.do" method="get">
						<input type="hidden" name="aIdx" value="${param.aIdx}">
						<input type="hidden" name="bIdx" value="${param.bIdx}">
						<c:if test="${login.mIdx == vo.mIdx}">
							<button class="normal-button accent-button" id="update" style="margin-left: 15px;">수정</button>
						</c:if>	
					</form>
				</div>
				<!-- 댓글영역 -->
				<div class="comment-area">
					<div class="comment-area-total">
						<span>댓글 <b id="cmtTotal"> ${cmtCount} </b> 개</span>
					</div>
					<!--  댓글 리스트 -->
					<ul class="comment-area-ul" id="commentUl">
						<c:set var="cmtTotal" value="${cmtCount}"/>
						<c:set var="page" value="${page}"/>
						<c:set var="startNum" value="${page-(page-1)%5}"/>	
						<c:set var="lastNum" value="${fn:substringBefore(Math.ceil(cmtTotal/10),'.')}"/>
						<c:if test="${fn:length(cmtList) gt 0}">
							<c:forEach var="item" items="${cmtList}">
							<li class="comment-area-ul-li">
								<div class="comment-area-content">
									<div class="comment-area-content-toparea">
							 			<div class="comment-area-content-toparea-left">
							 				<a class="miniprofile" onclick="profileOpen('${item.mIdx}')"><img src="${item.mProfileSrc}" style="width:22.5px; height:100%;"/>${item.mNickname}</a>
							 				<a><fmt:formatDate value="${item.regDate}" pattern="YY-MM-dd HH:mm:ss"/></a>
							 				<a onclick="commentReply()">답글달기</a>
							 			</div>
										<div class="comment-area-content-toparea-right">
										</div>
								 	</div>
							 		<div class="comment-area-content-contentarea">
								 		<div style="resize: none;border:none;width:100%;word-break:break-all;" readonly >${item.content}<br>
											<c:if test="${item.picSrc ne null}">
									 			<img src="${item.picSrc}" style="width:200px; height:100%; border:2px solid lightgray"/>
											</c:if>
										</div>
									</div>
								</div>
							 </li>
							</c:forEach>
						</c:if>
					</ul>
					<!-- 댓글 페이징 -->
					<c:if test="${fn:length(cmtList) gt 0}">
					<div id="cmtPageNum" class="pageNum">	
						<button onclick="commentList(1)" style="border-radius:10px;">첫페이지</button>
						<button onclick="commentList('${startNum-5}')" style="border-radius:10px;display:${(startNum<=1)?'none':'block'};">이전</button>
						<c:forEach var="i" begin="0" end="4">
							<c:if test="${(startNum+i)<= lastNum}">
								<button onclick="commentList('${startNum+i}')" style="color:${(startNum+i)== page ?'lightgreen; border:2px solid lightgray; border-radius:10px;':'#3796e8;border-radius:10px'}">${startNum+i}</button>
							</c:if>
						</c:forEach>
						<button onclick="commentList('${startNum+5}')" style="border-radius:10px;display:${(startNum+5<=lastNum)?'block':'none'};">다음</button>
						<button onclick="commentList('${page}')" style="border-radius:10px;">끝페이지</button>
					</div>
					</c:if>
					<!-- 댓글 등록 -->
					<div id="uploaded-file">
						<span><b>업로드된사진</b></span>
					</div>
					<div class="comment-area-write">
						<form id="commentfile">
							<input type="hidden" name="aIdx" value="${param.aIdx}">
							<input type="hidden" name="bIdx" value="${param.bIdx}">
							<input type="hidden" name="mIdx" value="${login.mIdx}">
							<input type="hidden" name="mNickname" value="${login.nickname}">
							<label style="margin-bottom:10px">
								<strong style="padding-left:5px;">댓글 쓰기</strong>
							</label>
							<label style="margin-bottom:10px">
								<input type="file" id="file" name="commentSrc" style='display:none' onchange="bbbb(event)" accept="image/*">
								<label for="file">
									<a><strong>사진 올리기</strong></a>
								</label>
							</label>
							<div class="comment-area-write-content">
								<c:choose>
									<c:when test="${login.mIdx != null}">
										<textarea id="comment-write-content" name="content" class="comment-area-write-content-area"></textarea>
										<input id="comment-write-button" type="button" value="등록" class="comment-area-write-content-button" onclick="commentWrite('${login.mIdx}')">
									</c:when>
									<c:otherwise>
										<textarea id="comment-write-content"  class="comment-area-write-content-area" placeholder="댓글은 로그인 후 작성 가능합니다" onclick="location.href='/member/glogin.do'"></textarea>
										<input id="comment-write-button" type="button" value="등록" class="comment-area-write-content-button" disabled>
									</c:otherwise>
								</c:choose>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/footer.do" />
</body>
</html>