<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>车票查询</title>
<!-- css -->
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link href="css/style.css" type="text/css" rel="stylesheet" media="all">
<link rel="stylesheet" href="css/flexslider.css" type="text/css"
	media="screen" />
<link type="text/css" rel="stylesheet" href="css/JFFormStyle-1.css" />
<link rel="stylesheet" type="text/css" href="css/list.css">
<link href="css/city.css" rel="stylesheet" type="text/css" />
<link href="css/mobiscroll_date.css" rel="stylesheet" />
<style type="text/css">
.tableList {
	background-color: #fff;
	width: 100%;
	height: auto;
}
</style>
</head>

<body style="background: #fff;">
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

	<div id="tableList">
		<br> <br> <br> <br>
		<div class="single_wapper">
			<div class="railway_info_pack">
				<div class="railway_detail_box">
					<div class="searchbox">

						出发城市 <input type="hidden" id="fromPlace"
							value="${sessionScope.ticketList[0].departPlace }" /> <input
							type="text" id="city_name" name="from"
							value="${sessionScope.ticketList[0].departPlace }"
							class="departP input_text typeahead1 input-md"
							style="width: 82px; color: black;" autocomplete="on"
							_cqnotice="中文/拼音/首字母"> <a href="javascript:void(0);"
							class="icon_change" id="changecity"></a> 到达城市 <input
							type="hidden" id="toPlace"
							value="${sessionScope.ticketList[0].destination }" /> <input
							type="text" id="city_name2" name="to"
							value="${sessionScope.ticketList[0].destination }"
							class="destP input_text typeahead1 input-md"
							style="width: 82px; color: black;" autocomplete="on"
							_cqnotice="中文/拼音/首字母"> 出发日期 <input type="hidden"
							id="date_A" value="${sessionScope.ticketList[0].date}"> <input
							type="text" style="width: 125px; height: 26px; color: black;"
							id="dateObj" name="date"
							value="${sessionScope.ticketList[0].date}" class="input_text"
							style="width:120px; color: gray;" _cqnotice="yyyy-mm-dd">

						<input type="button" class="btn_search" id="searchBusTicket"
							value="搜索" />

					</div>
					<table class="tb_railway_list nolayout" width="100%"
						id="tb_railway_list" style="margin-bottom: 0;">
						<!--	
								这是顶部一栏
						-->
						<tr>
							<th>发车时间</th>
							<th>发/到站</th>
							<th>车次/车型</th>
							<th>票价</th>
							<th>余量</th>
							<th>操作</th>
						</tr>




						<!-- 票具体信息 -->
						<c:forEach items="${sessionScope.ticketList}" var="item">
							<tr>
								<td>${item.date}<br/>${item.departureTime}</td>
								<td><span class="icon_start"></span>${item.departPlace}<br />
									<span class="icon_end"></span>${item.destination}</td>
								<td>${item.trainsNum }<c:if test="${item.busType==1}">
									 常规
								</c:if> <c:if test="${item.busType==2}">
								 	加班
								</c:if>
								</td>
								<td style="color: red;">￥${item.ticketPrice}</td>
								<td>${item.count}</td>
								<td><input id="ticketId" type="hidden" value="${item.id}" />
									<input type="button" onClick="reserve(this)"
									class="btn_book goBook" value="预订" />
									<p style="display: none;">
										<input type="button" value="查看"
											class="btn_book btn_prebook check_more1" style="width: 44px;">
									</p></td>
							</tr>
						</c:forEach>
						<!-- 套餐产品 -->

					</table>
					<div class="date_flip" style="margin-top: 12px; float: left">
						<a href="javascript:void(0);" id="preDay"><b
							class="icon_arrow_left" style="border-width: 10px"></b>前一天</a> <a
							href="javascript:void(0);" id="nextDay">后一天<b
							class="icon_arrow_right" style="border-width: 10px"></b></a>
					</div>
				</div>

			</div>
			<div>
				<br> <br>
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
	<script src="js/showTickets.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {

			autoLogin();
			x();
			y();
			login();
			register();
			logout();

		});
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
														obj[k].name,
														obj[k].pinyin);
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
		})
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
		startYear: currYear, //开始年份
		endYear: currYear + 10 //结束年份
	};

	$("#dateObj").mobiscroll($.extend(opt['date'], opt['default']));

});
	</script>
	<script src="js/cities.js"></script>
	<script src="js/jquery.autocomplete.js"></script>
	<script src="js/mobiscroll_date.js"></script>
	<script src="js/mobiscroll.js"></script>
</body>
</html>