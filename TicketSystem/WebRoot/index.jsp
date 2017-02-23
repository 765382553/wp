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
<title>长途汽车票购买</title>
<!-- css -->
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link href="css/style.css" type="text/css" rel="stylesheet" media="all">
<link rel="stylesheet" href="css/flexslider.css" type="text/css"
	media="screen" />
<link href="css/city.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.8.3.min.js" type="text/javascript"></script>
<link type="text/css" rel="stylesheet" href="css/JFFormStyle-1.css" />
<link rel="stylesheet" href="css/jquery-ui.css" />
<link href="css/mobiscroll_date.css" rel="stylesheet" />
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




	<marquee style="color: red; font-size: 20px; opacity: 0.7;">
		<p id="notice" style="color: red; opacity: 1;">
		<p>
	</marquee>
	<!-- banner -->
	<div class="banner bus-banner">
		<!-- container -->
		<div class="container">
			<div class="col-md-4 banner-left">
				<section class="slider2">
					<div class="flexslider">
						<ul class="slides">
							<li>
								<div class="slider-info">
									<img src="images/5.jpg" alt="">
								</div>
							</li>
							<li>
								<div class="slider-info">
									<img src="images/6.jpg" alt="">
								</div>
							</li>
							<li>
								<div class="slider-info">
									<img src="images/7.jpg" alt="">
								</div>
							</li>
							<li>
								<div class="slider-info">
									<img src="images/8.jpg" alt="">
								</div>
							</li>
							<li>
								<div class="slider-info">
									<img src="images/6.jpg" alt="">
								</div>
							</li>
						</ul>
					</div>
				</section>
				<!--FlexSlider-->
			</div>
			<div class="col-md-8 banner-right">
				<div class="sap_tabs" style="z-index: 10;">
					<div class="booking-info about-booking-info">
						<h2>Book Bus Tickets Online</h2>
					</div>
					<div id="horizontalTab"
						style="display: block; width: 100%; margin: 0px;">
						<!---->
						<div class="facts about-facts">
							<div class="booking-form">


								<!---/End-date-piker---->
								<!-- Set here the key for your domain in order to hide the watermark on the web server -->

								<div class="online_reservation">
									<div class="b_room">
										<div class="booking_room">
											<div class="reservation">
												<ul>
													<li class="span1_of_1 desti">
														<h5>From</h5>
														<div class="book_date">
															<form style="z-index: 20">
																<span class="glyphicon glyphicon-map-marker"
																	aria-hidden="true"></span>
																<div class="search-citys">
																	<!-- <input id="fromPlace"> -->
																	<input placeholder="出发地"
																		class="typeahead1 input-md form-control tt-input text fromPlace"
																		id="city_name" type="text" /> <input class="text"
																		id="hid_city_name" name="index_city"
																		style="display: none"> <input class="text"
																		id="hid_real_city_name" name="real_index_city"
																		style="display: none">

																	<!--热门城市下拉-->

																</div>
															</form>
														</div>
													</li>
													<li class="span1_of_1 left desti">
														<h5>To</h5>
														<div class="book_date">
															<form>
																<span class="glyphicon glyphicon-map-marker"
																	aria-hidden="true"></span>

																<!-- 	<input id="toPlace"
																	type="text" placeholder="目的地"
																	class="typeahead1 input-md form-control tt-input"
																	required=""> -->
																<div class="search-citys">
																	<input placeholder="目的的"
																		class="typeahead1 input-md form-control tt-input text toPlace"
																		id="city_name2" type="text" /> <input class="text"
																		id="hid_city_name2" name="index_city"
																		style="display: none"> <input class="text"
																		id="hid_real_city_name2" name="real_index_city"
																		style="display: none">

																	<!--热门城市下拉-->

																</div>

															</form>
														</div>
													</li>
													<div class="clearfix"></div>
												</ul>
											</div>
											<div class="reservation">
												<ul>
													<li class="span1_of_1">
														<h5>Departing</h5>
														<div class="book_date">
															<form>
																<span class="glyphicon glyphicon-calendar"
																	aria-hidden="true"></span> <input id="date" type="text"
																	value="" placeholder="选择日期" >
															</form>
														</div>
													</li>


													<div class="clearfix"></div>
												</ul>
											</div>
											<div class="reservation">
												<ul>
													<li class="span1_of_3">
														<div class="date_btn">
															<form>
																<input id="chaxun" type="submit" value="Search">
															</form>
														</div>
													</li>
													<div class="clearfix"></div>
												</ul>
											</div>
										</div>
										<div class="clearfix"></div>
									</div>
								</div>
								<!---->
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
		<!-- //container -->
	</div>
	<!-- 主体 -->
	<div class="wrap"></div>

	<!-- footer -->
	<footer>
		<nav class="navbar navbar-inverse navbar-fixed-bottom"></nav>
	</footer>


	<div id="contact">
		<ul>
			<a href="userBack.jsp"><li>联</li></a>
			<a href="userBack.jsp"><li>系</li></a>
			<a href="userBack.jsp"><li>我</li></a>
			<a href="userBack.jsp"><li>们</li></a>
		</ul>
	</div>
</body>
<!-- footer -->
<!-- js -->
<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/modernizr.custom.js"></script>
<script src="js/bootstrap.min.js"></script>
<script defer src="js/jquery.flexslider.js"></script>
<script src="js/easyResponsiveTabs.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/script.js"></script>
<script src="js/menu_jquery.js"></script>
<script src="js/cities.js"></script>
<script src="js/jquery.autocomplete.js"></script>
<script src="js/mobiscroll_date.js"></script>
<script src="js/mobiscroll.js"></script>
<script src="js/jquery.cookie.js"></script>
<script src="js/public.js"></script>
<script src="js/index.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		$.ajax({

			url : "notice/selNoticeList",
			type : "POST",
			dataType : "JSON",
			success : function(data) {

				var content = "";
				for (var i = 0; i < data.length; i++) {

					content += data[i].content + "  ";

				}
				$('#notice').text(content);

			}

		})

		autoLogin();
		x();
		login();
		register();
		logout();
		y();
		$("#datepicker,#datepicker1").datepicker();

	})

	var cityChange = eval(cityChange);
	$(function() {
		$('#index_province')
				.change(
						function() {
							for ( var i in cityChange) {
								if (i == this.value) {
									var index_city_obj = $('#index_city')[0];
									index_city_obj.innerHTML = '';
									var obj = cityChange[i];
									for ( var k in obj) {
										if (obj[k].name) {
											index_city_obj.options[index_city_obj.options.length] = new Option(
													obj[k].name, obj[k].pinyin);
										}
									}
									break;
								}
							}

						});
	})

	$(function() {

		$('#city_name').autocomplete(cities, {
			max : 12, //列表里的条目数
			minChars : 0, //自动完成激活之前填入的最小字符
			width : 385, //提示的宽度，溢出隐藏
			scrollHeight : 300, //提示的高度，溢出显示滚动条
			matchContains : true, //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示
			autoFill : false, //自动填充
			minChars : 1,
			formatItem : function(row, i, max) {
				return row.name + '（' + row.pinyin + '）';
			},
			formatMatch : function(row, i, max) {
				return row.match;
			},

			formatResult : function(row) {
				return row.name;
			},
			resultsClass : 'search-text'
		}).result(function(event, row, formatted) {
			$("#hid_city_name").val(row.pinyin);
			$("#hid_real_city_name").val(row.name);
			$('#pop_cities').hide();
		});
	});

	$(function() {

		$('#city_name2').autocomplete(cities, {
			max : 12, //列表里的条目数
			minChars : 0, //自动完成激活之前填入的最小字符
			width : 385, //提示的宽度，溢出隐藏
			scrollHeight : 300, //提示的高度，溢出显示滚动条
			matchContains : true, //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示
			autoFill : false, //自动填充
			minChars : 1,
			formatItem : function(row, i, max) {
				return row.name + '（' + row.pinyin + '）';
			},
			formatMatch : function(row, i, max) {
				return row.match;
			},

			formatResult : function(row) {
				return row.name;
			},
			resultsClass : 'search-text2'
		}).result(function(event, row, formatted) {
			$("#hid_city_name2").val(row.pinyin);
			$("#hid_real_city_name2").val(row.name);
			$('#pop_cities').hide();
		});

		/*联系我们*/
		var clientWidth = document.documentElement.clientHeight;
		var scrollTop = document.documentElement.scrollTop
				|| document.body.scrollTop;
		var oDiv = document.getElementById('contact');
		oDiv.style.top = document.documentElement.clientHeight / 2
				- oDiv.offsetHeight / 2 + scrollTop + 'px';
		var i = 0;

		document.onscroll = function() {
			var scrollTop = document.documentElement.scrollTop
					|| document.body.scrollTop;
			oDiv.style.top = document.documentElement.clientHeight / 2
					- oDiv.offsetHeight / 2 + scrollTop + 'px';
		}
		oDiv.onmousemove = function() {
			oDiv.style.background = 'black';
		}
		oDiv.onmouseout = function() {
			oDiv.style.background = 'gray';
		}
	});
	/*日期控件*/
 $(function () {
	var currYear = (new Date()).getFullYear();	
	var opt={};
	opt.date = {preset : 'date'};
	opt.datetime = {preset : 'datetime'};
	opt.time = {preset : 'time'};
	opt.default  = {
		theme: 'android-ics light', //皮肤样式
		display: 'modal', //显示方式 
		mode: 'scroller', //日期选择模式
		dateFormat: 'yyyy-mm-dd',
		lang: 'zh',
		showNow: true,
		nowText: "今天",
		startYear: currYear - 50, //开始年份
		endYear: currYear + 10 //结束年份
	};

	$("#date").mobiscroll($.extend(opt['date'], opt['default']));

});
	// );
</script>


</html>