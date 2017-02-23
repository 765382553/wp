<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改用户信息</title>
</head>
<script src="js/LoginJudge.js"></script>

<body style="background: #f1f1f1;">
	<span style="font-size:25px;margin-left:410px;">用户信息更新</span>
	<br />
	<br />
	<div class="form-group" style="margin-left:38px;">
		<form class="form-inline" role="form">
			<label class="sr-only" for="name">名称</label> <input type="text"
				class="form-control" id="username" placeholder="用户名" /> <input
				type="button" id="query" class="btn btn-default" value="查询" />
		</form>
	</div>
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<table class="table table-bordered table-hover table-condensed">
					<thead class="thead">
						<tr>
							<th>用户名</th>
							<th>余额</th>
							<th>email</th>
							<th>最近订单</th>
						</tr>
					</thead>
					<tbody class="tbody">

					</tbody>
				</table>

			</div>
		</div>
	</div>

</body>
</html>