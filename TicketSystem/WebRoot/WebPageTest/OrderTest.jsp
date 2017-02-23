<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$('#submit').click(function() {

							$.ajax({

								url : "order/createOrder",
								method : "POST",
								data : {
									trainsNum : $('#trainsNum').val(),
									seatNum : $('#seatNum').val(),
									totalPrice : $('#totalPrice').val(),
									customId : $('#customId').val(),
									customName : $('#customName').val(),
									account : $('#account').val(),
									departPlace : $('#departPlace').val(),
									destination : $('#destination').val(),
									date : $('#date').val(),
									departTime : $('#departTime').val(),
                                    ticketBarrier:$('#ticketBarrier').val()
								},
								success : function(data) {

									alert(data == "true" ? "添加成功" : "添加失败");

								},
								error : function() {

									alert("error")
								}

							});
						})

						$('#query')
								.click(
										function() {

											$
													.ajax({

														url : "order/selectByNeed",
														method : "POST",
														data : {

															account : $(
																	'#account_1')
																	.val()
														},
														success : function(data) {

															if (data.length == 0) {
																alert("暂无记录")
															}

															for (var i = 0; i < data.length; i++) {
															
																alert("车次:"
																		+ data[i].trainsNum
																		+ ",座位:"
																		+ data[i].seatNum
																		+ ",总价:"
																		+ data[i].totalPrice
																		+ ",乘客身份证:"
																		+ data[i].customId
																		+ ",乘客姓名:"
																		+ data[i].customName
																		+ ",账户:"
																		+ data[i].account
																		+ ",出发地:"
																		+ data[i].departPlace
																		+ ",目的地:"
																		+ data[i].destination
																		+ ",日期:"
																		+ data[i].date
																		+ ",发车时间:"
																		+ data[i].departTime);
															}

														},
														error : function() {

															alert("error");

														}

													});

										});

					});
</script>
<body>

	<form action="">
		<input type="text" id="trainsNum" placeholder="车次" /><br /> <input
			type="text" id="seatNum" placeholder="座位号" /><br /> <input
			type="text" id="totalPrice" placeholder="金额" /><br /> <input
			type="text" id="customId" placeholder="乘客身份证" /><br /> <input
			type="text" id="customName" placeholder="乘客姓名" /><br /> <input
			type="text" id="account" placeholder="账号" /><br /> <input
			type="text" id="departPlace" placeholder="出发地" /><br /> <input
			type="text" id="destination" placeholder="目的地" /><br /> <input
			type="text" id="date" placeholder="日期" /><br /> <input type="text"
			id="departTime" placeholder="发车时间" /><br />
			<input id="ticketBarrier" type="text" placeholder="检票口"/><br />
			 <input type="button"
			id="submit" value="添加">
	</form>
	<br />
	<br />
	<form action="">
		<input type="text" id="account_1" placeholder="账号" /><br /> <input
			type="button" id="query" value="查询" />

	</form>
</body>
</html>