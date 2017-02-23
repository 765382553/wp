<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单查询</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
</head>
<script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script src="js/LoginJudge.js"></script>
<style type="text/css">

  .pageSelected{
    background:"red";
    font-size:"30px;"
  }
  body {
	overflow: hidden;
	color: gray;
	}
  .container{
  	margin-left: -14px;
  }
  #record{
  	position: absolute;
	right: 220px;
	margin-top: 20px;
	width: 200px;
	height: 60px;
	line-height: 60px;
	text-align: center;
  }

</style>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
           getAdminLoginStatus();

						$('#query').click(function() {

							query();

						})

						function query() {

							$
									.ajax({

										url : "../order/selectByOrderNum",
										type : "POST",
										async : false,
										dataType : "JSON",
										data : {

											orderNum : $('#orderNum').val()
										},
										success : function(data) {

                                            $('.tbody').children().remove();
											if (data.length == 0) {

												alert("检查输入")
											} else {

												$('tbody')
														.append(
																"<tr class='active'><td>"
																		+ data.orderNum
																		+ "</td><td>"+data.date+"</td><td>"
																		+ data.departPlace
																		+ "</td><td>"
																		+ data.destination
																		+ "</td><td><div class='panel-group' id='accordion'><a data-toggle='collapse' data-parent='#accordion' href='#collapse'>详细</a><div id='collapse' class='panel-collapse collapse'><div class='panel-body'><span>车次号:&nbsp;&nbsp;"
																		+ data.trainsNum
																		+ "</span><span>&nbsp;&nbsp;座位号:&nbsp;&nbsp;"
																		+ data.seatNum
																		+ "</span><span>&nbsp;&nbsp;总价:&nbsp;&nbsp;"
																		+ data.totalPrice
																		+ "</span><span>&nbsp;&nbsp;乘客姓名:&nbsp;&nbsp;"
																		+ data.customName
																		+ "<br><br></span><span>乘客身份证:&nbsp;&nbsp;"
																		+ data.customId
																		+ "</span><span>&nbsp;&nbsp;日期:&nbsp;&nbsp;"
																		+ data.date
																		+ "</span><span>&nbsp;&nbsp;发车时间:&nbsp;&nbsp;"
																		+ data.departTime
																		+ "</span><span><br><br>检票口:&nbsp;&nbsp;"
																		+ data.ticketBarrier
																		+ "</span><span>&nbsp;&nbsp;购买账号:&nbsp;&nbsp;"+data.account+"</span></div></div></div></td></tr>")

											}

										}

									})
						}

					})
</script>

<body style="background: #f1f1f1;">
	<h1>订单信息查询</h1>


	<div class="form-group">
		<form class="form-inline" role="form">
			<label class="sr-only" for="name">名称</label> <input type="text"
				class="form-control" id="orderNum" placeholder="账单号" /> <input
				type="button" id="query" class="btn btn-default" value="查询" />
		</form>
	</div>
	
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<table class="table table-bordered table-hover table-condensed">
					<thead class="thead">
						<tr>
							<th>订单号</th>
							<th>日期</th>
							<th>出发地</th>
							<th>目的地</th>
							<th>详细信息</th>
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