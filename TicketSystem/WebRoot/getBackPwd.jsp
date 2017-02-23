<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link href="css/getBackPwd.css" type="text/css" rel="stylesheet">

</head>



<body>
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
	<!-- login -->

	<form class="pop_login">
		<div class="tab">
			<label id="login">用户登陆</label> <span class="line line_left"></span> <label
				id="reg">用户注册</label> <span class="line line_right"></span>
		</div>
		<div class="cont1">
			<input type="text" placeholder="手机/邮箱/用户名" id="user1"> <input
				type="password" placeholder="密码(6-12位)" id="password1">
			<div class="box">
				<input type="checkbox" id="check_box" checked="checked" />
				<p>下次自动登录</p>
			</div>
			<a class="login_btn" href="javascript:;">登录</a> <br /> <br />
			<div class="forgetPass">
				<a href="getBackPwd.jsp">忘记密码？</a>
			</div>
		</div>
		<div class="cont2">
			<input type="text" placeholder="字母数字下划线组成，字母开头,4-16位" id="user2"
				onchange="checkUser(this.value);"> <span class="error">用户名由字母数字下划线组成，字母开头,4-16位</span>
			<span class="error">用户名已存在</span> <input type="password"
				placeholder="字母开头,6~18之间,只能包含字母,数字" id="password2"
				onchange="checkPassword(this.value);"> <span class="error">请输入以字母开头,6~18之间,只能包含字母,数字的密码</span>
			<input type="password" placeholder="请重复输入密码" id="confirPassword"
				onchange="checkPasswordIsSame(this.value);"> <span
				class="error">密码不一致</span> <input type="Email" placeholder="请输入QQ邮箱"
				id="email" onchange="checkEmail(this.value);"> <span
				class="error">请输入正确邮箱地址</span> <a class="reg_btn"
				href="javascript:;">注册</a>
		</div>
	</form>
	<!-- login -->


	<!-- 主体 -->
	<div id="forgrt1" >
		<span id="val_status"></span>
		<div class="con">
			<input class="account" onblur="javascript:checkAccount(this);"
				type="text" placeholder="账号" />
			<div class="valueData">
				<input class="data" type="text" placeholder="验证码" /> <input
					class="getdata" onclick="javascript:getCode(this);" type="button"
					value="获取验证码" />
				<!-- <p>60s内重新获取</p> -->
			</div>
			<input class="next" type="button" onclick="javascript:validate();"
				value="下一步" />
		</div>

	</div>





	<div id="forgrt2" style="display: none" >
		<!-- <h3><a href="javascript:">本次操作需要进行密码的重置</a></h3> -->
		<span id="val_status1">密码以字母开头，长度在6~18之间</span>
		<div class="con">
			<input type="password" class="newPass" placeholder="新密码"
				name="newPass" /> <input type="password" placeholder="重复新密码"
				class="reNewPass" name="reNewPass" /> <input class="resert"
				onlick="javascript:resetPwd();" type="button" value="重置密码" />
		</div>
	</div>
	<!-- 主体 -->
	<div class="wrap"></div>
	<!-- footer -->
	<footer>
		<nav class="navbar navbar-inverse navbar-fixed-bottom"></nav>
	</footer>
	<script src="js/jquery-2.1.4.min.js"></script>
	<script src="js/jquery.cookie.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script defer src="js/jquery.flexslider.js"></script>
	<script src="js/easyResponsiveTabs.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/script.js"></script>
	<script src="js/modernizr.custom.js"></script>
	<script src="js/jquery.cookie.js"></script>
	<script src="js/menu_jquery.js"></script>
	<script src="js/public.js"></script>
	<script src="js/getBackPwd.js"></script>
	<script type="text/javascript">
			
	</script>
</body>
</html>

