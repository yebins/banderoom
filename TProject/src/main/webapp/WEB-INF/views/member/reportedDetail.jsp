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
<title>신고 상세</title>
<style>
#title {
    width: 100%;
    font-weight: bold;
    font-size: 25px;
    margin: 20px 0px;
}
#wrapper{
	padding-top: 0px!important;	
}
#content{
	border: 1px solid lightgray;
    padding: 5px;
    margin: 10px 0px;
    border-radius: 15px;
}
pre{
	font-family: '맑은 고딕';
}
.inner-box-button-wrap{
	margin-top:20px;
}
</style>
<script>

	function block(target){
		if(confirm('해당 회원을 차단하시겠습니까?')){
			$.ajax({
				url:"block.do",
				type:"post",
				data:"target="+target,
				success:function(data){
					if(data == "ok"){
						alert('차단이 완료되었습니다.');
						window.close();
					}else{
						alert('차단이 완료되지 않았습니다.');
					}
				}
			})
		}
	}
	
	function withdraw(target){
		if(confirm('해당 회원을 추방하시겠습니까?')){
			$.ajax({
				url:"withdraw.do",
				type:"post",
				data:"mIdx="+target + "&memberType=general",
				success:function(data){
					if(data == "ok"){
						alert('추방이 완료되었습니다.');
						window.close();
					}else{
						alert('추방이 완료되지 않았습니다.');
					}
				}
			})
		}
	}
	
	function deleteReport(rIdx){
		if(confirm('해당 신고글을 삭제하시겠습니까?')){
			$.ajax({
				url:"deleteReport.do",
				type:"post",
				data:"rIdx="+rIdx,
				success:function(data){
					if(data == "ok"){
						alert('신고글 삭제가 완료되었습니다.');
						window.close();
					}else{
						alert('신고글 삭제가 완료되지 않았습니다.');
					}
				}
			})
		}
	}
	
</script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<div id="wrapper" style="width:580px;">
		<div id="title">
			신고내용 보기
		</div>
		<div id="page-content">
			<div class="inner-box">
				<div>회원 닉네임 &nbsp;<b>${reportedDetail.targetname}</b></div><br>
				<div>신고 내용</div>
				<div id="content"><pre>${reportedDetail.content}</pre></div>
			</div>
			<div class="inner-box-button-wrap">
				<button class="normal-button" onclick="block(${reportedDetail.target})">회원 차단</button> &nbsp;&nbsp;
				<button class="normal-button" onclick="withdraw(${reportedDetail.target})">회원 추방</button> &nbsp;&nbsp;
				<button class="normal-button accent-button" onclick="deleteReport(${reportedDetail.rIdx})" style="width: 120px;">신고글 삭제</button>
			</div>
		</div><!-- page-content -->
	</div><!-- wrapper -->
</body>
</html>