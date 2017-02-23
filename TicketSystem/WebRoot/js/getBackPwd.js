var checkFlag = false;

function checkAccount(obj) {

	if ($(obj).val() == "") {

		$('#val_status').text("帐号不能为空")
		return;
	}
	$.ajax({

		url : "user/queryRepeatUser",
		type : "POST",
		async : false,
		data : {

			u : $(obj).val()

		},
		success : function(data) {

			if (data == 'true') {

				$('#val_status').text("帐号不存在")
				checkFlag = false;
			} else {

				$('#val_status').text("")
				checkFlag = true;

			}
		}
	})

}
function getCode(obj) {

	if (checkFlag == false) {

		alert("请填写正确的帐号")
		return;
	}

	$(obj).attr('disabled', 'true');
	$('#val_status').text('')
	timeTask();
	$.ajax({

		url : "user/getUserEmail",
		type : "POST",
		success : function(data) {

			$('#val_status').text("验证码已放送至邮箱" + data);
			sendMail();

		}

	})

}
function sendMail() {

	$.ajax({

		url : "user/validateCodeSend",
		type : "POST"
	})
}

function timeTask() {

	var obj = $('.getdata');
	var time = ($.cookie('code_time') > 0 && $.cookie('code_time') <= 60) ? $
			.cookie('code_time') : 60;
	$(obj).val(time + "后重新获取")
	time--;
	$.cookie('code_time', time)
	var t;
	if (time == 0) {

		$.cookie('code_time', null);
		$(obj).removeAttr('disabled');
		$(obj).val("获取验证码");
		return;
	}
	setTimeout('timeTask()', 1000);

}
function validate() {

	var code = $('.data').val();
	if (code == "") {

		$('#val_status').text("验证码不能为空");
		return;
	}
	$.ajax({

		url : "user/valiCodeJude",
		type : "POST",
		data : {
			code : code,

		},
		success : function(data) {

			if (data == "false") {

				alert("验证码错误或超时")

			} else {

				$('#forgrt1').css('display', 'none');
				$('#forgrt2').css('display', 'block');
			}

		}

	})

}
function resetPwd() {

	var newPwd = $('.newPwd').val();
	var reNewPwd = $('.reNewPwd').val();

	if (newPwd == "" || reNewPwd == "") {

		$('#val_status1').text("密码不能为空")
		return;
	}

	if (newPwd != reNewPwd) {

		$('#val_status1').text("两次输入的密码不一致")
		return;
	}
	if (checkPwd(newPwd) && checkPwd(reNewPwd)) {

		$.ajax({

			url : "user/forgetPwd",
			type : "POST",
			data : {

				u : $('.account').val(),
				p : newPwd,
				rp : reNewPwd

			},
			success : function(data) {

				if (data == "true") {

					alert("密码重置成功");
					logout();
					// window.location.href = "index.jsp"
				} else {

					$('#val_status1').text("重置失败，请稍后再试")
				}

			}

		})

	} else {

		$('#val_status1')
		text("密码格式错误")
	}

}
function checkPwd(str) {

	var re = /^[a-zA-Z]\w{5,17}$/;
	if (re.test(str)) {

		return true;

	}
	return false;

}