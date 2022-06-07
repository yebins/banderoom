<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<link href="<%=request.getContextPath() %>/css/air-datepicker/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<!-- Air datepicker css -->
<script src="<%=request.getContextPath() %>/js/air-datepicker/datepicker.js"></script> <!-- Air datepicker js -->
<script src="<%=request.getContextPath() %>/js/air-datepicker/datepicker.ko.js"></script> <!-- 달력 한글 추가를 위해 커스텀 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>이용료 정산</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">

<style>
	

	.date-input {
		width: 120px;
		text-align: center;
		margin-right: 10px;
	}
	
	.calc-wrap {
		margin-top: 40px;
		padding: 0px 15px !important;
	}
	
	.calc-wrap a:not(.calc-wrap a:last-child) > div {
		border-bottom: 1px solid lightgray;
		
	}
	
	.item-wrap {
		padding: 15px 0px;
		display: flex;
	}
	.item-wrap:not(.item-wrap:last-child) {
	}
	
	.space-info {
		flex: 1;
		display: flex;
		align-items: center;
	}
	
	.calc-thumb img {
		width: 90px;
		border-radius: 10px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.4);
		
	}
	
	.calc-thumb {
		margin-right: 15px;
	}
	
	.calc-name {
		font-weight: bold;
		font-size: 20px;
	}
	
	.calc-data {
		display: flex;
		flex-direction: column;
		margin-left: 20px;
		padding-left: 20px;
		justify-content: center;
		border-left: 1px solid lightgray;
	}
	
	.calc-data-title {
		font-weight: bold;
		font-size: 14px;
	}
	
	.calc-value {
		font-size: 20px;
		text-align: right;
	}
	
	.calc-count {
		width: 100px;
	}
	
	.calc-sum {
		width: 140px;
	}
	
	.calc-total-wrap {
		margin-top: 40px;
		font-weight: bold;
		font-size: 24px;
		text-align: right;
		display: flex;
		justify-content: flex-end;
		align-items: center;
	}
	
	.settle-button {
		margin-left: 20px;
		width: 150px;
		height: 50px;
		border-radius: 100px;
		font-size: 18px;
	}
	
	.settle-button.disabled {
		background-color: lightgray;
	}
</style>

<script>

	function selectMonth() {
		console.log($("#date").val())
	}
	
	function settle(mIdx, date, button) {
		
		if ($(button).hasClass("disabled")) {
			return;
		}
		
		if (!confirm("해당 월의 사용료를 정산받으시겠습니까?")) {
			return;
		}
		
		$.ajax({
			type: "post",
			url: "insertsettle.do",
			data: "hostIdx=" + mIdx + "&month=" + date,
			success: function(result) {
				if (result == 0) {
					alert('해당 월 정산을 완료했습니다.');
					location.reload();
				} else if (result == 1) {
					alert('이미 정산 받으셨습니다.');
				} else if (result == 2) {
					alert('오류가 발생했습니다.');					
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
		<div id="page-title">
			이용료 정산
		</div>
		<div id="page-content">
		
			<form action="settle.do">
				<div class="filter-wrap">
					<input type="hidden" name="mIdx" value="${param.mIdx }">
					<input class="datepicker-here date-input normal-button" name="date" 
								data-language="ko" data-min-view="months" data-view="months" data-date-format="yyyy-mm" 
								type="text" id="date" autocomplete="false" placeholder="기간 선택" value="${date}" readonly>
					<button class="normal-button accent-button">검색</button>
				</div>
			</form>
			
			<c:if test="${calc.size() > 0 }">
			<div class="inner-box calc-wrap">
				<c:forEach var="item" items="${calc }">
					<a href="myspacersv.do?idx=${item.spaceidx }&dateType=startDate&dateRange=${dateRange}">
					<div class="item-wrap">
						<div class="space-info">
							<div class="calc-thumb">
								<img src="<%=request.getContextPath() %>${item.thumb }">
							</div>
							<div class="space-restinfo">
								<div class="calc-name">${item.name }</div>
								<div class="calc-type">${item.type }</div>							
							</div>
						</div>
						
						<div class="calc-data calc-count">
							<div class="calc-data-title">예약 건수</div>
							<div class="calc-value">${item.count }건</div>
						</div>
						<div class="calc-data calc-sum">
							<div class="calc-data-title">이용료 합계</div>
							<div class="calc-value"><fmt:formatNumber value="${item.sum }" pattern="#,###" />원 </div>
						</div>
					
					</div>
					</a>
				</c:forEach>
			</div>
			</c:if>
			
			<div class="calc-total-wrap">
			<c:if test="${hlogin != null && available != null}">
				<c:choose>
					<c:when test="${calc.size() > 0 }">
						<div class="total-wrap">
							<span style="font-size: 16px;">총 정산 금액</span> <span style="color: #fb6544;"><fmt:formatNumber value="${total }" pattern="#,###" />원</span>
						</div>
						<button class="normal-button accent-button settle-button<c:if test="${settled > 0 }"> disabled</c:if>"
							onclick="settle(${param.mIdx}, '${date }', this)">정산 <c:if test="${settled > 0 }">받음</c:if><c:if test="${settled == 0 }">받기</c:if></button>
					</c:when>
					<c:otherwise>
							정산 금액이 없습니다.
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${available == null }">
				정산은 다음 달 1일부터 가능합니다.
			</c:if>
			</div>

			
		</div>
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>