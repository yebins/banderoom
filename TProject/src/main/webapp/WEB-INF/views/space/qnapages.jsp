<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<div id="qna-list">
	<c:if test="${qnaList.size() == 0}">
	<div>등록된 Q&amp;A가 없습니다.</div>
	</c:if>
	<div id="qna-elements">
	<c:forEach var="qnaVO" items="${qnaList}">
	<div class="review-wrap">
		<div class="review-header">
			<div class="review-member">
				<div class="review-profile-img">
					<img src="<%=request.getContextPath() %>${qnaVO.profileSrc}">
				</div>
				<div class="review-nickname" onclick="profileOpen(${qnaVO.mIdx})">
					${qnaVO.mNickname}
				</div>
			</div>
			<div class="review-score-wrap">
				<fmt:formatDate value="${qnaVO.regDate}" pattern="yyyy.MM.dd HH:mm" />
			</div>
		</div>
		<div class="review-body">
			<div class="review-content">
				<c:if test="${qnaVO.publicYN == 'N'}">
				<img src="<%=request.getContextPath() %>/images/lock.png" style="margin-bottom: 4px; height: 16px;">
				</c:if>${qnaVO.content}
			</div>
		</div>
		<div class="qna-buttons">
			<div class="qna-answer-button">
				<c:if test="${hlogin.mIdx == spacesVO.hostIdx && qnaVO.answer == null}">
				<button class="normal-button show-answer-button" onclick="qnaAnswer(${qnaVO.qnaIdx}, ${param.idx}, this)">답변하기</button>
				</c:if>
			</div>
			<div class="qna-modify-buttons">
				<c:if test="${qnaVO.mIdx == login.mIdx}">
				<button class="normal-button qna-update-button" onclick="qnaUpdate(${qnaVO.qnaIdx}, this)">수정</button>
				<button class="normal-button" onclick="qnaDelete(${qnaVO.qnaIdx})">삭제</button>
				</c:if>
			</div>
		</div>
		<c:if test="${qnaVO.answer != null}">
		<div class="qna-answer-wrap">
			<div class="qna-answer-title-wrap">
				<div class="qna-answer-title">
					호스트의 답변
				</div>
				<div class="qna-answer-date">
					<fmt:formatDate value="${qnaVO.answerDate}" pattern="yyyy.MM.dd HH:mm"/>
				</div>
			</div>
			<div class="qna-answer-content">
				<c:if test="${qnaVO.publicYN == 'N'}">
				<img src="<%=request.getContextPath() %>/images/lock.png" style="margin-bottom: 4px; height: 16px;">
				</c:if>${qnaVO.answer}
			</div>
			<c:if test="${hlogin.mIdx == spacesVO.hostIdx}">
			<div class="qna-answer-buttons">
				<button class="normal-button qna-answer-modify-button" onclick="qnaAnswerModify(${qnaVO.qnaIdx}, ${param.idx}, this)">수정</button>
				<button class="normal-button qna-answer-modify-button" onclick="qnaAnswerDelete(${qnaVO.qnaIdx}, ${param.idx})">삭제</button>
			</div>
			</c:if>
		</div>
		</c:if>
	</div>
	</c:forEach>
	</div>
</div>


<div id="qna-page-nav">
	<c:if test="${qnaLastPage < 6}">
		<c:forEach var="i" begin="${qnaStartPage}" end="${qnaEndPage}">
			<c:choose>
				<c:when test="${i == qnaNowPage}">
					<div class="qna-page-nav-button qna-current-page">${i}</div>
				</c:when>
				<c:otherwise>
					<div class="qna-page-nav-button" onclick="qnaList(${i})">${i}</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:if>
	<c:if test="${qnaLastPage > 5}">
		<c:if test="${qnaStartPage > 5}">
			<div class="qna-page-nav-button" onclick="qnaList(1)">1</div>
			<div class="qna-page-nav-button" onclick="qnaList(${qnaStartPage - 1})">◀</div>
		</c:if>
		
		<c:forEach var="i" begin="${qnaStartPage}" end="${qnaEndPage}">
			<c:choose>
				<c:when test="${i == 1}">
					<div class="qna-page-nav-button qna-current-page">${i}</div>
				</c:when>
				<c:otherwise>
					<div class="qna-page-nav-button" onclick="qnaList(${i})">${i}</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${qnaEndPage < qnaLastPage}">
			<div class="qna-page-nav-button" onclick="qnaList(${qnaEndPage + 1})">▶</div>
			<div class="qna-page-nav-button" onclick="qnaList(${qnaLastPage})">${qnaLastPage}</div>
		</c:if>
	</c:if>
</div>