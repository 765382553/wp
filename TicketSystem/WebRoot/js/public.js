/*设置状态变量*/
$(function() {
	var f1 = false;
	var f2 = false;
	var f3 = false;
	var f4 = false;
	$(".line_left").css("left", 0);
})

/* 自动登录 */
function autoLogin() {

	if (!($.cookie('user_account') == "null" || $.cookie('user_account') == null)) {

		showUser($.cookie('user_account'));
		$(".wrap").fadeOut();

		$(".login").addClass("personmenu");
		$(".login").removeClass("login");
		$(".pop_login").fadeOut();
		$.cookie("user_account", null);
		$.cookie("user_email", null);
		$.cookie("user_cardId", null);
		$.cookie("user_name", null);


	}

}

/* 登录 */
function login() {
	$('.login_btn').click(function() {

		var u = $('#user1').val();
		var p = $('#password1').val();
		
		if(u==""||p==""){
		
			alert("帐号或密码不能为空");
			return;
		}
		
		$.ajax({

			url : "user/login",
			data : {

				u : u,
				p : p

			},
			method : "POST",
			async : true,
			dataType : "text",
			success : function(data) {

				if (data != "{}") {

					var dataJson = $.parseJSON(data);
					// alert("欢迎您,"+$('#user1').val());
					var userName = $("#user1").val();
					showUser(userName);

					$(".wrap").fadeOut();

					$(".login").addClass("personmenu");
					$(".login").removeClass("login");
					$(".pop_login").fadeOut();
					$.cookie("user_account", dataJson.account);
					$.cookie("user_email", dataJson.email);
					$.cookie("user_cardId", dataJson.cardId);
					$.cookie("user_name", dataJson.name);

				} else {

					alert("账号密码错误");
				}

			},
			error : function() {

				alert("连接服务器失败！")
			}

		})

	});
}

/* 注册 */
function register() {

	$('.reg_btn').click(function() {

		if (f1 == false || f2 == false || f3 == false || f4 == false) {

			alert("请认真填写");
			return;
		}

		$.ajax({

			url : "user/register",
			data : {

				u : $('#user2').val(),
				p : $('#password2').val(),
				rp : $('#confirPassword').val(),
				mail : $('#email').val()

			},
			method : "POST",
			success : function(msg) {

				if (msg == "true") {

					$.cookie("user_account", dataJson.account);
					$.cookie("user_email", dataJson.email);
					$.cookie("user_cardId", dataJson.cardId);
					$.cookie("user_name", dataJson.name);
					window.location.reload();

				} else {

					alert(msg);
				}
			},
			error : function() {

				alert("服务器链接失败，请稍后再试");
			}

		});

	});

}

/* 登出 */
function logout() {

	$('#logout').click(function() {

		$.ajax({

			url : "user/logout",
			method : "POST",
			complete : function() {

				$.cookie("user_account", null);
				$.cookie("user_email", null);
				$.cookie("user_cardId", null);
				$.cookie("user_name", null);

				if (location.pathname.indexOf("showTickets") > 0) {

					return;
				}
				window.location.href = "index.jsp";

			}

		})

	});

}

/* 部分样式效果与验证函数 */
function x() {

	$('#horizontalTab').easyResponsiveTabs({
		type : 'default',
		// Types: default, vertical, accordion
		width : 'auto',
		// auto or any width like 600px
		fit : true
	// 100% fit in a container
	});

}
function y() {

	$('.flexslider').flexslider({
		animation : "slide",
		start : function(slider) {
			$('body').removeClass('loading');
		}
	});

}

$("#login").click(function() {

	$(".line_right").css("left", "100%");
	$(".line_left").css("left", 0);
	$(this).css("color", "#fff");
	$(".cont1").css("display", "block");
	$(".cont2").css("display", "none");

})
$("#reg").click(function() {
	$(".line_left").css("left", "-50%");
	$(".line_right").css("left", "50%");
	$(this).css("color", "#fff");
	$(".cont1").css("display", "none");
	$(".cont2").css("display", "block");
})
$("nav a.login").click(function() {
	if ($("#loginandinfo").hasClass("login")) {
		$(".pop_login").fadeIn();
		$(".wrap").fadeIn();
	} else {
		if ($("#menu").css('display') == 'block') {
			$("#menu").fadeOut();
		} else {
			$("#menu").fadeIn();
		}
	}
});

$(".wrap").click(function() {
	$(".pop_login").fadeOut();
	$(".wrap").fadeOut();
})
// 字母、数字、下划线组成，字母开头，4-16位。
function checkUser(str) {
	var re = /^[a-zA-z]\w{3,15}$/;
	if (re.test(str)) {
		f1 = true;
		$("#user2").next().removeClass("error_user");
		checkRepeatUser(str);

	} else {
		f1 = false;
		$("#user2").next().addClass("error_user");
	}
}
// 验证规则：姑且把邮箱地址分成“第一部分@第二部分”这样
// 第一部分：由字母、数字、下划线、短线“-”、点号“.”组成，
// 第二部分：为一个域名，域名由字母、数字、短线“-”、域名后缀组成，
// 而域名后缀一般为.xxx或.xxx.xx，一区的域名后缀一般为2-4位，如cn,com,net，现在域名有的也会大于4位
function checkEmail(str) {
	var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
	if (re.test(str)) {
		f4 = true;
		$("#email").next().removeClass('error_email');
	} else {
		f4 = false;
		$("#email").next().addClass('error_email');
	}
}
// 密码(以字母开头，长度在6~18之间，只能包含字母、数字和下划线)
function checkPassword(str) {
	var re = /^[a-zA-Z]\w{5,17}$/;
	if (re.test(str)) {
		f2 = true;
		$("#password2").next().removeClass("error_password");
	} else {
		f2 = false;
		$("#password2").next().addClass("error_password");
	}
}
// 两次输入密码是否相同
function checkPasswordIsSame(pwd) {
	var pwd2 = $("#password2")[0].value;
	if (pwd == pwd2) {
		f3 = true;
		$("#confirPassword").next().removeClass("error_confirPassword");
	} else {
		f3 = false;
		$("#confirPassword").next().addClass("error_confirPassword");
	}
}

function showUser(userName) {
	$(".login").empty();
	var wel = document.createElement("span");
	var t = document.createTextNode("欢迎您，");
	wel.appendChild(t);
	$(".login").append(wel);
	var name = document.createElement("span");
	var name_t = document.createTextNode(userName);
	name.appendChild(name_t);
	$(".login").append(name_t);
	var untils = document.createElement("span");
	$(untils).addClass("allow");
	$(".login").append(untils);
	$(".pop_login").fadeOut();
	$(".wrap").fadeOut();
	$(".login").addClass("personmenu");
	$(".login").removeClass("login");
}

function checkRepeatUser(str) {

	$.ajax({
		url : "user/queryRepeatUser",
		data : {
			u : str
		},
		dataType : "text",
		async : false,
		success : function(data) {

			if (data == "false") {
				// alert("该用户名已注册");
				$("#user2").next().next().addClass("error_repeat");
				f1 = false;
			} else {
				$("#user2").next().next().removeClass("error_repeat");
				f1 = true;
			}
		}
	})
}
$('#menu').mouseleave(function() {

	$('#menu').css('display', 'none');
})