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

<style>
	.inner-box {
		padding: 0px 15px !important;
	}

	.title-wrap {
	
		border-bottom: 1px solid lightgray;
		padding: 20px 10px;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.title {
		font-weight: bold;
		font-size: 24px;
		padding-left: 5px;
	}
	
	.regdate {
		font-size: 14px;
		color: darkgray;
	}
	
	.writer-wrap {
		padding: 20px 10px;
		display: flex;
		justify-content: space-between;
		align-items: center;
		border-bottom: 1px solid lightgray;
	}
	
	.writer-profile-wrap {
		display: flex;
		align-items: center;
	}
	
	.profile-picture {
		width: 24px;
		height: 24px;
		border-radius: 12px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		margin-right: 10px;
	}
	
	.info-wrap {
		display: flex;
		
	}
	
	.info-content {
		display: flex;
		align-items: center;
		margin-left: 15px;
		font-size: 14px;
	}
	
	.info-content span {
		display: flex;
		align-items: center;
		margin-left: 10px;
		font-weight: bold;
		font-size: 18px;
	}
	
	.content-wrap {
		padding: 30px 10px;
		word-break: break-all;
		border-bottom: 1px solid lightgray;
		min-height: 50vh;
	}
	
	.comments-wrap {
		margin-top: 30px;
		padding: 20px 10px;
	}
	
	.comment-count {
		font-size: 20px;
	}
	
	.comment-count span {
		font-weight: bold;
	}
	
	.comments {
		margin-top: 20px;
	}
	
	.comment-box:not(.comment-box:first-child) {
		border-top: 1px solid lightgray;
	}
	
	.comment-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	.comment-writer-wrap {
		padding: 15px 0px;
		display: flex;
		align-items: center;
	}
	.comment-profile-picture {
		width: 24px;
		height: 24px;
		border-radius: 12px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		margin-right: 10px;
	}
	.comment-regdate {
		font-size: 14px;
		color: darkgray;
	}
	.comment-body {
		display: flex;
		align-items: flex-start;
	}
	.comment-picture-wrap {
		width: 100px;
		border-radius: 10px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		margin-right: 15px;
		overflow: hidden;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 5px;
	}
	.comment-picture {
		width: 100px;
	}
	
	.comment-content {
		flex: 1;
		word-break: break-all;
		
	}
	
	.comment-footer {
		display: flex;
		justify-content: flex-end;
		align-items: center;
		padding: 15px 0px;
	}
	
	.comment-button {
		margin-left: 10px;
		font-size: 14px;
	}
	.comment-button:hover {
		cursor: pointer;
	}
	
	.comment-replies {
		margin-left: 50px;
	}
	
	.comment-write {
		padding: 15px 0px;
	}
	.comment-write textarea {
		width: 100%;
		height: 150px;
		border: 1px solid lightgray;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		border-radius: 10px;
		margin-top: 5px;
		resize: none;
		padding: 15px;
		font-family: '맑은 고딕';
	}
	
	.comment-buttons {
		margin-top: 15px;
		display: flex;
		justify-content: space-between;
	}
	
	.comment-right-buttons button {
		margin-left: 10px;
	}
	
	.picture-button {
		width: 36px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.picture-button img {
		width: 16px;
	}
	
	#page-nav {
		padding-top: 15px;
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
		background-color: #fbe6b2;
		font-weight: bold;
	}
	
</style>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			자유게시판
		</div>
		<div id="page-content">
			<div class="inner-box">
				<div class="title-wrap">
					<div class="title">제목입니다.</div>
					<div class="regdate">2022-05-17 13:52:24</div>
				</div>
				<div class="writer-wrap">
					<div class="writer-profile-wrap">
						<img class="profile-picture" src="/images/profile_default.png">
						<div class="nickname">
							에이에이
						</div>
					</div>
					<div class="info-wrap">
						<div class="info-content">
							조회 <span class="info-values">234</span>
						</div>
						<div class="info-content">
							추천 <span class="info-values">3</span>
						</div>
					</div>
				</div>
				<div class="content-wrap">
					aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
				</div>
				<div class="comments-wrap">
					<div class="comment-count">
						댓글 <span>6</span>
					</div>
					<div class="comments">
						<!-- 댓글 반복문 시작 -->
						<div class="comment-box">
							<div class="comment-header">
								<div class="comment-writer-wrap">
									<img class="comment-profile-picture" src="/images/profile_default.png">
									<div class="comment-nickname">
										에이에이
									</div>
								</div>
								<div class="comment-regdate">
									2022-05-16 23:11:05
								</div>
							</div>
							<div class="comment-body">
								<div class="comment-picture-wrap"> <!-- 사진이 있는 경우 출력 -->
									<img class="comment-picture" src="https://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg">
								</div>
								<div class="comment-content">
									내용입니다 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
								</div>
							</div>
							<div class="comment-footer">
								<div class="comment-button">수정</div>							
								<div class="comment-button">삭제</div>							
								<div class="comment-button">답글</div>				
							</div>
						</div>
						<!-- 댓글 반복문 끝 -->
						
						<!-- 댓글 반복문 시작 -->
						<div class="comment-box">
							<div class="comment-header">
								<div class="comment-writer-wrap">
									<img class="comment-profile-picture" src="/images/profile_default.png">
									<div class="comment-nickname">
										에이에이
									</div>
								</div>
								<div class="comment-regdate">
									2022-05-16 23:11:05
								</div>
							</div>
							<div class="comment-body">
								<div class="comment-content">
									aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
								</div>
							</div>
							<div class="comment-footer">
								<div class="comment-button">수정</div>							
								<div class="comment-button">삭제</div>							
								<div class="comment-button">답글</div>							
							</div>
						</div>
						
							<!-- 대댓글 반복문 시작 -->
							<div class="comment-box comment-replies">
								<div class="comment-header">
									<div class="comment-writer-wrap">
										<img class="comment-profile-picture" src="/images/profile_default.png">
										<div class="comment-nickname">
											에이에이
										</div>
									</div>
									<div class="comment-regdate">
										2022-05-16 23:11:05
									</div>
								</div>
								<div class="comment-body">
									<div class="comment-picture-wrap"> <!-- 사진이 있는 경우 출력 -->
										<img class="comment-picture" src="https://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg">
									</div>
									<div class="comment-content">
										aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
									</div>
								</div>
								<div class="comment-footer">
									<div class="comment-button">수정</div>							
									<div class="comment-button">삭제</div>							
								</div>
							</div>
							<!-- 대댓글 반복문 끝 -->
							
							
							<!-- 대댓글 반복문 시작 -->
							<div class="comment-box comment-replies">
								<div class="comment-header">
									<div class="comment-writer-wrap">
										<img class="comment-profile-picture" src="/images/profile_default.png">
										<div class="comment-nickname">
											에이에이
										</div>
									</div>
									<div class="comment-regdate">
										2022-05-16 23:11:05
									</div>
								</div>
								<div class="comment-body">
									<div class="comment-content">
										aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
									</div>
								</div>
								<div class="comment-footer">
									<div class="comment-button">수정</div>							
									<div class="comment-button">삭제</div>							
								</div>
							</div>
							<!-- 대댓글 반복문 끝 -->
							
							
							
							<!-- 대댓글 반복문 시작 -->
							<div class="comment-box comment-replies">
								<div class="comment-header">
									<div class="comment-writer-wrap">
										<img class="comment-profile-picture" src="/images/profile_default.png">
										<div class="comment-nickname">
											에이에이
										</div>
									</div>
									<div class="comment-regdate">
										2022-05-16 23:11:05
									</div>
								</div>
								<div class="comment-body">
									<div class="comment-content">
										aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
									</div>
								</div>
								<div class="comment-footer">
									<div class="comment-button">수정</div>							
									<div class="comment-button">삭제</div>							
								</div>
							</div>
							<!-- 대댓글 반복문 끝 -->
							
						<!-- 댓글 반복문 끝 -->	
						
						<!-- 댓글 반복문 시작 -->
						<div class="comment-box">
							<div class="comment-header">
								<div class="comment-writer-wrap">
									<img class="comment-profile-picture" src="/images/profile_default.png">
									<div class="comment-nickname">
										에이에이
									</div>
								</div>
								<div class="comment-regdate">
									2022-05-16 23:11:05
								</div>
							</div>
							<div class="comment-body">
								<div class="comment-content">
									aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
								</div>
							</div>
							<div class="comment-footer">
								<div class="comment-button">수정</div>							
								<div class="comment-button">삭제</div>							
								<div class="comment-button">답글</div>							
							</div>
						</div>
						<!-- 댓글 반복문 끝 -->
					</div>
					
					<div id="page-nav">
						<div class="page-nav-button">1</div>
						<div class="page-nav-button">◀</div>
						<div class="page-nav-button">6</div>
						<div class="page-nav-button">7</div>
						<div class="page-nav-button">8</div>
						<div class="page-nav-button current-page">9</div>
						<div class="page-nav-button">10</div>
						<div class="page-nav-button">▶</div>
						<div class="page-nav-button">32</div>
					</div>
					
					<div class="comment-write">
						<textarea placeholder="댓글을 입력하세요."></textarea>
						<div class="comment-buttons">
							<button class="normal-button picture-button">
								<img src="/images/picture-button.png">
							</button>
							<div class="comment-right-buttons">
								<button class="normal-button">초기화</button>
								<button class="normal-button accent-button">등록</button>							
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>