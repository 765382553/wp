<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>首页</title>
<!-- css -->
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link href="css/style.css" type="text/css" rel="stylesheet" media="all">
<link rel="stylesheet" href="css/flexslider.css" type="text/css"
	media="screen" />
<link type="text/css" rel="stylesheet" href="css/JFFormStyle-1.css" />
<link type="text/css" rel="stylesheet" href="css/myInfo.css" />

</head>



<body>
	<!--导航-->
	<!-- <div class="allow"></div> -->
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">

			<div class="navbar-header">
				<button class="navbar-toggle" type="button" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a href="index.jsp" class="navbar-brand">长途汽车售票系统</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="javascript:;" class="login" id="loginandinfo">登陆</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!--导航-->
	<div id="menu" style="z-index: 20;">
		<ul>
			<li><a href="myOrderList.jsp">我的订单</a></li>
			<li><a href="myInfo.jsp">我的资料</a></li>
			<li><a id="logout" href="">退出</a></li>
		</ul>
	</div>


	<!-- 主体 -->
	<div id="info">
		<!--修改密码-->
		<div id="mypasswd">
			<div id="changePass">
				<h3>修改密码</h3>
				<span class="span1">原密码格式填写错误</span> <span class="span2">新密码格式填写错误</span>
				<span class="span3">二次密码不一致</span>
				<form action="">
					<input type="text" id="old_pwd" placeholder="旧密码" /> <input
						type="text" id="new_pwd" placeholder="新密码" /> <input type="text"
						id="repNew_pwd" placeholder="重复新密码" /> <input type="button"
						id="updPwd" value="修改密码">
				</form>
			</div>
		</div>

		<div id="mid"></div>

		<!--我的信息-->
		<div id="myinfor">
			<div id="changeInfo">
				<h3>修改个人资料</h3>
				<span class="span1">格式填写错误</span> <span class="span2">格式填写错误</span>
				<span class="span3">格式填写错误</span>
				<form action="">
					<input type="text" id="cardId" placeholder="身份证" /> <input
						type="text" id="name" placeholder="姓名" /><input type="text"
						id="email_1" placeholder="邮箱" /> <input type="button"
						id="updInfo" value="修改资料" />
				</form>
			</div>

		</div>
	</div>

	<!-- 主体 -->
	<div class="wrap"></div>
	<!-- footer -->
	<footer>
		<nav class="navbar navbar-inverse navbar-fixed-bottom"></nav>
	</footer>

	<!-- footer -->
	<!-- js -->
	<script src="js/jquery-2.1.4.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script defer src="js/jquery.flexslider.js"></script>
	<script src="js/easyResponsiveTabs.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/script.js"></script>
	<script src="js/modernizr.custom.js"></script>
	<script src="js/jquery.cookie.js"></script>
	<script src="js/menu_jquery.js"></script>
	<script src="js/public.js"></script>
	<script src="js/myInfo.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {

			$('#email_1').val($.cookie("user_email"));
			$('#cardId').val($.cookie("user_cardId"));
			$('#name').val($.cookie("user_name"));
			autoLogin();
			logout();
			style();

			x();
			y();
		})
	</script>

	</body>
</html>