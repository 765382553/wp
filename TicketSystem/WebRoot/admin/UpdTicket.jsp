<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改车次信息</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
<script src="js/LoginJudge.js"></script>
<script type="text/javascript"></script>
</head>
<body style="background: #f1f1f1;">
	<span style="font-size:25px;margin-left:410px;">车次信息修改</span>
	<br />
	<br />
	<div class="form-group" style="margin-left:38px;">
		<form class="form-inline" role="form">
			<label class="sr-only" for="name">名称</label> <input type="text"
				class="form-control" id="trainsNum" placeholder="车次" /><br><br>
				<input type="text"
				class="form-control" id="trainsNum" placeholder="出发地" /><br><br>
				<input type="text"
				class="form-control" id="trainsNum" placeholder="目的地" /><br><br>
				<input type="text"
				class="form-control" id="trainsNum" placeholder="发车时间" /><br><br>
				<input type="text"
				class="form-control" id="trainsNum" placeholder="座位数 " /><br><br>
			    <input type="text"
				class="form-control" id="trainsNum" placeholder="票价 " /><br><br>
				<input type="text"
				class="form-control" id="trainsNum" placeholder="检票口" /><br><br>
				
				<input type="button" id="query"
				class="btn btn-default" value="修改" />
				<br><br>
				<span style="color:red">*注:前4项必须保持不变，只允许修改后4项，如有需求，请删除重新添加</span>
		</form>
	</div>
	
</body>
</html>