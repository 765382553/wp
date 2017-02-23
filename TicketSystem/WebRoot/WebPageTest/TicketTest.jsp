<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
table input:text{
	outline: none;
	border: 0;
	background: transparent;
}
 </style>
</head>
<script src="js/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {

				$('#submit').click(function() {

					$.ajax({

						url : "ticket/addTicket",
						method : "POST",
						data : {

							trainsNum : $('#trainsNum').val(),
							busType : $('#busType').val(),
							departPlace : $('#departPlace').val(),
							destination : $('#destination').val(),
							departureTime : $('#departureTime').val(),
							ticketPrice : $('#ticketPrice').val(),
							count : $('#count').val(),
							ticketBarrier : $('#ticketBarrier').val(),
							date : $('#date').val()

						},
						dataType : "text",
						success : function(data) {

							alert(data == "true" ? "添加成功" : "添加失败");

						},
						error : function() {

							alert("error");

						}

					});

				});

				$('#submit2').click(function() {

					$.ajax({

						url : "ticket/deleteTicket",
						type : "POST",
						data : {

							trainsNum : $('#trainsNum2').val()

						},
						async : false,
						dataType : "text",
						success : function(data) {

							alert(data == "true" ? "删除成功" : "刪除失败");
						},
						error : function() {

							alert("error");

						}
					});

				});

				$('#query').click(
						function() {

							$.ajax({

								url : "ticket/selectByNeed",
								type : "POST",
								data : {

									departPlace : $('#departPlcae_1').val(),
									destination : $('#destination_1').val(),
									date : $('#date_1').val()

								},
								dataType : "JSON",
								success : function(data) {

									if (data.length == 0) {
										alert("暂无所需车次!")
									}
									for (var i = 0; i < data.length; i++) {

										alert("车次:" + data[i].trainsNum
												+ ",类型:" + data[i].busType
												+ ",出发地:" + data[i].departPlace
												+ ",目的地:" + data[i].destination
												+ ",发车时间"
												+ data[i].departureTime
												+ ",票价:" + data[i].ticketPrice
												+ ",数量:" + data[i].count
												+ ",检票口:"
												+ data[i].ticketBarrier
												+ ",剩余座位:"
												+ data[i].seatResidual + ",日期:"
												+ data[i].date)
									}
								},
								error : function() {

									alert("error");

								}

							});

						});

			});
</script>

<link rel="stylesheet" type="text/css" href="css/bootstrap.css">

<body>
	<!-- <table class="table">
		<caption>票务添加</caption>
		<thead>
			<tr>
				<th>车次</th>
				<th>种类</th>
				<th>出发地</th>
				<th>目的地</th>
				<th>发车时间</th>

			</tr>
		</thead>

		<tbody>
			<tr class="active">
				<td><input type="text" id="trainsNum" name="trainsNum" /></td>
				<td><input type="text" id="busType" name="busType" /></td>
				<td><input type="text" id="departPlace" name="departPlace" /></td>
				<td><input type="text" id="destination" name="destination" /></td>
				<td><input type="text" id="departureTime" name="departureTime" /></td>

			</tr>
		</tbody>
		
		<thead>
			<tr>
               <th>票价</th>
               <th>余量</th>
               <th>检票口</th>
               <th>日期</th>
               <th>提交</th>
            </tr>
        </thead>
  <tbody>
  <tr class="active">
      <td><input type="text" id="ticketPrice" name="ticketPrice" /></td>
      <td><input type="text" id="count" name="count"  /></td>
      <td><input type="text" id="ticketBarrier" name="ticketBarrier" /></td>
      <td><input type="text" id="date" name="date" /></td>
      <td><input type="button" id="submit" value="提交"></td>
      </tr>
  </tbody>
    <tr class="success">
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>6</td>
      <td>7</td>
      <td>8</td>
      <td>9</td>
      </tr>
    <tr class="warning">
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>6</td>
      <td>7</td>
      <td>8</td>
      <td>9</td>
      </tr>
    <tr class="danger">
     <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>6</td>
      <td>7</td>
      <td>8</td>
      <td>9</td>
      </tr>
      <tr class="active">
     <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>6</td>
      <td>7</td>
      <td>8</td>
      <td>9</td>
      </tr>
		</tbody>
		
</table> -->
	<form>
		<input type="text" id="trainsNum" name="trainsNum" placeholder="车次" /><br />
		<input type="text" id="busType" name="busType" placeholder="种类" /><br />
		<input type="text" id="departPlace" name="departPlace"
			placeholder="出发地" /><br /> <input type="text" id="destination"
			name="destination" placeholder="目的地" /><br /> <input type="text"
			id="departureTime" name="departureTime" placeholder="发车时间" /><br />
		<input type="text" id="ticketPrice" name="ticketPrice"
			placeholder="票价" /><br /> <input type="text" id="count"
			name="count" placeholder="余量" /><br /> <input type="text"
			id="ticketBarrier" name="ticketBarrier" placeholder="检票口" /> <br />
		<input type="text" id="date" name="date" placeholder="日期" /><br /> <input
			type="button" id="submit" value="提交">
	</form>
	<br />
	<br />
	<form method="post" action="">
		<input type="text" id="trainsNum2" placeholder="输入要删除的车次号" /><br />
		<input type="submit" id="submit2" value="提交" /><br />
	</form>
	<br />
	<br />
	<form action="">
		<input type="text" id="departPlcae_1" placeholder="出发地" /><br /> <input
			type="text" id="destination_1" placeholder="目的地" /><br /> <input
			type="text" id="date_1" placeholder="日期" /><br /> <input
			type="button" id="query" value="查询需求信息" />
	</form>

</body>
</html>
