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
	.board-header{
		display:flex;
		font-size:20px;
	}
	.board-header-title{
		flex:1;
		width:90%;
	}
	.board-header-date{
	}
	.board-middle{
		display:flex;
		font-size:15px;
	}
	.board-middle-nickname{
		flex:1;
	}
	.board-middle-count{
		display:flex;
	}
	div.inner-box{
		height:auto;
	}
	.board-content{
		overflow:hidden;
		heigt:auto;
	}
	.board-content-like{
		display:flex;
		justify-content: center;
		align-items: flex-end;
		margin-bottom:5px;
	}
	.details-button{
		display:flex;
		flex-direction: row-reverse;
	}
	.board-recommand{
		margin-top:15px;
	}
</style>
<script>

	var liked;
	var mIdx = 0;
	
	<c:if test="${login != null}">
	mIdx = ${login.getmIdx()};
	</c:if>
	
	$(function() {
		
		likedStatus();
		likeCount();
		commentsList();
	});
	
	function commentsList(){
		$.ajax({
			type:"post",
			url:"commentsList.do",
			data:{
				aIdx:aIdx,
				bIdx:bIdx
			},
			success : function(result){
				//li에 댓글 출력하는 부분
			}
		});
	}
	
	function comments(){
		$.ajax({
			type:"post",
			url:"insertComments.do",
			data:{
				aIdx:aIdx,
				bIdx:bIdx,
				content:content
			},
			success : function(result){
				commentsList();
			}
		});
		
	}
	
	function likeCount(){
		$.ajax({
			type: "post",
			url: "likeCount.do",
			data:{
				aIdx:${vo.getaIdx()}
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
				aIdx:${vo.getaIdx()}
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

</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-content">
		<div class="inner-box" style="margin-top:30px;">
			<div class="inner-box-content">
				<div class="board-header">
					<div class="board-header-title">제목 : ${vo.title }</div>
					<div class="board-header-date"><fmt:formatDate value="${vo.regDate }" pattern="yyyy-MM-dd hh:mm"/></div>
				</div><hr>
				<div class="board-middle">
					<div class="board-middle-nickname">${vo.mNickname}</div><div class="board-middle-count">조회수 : ${vo.readCount}&nbsp;&nbsp;추천수 :&nbsp;<div id="likeCount"></div></div>
				</div><hr>
				<div class="board-content">
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
		</div>
		</div>
		<div class=comments-list>
			<li>
			</li>
		</div>
		<div class="board-recommand">
			<input type="hidden" name="aIdx" value="${param.aIdx}">
			<input type="hidden" name="bIdx" value="${param.bIdx}">
			<input class="normal-button" value="${login.getNickname}" style="width:50px;" readonly>
			<input type="text" class="normal-button" name="content" style="width:500px;" placeholder="댓글을 입력하세요.">
			<button class="normal-button accent-button" id="update" onclick="comments()">등록</button>
		</div>
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>