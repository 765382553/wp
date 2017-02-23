<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增车次</title>

<style type="text/css">
* {
	margin: 0;
	padding: 10px;
}

body {
	overflow: hidden;
}

#addTicket {
	width: 800px;
	height: 600px;
	float: left;
}

#addTicket h2 {
	color: gray;
}

#addTicket p {
	color: gray;
}

#addTicket span {
	float: left;
}

.article {
	width: 600px;
	height: 20px;
}

.article span {
	color: gray;
	line-height: 10px;
	text-align: center;
	float: left;
}

.article input {
	display: inline-block;
	float: right;
	width: 320px;
	height: 8px;
	border: 1px solid gray;
}
.article select {
	display: inline-block;
	float: right;
	width: 342px;
	height: 30px;
	border: 1px solid gray;
	padding:4px;
}

.sub {
	display: block;
	width: 40px;
	height: 16px;
}

.sub input {
	border: 0px;
	list-style: none;
	background: #a5b9a0;
	border-radius: 6px;
	color: white;
	margin-left: 10px;
	outline-style: none;
}

.sub input:hover {
	background: #7d9975;
}
</style>
<link href="../css/city.css" rel="stylesheet" type="text/css" />
<link href="../css/mobiscroll_date.css" rel="stylesheet" />
</head>


<body>
	<div id="addTicket">
		<h2>添加新车次</h2>
		<P>新建新车次,并将车次加入,以下均为必填项。</P>
		<div class="article">
			<span>车次</span><input type="text" id="trainsNum" name="trainsNum" />
		</div>
		<div class="article">
			<span>种类</span>
			<select id="busType">
                 <option value="1">常规</option>
                 <option value="2">加班</option>
            </select>
<!-- <input type="text" id="busType" name="busType" />  -->
		</div>
		<div class="article">
			<span>出发地</span><input type="text" id="city_name"
				class="departPlace typeahead1 input-md" name="departPlace" />
		</div>
		<div class="article">
			<span>目的地</span><input type="text" id="city_name2"
				class="destination typeahead1 input-md" name="destination" />
		</div>
		<div class="article">
			<span>发车时间</span><input type="text" id="departureTime"
				name="departureTime" />
		</div>
		<div class="article">
			<span>票价</span><input type="text" id="ticketPrice" name="ticketPrice" />
		</div>
		<div class="article">
			<span>余量</span><input type="text" id="count" name="count" />
		</div>
		<div class="article">
			<span>检票口</span><input type="text" id="ticketBarrier"
				name="ticketBarrier" />
		</div>
		<div class="article">
			<span>日期</span><input type="text" id="date" name="date" />
		</div>
		<div class="sub">
			<input onmouseover='bgchange(this)' onmousedown='bgback(this)'
				type="button" id="submit" value="添加车次" />
		</div>
	</div>
</body>
<script src="../js/jquery-2.1.4.min.js"></script>
<script src="js/LoginJudge.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
  
      getAdminLoginStatus();

		$('#submit').click(function() {

			$.ajax({

				url : "../ticket/addTicket",
				method : "POST",
				data : {

					trainsNum : $('#trainsNum').val(),
					busType : $("#busType option:selected").val(),
					departPlace : $('.departPlace').val(),
					destination : $('.destination').val(),
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

	});
	
</script>
<script type="text/javascript">
 
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
		nowText: "当前",
		startYear: currYear - 50, //开始年份
		endYear: currYear + 10 //结束年份
	};
    var optDateTime = $.extend(opt['datetime'], opt['default']);
    var optTime = $.extend(opt['time'], opt['default']);
	$("#date").mobiscroll($.extend(opt['date'], opt['default']));
	$("#departureTime").mobiscroll(optTime).time(optTime);

});
  
</script>
<script src="../js/cities.js"></script>
<script src="../js/jquery.autocomplete.js"></script>
<script src="../js/mobiscroll_date.js"></script>
<script src="../js/mobiscroll.js"></script>
</html>
