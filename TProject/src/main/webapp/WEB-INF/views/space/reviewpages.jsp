<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${reviewList.size() > 0}">
								<div id="reviewList">
								<c:forEach var="review" items="${reviewList}">
									<div class="review-wrap">
										<div class="review-header">
											<div class="review-member">
												<div class="review-profile-img">
													<img src="${review.profileSrc}">
												</div>
												<div class="review-nickname" onclick="profileOpen(${review.mIdx})">
													${review.mNickname}
												</div>
											</div>
											<div class="review-score-wrap">
												<fmt:formatDate value="${review.regDate}" pattern="yyyy.MM.dd HH:mm" />
												<div class="review-score-stars">
													<div class="review-score-color" style="width: ${review.score * 24}px"></div>
													<img src="<%=request.getContextPath() %>/images/score-star.png">
													<img src="<%=request.getContextPath() %>/images/score-star.png">
													<img src="<%=request.getContextPath() %>/images/score-star.png">
													<img src="<%=request.getContextPath() %>/images/score-star.png">
													<img src="<%=request.getContextPath() %>/images/score-star.png">
												</div>
											</div>
										</div>
										<div class="review-body">
											<div class="review-content">
												${review.content}
											</div>
											<c:if test="${review.pictureSrc != null}">
												<img class="review-thumb" src="<%=request.getContextPath() %>${review.thumbSrc}" onclick="drawImage('<%=request.getContextPath() %>${review.pictureSrc}')">
											</c:if>
										</div>
										<c:if test="${review.mIdx == login.mIdx}">
										<div class="review-footer">
											<button class="normal-button" onclick="updateReview(${review.resIdx})">수정</button>
											<button class="normal-button" onclick="deleteReview(${review.resIdx})">삭제</button>
										</div>
										</c:if>
									</div>
								</c:forEach>
								</div>
</c:if>