<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增公告</title>
<style type="text/css">
#Msg {
	width: 600px;
	margin-top: -20px;
}

#Msg h2 {
	color: gray;
	text-indent: 1em;
}

#Msg textarea {
	width: 500px;
	height: 200px;
	margin-left: 20px;
}

#Msg .add {
	width: 200px;
	height: 30px;
	margin-left: 20px;
	padding: 5px;
	outline: none;
	color: black;
	display: inline-block;
	font-size: 16px;
	margin-top: 20px;
	background: #6ebf9f;
	border: 1px solid #467d67;
}

#Msg .add:hover {
	background: #21362e;
	color: white;
}
</style>
<script src="../js/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function addMsg() {
	
		var content = $('#content').val();

		$.ajax({

			url : "../notice/addNioticeMessage",
			type : "POST",
			data : {

				content : content

			},
			success : function(data) {

				if (data == "true") {

					alert("添加成功");
				} else {

					alert("添加失败");
				}
			}

		})
	}
</script>
</head>
<body>
	<div id="Msg">
		<h2>添加公告</h2>
		<form action="">
			<textarea id="content" rows="5" cols="3" ></textarea>
			<input class="add" onclick="javascript:addMsg();" type="button"
				value="添加" />
		</form>
	</div>
</body>
</html>