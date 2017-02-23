var old_pwd = document.getElementById('old_pwd');
var new_pwd = document.getElementById('new_pwd');
var repNew_pwd = document.getElementById('repNew_pwd');
var updPwd = document.getElementById('updPwd');
var oChPass = document.getElementById('changePass');
var oSpan = oChPass.getElementsByTagName('span');

/*
 * 这是关于修改资料的获取
 */
var changeInfo = document.getElementById('changeInfo');
var oSpan2 = changeInfo.getElementsByTagName('span');
var cardId = document.getElementById('cardId');
var name1 = document.getElementById('name');
var email_1 = document.getElementById('email_1');

old_pwd.onblur = function() {
	if (checkPassword(old_pwd.value)) {
		oSpan[0].style.display = 'none'
		return true;
	} else {
		oSpan[0].style.display = 'block';
		return false;
	}
};
new_pwd.onblur = function() {
	if (checkPassword(old_pwd.value)) {
		oSpan[1].style.display = 'none'
		return true;
	} else {
		oSpan[1].style.display = 'block';
		return false;
	}
};
repNew_pwd.onblur = function() {
	if (repNew_pwd.value === new_pwd.value) {
		oSpan[2].style.display = 'none'
		return true;
	} else {
		oSpan[2].style.display = 'block';
		return false;
	}
};
/*
 * function checkPass(tag, content, t) { if (checkPassword(tag)) { return true; }
 * else { oSpan.style.display = 'block' oSpan.innerHTML = content;
 * oSpan.style.top = t; return false; } }
 */

/*
 * 这是修改个人资料的验证
 */
email_1.onblur = function() {
	if (checkEmail(email_1.value)) {
		oSpan2[2].style.display = 'none'
		return true;
	} else {
		oSpan2[2].style.display = 'block';
		return false;
	}
};
cardId.onblur = function() {
	if (checkMyInfo(cardId.value)) {
		oSpan2[0].style.display = 'none'
		return true;
	} else {
		oSpan2[0].style.display = 'block'
		return false;
	}
};

name1.onblur = function() {
	if (checkMyName(name1.value)) {
		oSpan2[1].style.display = 'none'
		return true;
	} else {
		oSpan2[1].style.display = 'block';
		return false;
	}
};

/*
 * 一些验证的增则表达式
 */

function checkPassword(str) {
	var re = /^[a-zA-Z]\w{5,17}$/g;
	if (re.test(str)) {
		return true;
	} else {
		return false;
	}
}
function checkEmail(str) {
	var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/g
	if (re.test(str)) {
		return true;
	} else {
		return false;
	}
}
function checkMyInfo(str) {
	var re = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/g
	if (re.test(str)) {
		return true;
	} else {
		return false;
	}
}

function checkMyName(str) {
	var re = /^[\u4E00-\u9FA5]+(·[\u4E00-\u9FA5]+)*$/g;
	if (re.test(str)) {
		return true;
	} else {
		return false;
	}
}

function style() {

	var updPwd = document.getElementById('updPwd');
	var updInfo = document.getElementById('updInfo');

	updPwd.onmousemove = chColor;
	updPwd.onmouseout = backColor;
	updInfo.onmousemove = chColor;
	updInfo.onmouseout = backColor;

}

function chColor() {
	this.style.background = '#1e6602';
}

function backColor() {
	this.style.background = '#4f9a0a';
}

$('#updPwd').click(function() {

	$.ajax({

		url : "user/updatePwd",
		type : "POST",
		data : {

			old_pwd : $('#old_pwd').val(),
			new_pwd : $('#new_pwd').val(),
			repNew_pwd : $('#repNew_pwd').val()

		},
		success : function(data) {

			alert(data == 'true' ? "密码修改成功" : "密码修改失败");

		},
		error : function() {

			alert("失败");

		}
	})

	$('#updInfo').click(function() {

		$.ajax({
			url : "user/updUserInfo",
			type : "POST",
			data : {

				email : $('#email_1').val(),
				cardId : $('#cardId').val(),
				name : $('#name').val()

			},
			success : function(data) {

				if (data == 'true') {

					alert("密码修改成功");
					window.location.href = "index.jsp";
				} else {

					alert("旧密码错误或两次新密码不同");
				}

			},
			error : function() {

				alert("失败");

			}
		})

	})

})
function checkPass(tag, content, t) {
	if (checkPassword(tag)) {
		return true;
	} else {
		oSpan.style.display = 'block'
		oSpan.innerHTML = content;
		oSpan.style.top = t;
		return false;
	}
}

function checkPassword(str) {
	var re = /^[a-zA-Z]\w{5,17}$/g;
	if (re.test(str)) {
		return true;
	} else {
		return false;
	}
}
