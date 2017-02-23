<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fast</title>
<link rel="stylesheet" type="text/css" href="css/index.css" />
<style type="text/css">
#main h1 {
	color: white;
	font-size: 24px;
	font-family: cursive;
	font-weight: bold;
	width: 950px;
	height: 60px;
	line-height: 60px;
	text-indent: 1em;
	background: #303236;
	box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.5);
	margin-top: 3px;
	margin-bottom: 10px;
	border-radius: 5px 5px;
}

#back {
	border: 1px solid gray;
	position: relative;
}

#back h2 {
	color: gray;
	font-size: 18px;
	padding: 10px;
}

#back ul {
	list-style: none;
}

#back li {
	display: block;
	border-top: 1px solid black;
	font-size: 18px;
	color: white;
	background: #a8adb3;
	text-indent: 2em;
	height: 60px;
	padding-top: 10px;
}

#back  li .back_bot {
	display: none;
	color: red;
	padding: 6px;
	font-size: 13px;
}

#back .back_bot a {
	color: black;
}

#back .back_bot a:hover {
	color: white;
}

#back #backContent {
	display: none;
	position: absolute;
	left: 50%;
	top: 10px;
	width: 200px;
	margin-left: -100px;
	border: 10px solid #cdcdcd;
	z-index: 20px;
	background: #ffffff;
}

#back #backContent p {
	position: absolute;
	right: 4px;
	top: 0px;
}

#back #backContent h3 {
	color: black;
	font-size: 16px;
	border-bottom: 1px solid #7e7b7b;
	background: #f1f1f1;
}

#back #backContent textarea {
	height: 140px;
	outline: none;
	text-indent: 2em;
	width: 200px;
	border: 0px;
	background: #ffffff;
	border: 1px;
}

#back #backContent .bcBot {
	background: #efefef;
	width: 200px;
	height: 30px;
	margin-top: 0px;
}

#back #backContent .subFast {
	padding: 4px;
	color: white;
	width: 80px;
	display: block;
	float: right;
	outline: none;
	background: gray;
}

#back #backContent .subFast:hover {
	background: #6ebf9f;
}

.tcdPageCode {
	float: right; center;
	color: black;
	padding: 5px 0 0 0;
}

.tcdPageCode a {
	display: inline-block;
	color: black;
	display: inline-block;
	height: 25px;
	line-height: 25px;
	padding: 0 10px;
	border: 1px solid #ddd;
	margin: 0 2px;
	border-radius: 4px;
	vertical-align: middle;
}

.tcdPageCode a:hover {
	text-decoration: none;
	border: 1px solid black;
}

.tcdPageCode span.current {
	display: inline-block;
	height: 25px;
	line-height: 25px;
	padding: 0 10px;
	margin: 0 2px;
	color: black;
	background-color: gray;
	border: 1px solid #428bca;
	border-radius: 4px;
	vertical-align: middle;
}

.tcdPageCode span.disabled {
	display: inline-block;
	height: 25px;
	line-height: 25px;
	padding: 0 10px;
	margin: 0 2px;
	color: black;
	background: gray;
	border: 1px solid #bfbfbf;
	border-radius: 4px;
	vertical-align: middle;
}
</style>

</head>
<script src="../js/jquery-2.1.4.min.js"></script>
<script src="../js/jquery.page.js"></script>
<script type="text/javascript">
	function changeJsp(str) {

		window.location.href = str;

	}
	$(function() {

		getNum();
		getList(1);
		FPage(1);

	})

	//得到总页数
	function getNum() {

		$.ajax({

			url : "../back/getNum",
			type : "POST",
			async : false,
			success : function(data) {

				$('#pageAllNum').val(data)

			}

		})
	}

	function getList(page) {

		$
				.ajax({

					url : "../back/getList",
					type : "POST",
					data : {

						page : page
					},
					dataType : "JSON",
					success : function(data) {

						for (var i = 0; i < data.length; i++) {

							$('#back ul')
									.append(
											"<li>"
													+ data[i].name
													+ ":"
													+ data[i].content
													+ "<input class='user_id' type='hidden' value="+data[i].id+" ><input class='user_name' type='hidden' value="+data[i].name+" /><input class='user_email' type='hidden' value="+data[i].email+" /><div class='back_bot'><a onclick='javascript:delBackInfo(this)'>删除</a> | <a onclick='javascript:replyClick(this)'>回复</a></div></li>");

						}

					}

				})
	}
	function delBackInfo(obj) {

		$.ajax({

			url : "../back/delBackInfo",
			type : "POST",
			data : {

				id : $(obj).parents("li").find(".user_id").val()
			},
			success : function(data) {

				if (data == "true") {

					$(obj).parents("li").remove();
				} else {

					alert("删除失败，请稍后再试")
				}

			}

		})

	}
	function reply() {

		var content = $('#replyContent').val();
		var email = $('.userEmail').val();
		var id = $('.userId').val();

		$.ajax({

			url : "../back/reply",
			type : "POST",
			data : {

				id : id,
				email : email,
				content : content

			},
			success : function() {

				$('#replyContent').val("")
				$('#backContent').css('display', 'none');
				location.href = "Fast.jsp";
			}
		})

	}

	function replyClick(obj) {

		$('.to_name').text(
				"TO:  " + $(obj).parents("li").find(".user_name").val());
		$('.userEmail').val($(obj).parents("li").find(".user_email").val());
		$('.userId').val($(obj).parents("li").find(".user_id").val())
		$('#backContent').css('display', 'block');

	}
	function FPage(page) {

		$("#tcdPageCode").createPage({
			pageCount : $('#pageAllNum').val(),
			current : page,
			backFn : function(p) {

				$('#back ul').html("")
				getList(p)
			}
		});
	}
</script>
<script type="text/javascript">
	window.onload = function() {
		var oBack = document.getElementById("back");
		var oUl = oBack.getElementsByTagName('ul')[0];
		var oLi = 0;
		var oBack_bot = oBack.getElementsByClassName('back_bot');
		var obackContent = document.getElementById('backContent');
		var oclear = document.getElementById('clear');

		oclear.onclick = function() {
			obackContent.style.display = 'none';
		}

		oUl.onmousemove = function() {
			oLi = oUl.getElementsByTagName('li');

			for (var i = 0; i < oLi.length; i++) {
				oLi[i].index = i;
				oLi[i].onmousemove = function() {
					oBack_bot[this.index].style.display = 'block';

				}
				oLi[i].onmouseout = function() {
					oBack_bot[this.index].style.display = 'none';
				}

			}
		}

	}
</script>
<body style="overflow: hidden;">
	<div id="main">
		<h1>Fast Option</h1>
		<div class="clear" id="top">
			<div class="top_con">
				<img alt="a" src="./images/top_1.png">
				<h2>
					<a href="javascript:changeJsp('./AddTicket.jsp');">添加车次</a>
				</h2>
			</div>
			<div class="top_con">
				<img alt="a" src="./images/top_1.png">
				<h2>
					<a href="javascript:changeJsp('./OrderList.jsp');">订单列表</a>
				</h2>
			</div>
			<div class="top_con">
				<img alt="a" src="./images/top_1.png">
				<h2>
					<a href="javascript:changeJsp('./UpdMsg.jsp');">公告更新</a>
				</h2>
			</div>
			<div class="top_con">
				<img alt="a" src="./images/top_1.png">
				<h2>
					<a href="javascript:changeJsp('./SelUser.jsp');">用户查询</a>
				</h2>
			</div>
		</div>

		<div id="back">
			<h2>用户留言</h2>
			<ul>

			</ul>

			<div id="backContent">
				<h3 class="to_name"></h3>
				<p>
					<a id="clear" href="javascript:">x</a>
				</p>
				<textarea id="replyContent" rows="5" cols="95"></textarea>
				<div class="bcBot">
					<input class="userId" type="hidden" value="" /> <input
						class="userEmail" type="hidden" value="" /> <input
						class="subFast" onclick="javascript:reply()" type="button"
						value="提交">
				</div>
			</div>
		</div>


	</div>
	<input type="hidden" id="pageAllNum" value="" />
	<div id="tcdPageCode" class="tcdPageCode"></div>




</body>
</html>