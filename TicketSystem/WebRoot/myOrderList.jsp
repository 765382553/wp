<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
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
<title>我的订单</title>
<!-- css -->
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link href="css/style.css" type="text/css" rel="stylesheet" media="all">
<link rel="stylesheet" href="css/flexslider.css" type="text/css"
	media="screen" />
<link type="text/css" rel="stylesheet" href="css/JFFormStyle-1.css" />
<link rel="stylesheet" href="css/orderList.css">
</head>
<body style="background: #fff;overflow: auto">
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
	<!-- 代码部分begin -->
	<div class="orderBody">
		<div id="tabs" class="tabs">
			<a href="#" id="order_1" hidefocus="true" class="active">全部订单</a> <a
				href="#" id="order_2" hidefocus="true">已出票</a> <a href="#"
				id="order_3" hidefocus="true">已退订</a>
		</div>
		<div class="swiper-container">

			<div id="swiper-wrapper" class="swiper-wrapper">



				<!--
					这是第一个页面
				  -->
				<div class="swiper-slide">
					<div id="content" class="content-slide">

						<div class="content-slide-top marginCen">
							<form action="" method="post">
								<input id="order" class="order" name="orderName" type="text"
									value="请输入订单号进行搜索" /> <a href="#"><input class="search"
									type="button" value="搜索" /></a>
							</form>
						</div>

						<div class="content-slide-main-header marginCen">
							<table>
								<td>出发点/终点站</td>
								<td>车次</td>
								<td>金额</td>
								<td>座位号</td>
								<td>检票口</td>
								<td>发车时间</td>
								<td>状态</td>
								<td>操作</td>
							</table>
						</div>

						<div id="orderContent"></div>
						<input type="hidden" id="pageNum1" value="" />

						<div class="content-bottom">

							<div id="tcdPageCode1" class="tcdPageCode" style="display:block;"></div>

						</div>

					</div>
				</div>



				<!--
					这是第二个页面
				  -->
				<div style="display:none;" class="swiper-slide">
					<div id="content" class="content-slide">

						<div class="content-slide-top marginCen">
							<form action="" method="post">
								<input id="order" class="order" name="orderName" type="text"
									value="请输入订单号进行搜索" /> <a href="#"><input class="search"
									type="button" value="搜索" /></a>
							</form>
						</div>

						<div class="content-slide-main-header marginCen">
							<table>
								<td>出发点/终点站</td>
								<td>车次</td>
								<td>金额</td>
								<td>座位号</td>
								<td>检票口</td>
								<td>发车时间</td>
								<td>状态</td>
								<td>操作</td>
							</table>
						</div>

						<div id="orderContent_1"></div>


						<div class="content-bottom">
							<input type="hidden" id="pageNum2" value="" />

							<div id="tcdPageCode2" class="tcdPageCode" style="display:hidden"></div>

						</div>

					</div>
				</div>


				<!--
					这是第三个页面
				  -->
				<div style="display:none;" class="swiper-slide">
					<div id="content" class="content-slide">

						<div class="content-slide-top marginCen">
							<form action="" method="post">
								<input id="order" class="order" name="orderName" type="text"
									value="请输入订单号进行搜索" /> <a href="#"><input class="search"
									type="button" value="搜索" /></a>
							</form>
						</div>

						<div class="content-slide-main-header marginCen">
							<table>
								<td>出发点/终点站</td>
								<td>车次</td>
								<td>金额</td>
								<td>座位号</td>
								<td>检票口</td>
								<td>发车时间</td>
								<td>状态</td>
								<td>操作</td>
							</table>
						</div>

						<div id="orderContent_2"></div>

						<input type="hidden" id="pageNum3" value="" />
						<div class="content-bottom">

							<div id="tcdPageCode3" class="tcdPageCode" style="display:hidden"></div>

						</div>

					</div>
				</div>

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
	<script src="js/idangerous.swiper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script defer src="js/jquery.flexslider.js"></script>
	<script src="js/easyResponsiveTabs.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/script.js"></script>
	<script src="js/jquery.cookie.js"></script>
	<script src="js/modernizr.custom.js"></script>
	<script src="js/menu_jquery.js"></script>
	<script src="js/jquery.page.js"></script>
	<script src="js/public.js"></script>
	<script src="js/myOrderList.js"></script>
	<script type="text/javascript">
		$(window).load(function() {
			autoLogin();
			x();
			y();
			login();
			register();
			logout();
			getUserPageNum();
			selectMyOrder();
			style();
		});
	</script>
</body>
</html>