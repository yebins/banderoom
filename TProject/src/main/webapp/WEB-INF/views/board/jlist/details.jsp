<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
		commentList();
		adjustHeight();
	})()
	
	function likeCount(){
		$.ajax({
			type: "post",
			url: "/board/likeCount.do",
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
			url: "/board/likedStatus.do",
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
				url: "/board/likedArticles.do",
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
				url: "/board/unLikedArticles.do",
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
		if(obj != null){
			page=$(obj).text();
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
				var htmls="";
				if(list.length <1){
					htmls+="무플";
				} else {
					$.each(list,function(index,el){
						console.log(el.mNickname);
						htmls+='<li class="comment-area-ul-li">'
						htmls+='<div class="comment-area-content">'
						htmls+='<div class="comment-area-content-toparea">'
						htmls+='<div class="comment-area-content-toparea-left">'
						htmls+='<a class="miniprofile" onclick="profileOpen('+el.mIdx+')"><img src="'+el.picSrc+'" style="width:22.5px; height:100%;"/>'+el.mNickname+'</a>'
						htmls+='</div>'
						htmls+='<div class="comment-area-conten-toparea-right">'
						htmls+='<span></b></span>'
						htmls+='<span></b></span>'
						htmls+='</div>'
						htmls+='</div>'
						htmls+='<div class="comment-area-content-contentarea">'
						htmls+='<div style="resize: none;border:none;width:100%;" readonly>'+el.content+'</div>'
						htmls+='</div>'
						htmls+='</div>'
						htmls+='</li>'
					})
				}
				
				$("#commentUl").html(htmls);
			}
		});
		
		
	}
		
		var i = ${cmtCount};
		
	function commentWrite(obj){
		var mIdx=0;
		var content=document.querySelector("#comment-write-content").value;
			if(obj != null){
				mIdx=obj;
			}
			
		var data={
			bIdx:${param.bIdx},
			mIdx:mIdx,
			mNickname:"${login.nickname}",
			content:content,
			aIdx:${vo.aIdx},
			picsrc:"${login.profileSrc}"	
		}
		
		$.ajax({
			url:"commentWrite.do",
			type:"post",
			data:data,
			success:function(result){
				if(result > 0){
					console.log(i);
					$("#cmtTotal").text(" "+(i+1)+" ");
					alert('댓글쓰기성공');
					$("#comment-write-content").val('');
					i++;
				}
					commentList();
			}
		});
		
		
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
		  						<span class="board-area-toparea-date"><fmt:formatDate value="${vo.regdate}" pattern="yyyy-MM-dd hh:mm"/></span>
							</h4>
						</div>
						<div class="board-area-btmarea">
							<div class="board-area-btmarea-left">
								<a href="">
									<img src="${profileSrc}" style="width:22.5px; height:100%;"/>
									${vo.mnickname}							
								</a>
							</div>
							<div class="board-area-btmarea-right">
								<span>조회수: <b>${vo.readcount}</b></span>
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
					<%-- <form action="delete.do">
						<input type="hidden" name="aIdx" value="${param.aIdx}">
						<input type="hidden" name="bIdx" value="${param.bIdx}">
						<input type="hidden" name="mIdx" value="${vo.mIdx}">
						<c:if test="${login.mIdx != vo.mIdx}">
							<button class="normal-button" id="delete" style="margin-left: 15px;">삭제</button>
						</c:if>	
					</form>
					<form action="update.do" method="get">
						<input type="hidden" name="aIdx" value="${param.aIdx}">
						<input type="hidden" name="bIdx" value="${param.bIdx}">
						<c:if test="${login.mIdx == vo.mIdx}">
							<button class="normal-button accent-button" id="update" style="margin-left: 15px;">수정</button>
						</c:if>	
					</form> --%>
				</div>
				<div class="comment-area">
					<div class="comment-area-total">
						<span>댓글<b id="cmtTotal"> ${cmtCount} </b>개</span>
					</div>
					<ul class="comment-area-ul" id="commentUl">
						<%-- <li class="comment-area-ul-li">
							<div class="comment-area-content">
								<div class="comment-area-content-toparea">
									<div class="comment-area-content-toparea-left">
										<a href="">
											<img src="" style="width:22.5px; height:100%;"/>
											${vo.mnickname}							
										</a>
									</div>
									<div class="comment-area-conten-toparea-right">
										<span>추천<b> 1 </b></span>
										<span>비추천<b> 2 </b></span>
									</div>
								</div>
								<div class="comment-area-content-contentarea">
								<textarea style="resize: none;border:none;width:100%;" readonly></textarea>
								</div>
							</div>
						</li> --%>
					</ul>
					<div class="comment-area-write">
						<label style="margin-bottom:10px">
							<strong style="padding-left:5px;">댓글 쓰기</strong>
						</label>
						<div class="comment-area-write-content">
							<c:choose>
								<c:when test="${login.mIdx != null}">
									<textarea id="comment-write-content" class="comment-area-write-content-area"></textarea>
									<input id="comment-write-button" type="button" value="등록" class="comment-area-write-content-button" onclick="commentWrite('${login.mIdx}')">
								</c:when>
								<c:otherwise>
									<textarea id="comment-write-content" class="comment-area-write-content-area" placeholder="댓글은 로그인 후 작성 가능합니다" onclick="location.href='/member/glogin.do'"></textarea>
									<input id="comment-write-button" type="button" value="등록" class="comment-area-write-content-button" onclick="commentWrite('${login.mIdx}')" disabled>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/footer.do" />
</body>
</html>