<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>
	${vo.title}
</title>
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
		p
		
	}
	.comment-area-content-contentarea{
		padding-top:10px;
	}
	.comment-area-content{
	}
	.comment-area-content-bottomarea{
		display:flex;
		justify-content:end;
		align-items:center;
		height:30px;
	}
	.comment-area-content-bottomarea a:nth-of-type(1){
		justify-self:start;
	}
	.comment-area-content-bottomarea a{
		margin-left:10px;
	}
	.comment-area-ul{
		list-style: none;
	    margin: 0;
	    padding: 0;
	}
	.comment-area-ul-li{
	    border-top: 1px solid #eee;
 	    border-bottom: 1px solid #eee;
 	    padding:20px;
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
	.comment-area-content-contentarea img{
		width:200px;
		height:100%;
	}
	textarea {
		outline:none;
		height:auto;
	}
	.comment-area-write-content-button{
		background-color:#fb6544;
		color:white;
		border: 1px solid #ccbb;
	    border-radius: 10px;
	}
	.uploaded-file img{
		width:100px;
		height:100px;
	}
	.uploaded-file {
		align-items:center;
		display:none;
		border:3px solid #ccbb;
		margin-top:20px;
	}
	
	.uploaded-file span{
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
    	display:flex;
    	flex-direction: row-reverse;
    	padding-right:20px;
    }
   	
   	.commentModify{
   		display:block;
   	}
   	.commentHidden{
   		display:none;
   	}
   	.prev-next{
   		width:100%;
   	}
   	tr{
   		text-align:center;
   	}
   	.title-area{
		display:flex;
		justfy-content:center;
		margin-left:30px;
		}
   	.reg-date{
   		font-size: 14px;
    	color: darkgray;
   	}
   	.top-reg-date{
   		font-size: 14px;
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
		background-color: #2A3F6A;
		font-weight: bold;
	}
	.psrc{
		border-radius:12.5px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		width:25px;
		margin-right:10px;
	}
	.countSpan{
		font-size:14px;
	}
	img{
		cursor:pointer;
	}
	html body .imgExtend{
		width:100%;
		z-index:10000;
		display:flex;
		justify-content:center;
		margin:auto;
		top:0;
		left:0;
		position:fixed;
		height:100%;
	}
	.IED > img{
		max-width:100%;
		height:600px;
	}
	.IED{
		padding-top:50px;
		padding-bottom:50px;
		display:none;
		background: rgb(0 0 0 / 80%);
	}
	pre{
	    width: 100%;
  	  font-family: system-ui;
  	  word-break: break-all;
 	   white-space: pre-wrap;
	}
	.page-nav-button.current-page{
		background-color: #2A3F6A;
		color: #F5F5F5;
	}
</style>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.3/moment.min.js"></script>
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
	// 댓글리스트 불러오기
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
				console.log(list[2]);
				console.log(list[3]);
				console.log(list[4]);
				var htmls="";
				
				if(list[1].length <1){
				} else {
					$.each(list[1],function(index,el){
						var cIdx=el.cIdx;
						if(list[4][el.cIdx].length > 0 || el.status != 1){
						htmls+='<li class="comment-area-ul-li">'
						htmls+='<div class="comment-area-content">'
						htmls+='<div class="comment-area-content-toparea">'
						htmls+='<div class="comment-area-content-toparea-left">'
						if(el.status != 1){							
							htmls+='<a class="miniprofile" onclick="profileOpen('+el.mIdx+')"><img src="el.mProfileSrc+'" class="psrc"/>'
							if('${vo.mNickname}' == el.mNickname){
							htmls+='<span style="font-weight:600;color:blue;">'+el.mNickname+ "  "+'</span></a>'														
							} else{
							htmls+='<span style="font-weight:600">'+el.mNickname+ "  "+'</span></a>'							
							}
						}
						htmls+='</div>'
						htmls+='<div class="comment-area-content-toparea-right">'
						htmls+='<a class="reg-date">'
						htmls+=moment(new Date(el.regDate)).format("YY-MM-DD HH:mm:ss ")
						htmls+='</a>'
						htmls+='</div>'
						htmls+='</div>'
						htmls+='<div class="comment-area-content-contentarea">'
						if(el.status != 1){
						htmls+='<div style="resize: none;border:none;width:100%;" readonly ><pre>'+el.content+'</pre><br>'							
						if(el.picSrc != null){
						htmls+='<img src="<%=request.getContextPath() %>'+el.picSrc+'" style="width:200px; height:100%; border:2px solid lightgray;margin-top:10px;margin-bottom:10px"/>'	
							}
						} else {
							htmls+='<div style="resize: none;border:none;width:100%;word-break:break-all; font-weight:bold;" readonly >삭제된댓글입니다.<br></div>'
						}
						htmls+='</div>'
						htmls+='</div>'
						htmls+='<div class="comment-area-content-bottomarea">'
						if(el.status != 1){
							htmls+='<a onclick="commentReply('+el.cIdx+')">답글</a>';
						}
						if(el.mIdx == mIdx || mIdx == 4){
							if(el.status != 1){
						htmls+='<a onclick="commentModify('+el.cIdx+')"> 수정 </a>';															
						htmls+='<a onclick="commentDelete('+el.cIdx+')"> 삭제 </a>';							
								}
							}
						htmls+='</div>'
						htmls+='</div>'
						htmls+='</li>'
							/* 수정하기 */				
							htmls+='<div id="commentModify'+el.cIdx+'" class="commentHidden">'
						 	htmls+='<div class="comment-area-write">'
						 	htmls+='<div id="uploaded-file'+el.cIdx+'" class="uploaded-file">'
							htmls+='<span><b>업로드된사진</b></span>'
								if(el.picSrc != null){
								 htmls+='<img src="<%=request.getContextPath() %>'+el.picSrc+'" style="width:200px; height:100%; border:2px solid lightgray"/>'
									}
							htmls+='</div>'
							htmls+='<form id="commentfile'+el.cIdx+'">'
							htmls+='<input type="hidden" name="fileChange" value="0">'
							htmls+='<input type="hidden" name="aIdx" value="'+el.aIdx+'">'
							htmls+='<input type="hidden" name="bIdx" value="'+el.bIdx+'">'
							htmls+='<input type="hidden" name="cIdx" value="'+el.cIdx+'">'
							htmls+='<input type="hidden" name="mIdx" value="${login.mIdx}">'
							htmls+='<input type="hidden" name="mNickname" value="${login.nickname}">'
							htmls+='<input type="hidden" name="status" value="'+el.status+'">'
							htmls+='<label style="margin-bottom:10px">'
							htmls+='<input type="file" id="file'+el.cIdx+'" name="commentSrc" style="display:none" onchange="preview(event,'+el.cIdx+',this)" accept="image/*">'
							htmls+='<label for="file'+el.cIdx+'">'
								if(el.picSrc != null){
							htmls+='<a> <strong>사진 변경하기</strong></a>'
								} else{
							htmls+='<a><img src="<%=request.getContextPath() %>/images/picture-button.png" style="width:20px;margin-left:10px;padding-bottom:5px;" class="npic"/></a>'								
								}
							htmls+='</label>'
							htmls+='</label>'
							htmls+='<div class="comment-area-write-content">'
							htmls+='<textarea id="comment-write-content'+el.cIdx+'" name="content" class="comment-area-write-content-area">'+el.content+'</textarea>'
							htmls+='<input id="comment-write-button'+el.cIdx+'" type="button" value="수정" class="comment-area-write-content-button" onclick="commentUpdate(${login.mIdx},'+el.cIdx+')">'
							htmls+='</div>'
							htmls+='</form>'
							htmls+='</div>'
							htmls+='</div>'
								/* 답글달기 */
								htmls+='<div id="replyWrite'+el.cIdx+'" class="commentHidden">'
								htmls+='<div class="comment-area-write comment-area-write'+el.cIdx+'" id="write-area-write_id">'
								htmls+='<div id="reply-uploaded-file'+el.cIdx+'" class="uploaded-file">'
								htmls+='<span><b>업로드된사진</b></span>'
								htmls+='</div>'
								htmls+='<form id="replyFile'+el.cIdx+'">'
								htmls+='<input type="hidden" name="mIdx" value="${login.mIdx}">'
								htmls+='<input type="hidden" name="cIdx" value="'+el.cIdx+'">'
								htmls+='<input type="hidden" name="mNickname" value="${login.nickname}">'
								htmls+='<label style="margin-bottom:10px">'
								htmls+='<input type="file" id="reply-file'+el.cIdx+'" name="commentSrc" style="display:none" onchange="replyPreview(event,'+el.cIdx+',this)" accept="image/*">'
								htmls+='<label for="reply-file'+el.cIdx+'">'
								htmls+='</label>'
								htmls+='<a><img src="<%=request.getContextPath() %>/images/picture-button.png" style="width:20px;margin-left:10px;padding-bottom:5px;" class="npic"></a>'											
								htmls+='</label>'
								htmls+='<div class="comment-area-write-content">'
								htmls+='<textarea id="reply-write-content'+el.cIdx+'" name="content" class="comment-area-write-content-area"></textarea>'
								htmls+='<input id="reply-write-button'+el.cIdx+'" type="button" value="등록" class="comment-area-write-content-button" onclick="replyWrite('+el.cIdx+','+list[2]+')">'
								htmls+='</div>'
							 	htmls+='</form>'
								htmls+='</div>'
								htmls+='</div>'
						console.log('대댓글리스트'+Object.keys(list[4]).length);
						if(Object.keys(list[4]).length > 0){
								$.each(list[4][el.cIdx],function(index,rl){
								htmls+='<li class="comment-area-ul-li" style="margin-left:40px;">'
								htmls+='<div class="comment-area-content">'
								htmls+='<div class="comment-area-content-toparea">'
								htmls+='<div class="comment-area-content-toparea-left">'
								htmls+='<a class="miniprofile" onclick="profileOpen('+rl.mIdx+')">'
								if(rl.mProfileSrc != null){
								htmls+='<img src="" class="psrc"/>'
								} else{
								htmls+='<img src="<%=request.getContextPath() %>/images/profile_default.png" class="psrc"/>'
								}
								if(rl.mNickname == '${vo.mNickname}'){
								htmls+='<span style="font-weight:600; color:blue">'+rl.mNickname+" "+'</span></a>'																		
								} else{
								htmls+='<span style="font-weight:600;">'+rl.mNickname+" "+'</span></a>'																											
								}
								htmls+='</div>'
								htmls+='<div class="comment-area-content-toparea-right">'
								htmls+='<a class="reg-date">'
								htmls+=moment(new Date(rl.regDate)).format("YY-MM-DD HH:mm:ss ")
								htmls+='</a>'
								htmls+='</div>'
								htmls+='</div>'
								htmls+='<div class="comment-area-content-contentarea">'
								htmls+='<div style="resize: none;border:none;width:100%;"readonly ><pre>'+rl.content+'</pre><br>'
								if(rl.picSrc != null){
								htmls+='<img src="<%=request.getContextPath() %>'+rl.picSrc+'" style="width:200px; height:100%; border:2px solid lightgray"/>'							
								}
								htmls+='</div>'
								htmls+='</div>'
								htmls+='<div class="comment-area-content-bottomarea">'
									if(rl.mIdx == mIdx || mIdx == 4){										
										htmls+='<a onclick="replyModify('+rl.rIdx+')"> 수정 </a>'						
										htmls+='<a onclick="replyDelete('+rl.rIdx+','+list[2]+','+rl.mIdx+')"> 삭제 </a>'						
									}
								htmls+='</div>'
								htmls+='</div>'
								htmls+='</li>'
								//답글 수정하기 박스
								htmls+='<div id="replyModify'+rl.rIdx+'" class="commentHidden">'
								htmls+='<div class="comment-area-write">'
								htmls+='<div id="reply-uploaded-file'+rl.rIdx+'" class="uploaded-file">'
								htmls+='<span><b>업로드된사진</b></span>'
								if(rl.picSrc != null){
								htmls+='<img src="<%=request.getContextPath() %>'+rl.picSrc+'" style="width:200px; height:100%; border:2px solid lightgray"/>'
								}
								htmls+='</div>'
								htmls+='<form id="replyfile'+rl.rIdx+'">'
								htmls+='<input type="hidden" name="fileChange" value="0">'
								htmls+='<input type="hidden" name="mIdx" value="${login.mIdx}">'
								htmls+='<input type="hidden" name="rIdx" value="' + rl.rIdx + '">'
								htmls+='<input type="hidden" name="mNickname" value="${login.nickname}">'
								htmls+='<label style="margin-bottom:10px">'
								htmls+='<input type="file" id="reply-file'+rl.rIdx+'" name="commentSrc" style="display:none" onchange="replyPreview(event,'+rl.rIdx+',this)" accept="image/*">'
								htmls+='<label for="reply-file'+rl.rIdx+'">'
									if(rl.picSrc != null){
								htmls+='<a> <strong>사진 변경하기</strong></a>'
									} else{
								htmls+='<a><img src="<%=request.getContextPath() %>/images/picture-button.png" style="width:20px;margin-left:10px;padding-bottom:5px;" class="npic"/></a>'								
									}
								htmls+='</label>'
								htmls+='</label>'
								htmls+='<div class="comment-area-write-content">'
								htmls+='<textarea id="reply-write-content'+rl.rIdx+'" name="content" class="comment-area-write-content-area">'+rl.content+'</textarea>'
								htmls+='<input id="reply-write-button'+rl.rIdx+'" type="button" value="수정" class="comment-area-write-content-button" onclick="replyUpdate(${login.mIdx},'+rl.rIdx+',this)">'
								htmls+='</div>'
								htmls+='</form>'
								htmls+='</div>'
								htmls+='</div>'
								
								})
						}
						}
						
					})
					var htmlss="";
					
					var cmtCount=list[3];
					var page=list[2];
					var startNum=page-(page-1)%5;
					var lastNum=Math.ceil(cmtCount/10);
					console.log(cmtCount);
					console.log(startNum);
					console.log(lastNum);
					
					if(page>5){
					htmlss+='<button onclick="commentList(1)" class="page-nav-button">1</button>'						
					}
					htmlss+='<button onclick="commentList('+(startNum-5)+')" class="page-nav-button"'
					if(startNum <= 1){
					htmlss+='style="display:none"'
					}
					htmlss+='>◀</button>'
					for(var i=0;i<5;i++){						
						if((startNum+i)<= lastNum){
							if(startNum+i == page){
							htmlss+='<button onclick="commentList('+(startNum+i)+')" class="page-nav-button current-page">'+(startNum+i)+'</button>'															
							} else{
							htmlss+='<button onclick="commentList('+(startNum+i)+')" class="page-nav-button">'+(startNum+i)+'</button>'															
							}						
						}
					}
					htmlss+='<button onclick="commentList('+(startNum+5)+')" class="page-nav-button"'
					console.log(startNum+5);
					console.log(lastNum);
					if((startNum+5) > lastNum){
					htmlss+='style="display:none"'
					}
					htmlss+='>▶</button>'
					if((lastNum-5)>=page){
					htmlss+='<button onclick="commentList('+lastNum+')" class="page-nav-button">'+lastNum+'</button>'						
					}
					
						
				}
	
				$("#commentUl").html(htmls);
				$("#cmtPageNum").html(htmlss);
				$("#cmtTotal").html(list[0]);
				caa();
			}
		});
		
		
	}
		
		
	//댓글 쓰기 
	function commentWrite(aIdx){
		var formData = new FormData($('#commentfile')[0]);
		
	/* 	var mIdx=0;
		
			if(mIdx != null){
				mIdx=mIdx;
			} */
			
			console.log(formData);
			console.log(formData.content);
		
		$.ajax({
			url:"commentWrite.do",
			type:"post",
			data:formData,
			contentType: false,
			processData: false,
			success:function(result){
				if(result.result == 1){
					alert('댓글쓰기성공');
					$("#comment-write-content").val('');
					$("#uploaded-file").css('display','none');
					$("#uploaded-file>img").remove();
					$("#file").val('');
					commentList(result.lastPage);
				} else {
					console.log(result);
					alert('댓글을 작성할 수 없습니다.');	
				}
			}
		});
		
		
	}
	//답글 쓰기 
	function replyWrite(cIdx,page){
		
		if ($("#reply-write-content" + cIdx).val() == '') {
			alert('내용을 입력해 주세요.')
			return;
		}
		
		var tg="replyFile"+cIdx;
		var formData = new FormData($('#'+tg)[0]);
		
		console.log(tg)
// 		var mIdx=0;
		
// 			if(mIdx != null){
// 				mIdx=mIdx;
// 			}
		
		$.ajax({
			url:"replyWrite.do",
			type:"post",
			data:formData,
			contentType: false,
			processData: false,
			success:function(result){
				if(result==1){
					alert('답글쓰기성공');
					var wc="reply-write-content"+cIdx;
					var wuf="reply-uploaded-file"+cIdx;
					var wufi="reply-uploaded-file>img"+cIdx;
					var rf="reply-file"+cIdx;
					var formID="replyWrite"+cIdx;
					$('#'+rf).val(null);
					$('#'+wc).val('');
					$('#'+wuf).css('display','none');
					$('#'+wufi).remove();
					$('#'+tg).val('');
					$('#'+formID).addClass('commentHidden')
					
				} else if(result == 2){
					alert('할수 없습니다.')
				}else if(result == 3){
					alert('로그인 후 이용하세요.')
				} else {
					alert('내용을 적어주세요');	
				}
				console.log("page"+page);
			commentList(page);
			}
		});
		
	}
	
	function replyDelete(rIdx,page,mIdx){
		var data={
			rIdx:rIdx,
			mIdx:mIdx
		};
		
		
		$.ajax({
			url:"replyDelete.do",
			type:"post",
			data:data,
			success:function(result){
				if(result==1){
					alert('삭제되었습니다.')
				}else if(result == 2){
					alert('삭제할수 없습니다.')
				}else{
					alert('작성자가 아닙니다');
				}
			commentList(page);
			}
		});
	}
	//댓글 수정하기
	function commentUpdate(mIdx,cIdx){
		var formTG="commentfile"+cIdx;
		var formData = new FormData($('#'+formTG)[0]);
		
// 		var mIdx=0;
		
// 			if(mIdx != null){
// 				mIdx=mIdx;
// 			}
			
		$.ajax({
			url:"commentUpdate.do",
			type:"post",
			data:formData,
			contentType: false,
			processData: false,
			success:function(result){
				 	if(result == 1){
				 	console.log(result);
					alert('댓글수정성공');
					commentList('${page}');	
				} else if(result == 2){
					alert('수정할수 없습니다.')
				}else{
					 alert('수정실패');
				}
			}
		});
		
		
	}
	//답글수정하기
	function replyUpdate(mIdx,rIdx,obj){
		var formTG="replyfile"+rIdx;
		var formData = new FormData($('#'+formTG)[0]);
		
// 		var mIdx=0;
		
// 			if(mIdx != null){
// 				mIdx=mIdx;
// 			}
			
		
		$.ajax({
			url:"replyUpdate.do",
			type:"post",
			data:formData,
			contentType: false,
			processData: false,
			success:function(result){
				 	if(result == 1){
				 	console.log(result);
					alert('댓글수정성공');
					commentList('${page}');	
				} else if(result == 2){
					alert('수정할수 없습니다.')
				}else{
					 alert('수정실패');
				}
			}
		});
		
		
	}
		//사진미리보기
		function preview(event,cIdx,obj){
			var fileChange=$(obj).parent().parent().children().first();
			fileChange.val('1');
			
			if(cIdx != null){
			var id="uploaded-file"+cIdx;
			var ds="uploaded-file"+cIdx+">img";
				$('#'+ds).remove();
				
			} else {
			var	id="uploaded-file";
			var ds="uploaded-file>img";
				$('#'+ds).remove();
			}
			
			var reader=new FileReader(); //파일리더 객체생성 
			reader.onload=function(event){ //onload 됐을 시 발생할 이벤트 추가
				var img=document.createElement("img");//요소생성
				img.setAttribute("src",event.target.result);//이 이벤트를 발생한 곳의 값을 따와서 설정
				img.addEventListener("click",(e)=>{
					$(e.target).remove();
					fileChange.val('1');
				})
				document.querySelector('#'+id).appendChild(img);
				document.querySelector('#'+id).style.display='inline-flex';
				
			};
			
			reader.readAsDataURL(event.target.files[0]);

		}
		//답글사진미리보기
		function replyPreview(event,rIdx,obj){
			var fileChange=$(obj).parent().parent().children().first();
			fileChange.val('1');
			
			if(rIdx != null){
			var id="reply-uploaded-file"+rIdx;
			var ds="reply-uploaded-file"+rIdx+">img";
				$('#'+ds).remove();
				
			} else {
			var	id="reply-uploaded-file";
			var ds="reply-uploaded-file>img";
				$('#'+ds).remove();
			}
			
			var reader=new FileReader(); //파일리더 객체생성 
			reader.onload=function(event){ //onload 됐을 시 발생할 이벤트 추가
				var img=document.createElement("img");//요소생성
				img.setAttribute("src",event.target.result);//이 이벤트를 발생한 곳의 값을 따와서 설정
				img.addEventListener("click",(e)=>{
					$(e.target).remove();
					fileChange.val('1');
				});
				document.querySelector('#'+id).appendChild(img);
				document.querySelector('#'+id).style.display='inline-flex';
				
			};
			
			reader.readAsDataURL(event.target.files[0]);

		}	
		//답글 달기버튼
		function commentReply(obj){
			var id = "replyWrite"+obj;
			let replyID = $('#'+id);
			if(replyID.hasClass('commentHidden')){
				replyID.removeClass('commentHidden')
				replyID.addClass('commentModify');
			} else {
				replyID.addClass('commentHidden');				
				replyID.removeClass('commentModify');
			}
			
		}
		
		//댓글 수정버튼
		function commentModify(obj){
			var a ="commentModify"+obj;
			var bb="uploaded-file"+obj;
			var cc="file"+obj;
			$('#'+bb+'>img').click(function (){
				$(this).remove();
				var cmt="commentfile"+obj;
				console.log($('#'+cmt).children('input[name=fileChange]').val('1'));
			});
			$('#'+bb).css("display","inline-flex");
			let aa=$('#'+a);
			if(aa.hasClass('commentHidden')){
				aa.removeClass('commentHidden')
				aa.addClass('commentModify');
			} else {
				aa.addClass('commentHidden');				
				aa.removeClass('commentModify');
			}
			
		}
		//답글 수정버튼
		function replyModify(obj){
			var a ="replyModify"+obj;
			var bb="reply-uploaded-file"+obj;
			var cc="replyfile"+obj;
			$('#'+bb+'>img').click(function (){
				$(this).remove();
				var cmt="replyfile"+obj;
				console.log($('#'+cmt).children('input[name=fileChange]').val('1'));
			});
			$('#'+bb).css("display","inline-flex");
			let aa=$('#'+a);
			if(aa.hasClass('commentHidden')){
				aa.removeClass('commentHidden')
				aa.addClass('commentModify');
			} else {
				aa.addClass('commentHidden');				
				aa.removeClass('commentModify');
			}
			
		}
		
		//댓글 삭제하기
		
		function commentDelete(cIdx){
			console.log(cIdx);
			
			$.ajax({
				url:"commentDelete.do",
				type:"post",
				data:{cIdx:cIdx,
					mIdx:mIdx},
				success:function(result){
					console.log(result)
					if(result == 1){
						alert("삭제되었습니다.");
						commentList('${page}');	
					}else {
						alert('할수 없습니다.')
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
		<div id="page-content">
			<div class="inner-box" style="margin-top:20px;">
				<div class="inner-box-content">
					<div class="board-area">
						<div class="board-area-toparea">
								<c:if test="${vo.bIdx == 3}">
									<c:choose>
										<c:when test="${vo.status == 97}">
											<span>[판매]</span>
										</c:when>
										<c:when test="${vo.status == 98 }">
											<span>[구매]</span>
										</c:when>
										<c:when test="${vo.status == 99 }">
											<span>[거래완료]</span>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
								</c:if>
							<h4>
								<span>${vo.title}</span>
		  						<span class="top-reg-date"><fmt:formatDate value="${vo.regDate}" pattern="yyyy-MM-dd hh:mm"/></span>
							</h4>
						</div>
						<div class="board-area-btmarea">
							<div class="board-area-btmarea-left">
								<a class="miniprofile" onclick="profileOpen('${vo.mIdx}')" style="display:flex">
									<img src="${profileSrc}" class="psrc"/>
									<span style="font-weight:600;align-self:center;">${vo.mNickname}</span>						
								</a>
							</div>
							<div>
							</div>
							<div class="board-area-btmarea-right">
								<span class="countSpan">조회수: <b>${vo.readCount}</b></span>
								<span class="countSpan">추천수: <b id="likeCount"></b></span>
								
							</div>
						</div>
					</div>
					<div class="board-area-content">
						${vo.content}
						<c:if test="${login != null}">
							<div class="board-content-like">
								<input type="button" id="like-button" class="normal-button" style="width:70px;" onclick="likedArtilces()" value="추천">
							</div>
						</c:if>
					</div>
				</div>
				<div class="details-button">
					 <form action="delete.do">
						<input type="hidden" name="aIdx" value="${param.aIdx}">
						<input type="hidden" name="bIdx" value="${param.bIdx}">
						<input type="hidden" name="mIdx" value="${vo.mIdx}">
						<c:if test="${login.mIdx eq vo.mIdx || login.auth == 3}">
							<button class="normal-button" id="delete" style="margin-left: 15px;" onclick="confirm('삭제하시겠습니까?')">삭제</button>
						</c:if>	
					</form>
					<form action="update.do" method="get">
						<input type="hidden" name="aIdx" value="${param.aIdx}">
						<input type="hidden" name="bIdx" value="${param.bIdx}">
						<input type="hidden" name="page" value="${param.page}">
						<c:if test="${login.mIdx eq vo.mIdx || login.auth == 3}">
							<button class="normal-button accent-button" id="update" style="margin-left: 15px;">수정</button>
						</c:if>	
					</form> 
					<div>
						<button class="normal-button" style="margin-left: 15px;" onclick="location.href='<%=request.getContextPath() %>/board/list.do?bIdx=2&page=${param.page}'">목록</button>
					</div>
				</div>
				<!-- 댓글영역 -->
				<div class="comment-area">
					<div class="comment-area-total">
						<span>댓글 <b id="cmtTotal"> ${cmtCount} </b> 개</span>
					</div>
					<!--  댓글 리스트 -->
					<ul class="comment-area-ul" id="commentUl">
						<c:set var="cmtTotal" value="${oCCount}"/>
						<c:set var="page" value="${page}"/>
						<c:set var="startNum" value="${page-(page-1)%5}"/>	
						<c:set var="lastNum" value="${fn:substringBefore(Math.ceil(cmtTotal/10),'.')}"/>
						<c:if test="${fn:length(cmtList) gt 0 }">
							<c:forEach var="item" items="${cmtList}" varStatus="st">
							<c:set var="key" value="${item.cIdx}"/>
							<c:if test="${fn:length(replyList[key]) gt 0 || item.status eq 0}">
							<li class="comment-area-ul-li">
								<div class="comment-area-content">
									<div class="comment-area-content-toparea">
							 			<div class="comment-area-content-toparea-left">
							 				<c:if test="${item.status eq 0}">
							 				<a class="miniprofile" onclick="profileOpen('${item.mIdx}')"><img src="${item.mProfileSrc}" style="width:25px; height:100%; margin-right:10px;" class="psrc"/>
							 				<c:choose>
							 				<c:when test="${vo.mNickname eq item.mNickname }">
							 				<span style="font-weight: 600;color:blue">${item.mNickname}</span>
							 				</c:when>
							 				<c:otherwise>
							 				<span style="font-weight: 600">${item.mNickname}</span>
							 				</c:otherwise>
							 				</c:choose>
							 				</a>
							 				</c:if>
							 			</div>
										<div class="comment-area-content-toparea-right">
							 				<a class="reg-date"><fmt:formatDate value="${item.regDate}" pattern="YY-MM-dd HH:mm:ss"/></a>
										</div>
								 	</div>
							 		<div class="comment-area-content-contentarea">
							 			<c:choose>
							 			<c:when test="${item.status eq 0}">
								 		<div style="resize: none;border:none;width:100%;word-break:break-all;" readonly ><pre style="font-family:system-ui">${item.content}</pre><br>
											<c:if test="${item.picSrc ne null}">
									 			<img src="<%=request.getContextPath() %>${item.picSrc}"/>
											</c:if>
										</div>
										</c:when>
										<c:otherwise>
										<div style="resize: none;border:none;width:100%;word-break:break-all; font-weight:bold;" readonly >삭제된댓글입니다.<br>
										</div>
										</c:otherwise>
										</c:choose>
									</div>
									<div class="comment-area-content-bottomarea">
										<c:if test="${item.status != 1}">
							 				<a onclick="commentReply('${item.cIdx}')">답글</a>
							 			</c:if>
										<c:if test="${(item.mIdx == login.mIdx || login.auth == 3) && item.status != 1}">
							 				<a onclick="commentModify('${item.cIdx}')">수정</a>							 				
							 				<a onclick="commentDelete('${item.cIdx}')">삭제</a>							 				
								 		</c:if>
									</div>
								</div>
							 </li>
							 <!-- 수정하기 박스 -->
							  <div id="commentModify${item.cIdx}" class="commentHidden">
							 	<div class="comment-area-write comment-area-write${item.cIdx}" id="comment-area-write_id">
							 		<div id="uploaded-file${item.cIdx}" class="uploaded-file">
										<span><b>업로드된사진</b></span>
										<c:if test="${item.picSrc ne null}">
									 			<img src="<%=request.getContextPath() %>${item.picSrc}" style="width:100px; height:100px;"/>
										</c:if>
									</div>
									<form id="commentfile${item.cIdx}">
										<input type="hidden" name="fileChange" value="0">
										<input type="hidden" name="aIdx" value="${param.aIdx}">
										<input type="hidden" name="bIdx" value="${param.bIdx}">
										<input type="hidden" name="mIdx" value="${login.mIdx}">
										<input type="hidden" name="cIdx" value="${item.cIdx}">
										<input type="hidden" name="mNickname" value="${login.nickname}">
										<input type="hidden" name="status" value="${item.status}">
										<label style="margin-bottom:10px">
											<input type="file" id="file${item.cIdx}" name="commentSrc" style='display:none' onchange="preview(event,'${item.cIdx}',this)" accept="image/*">
											<c:choose>
												<c:when test="${item.picSrc ne null}">
												<label for="file${item.cIdx}">
												</label>
												<a><strong>사진 변경하기</strong></a>	
												</c:when>
												<c:otherwise>
												<label for="file${item.cIdx}">
												</label>
												<a><img src="<%=request.getContextPath() %>/images/picture-button.png" style="width:20px;margin-left:10px;padding-bottom:5px;" class="npic"></a>												
												</c:otherwise>
											</c:choose>
										</label>
										<div class="comment-area-write-content">
												<textarea id="comment-write-content${item.cIdx}" name="content" class="comment-area-write-content-area">${item.content}</textarea>
												<input id="comment-write-button${item.cIdx}" type="button" value="수정" class="comment-area-write-content-button" onclick="commentUpdate(${login.mIdx},${item.cIdx})">
										</div>
									</form>
								</div>
							 </div>
							 </c:if>
							 <c:set var="key" value="${item.cIdx}"/>
							 <c:if test="${fn:length(replyList[key]) gt 0}">
							 <c:forEach items="${replyList[key]}" varStatus="j" var="rList">
							 <li class="comment-area-ul-li" style="margin-left:40px;">
								<div class="comment-area-content">
									<div class="comment-area-content-toparea">
							 			<div class="comment-area-content-toparea-left">
							 				<a class="miniprofile" onclick="profileOpen('${rList.mIdx}')">
							 				<img src="<%=request.getContextPath() %>/images/profile_default.png" style="width:25px;margin-right:10px; height:100%;" class="psrc npic"/>
							 				<c:choose>
							 				<c:when test="${vo.mNickname eq rList.mNickname}">
							 				<span style="font-weight:600; color:blue;">${rList.mNickname}</span>
							 				</c:when>
							 				<c:otherwise>
							 				<span style="font-weight:600;">${rList.mNickname}</span>
							 				</c:otherwise>
							 				</c:choose>
							 				</a>
							 			</div>
										<div class="comment-area-content-toparea-right">
							 				<a class="reg-date"><fmt:formatDate value="${rList.regDate}" pattern="YY-MM-dd HH:mm:ss"/></a>
										</div>
								 	</div>
							 		<div class="comment-area-content-contentarea">
								 		<div style="resize: none;border:none;width:100%;word-break:break-all;" readonly >${rList.content}<br>
											<c:if test="${rList.picSrc ne null}">
									 			<img src="<%=request.getContextPath() %>${rList.picSrc}" style="width:200px; height:100%; border:2px solid lightgray"/>
											</c:if>
										</div>
									</div>
									<div class="comment-area-content-bottomarea">
										<c:if test="${rList.mIdx == login.mIdx || login.auth == 3}">
							 				<a onclick="replyModify('${rList.rIdx}','${page}','${rList.mIdx}')">수정</a>							 				
							 				<a onclick="replyDelete('${rList.rIdx}','${page}','${rList.mIdx}')">삭제</a>							 				
								 		</c:if>
									</div>
								</div>
							 </li>
							 <!-- 답글수정 --> 
							<div id="replyModify${rList.rIdx}" class="commentHidden">
								<div class="comment-area-write">
									<div id="reply-uploaded-file${rList.rIdx}" class="uploaded-file">
								 		<span><b>업로드된사진</b></span>
										<c:if test="${rList.picSrc != null}">
										 <img src="<%=request.getContextPath() %>${rList.picSrc}" style="width:200px; height:100%; border:2px solid lightgray"/>
										</c:if>
									</div>
										 <form id="replyfile${rList.rIdx}">
											 <input type="hidden" name="fileChange" value="0">
											 <input type="hidden" name="rIdx" value="${rList.rIdx}">
											 <input type="hidden" name="mIdx" value="${login.mIdx}">
											 <input type="hidden" name="mNickname" value="${login.nickname}">
										 	<label style="margin-bottom:10px">
												 <input type="file" id="reply-file${rList.rIdx}" name="commentSrc" style="display:none" onchange="replyPreview(event,${rList.rIdx},this)" accept="image/* ">
												 <label for="reply-file${rList.rIdx}">
												<c:choose>
													<c:when test="${rList.picSrc != null}">
												 	<a> <strong>사진 변경하기</strong></a>
													</c:when>
													<c:otherwise>
													 <a><img src="<%=request.getContextPath() %>/images/picture-button.png" style="width:20px;margin-left:10px;padding-bottom:5px;" class="npic"/></a>						
													</c:otherwise>
												</c:choose>
												 </label>
											</label>
											 <div class="comment-area-write-content">
												 <textarea id="reply-write-content${rList.rIdx}" name="content" class="comment-area-write-content-area">${rList.content}</textarea>
												 <input id="reply-write-button${rList.rIdx}" type="button" value="수정" class="comment-area-write-content-button" onclick="replyUpdate(${login.mIdx},${rList.rIdx},this)">
											 </div>
										 </form>
									 </div>
								 </div>
							 </c:forEach>
							 </c:if>
							 
							 <!-- 답글달기 박스 -->
							   <div id="replyWrite${item.cIdx}" class="commentHidden">
							 	<div class="comment-area-write comment-area-write${item.cIdx}" id="write-area-write_id">
							 		<div id="reply-uploaded-file${item.cIdx}" class="uploaded-file">
										<span><b>업로드된사진</b></span>
									</div>
									<form id="replyFile${item.cIdx}">
										<input type="hidden" name="mIdx" value="${login.mIdx}">
										<input type="hidden" name="cIdx" value="${item.cIdx}">
										<input type="hidden" name="mNickname" value="${login.nickname}">
										<label style="margin-bottom:10px">
											<input type="file" id="reply-file${item.cIdx}" name="commentSrc" style='display:none' onchange="replyPreview(event,'${item.cIdx}',this)" accept="image/*">
												<label for="reply-file${item.cIdx}">
												</label>
												<a><img src="<%=request.getContextPath() %>/images/picture-button.png" style="width:20px;margin-left:10px;padding-bottom:5px;" class="npic"></a>												
										</label>
										<div class="comment-area-write-content">
												<textarea id="reply-write-content${item.cIdx}" name="content" class="comment-area-write-content-area"></textarea>
												<input id="reply-write-button${item.cIdx}" type="button" value="등록" class="comment-area-write-content-button" onclick="replyWrite(${item.cIdx},${page})">
										</div>
									</form>
								</div>
							 </div>
							</c:forEach>
						</c:if>
					</ul>
					<!-- 댓글 페이징 -->
					<c:if test="${fn:length(cmtList) gt 0}">
					<div id="cmtPageNum" class="pageNum" style="padding-top:30px;">
						<c:if test="${page>5}">
						<button onclick="commentList(1)" class="page-nav-button">1</button>
						</c:if>
						<button onclick="commentList('${startNum-5}')" class="page-nav-button" style="display:${startNum <= 1?'none':'block'}">◀</button>
						<c:forEach var="i" begin="0" end="4">
							<c:if test="${(startNum+i)<= lastNum}">
								<c:choose>
									<c:when test="${(startNum+i) == page }">
									<button onclick="commentList('${startNum+i}')" class="page-nav-button current-page" >${startNum+i}</button>
									</c:when>
									<c:otherwise>
									<button onclick="commentList('${startNum+i}')" class="page-nav-button" >${startNum+i}</button>
									</c:otherwise>
								</c:choose>
							</c:if>
						</c:forEach>
						<button onclick="commentList('${startNum+5}')" class="page-nav-button" style="display:${(startNum+5)>lastNum?'none':'block'}">▶</button>
						<c:if test="${(lastNum-5) >= page}">
						<button onclick="commentList('${page}')" class="page-nav-button">${lastNum}</button>
						</c:if>
					</div>
					</c:if>
					<!-- 댓글 등록 -->
					<div id="uploaded-file" class="uploaded-file">
						<span><b>업로드된사진</b></span>
					</div>
					<div class="comment-area-write" id="comment-area-write_id">
						<form id="commentfile">
							<input type="hidden" name="aIdx" value="${param.aIdx}">
							<input type="hidden" name="bIdx" value="${param.bIdx}">
							<input type="hidden" name="mIdx" value="${login.mIdx}">
							<input type="hidden" name="mNickname" value="${login.nickname}">
							<label style="margin-bottom:10px">
								<strong style="padding-left:5px;">댓글 쓰기</strong>
							</label>
							<label style="margin-bottom:10px">
								<input type="file" id="file" name="commentSrc" style="display:none" onchange="preview(event)" accept="image/*">
								<label for="file">
									<a><img src="<%=request.getContextPath() %>/images/picture-button.png" style="width:20px;margin-left:10px;padding-bottom:5px;" class="npic"></a>
								</label>
							</label>
							<div class="comment-area-write-content">
								<c:choose>
									<c:when test="${login.mIdx != null}">
										<textarea id="comment-write-content" name="content" class="comment-area-write-content-area"></textarea>
										<input id="comment-write-button" type="button" value="등록" class="comment-area-write-content-button" onclick="commentWrite('${param.aIdx}')">
									</c:when>
									<c:otherwise>
										<textarea id="comment-write-content"  class="comment-area-write-content-area" placeholder="댓글은 로그인 후 작성 가능합니다" onclick="location.href='<%=request.getContextPath() %>/member/glogin.do'"></textarea>
										<input id="comment-write-button" type="button" value="등록" class="comment-area-write-content-button" disabled>
									</c:otherwise>
								</c:choose>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="inner-box" style="margin-top:20px;">
				<table class="prev-next">
					<c:if test="${next.size() != 0}">
						<c:forEach var="i" begin="0" end="${next.size()-1}">
							<tr>
								<td class="title-area"><a href="details.do?bIdx=${param.bIdx}&aIdx=${next.get(next.size()-1-i).aIdx}">${next.get(next.size()-1-i).title }</a></td>
								<td>${next.get(next.size()-1-i).mNickname }</td>
								<td><fmt:formatDate value="${next.get(next.size()-1-i).regDate }" pattern="yyyy-MM-dd hh:mm"/></td>
							</tr>
						</c:forEach>
					</c:if>
					<tr>
						<td class="title-area" style="font-weight:bold;">${vo.title}</td>
						<td width="30%" style="font-weight:bold;">${vo.mNickname}</td>
						<td width="20%" style="font-weight:bold;"><fmt:formatDate value="${vo.regDate}" pattern="yyyy-MM-dd hh:mm"/></td>
					</tr>
					<c:if test="${prev.size() != 0}">
						<c:forEach var="i" begin="0" end="${prev.size()-1}">
							<tr>
								<td class="title-area"><a href="details.do?bIdx=${param.bIdx}&aIdx=${prev.get(i).aIdx}">${prev.get(i).title }</a></td>
								<td>${prev.get(i).mNickname }</td>
								<td><fmt:formatDate value="${prev.get(i).regDate }" pattern="yyyy-MM-dd hh:mm"/></td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>
		</div>
	</div>
	<div id="IExtend" class="IED">
		<img src="">
	</div>
	<script>
	//이미지 확대해서보기
	var caa=function imgWide(){
		
		var img=document.querySelectorAll('.comment-area-content-contentarea div>img');
		for(var i=0;i<img.length; i++){
			img[i].addEventListener("click",function(){
				$('#IExtend>img').attr('src',this.src);
				var imgDIV=document.querySelector('#IExtend');
				imgDIV.classList.toggle("imgExtend");
			});
		}
		
		var imgd=document.querySelector('#IExtend');
		imgd.addEventListener("click",function(){
			$(this).removeClass('imgExtend');
		});
	}
	//로드시 
	caa();
	</script>
	<c:import url="/footer.do" />
</body>
</html>