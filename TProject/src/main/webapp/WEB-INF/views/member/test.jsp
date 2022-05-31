<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<script>
	function checkBrn() {
		var data = {
				"businesses": [{
					"b_no": $("input[name=brn]").val(),
					"start_dt": $("input[name=date]").val(),
					"p_nm": $("input[name=name]").val()
				}]
		};
		
		$.ajax({
		  url: "https://api.odcloud.kr/api/nts-businessman/v1/validate?serviceKey=58YTOvncdGMmTAyN6eM%2BJwhKNB6c%2B3LyMDrEz1dSE2cLLuB32zXm9pHfGwovijlUJMVqfnk1h6%2FhFGEWpsDPGg%3D%3D",  // serviceKey 값을 xxxxxx에 입력
		  type: "POST",
		  data: JSON.stringify(data), // json 을 string으로 변환하여 전송
		  dataType: "JSON",
		  contentType: "application/json",
		  accept: "application/json",
		  success: function(result) {
		      console.log(result);
		  },
		  error: function(result) {
		      console.log(result.responseText); //responseText의 에러메세지 확인
		  }
		});
	}
</script>


</head>
<body>
	<input type="text" name="brn">
	<input type="text" name="name">
	<input type="text" name="date">
	<button class="normal-button" onclick="checkBrn()">확인</button>
</body>
</html>