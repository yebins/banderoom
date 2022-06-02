<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>

<style>
.terms-list{
    padding-left: 5px;
}
.terms{
    padding: 6px;
    font-size: 14px;
    margin-right:5px;
}
#title{
	font-size: 25px;
    padding: 10px;
}
#writer{
    padding: 10px;
    position: relative;
}
#deadline{
	color: #303030;
    /* border: 1px solid #FB6544; */
    background: #2A3F6A;
    border-radius: 20px;
    padding: 6px;
    font-size: 13px;
    margin-left: 10px;
    box-shadow: 1px 1px 4px 0px rgb(0 0 0 / 20%);
}
#content{
	width:100%;
	min-height:500px;
	margin:30px 0px;
}
.inner-box{
	margin-bottom: 50px;
}
.normal-button{
	margin-right: 8px;
}
.date{
	position: absolute;
	right: 0px;
}
.midx:hover{
	cursor: pointer;
}
#endPost{
	text-align: center;
    font-size: 25px;
}
#delete{
    text-align: center;
    font-size: 25px;
}
.psrc{
	border-radius:12.5px;
	box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
	width:25px;
	margin-right:10px;
}
.big-title {
	font-size: 20px;
    font-weight: bold;
    margin-bottom: 20px;
}
#myChart-div{
	width:500px;
}

</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.0.0/dist/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
<script type="text/javascript">

	function deleteFn(){
		
		if(confirm('정말 삭제하시겠습니까?')){
			$.ajax({
			url:"delete.do",
			type:"post",
			data:"teamIdx="+$("#teamIdx").val(),
			success:function(data){
					if(data = "ok"){
						alert('삭제되었습니다.');
						location.replace('main.do');
					}else{
						alert('글 삭제가 완료되지 않았습니다.');
					}
				}
			});
		}
	}
	
	function applyPopup(){
		if(${login == null}){
			alert('로그인해주세요.');
			location.href = "/member/glogin.do";
		}
		else if(${login.auth == 1}){
			alert('차단된 회원은 지원하실 수 없습니다.');
		}
		else{
		window.open('application.do?teamIdx=${details.teamIdx}', '_blank', 
        'top=140, left=300, width=600, height=600, menubar=no,toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');
		}
	}
	
	
</script>



<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>${details.title}</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			팀원 모집
		</div>
		<div id="page-content">
			<c:if test='${details.status!=1}'>
				<div class="inner-box" <c:if test='${details.status==2}'>style="filter: brightness(0.8);"</c:if>>
					<input type="hidden" name="teamIdx" id="teamIdx" value="${details.teamIdx}">
					<c:if test='${details.status==2}'>
						<div id="endPost">마감된 글입니다.</div>
					</c:if>
					<div id="title">[${details.type}] ${details.title}</div>
					<div id="writer">
					
						<a class="miniprofile" onclick="profileOpen('${details.mIdx}')">
							<img src="${profileSrc}" class="psrc"/>
							<span style="font-weight:600;vertical-align: middle;">${details.mNickname}</span>						
						</a>
					
						<span class="terms date"><b>작성일자</b> <fmt:formatDate value="${details.regDate}" pattern="yyyy년 MM월 dd일 HH시 mm분"/></span>
					</div>
					<hr style="margin-top: 0px; margin-bottom:25px;">
					
					<div class="terms-list">
						<span class='terms'><b>지역</b> &nbsp;${details.addr1} ${details.addr2}</span>
						<span class='terms'><b>팀 레벨</b> &nbsp;${details.teamLevel}</span>
						<span class='terms'><b>장르</b> &nbsp;${details.genre}</span>
					</div>
					<div class="terms-list">
						<span class='terms'><b>파트/인원</b> &nbsp;
							<c:forEach var="parts" items="${parts}" varStatus="lastPart">
							${parts.name} ${parts.capacity}명<c:if test="${!lastPart.last}">, </c:if>
							</c:forEach>
						</span>
					</div>
					<div class="terms-list">
						<span class='terms'><b>마감날짜 </b> &nbsp;
							<fmt:parseDate value="${details.endDate}" var="endDate" pattern="yyyy-MM-dd"/>
							<fmt:formatDate value="${endDate}" pattern="yyyy년 M월 d일"/>
						</span>
					</div>
					<div class="inner-box-content">
						<div id="content" class="form-control">${details.content}</div>
					</div>
					<div class="inner-box-button-wrap">
					<c:if test="${details.status==0}">
						<c:if test="${details.mIdx == login.mIdx}">
							<button type="button" class="normal-button" onclick="location.href='update.do?teamIdx=${details.teamIdx}'">수정</button> 
							<button type="button" class="normal-button" onclick="deleteFn()">삭제</button>
						</c:if>
						<c:if test="${details.mIdx != login.mIdx}">
							<button type="button" class="normal-button accent-button" onclick="applyPopup()">지원하기</button> 
						</c:if>
					</c:if>
					</div>
					<div id="statistics" style="margin: 30px;">
						<div class="big-title">
							지원자 현황
						</div>
						<div id="myChart-div">
							<canvas id="myChart"></canvas>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test='${details.status==1}'>
				<div id="delete">삭제된 글입니다.</div>
			</c:if>
			
		</div>
	</div>
	
	
<script>
//차트를 그럴 영역을 dom요소로 가져온다.
var chartArea = document.getElementById('myChart').getContext('2d');
// 차트를 생성한다. 
var myChart = new Chart(chartArea, {
    // ①차트의 종류(String)
    type: 'bar',
    plugins:[ChartDataLabels],
    // ②차트의 데이터(Object)
    data: {
        // ③x축에 들어갈 이름들(Array)
        labels: [
        	<c:forEach var="parts" items="${cntList}" varStatus="lastPart">
        	'${parts.name}'<c:if test="${!lastPart.last}">, </c:if>
			</c:forEach>
        	],
        // ④실제 차트에 표시할 데이터들(Array), dataset객체들을 담고 있다.
        datasets: [{
            // ⑤dataset의 이름(String)
            label: '지원자수',
            // ⑥dataset값(Array)
            data: [
            	<c:forEach var="parts" items="${cntList}" varStatus="lastPart">
            	'${parts.cnt}'<c:if test="${!lastPart.last}">, </c:if>
    			</c:forEach>
            ],
            // ⑦dataset의 배경색(rgba값을 String으로 표현)
            backgroundColor: ['rgba(255, 99, 132, 0.2)',
				              'rgba(255, 159, 64, 0.2)',
				              'rgba(255, 205, 86, 0.2)',
				              'rgba(75, 192, 192, 0.2)',
				              'rgba(54, 162, 235, 0.2)',
				              'rgba(153, 102, 255, 0.2)'],
            // ⑧dataset의 선 색(rgba값을 String으로 표현)
            borderColor: ['rgb(255, 99, 132)',
		                  'rgb(255, 159, 64)',
		                  'rgb(255, 205, 86)',
		                  'rgb(75, 192, 192)',
		                  'rgb(54, 162, 235)',
		                  'rgb(153, 102, 255)'],
            // ⑨dataset의 선 두께(Number)
            borderWidth: 1
        }]
    },
    // ⑩차트의 설정(Object)
    options: {
    	maxBarThickness:30,
    	indexAxis: 'y',
    	legend: {
    	      display: false
    	   },
    	scales: {
            x: {
            	display:false
                /*suggestedMax:function(){
                	var cntList = new Array();
                	<c:forEach var="cntList" items="${cntList}">
                		cntList.push("${cntList.cnt}");
        			</c:forEach>
        			var cnt = 0;
        			for (var i = 0; i < cntList.length; i++) {
        			    cnt += parseInt(cntList[i]);
        			}
        			return cnt;
                }*/
            }
        }
    }
});
</script>

	<c:import url="/footer.do" />
</body>
</html>