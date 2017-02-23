<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>用户反馈</title>
<script src="js/jquery-2.1.4.min.js"></script>
<script>
	//移动 
	function startMove(obj, json, fnEnd) {
		if (obj.timer) {
			clearInterval(obj.timer);
		}
		obj.timer = setInterval(function() {
			doMove(obj, json, fnEnd);
		}, 30);

		var oDate = new Date();

		if (oDate.getTime() - obj.lastMove > 30) {
			doMove(obj, json, fnEnd);
		}
	}

	function getStyle(obj, attr) {
		if (obj.currentStyle) {
			return obj.currentStyle[attr];
		} else {
			return getComputedStyle(obj, false)[attr];
		}
	}

	function doMove(obj, json, fnEnd) {
		var iCur = 0;
		var attr = '';
		var bStop = true; //假设运动已经该停止了

		for (attr in json) {
			if (attr == 'opacity') {
				iCur = parseInt(100 * parseFloat(getStyle(obj, 'opacity')));
			} else {
				iCur = parseInt(getStyle(obj, attr));
			}

			if (isNaN(iCur)) {
				iCur = 0;
			}

			var iSpeed = (json[attr] - iCur) / 8;
			iSpeed = iSpeed > 0 ? Math.ceil(iSpeed) : Math.floor(iSpeed);

			if (parseInt(json[attr]) != iCur) {
				bStop = false;
			}

			if (attr == 'opacity') {
				obj.style.filter = "alpha(opacity:" + (iCur + iSpeed) + ")";
				obj.style.opacity = (iCur + iSpeed) / 100;
			} else {
				obj.style[attr] = iCur + iSpeed + 'px';
			}
		}

		if (bStop) {
			clearInterval(obj.timer);
			obj.timer = null;

			if (fnEnd) {
				fnEnd();
			}
		}

		obj.lastMove = (new Date()).getTime();
	}

	function submitInfo() {

		var name = $('#name').val();
		var email = $('#email').val();
		var content = $('#content').val();

		if (name == "" || email == "" || content == "") {

			alert("都是必填项，不能为空哦");
			return;

		}
		if (!checkEmail(email)) {

			alert("邮箱格式不对，重新填写吧");
			return;

		}

		$.ajax({

			url : "back/addBackInfo",
			type : "POST",
			data : {

				name : name,
				email : email,
				content : content

			},
			success : function(data) {

				if (data == "true") {

					alert("提交成功，工作人员会尽快处理哦");
					location.href = "index.jsp";
				} else {

					alert("操作失败,请稍后再试吧..")
				}
			},
			error : function(data) {

				alert("服务器连接失败")

			}

		})

	}

	function checkEmail(str) {
		var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;

		return re.test(str);
	}
</script>
<style>
#userback {
	width: 800px;
	padding: 20px 50px;
	border: 1px solid grey;
	margin: 0 auto;
	position: relative;
}

#userback #quick {
	position: absolute;
	top: 20px;
	right: 20px;
	width: 74px;
	height: 20px;
	padding: 5px;
	border: 1px solid darkgray;
	overflow: hidden;
	color: white;
}

#quick p {
	margin: 0;
	padding: 0;
	text-align: left;
}

#quick ul {
	margin-top: 20px;
	padding: 20px 40px;
}

#quick li {
	list-style: none;
	color: red;
	width: 260px;
	height: 30px;
	padding: 5px;
}

#quick ul a {
	text-decoration: none;
}

.user {
	text-indent: 1em;
	width: 300px;
	height: 25px;
	padding: 5px;
	border-radius: 1px;
	display: block;
	border: 1px solid gainsboro;
	outline: none;
	font-size: 15px;
	color: grey;
}

#userback p {
	font-size: 18px;
	color: black;
}

#userback textarea {
	display: block;
	width: 700px;
	height: 200px;
	outline: none;
	border: 1px solid gainsboro;
	font-size: 16px;
	color: grey;
	text-indent: 2em;
}

#userback .sendemail {
	margin-top: 20px;
	width: 360px;
	height: 40px;
	text-align: center;
	background: forestgreen;
	color: white;
	font-size: 24px;
	border: 1px solid gray;
	outline: none;
}

#userback .sendemail:hover {
	background: green;
}
</style>
<script>
	window.onload = function() {
		var oQuick = document.getElementById('quick');
		oQuick.onmousemove = function() {
			startMove(this, {
				'height' : '200',
				'width' : '200'
			});
		}
		oQuick.onmouseout = function() {
			startMove(this, {
				'height' : '20',
				'width' : '74'
			});
		}
	}
</script>
</head>

<body>
	<div id="userback">
		<div id="quick">
			<p>紧急状况</p>

			<ul>
				<a href=""><li>QQ:378899470</li></a>
				<a href=""><li>电话:1xxxxxx</li></a>
				<a href=""><li>备用号码:1xxxxxx</li></a>
			</ul>
		</div>

		<h2>用户反馈</h2>
		<p>姓名</p>
		<input class="user" id="name" type="text" value="" />
		<p>邮箱</p>
		<input class="user" id="email" type="text" value="" />
		<p>反馈/建议</p>
		<textarea rows="6" id="content" cols="30"></textarea>
		<input onClick="submitInfo();" class="sendemail" type="button"
			value="提交信息" />
	</div>

</body>
</html>