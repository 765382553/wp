<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>删除/停用(恢复)车次</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
</head>
<script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
<script src="js/LoginJudge.js"></script>
<script type="text/javascript">
    
    $(document).ready(function(){
       
       getAdminLoginStatus();
    
      $('#delete').click(function(){
      
              
            $.ajax({
            
            url : "../ticket/deleteTicket",
            type: "POST",
            data:{
              
               trainsNum:$('#trainsNum').val()
            
            },
            success:function(data){
             
             if(data == "true"){
             
               alert("删除成功");
             }else{
             
               alert("删除失败");
             }
            
            },error:function(){
             
               alert("服务器连接失败");
             }
             
           
            })
        
      })
     $('#stop').click(function(){
      
           
            $.ajax({
            
            url : "../ticket/pauseTicket",
            type: "POST",
            data:{
              
               trainsNum:$('#trainsNum').val()
            
            },
            success:function(data){
             
             if(data == "true"){
             
               alert("操作成功");
             }else{
             
               alert("操作失败");
             }
            
            },error:function(){
             
               alert("服务器连接失败");
             }          
      
      })

      })
      $('#recover').click(function(){
      
           
            $.ajax({
            
            url : "../ticket/recoverUse",
            type: "POST",
            data:{
              
               trainsNum:$('#trainsNum').val(),
               type:1
            
            },
            success:function(data){
             
             if(data == "true"){
             
               alert("操作成功");
             }else{
             
               alert("操作失败");
             }
            
            },error:function(){
             
               alert("服务器连接失败");
             }          
      
      })

      })
    })
</script>
<body style="background: #f1f1f1;">
     <span style="font-size:25px;margin-left:410px;">删除/停用车次</span>
	<br />
	<br />
	<div class="form-group" style="margin-left:38px;">
		<form class="form-inline" role="form">
			<label class="sr-only" for="name">名称</label> <input type="text"
				class="form-control" id="trainsNum" placeholder="车次" />
				<br> <br>
				 <input type="button" id="delete"
				class="btn btn-default" value="删除" />
				&nbsp;&nbsp;
				<input type="button" id="stop"
				class="btn btn-default" value="停用" />
				<input type="button" id="recover"
				class="btn btn-default" value="恢复" />
		</form>
	</div>
</body>
</html>