<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
		<style>
			#forgrt1 {
				/*border: 1px solid aqua;*/
				margin: 100px auto;
				width: 560px;
				/*background: red;*/
				padding: 10px;
			}
			
			#forgrt1 h3 {
				text-decoration: underline;
				text-align: center;
			}
			
			#forgrt1 p {
				text-align: center;
			}
			
			#forgrt1 a:hover {
				color: seagreen;
			}
			
			.con {
				width: 210px;
				margin: 0 auto;
			}
			
			input {
				color: grey;
				outline: none;
				border-radius: 4px;
				padding: 5px;
				height: 20px;
			}
			
			.con input {
				margin-top: 15px;
				width: 200px;
			}
			.con .valueData{
				position: relative;
			}
			.con .valueData input {
				width: 100px;
			}
			
			.con .valueData .getdata {
				color: white;
				height: 35px;
				background: seagreen;
				padding: 5px;
				width: 80px;
				float: right;
				margin-left: 5px;
				border: 1px solid seagreen;
			}
			
			.valueData p {
				position: absolute;
				font-size: 12px;
				right: -110px;
				top: 3px;
				border: 1px solid red;
				color: red;
				padding: 10px;
			}
			
			.con .next {
				color: white;
				width: 215px;
				padding: 5px;
				height: 35px;
				font-size: 20px;
				border: 0;
				background: seagreen;
			}
			
			
			
			
			#forgrt2{
				margin: 100px auto;
				width: 560px;
				/*background: red;*/
				padding: 10px;
			} 
			#forgrt2 h3{
				text-decoration: underline;
				text-align: center;
			}
			#forgrt2 p {
				text-align: center;
			}
			#forgrt2 input{
				color: grey;
				outline: none;
				border-radius: 4px;
				padding: 5px;
				height: 20px;
				display: block;
			}
			#forgrt2 .resert{
				color: white;
				width: 215px;
				padding: 5px;
				height: 35px;
				font-size: 20px;
				border: 0;
				background: seagreen;
			}
		</style>
	</head>

	<body>
		<div id="forgrt1">
			<h3><a href="javascript:">经过智能的检测，本次操作需要您通过以下方式确认身份</a></h3>
			<p>密码已经发送到389823492@qq.com 请登录查收</p>
			<div class="con">
				<input class="account" type="text" value="账号" name="account" />
				<div class="valueData">
					<input class="data" type="text" value="验证码" />
					<input class="getdata" type="button" value="获取验证码" />
					<p>60s内重新获取</p>
				</div>
				<input class="next" type="button" value="下一步" />
			</div>

		</div>

		<div id="forgrt2">
			<h3><a href="javascript:">本次操作需要进行密码的重置</a></h3>
			<div class="con">
				<input type="text" value="新密码" name="newPass" />
				<input type="text" value="重复新密码" name="" />
				<input class="resert" type="reset" value="重置密码" />
			</div>
		</div>
	</body>

</html>