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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
	.filter-buttons {
		width: 100%; 	
		display: flex;
		justify-content: flex-end;
		align-items: center;
		margin-bottom: 40px;
	}
	
	.form-select {
    margin-left: 20px;
    width: 160px;
    height: 50px;
    border-radius: 25px;
    padding: 0px 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		border: none;
	}
	.form-select:focus {
		outline: none;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
		border: none;
		}
	.form-select:active {
		filter: brightness(90%);
		}
	.reset-filter {
    margin-left: 20px;
    width: 160px;
    height: 50px;
    border-radius: 25px;
	}
		
	.inner-box-content {
		display: flex;
		align-items: center;
	}
	
	.spacebox {
		position: relative;
	}
	
	.spacebox:hover {
		cursor: pointer;
		outline: 3px solid #fb6544;
	}
	
	.space-thumb {
		width: 120px;
		height: 90px;
		border-radius: 7px;
		overflow: hidden;
		background: lightgray;
		display: flex;
		justify-content: center;
		align-items: center;
		font-size: 14px;
		font-weight: bold;
	}
	
	.space-info {
		flex: 1;
		height: 90px;
		padding-left: 15px;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
	}
	
	.space-name {
		font-size: 24px;
		font-weight: bold;
	}
	
	.space-type {
		font-size: 12px;
		padding: 0px 10px;
	}
	
	.space-rest-info {
		display: flex;
		justify-content: space-between;
	}
	
	.status-accepted {
		color: #14C681;
	}
	.status-refused {
		color: #FB6544;
	}
	
	.myspacersv-button {
		position: absolute;
		top: 15px;
		right: 15px;
		width: 80px;
		height: 30px;
		font-size: 14px;
	}
		
</style>
<script>

	var locations;
	
	$(function() {
		
		$.ajax({
			type: "get",
			url: "getlocations.do",
			success: function(data) {
				locations = data;
				var addr1 = [];
				
				for (var i = 0; i < data.length ; i++) {
					addr1[i] = data[i].addr1;
				}
				
				addr1 = addr1.filter((v, i) => addr1.indexOf(v) === i);
				
				$("#addr1-loading").remove();
				
				for (var i = 0; i < addr1.length ; i++) {
					var html = "<option>" + addr1[i] + "</option>"
					$("#addr1").append(html);
				}
			}
		})
		
	})

	function showAddr2() {
		
		$("#space-list tr").css("display", "table-row");
		
		if ($("#addr1").val() == "") {
			$("#addr2").css("display", "none");
			$("#addr2").val("");
			listFilter();
			return;
		}
		
		$("#addr2").children().each(function() {
			$(this).remove();
		});

		
		$("#addr2").append("<option value=''>지역 소분류</option>")	;
		
		for (var i = 0; i < locations.length; i++) {
			if (locations[i].addr1 == $("#addr1").val()) {
				var html = "<option>" + locations[i].addr2 + "</option>";
				$("#addr2").append(html);
			}
		}
		$("#addr2").css("display", "block");

		listFilter();
		
	}
	
	function listFilter() {
		
		var addr1Filter = $("#addr1").val();
		var addr2Filter = $("#addr2").val();
		var typeFilter = $("#space-type").val();
		var statusFilter = $("#space-status").val();

		$(".spacebox").css("display", "flex");
		
		if (addr1Filter != "") {
			$("input.addr1-hidden").each(function() {
				var addr1 = $(this).val();
				if (addr1 != addr1Filter) {
					$(this).parent().css("display", "none");
				}
			})
		}
		
		if (addr2Filter != "" && addr2Filter != null && addr2Filter != undefined) {
			$("input.addr2-hidden").each(function() {
				var addr2 = $(this).val();
				if (addr2 != addr2Filter) {
					$(this).parent().css("display", "none");
				}
			})
		}
		
		if (typeFilter != "") {
			$("input.type-hidden").each(function() {
				var type = $(this).val();
				if (type != typeFilter) {
					$(this).parent().css("display", "none");
				}
			})
		}

		if (statusFilter != "") {
			$("input.status-hidden").each(function() {
				var status = $(this).val();
				if (status != statusFilter) {
					$(this).parent().css("display", "none");
				}
			})
		}
		
	}
	
	function resetFilter() {
		$("#addr1").val("");
		$("#addr2").val("");
		$("#space-type").val("");
		$("#space-status").val("");
		
		listFilter();
		
	}
	
	function mySpaceRsv(idx) {
		event.stopPropagation();
		location.href = 'myspacersv.do?idx=' + idx;
	}
	
	
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			공간 관리
		</div>
		<div id="page-content">
			<div class="filter-buttons">
				<select id="addr1" class="form-select form-select-sm" onchange="showAddr2()">
					<option value="">지역</option>
					<option id="addr1-loading" value="">로드 중..</option>
				</select>
				<select id="addr2" class="form-select form-select-sm" style="display: none;" onchange="listFilter()">
				</select>
				<select id="space-type" class="form-select form-select-sm" onchange="listFilter()">
					<option value="">분류</option>
					<option>녹음실</option>
					<option>밴드연습실</option>
					<option>댄스연습실</option>
				</select>
				<select id="space-status" class="form-select form-select-sm" onchange="listFilter()">
					<option value="">등록 상태</option>
					<option value="0">등록 대기</option>
					<option value="1">등록 완료</option>
					<option value="2">등록 거부됨</option>
				</select>
				<button class="normal-button reset-filter" onclick="resetFilter()">필터 초기화</button>
			</div>
			
			<c:forEach var="vo" items="${spacesVOs}">
				<div class="inner-box spacebox" style="height: 120px; margin-bottom: 20px;" onclick="location.href='details.do?idx=${vo.getIdx()}'">
					<input type="hidden" class="addr1-hidden" value="${vo.getAddr1()}">
					<input type="hidden" class="addr2-hidden" value="${vo.getAddr2()}">
					<input type="hidden" class="type-hidden" value="${vo.getType()}">
					<input type="hidden" class="status-hidden" value="${vo.getStatus()}">
					<div class="inner-box-content">
						<div class="space-thumb">
							<c:choose>
								<c:when test="${vo.getThumb() != null}">
									<img src="${vo.getThumb()}" width="100%">
								</c:when>
								<c:otherwise>
									썸네일 없음
								</c:otherwise>
							</c:choose>
						</div>
						<div class="space-info">
							<div class="space-name">
								${vo.getName()} 
								<span class="space-type">
									${vo.getType()}
								</span>
							</div>
							<div class="space-rest-info">
								<div>
									<span class="space-addr">
										${vo.getAddr1()} ${vo.getAddr2()}
									</span>
									|
									<span class="space-regdate">
										등록일 <fmt:formatDate value="${vo.getRegDate()}" pattern="yyyy-MM-dd"/>
									</span>
								</div>
								<div class="space-status">
									<c:choose>
										<c:when test="${vo.getStatus() == 0}">
											<span class="status-waiting">등록 대기</span>
										</c:when>
										<c:when test="${vo.getStatus() == 1}">
											<span class="status-accepted">등록 완료</span>
										</c:when>
										<c:when test="${vo.getStatus() == 2}">
											<span class="status-refused">등록 거부됨</span>
										</c:when>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
					<button class="normal-button myspacersv-button" onclick="mySpaceRsv(${vo.idx})">예약 내역</button>
				</div>
			</c:forEach>
			
		</div>
		
		<!-- 여기까지 틀이고 밑에는 요소 공통사항
		<div>
			위까지는 틀이고 밑에는 요소 공통사항
			<br><br><br>
			버튼 세로 크기 수정시 border-radius도 수정해야함<br>
			<br>
			<button class="normal-button">버튼</button> 
			일반 버튼 (button class="normal-button") (버튼이 여러개 줄줄이 배치될 시 하나만 강조 컬러 넣을것)<br><br>
			<button class="normal-button accent-button">버튼</button> 강조 버튼 (button class="normal-button accent-button")<br><br>
			<br><br><br>
			내부 박스 틀과 예시
			<div class="inner-box">
				<div class="inner-box-content">
				박스에 들어갈 내용
				</div>
				<div class="inner-box-button-wrap">
					<button class="normal-button">일반버튼</button>
					<button class="normal-button accent-button" style="margin-left: 15px;">강조버튼</button>
				</div>
			</div>
			<br><br>
		</div>
		<!-- 여기까지 -->
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>