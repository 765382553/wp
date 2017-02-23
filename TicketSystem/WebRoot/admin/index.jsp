<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>长途汽车票务管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/LoginJudge.js"></script>
<script src="../js/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
  
  getAdminLoginStatus();
  
  })
  
  function logout(){
  
    $.post("../admin/logout",{},function(){})
    window.location.href="login.jsp";
  }

</script>
<script type="text/javascript">
	function pr(_id) {
		var select_id = parseInt(_id.replace("xx", ""));
		for (i = 1; i <= 8; i++) {
			if (i == select_id) {
				document.getElementById("xx" + i).className = "x_css";
			} else {
				document.getElementById("xx" + i).className = "y_css";
			}
		}
	}
</script>
<script type="text/javascript">
	function show(num) {
		document.getElementById(num).style.display = "block";
	}
	function hidden1(num) {
		document.getElementById(num).style.display = "none";
	}
</script>
<script type="text/javascript">
	function r(num) {
		document.getElementById(num).style.display = "block";
	}
	function r_1(num) {
		document.getElementById(num).style.display = "none";
	}
</script>
<script type="text/javascript">
	function srcchange(id) {

		if (id == "hr1") {
			document.getElementById("mainFrame").src = "./AddTicket.jsp";

		} else if (id == "hr2") {
			document.getElementById("mainFrame").src = "./DelTicket.jsp";
		} 
		else if (id == "hr4") {
			document.getElementById("mainFrame").src = "./SelTicket.jsp";

		} else if (id == "hr5") {

			document.getElementById("mainFrame").src = "./SelUser.jsp";

		} else if (id == "hr8") {
			document.getElementById("mainFrame").src = "./SelOrder.jsp";

		} else if (id == "hr9") {
			document.getElementById("mainFrame").src = "./OrderList.jsp";

		} else if (id == "hr11") {
			document.getElementById("mainFrame").src = "./AddMsg.jsp";

		} else if (id == "hr12") {
			document.getElementById("mainFrame").src = "./UpdMsg.jsp";

		} else if (id == "hr13") {
			document.getElementById("mainFrame").src = "";

		}else if (id == "hr14") {
			document.getElementById("mainFrame").src = "./UpdAdminInfo.jsp";

		}
	}
</script>
<link rel="stylesheet" type="text/css" href="css/index.css" />
<link rel="stylesheet" type="text/css" href="css/main.css" />
</head>
<body style="margin: 0 auto;">

	<!-- 	<div class="mian_r" onmousemove="r(22)" onmouseout="r_1(22)">
			<div class="mian_r_bj png" style="display: none;" id="22" onmousemove="r(22)" onmouseout="r_1(22)">
			</div>
		</div> -->
		
		<div id="header">
				<div class="left">
					<h1><a href="index.jsp">长途汽车票务管理系统</a></h1>
				</div>
				
				<div class="right">
					
					<div class="admin_header">
						<input type="text" value="search...."> 
						<a href="#" id="xx99" onmouseover="show(99)" onmouseout="hidden1(99)"><img alt="bus" src="./images/manager.png"></a>
					</div>
					
					<div class="show_admin" id="99" onmouseover="show(99)" onmouseout="hidden1(99)" style="display: none;">
						<ul>
							<li><a>用户:${sessionScope.admin.account }</a></li>
							<li><a onclick="srcchange('hr14');">编辑资料</a></li>
							<li><a onclick="javascript:logout();" >登出</a></li>
						</ul>
					</div>
				</div>
		</div>
		
		
<div id="wrap">	
	<!-- 这是sidebar -->
	<div class="side">
			<ul id="nav">
				<li class="nav_01" id="xx1" onmouseover="show(1)" onmouseout="hidden1(1)">
					<a href="#" class="active" onmousedown="javascript:pr('xx1')">票务管理</a>
				</li>
				
				<li id="xx2"><a href="#" onclick="changeIcon('Notice')" onmousedown="javascript:pr('xx2')" onmouseover="show(2)" onmouseout="hidden1(2)">用户管理</a>
				</li>
				
				<li id="xx3"><a href="#" onclick="changeIcon('KnowLedge')" onmousedown="javascript:pr('xx3')" onmouseover="show(3)" onmouseout="hidden1(3)">订单管理</a>
				</li>
				
				
				<li id="xx4"><a href="#" onclick="changeIcon('Task')" onmousedown="javascript:pr('xx4')" onmouseover="show(4)" onmouseout="hidden1(4)">系统公告</a>
				</li>
				
				<li id="xx5"><a href="#" onclick="changeIcon('Order')" onmousedown="javascript:pr('xx5')" onmouseover="show(5)" onmouseout="hidden1(5)">其他功能</a>
				</li>
			</ul>
			<!-- 
		这是票务管理的附属项
 -->
		<div class="left_r1" onmousemove="show(1)" onmouseout="hidden1(1)" id="1">
			<div class="left_r" onmousemove="show(1)" onmouseout="hidden1(1)">
				<ul>
					<li><a onclick="srcchange('hr1');">新增车次</a></li>
					<li><a onclick="srcchange('hr2');">删除/停(复)车次</a></li>
					<li><a onclick="srcchange('hr4');">查询车次</a></li>
				</ul>
			</div>
		</div>
		
		
		
		
		<div class="left_r1" onmousemove="show(2)" onmouseout="hidden1(2)" id="2">
			<div class="left_r" onmousemove="show(2)" onmouseout="hidden1(2)">
				<ul>
					<li><a onclick="srcchange('hr5')">查询用户信息</a></li>
					<li><a onclick="srcchange('hr14')">管理员资料修改</a></li>
				</ul>
			</div>
		</div>
		
		
		<div class="left_r1" onmousemove="show(3)" onmouseout="hidden1(3)" id="3">
			<div class="left_r" onmousemove="show(3)" onmouseout="hidden1(3)">
				<ul>
					<li><a onclick="srcchange('hr8');">订单查询</a></li>
					<li><a onclick="srcchange('hr9');">订单列表</a></li>
				</ul>
			</div>
		</div>
		<div class="left_r1" onmousemove="show(4)" onmouseout="hidden1(4)" id="4" style="display: none;">
			<div class="left_r" onmousemove="show(4)" onmouseout="hidden1(4)">
				<ul>
					<li><a onclick="srcchange('hr11');">新增公告</a></li>
					<li><a onclick="srcchange('hr12');">调整公告</a></li>

				</ul>
			</div>
		</div>
		<div class="left_r1" onmousemove="show(5)" onmouseout="hidden1(5)" id="5" style="display: none;">
			<div class="left_r" onmousemove="show(5)" onmouseout="hidden1(5)">
				<ul>
					<li><a onclick="srcchange('hr13');">数据分析</a></li>
				</ul>
			</div>
		</div>
		<div class="left_r1" onmousemove="show(6)" onmouseout="hidden1(6)" id="6">
			<div class="left_r" onmousemove="show(6)" onmouseout="hidden1(6)">
			</div>
		</div>
	</div>
	
	<div id="main">
		<iframe frameborder="0" scrolling="auto" id="mainFrame" name="mainFrame" src="Fast.jsp">
		</iframe> 

	</div>
	
	

</div>

</body></html>