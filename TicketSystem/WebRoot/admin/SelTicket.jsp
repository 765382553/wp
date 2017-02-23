<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询车次</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<style type="text/css">
.pageSelected {
	background: "red";
	font-size: "30px;"
}

body {
	overflow: hidden;
	color: gray;
}

.container {
	margin-left: -14px;
}

#record {
	position: absolute;
	right: 220px;
	margin-top: 20px;
	width: 200px;
	height: 60px;
	line-height: 60px;
	text-align: center;
}
.search-text ul li{

  margin-left:-39px;
}
.search-text2 ul li{
  margin-left:-39px;

}


</style>
<link href="../css/city.css" rel="stylesheet" type="text/css" />
<link href="../css/mobiscroll_date.css" rel="stylesheet" />
</head>
<script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
<script src="js/LoginJudge.js"></script>
<script>
	$(document).ready(function() {
    
      getAdminLoginStatus();

		$('#query').click(
		   
		   function(){
		   
		    query();
		   }
		);

	})
	function query() {

		$.ajax({

			url : "../ticket/selectByNeed",
			type : "POST",
			data : {

				departPlace : $('.departPlcae_1').val(),
				destination : $('.destination_1').val(),
				date : $('#date_1').val()

			},
			async:false,
			dataType : "JSON",
			success : function(data) {

				    $('.tbody').children().remove();
				if (data.length == 0) {
				   
					alert("暂无所需车次!")
				}
				for (var i = 0; i < data.length; i++) {

					/* alert("车次:" + data[i].trainsNum
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
							+ data[i].date) */

					/* 	if(data.length!=0){
								
						 $(".tbody").after("<span class='span123'>111</span>");
						} */
					for (var i = 0; i < data.length; i++) {
                        if(data[i].busType==1){
                        
                        data[i].busType = "常规";
                        }else{
                          
                        data[i].busType = "加班";
                        }
						switch ((i + 1) % 5) {
                         
						case 1:
							$(".tbody").append(
									"<tr class='success'><td>"
											+ data[i].trainsNum + "</td><td>"
											+ data[i].busType + "</td><td>"
											+ data[i].departPlace + "</td><td>"
											+ data[i].destination + "</td><td>"
											+ data[i].departureTime
											+ "</td><td>" + data[i].ticketPrice
											+ "</td><td>" + data[i].count
											+ "</td><td>"
											+ data[i].ticketBarrier
											+ "</td><td>" + data[i].date
											+ "</td></tr>")
							break;
						case 2:
							$(".tbody").append(
									"<tr class='success'><td>"
											+ data[i].trainsNum + "</td><td>"
											+ data[i].busType + "</td><td>"
											+ data[i].departPlace + "</td><td>"
											+ data[i].destination + "</td><td>"
											+ data[i].departureTime
											+ "</td><td>" + data[i].ticketPrice
											+ "</td><td>" + data[i].count
											+ "</td><td>"
											+ data[i].ticketBarrier
											+ "</td><td>" + data[i].date
											+ "</td></tr>");
							break;
						case 3:
							$(".tbody").append(
									"<tr class='error'><td>"
											+ data[i].trainsNum + "</td><td>"
											+ data[i].busType + "</td><td>"
											+ data[i].departPlace + "</td><td>"
											+ data[i].destination + "</td><td>"
											+ data[i].departureTime
											+ "</td><td>" + data[i].ticketPrice
											+ "</td><td>" + data[i].count
											+ "</td><td>"
											+ data[i].ticketBarrier
											+ "</td><td>" + data[i].date
											+ "</td></tr>");
							break;
						case 4:
							$(".tbody").append(
									"<tr class='warning'><td>"
											+ data[i].trainsNum + "</td><td>"
											+ data[i].busType + "</td><td>"
											+ data[i].departPlace + "</td><td>"
											+ data[i].destination + "</td><td>"
											+ data[i].departureTime
											+ "</td><td>" + data[i].ticketPrice
											+ "</td><td>" + data[i].count
											+ "</td><td>"
											+ data[i].ticketBarrier
											+ "</td><td>" + data[i].date
											+ "</td></tr>");
							break;
						case 5:
							$(".tbody").append(
									"<tr class='info'><td>" + data[i].trainsNum
											+ "</td><td>" + data[i].busType
											+ "</td><td>" + data[i].departPlace
											+ "</td><td>" + data[i].destination
											+ "</td><td>"
											+ data[i].departureTime
											+ "</td><td>" + data[i].ticketPrice
											+ "</td><td>" + data[i].count
											+ "</td><td>"
											+ data[i].ticketBarrier
											+ "</td><td>" + data[i].date
											+ "</td></tr>");
							break;

						}

					}
					//

				}
			},
			error : function() {

				alert("error");

			}

		});

	}
</script>
<body style="background: #f1f1f1;">
	<h1>车票查询</h1>


	<div class="form-group">
		<form class="form-inline" role="form">
			<label class="sr-only" for="name">名称</label> <input type="text"
				class="typeahead1 input-md form-control departPlcae_1"
				id="city_name" placeholder="出发地" /> <input type="text"
				class="typeahead1 input-md form-control destination_1"
				id="city_name2" placeholder="目的地" /> <input type="text"
				class="form-control" id="date_1" placeholder="日期" /> <input
				type="button" id="query" class="btn btn-default" value="查询" />
		</form>
	</div>


	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<table class="table table-bordered table-hover table-condensed">
					<thead class="thead">
						<tr>
							<th>车次</th>
							<th>种类</th>
							<th>出发地</th>
							<th>目的地</th>
							<th>发车时间</th>
							<th>票价</th>
							<th>余量</th>
							<th>检票口</th>
							<th>日期</th>
						</tr>
					</thead>
					<tbody class="tbody">

					</tbody>
				</table>

				<ul class="pagination">
					<li><a href="javascript:void(0)" onclick="preDay()">前一天</a></li>
					<li><a href="javascript:void(0)" onclick="nexDay()">后一天</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>


<script type="text/javascript">
	function preDay() {

		var d = $('#date_1').val();
		 d = new Date(d);
         d = d-1000*60*60*24;
         d = new Date(d);
        var    x = d.getFullYear();
        var    y = (d.getMonth()+1);
        var    z = d.getDate();
       if(y<10){
        
        y= '0'+y;
       }
       if(z<10){
        
        z= '0'+z;
       }
       
      

		$('#date_1').val(""+x+"-"+y+"-"+z);
						query();

	}
	function nexDay() {

		  var d = $('#date_1').val();
		  d = new Date(d);
          d =+d+1000*60*60*24;
          d = new Date(d);
          var  x = d.getFullYear();
          var    y = (d.getMonth()+1);
       var    z = d.getDate();
       if(y<10){
        
        y= '0'+y;
       }
       if(z<10){
        
        z= '0'+z;
       }
       
		$('#date_1').val(x+"-"+y+"-"+z)

        query();
	}
	/*地区控件*/
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
 //   var optDateTime = $.extend(opt['datetime'], opt['default']);
//    var optTime = $.extend(opt['time'], opt['default']);
	$("#date_1").mobiscroll($.extend(opt['date'], opt['default']));
//	$("#departureTime").mobiscroll(optTime).time(optTime);

});
  
</script>
<script src="../js/cities.js"></script>
<script src="../js/jquery.autocomplete.js"></script>
<script src="../js/mobiscroll_date.js"></script>
<script src="../js/mobiscroll.js"></script>
</html>