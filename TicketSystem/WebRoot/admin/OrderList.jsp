<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单列表</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link href="../css/mobiscroll_date.css" rel="stylesheet" />
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
</head>
<script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script src="js/LoginJudge.js"></script>
<script type="text/javascript">


	$(document).ready(function() {
	
	  getAdminLoginStatus();
    //当前page
    pageNow = 1;
    // page总数
    pageNum = 1;

    $('#query').click(function() {

     $('#pageform').css("display", "block");
        $('#query').attr('disabled', 'disabled');
        $.ajax({

            url: "../order/getOrderNum",
            type: "POST",
            data:{
              date:$('#date').val()
            },
            async: false,
            success: function(data) {
                pageNum = data;
                $('#pageul').css('display', 'inline-block');

                if (data <= 5) {
                    for (var i = 1; i <= data; i++) {

                        $('.liend').before("<li><a href='javascript:PageHandle(" + i + ",this)'>" + i + "</a></li>")
                    }

                } else {

                    for (var i = 1; i <= 5; i++) {

                        $('.liend').before("<li><a href='javascript:PageHandle(" + i + ",this)'>" + i + "</a></li>")
                    }
                    $('.liend').before("<li><a href='javascript:PageHandle(" + data + ",this)'>...</a></li>")

                }
                PageHandle(1,this);

            },
            error: function() {

                alert("获取页码总数失败...")
            }

        })

    })

})
</script>
<body style="background: #f1f1f1;">
	<h1>订单信息查询</h1>

	<div class="form-group">
		<form class="form-inline" role="form">
			<label class="sr-only" for="name">名称</label> 
			<input type="text" class="form-control" id="date" placeholder="日期" />
			<input type="button" id="query" class="btn btn-default" value="生成列表" />
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
	
	<ul class="pagination pagination-lg" id="pageul" style="display:none">
		<li><a href="javascript:prePage()">&laquo;</a></li>
		<li class="liend"><a href="javascript:nextPage()">&raquo;</a></li>
	</ul>
	
	<span id="record" class="pageInfo"></span>
	
    <form id="pageform"  style="display:none" class="form-inline page" role="form">
		<label class="sr-only" for="name">名称</label>
		<input type="text" id="page" class="form-control" placeholder="页数" />
		<input type="button" id="query" onclick="javascript:jumpPage()" class="btn btn-default" value="跳转" />
	</form>
	  

</body>
<script type="text/javascript">


	function getList(page) {

  

    //对底部页码li进行变换
    if (page <= 5) {

        $('#pageul').children().remove();
        $('#pageul')
            .append(
                "<li><a href='javascript:prePage()'>&laquo;</a></li><li class='liend'><a href='javascript:nextPage()'>&raquo;</a></li>")
        if (pageNum > 5) {

            for (var i = 1; i <= 5; i++) {
                $('.liend').before(
                    "<li><a href='javascript:PageHandle(" + i + ",this)'>" + i + "</a></li>");

            }
            $('.liend').before(
                "<li><a href='javascript:PageHandle(" + pageNum + ",this)'>...</a></li>");
        } else {

            for (var i = 1; i <= pageNum; i++) {

                $('.liend').before(
                    "<li><a href='javascript:PageHandle(" + i + ",this)'>"+i+"</a></li>");

            }

        }

    }
    if (page > 5) {

        $('#pageul').children().remove();

        $('#pageul')
            .append(
                "<li><a href='javascript:prePage()'>&laquo;</a></li><li class='liend'><a href='javascript:nextPage()'>&raquo;</a></li>")
        if (page + 4 >= pageNum) {

            $('.liend').before(
                "<li><a href='javascript:PageHandle(" + 1 + ",this)'>...</a></li>");
            for (var i = pageNum - 4; i <= pageNum; i++) {

                $('.liend').before(
                    "<li><a href='javascript:PageHandle(" + i + ",this)'>" + i + "</a></li>")

            }
        } else {

            for (var i = (page - 4); i <= page; i++) {

                $('.liend').before(
                    "<li><a href='javascript:PageHandle(" + i + ",this)'>" + i + "</a></li>")

            }
            $('.liend').before(
                "<li><a href='javascript:PageHandle(" + pageNum + ",this)'>...</a></li>");
        }

    }

    $
        .ajax({

            url: "../order/selectOrderList",
            type: "GET",
            data: {
                page: page,
                date:$('#date').val()
            },
            dataType: "JSON",
            success: function (data) {
                    pageNow = page;
                    if (data.length != 0) {

                        $('.tbody').children().remove();
                    }
                    for (var i = 0; i < data.length; i++) {
                        $('tbody')
                            .append(
                                "<tr class='active'><td>" + data[i].orderNum + "</td><td>" + data[i].date + "</td><td>" + data[i].departPlace + "</td><td>" + data[i].destination + "</td><td><div class='panel-group' id='accordion'><a data-toggle='collapse' data-parent='#accordion' href='#collapse"+i+"'>详细</a><div id='collapse"+i+"' class='panel-collapse collapse'><div class='panel-body'><span>车次号:&nbsp;&nbsp;" + data[i].trainsNum + "</span><span>&nbsp;&nbsp;座位号:&nbsp;&nbsp;" + data[i].seatNum + "</span><span>&nbsp;&nbsp;总价:&nbsp;&nbsp;" + data[i].totalPrice + "</span><span>&nbsp;&nbsp;乘客姓名:&nbsp;&nbsp;" + data[i].customName + "<br><br></span><span>乘客身份证:&nbsp;&nbsp;" + data[i].customId + "</span><span>&nbsp;&nbsp;日期:&nbsp;&nbsp;" + data[i].date + "</span><span>&nbsp;&nbsp;发车时间:&nbsp;&nbsp;" + data[i].departTime + "</span><span><br><br>检票口:&nbsp;&nbsp;" + data[i].ticketBarrier + "</span><span>&nbsp;&nbsp;购买账号:&nbsp;&nbsp;" + data[i].account + "</span></div></div></div></td></tr>")

                    }
                    
                    $('.pageInfo').html("当前页/总页数:"+pageNow+"/"+pageNum);

                },
                error: function () {

                    alert("数据取出异常")

                }

        })

}

function prePage() {

    if ((pageNow - 1) <= 0) {

        alert("没有上一页了");
        return;
    }

    getList(pageNow - 1);

}

function nextPage() {

    if (pageNow + 1 > pageNum) {

        alert("没有下一页了");
        return;
    }

    getList(pageNow + 1);
}

function jumpPage(){

   PageHandle($('#page').val());
}

function PageHandle(page,obj){

  getList(page);

}

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
	$("#date").mobiscroll($.extend(opt['date'], opt['default']));
	
});

</script>
<script src="../js/mobiscroll_date.js"></script>
<script src="../js/mobiscroll.js"></script>
</html>