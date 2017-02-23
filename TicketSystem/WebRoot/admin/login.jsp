<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/login.css">
</head>
<script src="../js/jquery-2.1.4.min.js"></script>  
<script src="../js/bootstrap.min.js"></script>  
<script type="text/javascript">

  $(document).ready(function(){
  
     $('#login').click(function(){
     
       $.ajax({
       
         url:"../admin/login",
         method:"POST",
         data:{
          
            u:$('#u').val(),
            p:$('#p').val()
         },
         success:function(data){
         
           if(data=='true'){
             
             window.location.href="index.jsp";
           }else{
           
             alert("密码错误!")
           
           }
         }
       
       
       
       })
     
     
     
     
     })
  
  
  
  })


</script>
<body>
	<!--导航-->
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <!--小屏幕按钮和logo-->
           <div class="navbar-header">
               <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
                   <span class="icon-bar"></span>
                   <span class="icon-bar"></span>
                   <span class="icon-bar"></span>
               </button>
               <a href="#" class="navbar-brand">长途汽车售票系统管理中心</a>
           </div>
            
        </div>
    </nav>
    <!--导航-->
    <!-- 主体 -->
    <div class="Login-body">
      <div class="container">
          <form class="form-horizontal" role="form">
            <div class="form-group">
              <label for="inputEmail3" class="col-sm-2 control-label" style="padding-left:0">账号</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="u" placeholder="Account">
              </div>
            </div>
            <div class="form-group">
              <label for="inputPassword3" class="col-sm-2 control-label" style="padding-left:0">密码</label>
              <div class="col-sm-10">
                <input type="password" class="form-control" id="p" placeholder="Password">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-offset-2 col-sm-10">
                <div class="checkbox">
                  <label>
                    <input type="checkbox">记住密码
                  </label>
                </div>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-offset-2 col-sm-10">
                <button type="button" id="login" class="btn btn-default">登陆</button>
              </div>
            </div>
          </form>

      </div>
      <div class="wrap"></div>
      <img src="images/Login_bac.jpg">
    </div>
     
    <!-- 主体 -->

    <!-- footer -->
    <footer>
    	 <nav class="navbar navbar-inverse navbar-fixed-bottom">
    	 </nav>
    </footer>
    <!-- footer --> 
	
</body>
</html>