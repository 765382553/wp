<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
</head>
<script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script src="js/LoginJudge.js"></script>
<script type="text/javascript">
  $(document).ready(function(){
    
     getAdminLoginStatus();
  
      $('#delete').click(function(){
      
      
          $.ajax({
          
            url:"../user/deleteUser",
            type:"POST",
            data:{
            
              u:$('#username').val()
            
            },
            success:function(data){
             
             if(data == "true"){
             
               alert("删除成功");
             }else{
             
               alert("检查输入");
             }
            
            },error:function(){
             
               alert("服务器连接失败");
             }
             
          
          
          })
      
      
      
      })
  
  
  })
</script>
<body style="background: #f1f1f1;">
  <span style="font-size:25px;margin-left:410px;">删除用户</span>
	<br />
	<br />
	<div class="form-group" style="margin-left:38px;">
		<form class="form-inline" role="form">
			<label class="sr-only" for="name">用户账号</label> <input type="text"
				class="form-control" id="username" placeholder="账号" />
				<br> <br>
				 <input type="button" id="delete"
				class="btn btn-default" value="删除" />
				&nbsp;&nbsp;
				
		</form>
	</div>


</body>
</html>