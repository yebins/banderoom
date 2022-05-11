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
<title>팀원 모집 main</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">

<link href="/css/air-datepicker/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<!-- Air datepicker css -->
<script src="/js/air-datepicker/datepicker.js"></script> <!-- Air datepicker js -->
<script src="/js/air-datepicker/datepicker.ko.js"></script> <!-- 달력 한글 추가를 위해 커스텀 -->

<style>
.form-select{
	margin-right:10px;
	height: 35px;
	border-radius:17.5px;
}
.part{
	margin:0px;
}
.form-control{
	margin-right:10px;
	width:200px;
	height: 35px;
	border-radius:17.5px;
}
.form{
    width: 100%;
    text-align: center;
    margin: auto;
    padding: 30px 40px 14px 50px;
    border-radius: 15px;
    background: white;
    box-shadow: 0px 5px 10px rgb(0 0 0 / 20%);
}
.search-top{
	width: 100%;
}
.search-bottom{
    justify-content: space-between;
    display: flex;
    width: 100%;
}
.container{
	margin-top:20px;
}
.team-col{
	width:33.3%;
	padding-bottom:24px;
}
.team-list{
	width:100%;
	border-radius:15px;
	overflow:hidden;
	box-shadow: 0px 5px 10px rgb(0 0 0 / 20%);
}
.team-list:hover{
	cursor: pointer;
	outline:3px solid #FB6544;
}
.team-list:active {
	filter: brightness(90%);
}
.team-title{
	padding: 15px;
	width:100%;
	height:73px;
	background:#FBE6B2;
	color:#303030;
	font-size: 15px;
}
.team-content{
	width:100%;
	height:220px;
	background:white;
	color:#303030;
	text-align: center;
	font-size: 13px;
	padding:0px 5px;
}
table{
	height:100%;
	width:100%;
}
tr{
	border-bottom:1px solid #FBE6B2;
}
tr:last-of-type{
	border:none;
}
td{
	padding:3px;
}
.reg-btn{
	text-align: right;
	margin-bottom: 20px;
}
.team-btn{
    width: 150px;
}
button.col-1{
	margin-right: 10px;
}
/*@font-face {
    font-family: 'SuncheonB';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2202-2@1.0/SuncheonB.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
*{
	font-family:'SuncheonB';
}*/
</style>
<script type="text/javascript">
	$(function(){
		$("#datepicker").datepicker({
			language: 'ko'
		});
		
		$("select[name=addr1]").val("${param.addr1}");
		$("select[name=addr2]").val("${param.addr2}");
		$("select[name=teamLevel]").val("${param.teamLevel}");
		$("select[name=type]").val("${param.type}");
		$("input[name=searchWord]").val("${param.searchWord}");
		$("input[name=endDate]").val("${param.endDate}");
		
		
		$.ajax({
			type: "get",
			url: "/space/getlocations.do",
			success: function(data) {
				locations = data;
				var addr1 = [];
				
				for (var i = 0; i < data.length ; i++) {
					addr1[i] = data[i].addr1;
				}
				
				addr1 = addr1.filter((v, i) => addr1.indexOf(v) === i);
				
				for (var i = 0; i < addr1.length ; i++) {
					var html = "<option>" + addr1[i] + "</option>"
					$("#addr1").append(html);
				}

				$("select[name=addr1]").val("${param.addr1}");
				
				if ($("select[name=addr1]").val() != '') {
					showAddr2();
				}
			}
		})
	});
	
	function showAddr2() {
		
		if ($("#addr1").val() == "") {
			$("#addr2").val("");
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
	}	
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			팀원 모집
		</div>
		<div id="page-content">
			<form action="main.do">
				<div class="form">
					<input type="hidden" name="search" value="1">
					<div class="mb-3 d-inline-flex search-top">
						<select class="form-select form-select-sm col" name="addr1" id="addr1" onchange="showAddr2()">
							<option value="" selected hidden>지역</option>
						</select>
						<select class="form-select form-select-sm col" name="addr2" id="addr2">
							<option value="" selected hidden>지역을 선택하세요.</option>
						</select>
						<select class="form-select form-select-sm col" name="teamLevel">
							<option value="" selected hidden>팀 레벨</option>
							<option>초급</option>
							<option>중급</option>
							<option>고급</option>
						</select>
						<select class="form-select form-select-sm col" name="type">
							<option value="" selected hidden>분야</option>
							<option>밴드</option>
							<option>댄스</option>
						</select>
					</div>
					<br>
					<div class="mb-3 d-inline-flex search-bottom row">
						<input class="form-control form-control-sm col-4" type="text" placeholder="모집 기간 선택" id="datepicker" name="endDate">
						<input class="form-control form-control-sm col" type="text" placeholder="검색어를 입력하세요." name="searchWord">
						<button type="submit" class="accent-button normal-button col-1">검색하기</button>
						<button type="button" class="normal-button col-1" onclick="location.href='main.do'">초기화</button>
					</div>
				</div>
			</form>
			
			<div class="container">
				<div class="reg-btn">
					<c:if test="${login.mIdx ne null}">
						<button class="normal-button team-btn" onclick="location.href='/teams/register.do'">팀원모집 글작성</button>
					</c:if>
				</div>
				<div class="row row-cols-1 row-cols-sm-3">
					<c:if test="${teamsList.size()>0}">
					<c:forEach var="item" items="${teamsList}">
						<div class="col team-col" onclick="location.href='details.do?teamIdx=${item.teamIdx}'">
							<input type="hidden" name="teamIdx" value="${item.teamIdx}">
							<div class="team-list">
								<div class="team-title">
									[${item.type}] ${item.title}
								</div>
								<div class="team-content">
									<table>
										<tr>
											<td style="width: 75px;">지역</td>
											<td>${item.addr1} ${item.addr2}</td>
										</tr>
										<tr>
											<td>수준</td>
											<td>${item.teamLevel}</td>
										</tr>
										<tr>
											<td>장르</td>
											<td>${item.genre}</td>
										</tr>
										<tr>
										<c:if test="${item.type == '밴드'}">
											<td>파트</td>
											<td>
												
												<c:forEach var="parts" items="${partsMap.get(item.teamIdx)}" varStatus="lastPart">
													${parts.name} ${parts.capacity}명<c:if test="${!lastPart.last}">, </c:if>
												</c:forEach>
											</td>
										</c:if>
										<c:if test="${item.type == '댄스'}">
											<td>인원</td>
											<td>
												<c:forEach var="parts" items="${partsMap.get(item.teamIdx)}">
													${parts.capacity}명
												</c:forEach>
											</td>
										</c:if>
										</tr>
										<tr>
											<td>모집기간</td>
											<td>
												<fmt:parseDate value="${item.endDate}" var="endDate" pattern="yyyy-MM-dd"/>
												<fmt:formatDate value="${endDate}" pattern="yyyy년 MM월 dd일 마감"/>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						</c:forEach>
					</c:if>
					<c:if test="${teamsList.size()==0}">
					작성된 글이 존재하지 않습니다.
					</c:if>
				</div>
			</div>
		</div>
		
		
	</div>
	<c:import url="/footer.do" />
</body>
</html>