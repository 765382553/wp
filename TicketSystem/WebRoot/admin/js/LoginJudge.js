function getAdminLoginStatus(){
	
	$.ajax({
		
		url:"../admin/getLoginStatus",
		async:false,
		success:function(data){
			
			if(data==""){
				alert("您尚未登录，请登录后再进行操作!")
				top.location.href="login.jsp";
			}
			
		}
	})
	
	
}