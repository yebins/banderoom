<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${spaceList.size() > 0}">
<c:forEach var="i" begin="0" end="${spaceList.size() - 1}">
	<div class="col spacecol">
		<div class="inner-box spacebox" onclick="location.href='details.do?idx=${spaceList[i].getIdx()}'">
		<input type="hidden" name="idx" value="${spaceList[i].getIdx()}">
		<input type="hidden" name="address" value="${spaceList[i].getAddress()}">
		<c:if test="${spaceList[i].liked == 1 }">
		<img class="liked-space" src="<%=request.getContextPath() %>/images/heart-filled.png">
		</c:if>
			<div class="space-thumb">
				<img src="<%=request.getContextPath() %>${spaceList[i].thumb}" width="100%">
			</div>
			<div class="space-info">
				<div class="space-name">${spaceList[i].getName()}</div>
				<div class="space-restinfo">
					<div class="space-type-cost-wrap">
						<div class="space-type">${spaceList[i].getType()}</div>
						<div class="space-cost">
							<span>
								<fmt:formatNumber value="${spaceList[i].getCost()}" pattern="#,###" /> 
							</span>
							원 / 시간
						</div>
					</div>
					<div class="space-restinfo-restinfo">
						<div class="space-addr">${spaceList[i].getAddr1()} ${spaceList[i].getAddr2()}</div>
						<div class="space-score">
							⭐ <fmt:formatNumber value="${spaceList[i].getReviewAvg()}" pattern="0.0" /> (${spaceList[i].getReviewCnt()})
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>
</c:if>