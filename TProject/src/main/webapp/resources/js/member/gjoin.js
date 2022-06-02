
 	var emailChecked = false;
	var pwChecked = false;
	var nickChecked = false;
	var telChecked = false;
	
	function profileUpload() {
		
		var formData = new FormData($('#profile')[0])
		$.ajax({
			url: "profileUpload.do",
			type: "post",
			data: formData,
			contentType: false,
			processData: false,
			success: function(data) {
				$('div.profile-picture').html("<img src='" + data + "' width='160px'>");
				$('input[name=profileSrc]').val(data);
			}
		});
		
	}
	
	function profileReset() {
		$('#profile')[0].reset();
		$('div.profile-picture').html("<img src='/banderoom/images/profile_default.png' width='160px'>");
		$('input[name=profileSrc]').val('/banderoom/images/profile_default.png');
	}

	function chkEmail(obj) {
		emailChecked = false;
		$(obj).next().addClass("accent-button");
	}

	function sendEmail(obj) {
		var email = $('input[name=email]').val();
		var button = $(obj);
		$(button).attr("disabled", true);
		$(button).text("• • •");

		if (email == null || email == '') {
			$(button).attr("disabled", false);
			$(button).text("이메일 인증");
			return;
		}

		$.ajax({
			type : "post",
			url : "sendEmail.do",
			data : "email=" + email + "&memberType=general", // 중복 체크를 일반과 호스트회원 각각 해야하므로 변수로 넣어줌
			success : function(data) {

				if (data == 2) {
					alert('이미 존재하는 이메일입니다.');
					$(button).attr("disabled", false);
					$(button).text("이메일 인증");
				} else if (data == 0) {
					$(button).attr("disabled", false);
					$(button).text("이메일 인증");
					$(button).removeClass("accent-button");
					$(".email-field2").css("display", "flex");
				}
			}
		})
	}

	function checkEmailKey() {
		var email = $('input[name=email]').val();
		var regkey = $('#email-key').val();

		if (regkey == null || regkey == '') {
			alert('값을 입력해 주세요.');
			return;
		}

		$.ajax({
			type : "post",
			url : "checkEmail.do",
			data : "email=" + email + "&regkey=" + regkey,
			success : function(data) {
				if (data == 0) {
					emailChecked = true;
					alert('인증이 완료되었습니다.');
					$(".email-field2").css("display", "none");
				} else if (data == 1) {
					alert('해당 이메일로 보낸 인증 키가 없습니다.\n다시 보내 주세요.');
				} else if (data == 2) {
					alert('인증 키가 일치하지 않습니다.');
				} else if (data == 3) {
					alert('인증 시간이 만료되었습니다.');
				}
			}
		})
	}

	function chkPw() {
		var pwReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/;

		pwChecked = false;
		if ($("#pw1").val() == $("#pw2").val() && pwReg.test($("#pw1").val())) {
			pwChecked = true;
			$("span.pwCheck-message").text("");
		} else {
			if($("#pw2").val() != '') {
				
				if ($("#pw1").val() != $("#pw2").val()) {
					$("span.pwCheck-message").text("비밀번호가 일치하지 않습니다.");
				} else if (!pwReg.test($("#pw1").val())) {
					$("span.pwCheck-message").text("영문, 숫자, 기호 포함 8~20자 입력해주세요.");
				}
			}
		}
	}
	
	function checkNickAlert(obj) {
		nickChecked = false;
		$(obj).next().addClass("accent-button");
	}
	
	const getByteLengthOfString = function(s,b,i,c){
	    for(b = i = 0; c = s.charCodeAt(i++); b += c >> 11 ? 3 : c >> 7 ? 2 : 1);
	    return b;
	};
	
	function checkNickname(obj) {
		var nickname = $("input[name=nickname]").val();
		
		if (nickname == null || nickname == '') {
			return;
		}
				
		if (getByteLengthOfString(nickname) > 30) {
			alert('닉네임은 한글 10자, 영문 30자 이내로 입력하세요.');
			return;
		}
		
		$(obj).attr("disabled", true);
		$(obj).text("• • •");

		$.ajax({
			type : "post",
			url : "checkNickname.do",
			data : "nickname=" + nickname + "&memberType=general",
			success : function(data) {
				if (data == 1) {
					alert('이미 존재하는 닉네임입니다.');
				} else if (data == 0) {
					alert('사용 가능한 닉네임입니다.')
					$(obj).removeClass("accent-button");
					nickChecked = true;
				}
				$(obj).attr("disabled", false);
				$(obj).text("중복 확인");
			}
		})
	}
	
	function nameMaxLengthCheck(input) {
		var name = $(input).val();
		if (getByteLengthOfString(name) > 20) {
			
			$(input).val(name.getStringFromByteLength(20));
		}
	}
	
	String.prototype.getStringFromByteLength = function( length ) {
    const contents = this;
    let str_character;
    let int_char_count = 0;
    let int_contents_length = contents.length;

    let returnValue = '';

    for (k = 0; k < int_contents_length; k++) {
        str_character = contents.charAt(k);
        if (escape(str_character).length > 4)
            int_char_count += 2;
        else
            int_char_count++;

        if ( int_char_count > length ) {
            break;
        }
        returnValue += str_character;
    }
    return returnValue;
}
	

	function searchAddr() {
		new daum.Postcode({
			oncomplete : function(data) {
				$('input[name=address]').val(
						data.address + " ("
								+ data.bname + ")");
				$('input[name=addressDetail]').val(
						data.buildingName);
				$('input[name=addr1]').val(data.sido);
				$('input[name=addr2]').val(data.sigungu);
			}
		}).open();
	}

	function chkPhoneType(type, obj) {
		var input = $(obj).val();

		//focus out인 경우 
		//input type을 text로 바꾸고 '-'추가
		if (type == 'blur') {
			$(obj).prop('type', 'text');
			var phone = chkItemPhone(input);
		}

		//focus인 경우
		//input type을 number로 바꾸고 '-' 제거
		if (type == 'focus') {
			var phone = input.replace(/-/gi, '');
			$(obj).prop('type', 'number');
		}

		$(obj).val(phone);
	}

	function chkItemPhone(temp) {
		var number = temp.replace(/[^0-9]/g, "");
		var phone = "";

		if (number.length < 9) {
			return number;
		} else if (number.length < 10) {
			phone += number.substr(0, 2);
			phone += "-";
			phone += number.substr(2, 3);
			phone += "-";
			phone += number.substr(5);
		} else if (number.length < 11) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 3);
			phone += "-";
			phone += number.substr(6);
		} else {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 4);
			phone += "-";
			phone += number.substr(7);
		}

		return phone;
	}
	function maxLengthCheck(object) {
		if (object.value.length > 11) {
			object.value = object.value.slice(0, 11);
		}
	}
	
	function checkPhone(obj) {
		var tel = $('#tel-input').val()
		$(obj).attr("disabled", true);
		$(obj).text("• • •");

		if (tel == null || tel == '') {
			$(obj).attr("disabled", false);
			$(obj).text("휴대폰 인증");
			return;
		}

		
		$.ajax({
			type: "post",
			url: "sendSms.do",
			data: "tel=" + tel,
			success: function() {

				$(obj).attr("disabled", false);
				$(obj).text("휴대폰 인증");
				$(obj).removeClass("accent-button");
				$(".tel-field").css("display", "flex");
			}
		})
	}
	
	function checkTelAlert(obj) {
		telChecked = false;
		$(obj).next().addClass("accent-button");
	}
	

	function checkTelKey() {
		var tel = $('input[name=tel]').val();
		var regkey = $('#tel-key').val();

		if (regkey == null || regkey == '') {
			alert('값을 입력해 주세요.');
			return;
		}

		$.ajax({
			type : "post",
			url : "checkTel.do",
			data : "tel=" + tel + "&regkey=" + regkey,
			success : function(data) {
				if (data == 0) {
					telChecked = true;
					alert('인증이 완료되었습니다.');
					$(".tel-field").css("display", "none");
				} else if (data == 1) {
					alert('해당 번호로 보낸 인증 키가 없습니다.\n다시 보내 주세요.');
				} else if (data == 2) {
					alert('인증 키가 일치하지 않습니다.');
				} else if (data == 3) {
					alert('인증 시간이 만료되었습니다.');
				}
			}
		})
	}
	
	function resetAllForms() {
		$('form').each(function() {
			this.reset();
		});
	}
	
	function submitAllForms(obj) {
		if (!emailChecked) {
			alert('이메일 인증이 필요합니다.');
			return;
		}
		if (!pwChecked) {
			alert('비밀번호를 확인해 주세요.');
			return;
		}
		if (!nickChecked) {
			alert('닉네임 중복 확인이 필요합니다.');
			return;
		}
		if (!telChecked) {
			alert('휴대폰 인증이 필요합니다.');
			return;
		}
		if (!$("#term-1").is(":checked") || !$("#term-2").is(":checked")) {
			alert('약관에 동의가 필요합니다.');
			return;
		}
		
		if (
				$('input[name=name]').val() == '' ||
				$('input[name=name]').val() == null ||
				$('input[name=name]').val() == undefined ||
				$('input[name=address]').val() == '' ||
				$('input[name=address]').val() == null ||
				$('input[name=address]').val() == undefined ||
				$('input[name=gender]:checked').val() == '' ||
				$('input[name=gender]:checked').val() == null ||
				$('input[name=gender]:checked').val() == undefined) {
			
			alert('필수 항목을 입력해 주세요.');
			return;
		}

		$(obj).text("• • •");
		
		$.ajax({
			type: "post",
			url: "gjoin.do",
			data: $('form.joinform').serialize(),
			success: function(data) {
				if (data > 0) {
					// 성공
					alert("회원가입이 완료되었습니다.");
					location.href='/';
					
				} else {
					// 실패
					alert("가입에 실패했습니다. 다시 시도해 주세요.");
					location.href='/';
				}
			}
		})
		
	}
	
	function viewTerms(idx) {
		$("#term-wrap-" + idx).css("display", "flex");
		$("#term-wrap-" + idx).animate({opacity: "100%"}, 200);
	}
	
	function closeTerms(obj) {
		$(obj).parent().animate({opacity: "0%"}, 200);
		setTimeout(function() {
			$(obj).parent().css("display", "none");
		}, 200);
	}