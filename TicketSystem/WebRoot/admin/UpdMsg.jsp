<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告调整</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<style type="text/css">
body {
	overflow: hidden;
	background: #f1f1f1;
}

input[type="text"] {
	background: #f1f1f1;
	border: 0;
	outline: none;
}

a {
	cursor: pointer;
}

#upMsg {
	margin-top: -20px;
}

#upMsg h2 {
	color: gray;
}
</style>
<script src="../js/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function showList(obj) {

		$
				.ajax({

					url : "../notice/selNoticeList",
					type : "POST",
					dataType : "JSON",
					success : function(data) {

						for (var i = 0; i < data.length; i++) {

							var s = "<tr><td class='id'>"
									+ data[i].id
									+ "</td><td class='msg'><input type='text'onkeydown='this.onkeyup();' onkeyup='this.size=(this.value.length>25?this.value.length:25);'maxlength='150' size='25'value='"
									+ data[i].content
									+ "'/></td><td><a onclick='javascript:updMsg(this);'>更新</a>/<a onclick='javascript:delMsg(this);'>删除</a></td></tr>"

							$('#content').append(s);

						}
						$(obj).attr('disabled', 'disabled');
					}

				})
	}
	function updMsg(obj) {

		var id = $(obj).parents("tr").find('.id').text();
		var content = $(obj).parents("tr").find('.msg input').val();

		$.ajax({

			url : "../notice/updNoticeMessage",
			type : "POST",
			data : {

				id : id,
				content : content

			},
			success : function(data) {

				if (data == "true") {

					alert("更新成功!")
				} else {

					alert("更新失败，请稍后再试")
				}
			}

		})
	}

	function delMsg(obj) {

		var id = $(obj).parents("tr").find('.id').text();
		$.ajax({

			url : "../notice/delNoticeMessage",
			type : "POST",
			data : {

				id : id
			},
			success : function(data) {

				if (data == "true") {

					$(obj).parents("tr").remove();
				} else {

					alert("删除失败，请稍后再试");
				}

			}

		})
	}
</script>
</head>
<body>
	<div id="upMsg">
		<h2>公告调整</h2>
	</div>
	<input type="button" class="btn btn-default"
		onclick="javascript:showList(this);" value="显示列表信息" />
	<br />
	<br />
	<table class="table table-bordered table-hover table-condensed">
		<thead class="thead">
			<th>ID</th>
			<th>内容</th>
			<th>操作</th>
		</thead>
		<tbody id="content">
		</tbody>
	</table>

</body>
</html>