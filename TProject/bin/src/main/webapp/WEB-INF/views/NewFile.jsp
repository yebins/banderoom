<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
  

    var IMP = window.IMP; 
    IMP.init('imp34520606'); 
    
    function pay() {
    	

        IMP.request_pay({
        		pg : "kakaopay", 
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : $('input[name=mname]').val(),
            amount : $('input[name=amount]').val(),
            buyer_email : $('input[name=email]').val(),
            buyer_name : $('input[name=name]').val(),
            buyer_tel : $('input[name=tel]').val(),
            buyer_addr : $('input[name=addr]').val(),
            buyer_postcode : $('input[name=postcode]').val()
        }, function(rsp) {
            if ( rsp.success ) {
							$.ajax({
								url: "payProcess.do",
								type: "post",
								data: "imp_uid=" + rsp.imp_uid + "&merchant_uid=" + rsp.merchant_uid,
								success: function() {
									alert('결제 성공!');
									location.href='<%=request.getContextPath()%>/newfile.do';
								}
							});
            } else {
                var msg = '결제에 실패하였습니다.';
                rsp.error_msg;
                
            }
        });

    }

    </script>
</head>
<body>
	<table>
	<tr>
		<td>
		상품명
		</td>
		<td>
	<input type="text" name="mname">
		</td>
	</tr>
	<tr>
		<td>
		가격
		</td>
		<td>
	<input type="text" name="amount">
		</td>
	</tr>
	<tr>
		<td>
		이메일
		</td>
		<td>
	<input type="text" name="email">
		</td>
	</tr>
	<tr>
		<td>
		이름
		</td>
		<td>
	<input type="text" name="name">
		</td>
	</tr>
	<tr>
		<td>
		전화번호
		</td>
		<td>
	<input type="text" name="tel">
		</td>
	</tr>
	<tr>
		<td>
		주소
		</td>
		<td>
	<input type="text" name="addr">
		</td>
	</tr>
	<tr>
		<td>
		우편번호
		</td>
		<td>
	<input type="text" name="postcode">
		</td>
	</tr>
	</table>
	<button onclick="pay()">결제</button>
</body>
</html>