<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-2.1.4.min.js"></script>
<script src="js/LoginJudge.js"></script>
<script type="text/javascript">
	

   $(document).ready(function(){
   
      getAdminLoginStatus();
    
   })
   /**
     更改账号信息
   */
   function updateInfo(){
     
     var password = $('#password').val();
     var repassword = $('#repassword').val()
   
      if(password!=repassword){
        alert("两次输入的密码不一致!")
        return;
      }
   
     $.ajax({
      
        url:"../admin/updAdminsInfo",
        method:"POST",
        data:{
        
           id:$('#id').val(),
           account:$('#account').val(),
           password:password,
           email:$('#email').val(),
           address:$('#address').val()
        
        },
        success:function(data){
          
          if(data=='false'){
            
            alert("修改失败,请检查输入!")
          }else{
          
            top.location.href="login.jsp"
          }
            
        }
      
      
      })
   
   
   }

</script>
<style type="text/css">

<style type="text/css">
*{
	margin:0;
	padding: 10px;
}
body{
	overflow:hidden; 
}
#updateadmin{
	width: 800px;
	height:600px;
	float: left;
}
#updateadmin h2{
	color: black;
	
}
#updateadmin p{
	color: gray;
}

.article{
	margin:10px 10px;
	width: 600px;
	height: 40px;
}
.article span{
	color:gray;
	float: left;
}
.article input{
	display:inline-block;
	width:320px;
	height:20px;
	float:right;
	border: 1px solid gray;
}
.sub{
	display:block;
	width: 40px;
	height: 16px;

} 
.sub input {
	
	width:58px;
	height:40px;
	border: 0px;
	list-style: none;
	background:#a5b9a0;
	border-radius: 6px;
	color: white;
	margin-left: 10px;
	outline-style: none;
}
.sub input:hover{
	background: #7d9975;
}
</style>
</head>
<body>
<div id="updateadmin">
	<h2>编辑管理员信息</h2>
	<form action="" method="post">
		<input type="hidden" id="id" value="${sessionScope.admin.id}">
		<div class="article"><span>姓名:</span><input id="account" type="text" value="${sessionScope.admin.account}"/></div>
		<div class="article"><span>密码</span><input id="password" type="password" value=""/></div>
		<div class="article"><span>再次输入密码</span><input id="repassword" type="password" value=""/></div>
		<div class="article"><span>邮箱</span><input id="email" type="text" value="${sessionScope.admin.email}"/></div>
		<div class="article"><span>居住地住</span><input id="address" type="text" value="${sessionScope.admin.address}"/></div>
		<div class="sub">
				<input onclick='updateInfo()' ` type="button" id="submit" value="确认修改">
		</div>
	</form>
</div>
</body>
</html>