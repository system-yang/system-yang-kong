<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>daydayup</title>
<%@ include file="commons/basejs.jsp"%>
</head>
<style>
html{
    height: 100%;
}
body{
    padding: 0;
    margin: 0;
    background: url("static/image/loginImage.jpg") no-repeat;
    background-size: 100% 100%;
    position: absolute;
}
</style>
<body>
	<div style="padding:80px 40%; ">
		<div class="easyui-panel" style="width:400px;padding:20px 60px; ">
			<form id="ff" method="post" action="${ctxPath}/login">
				<div align="center">
					<h2>XX平台登录管理</h2>
				</div>
				<div style="margin-bottom:20px">
					<input class="easyui-textbox" name="username" value="admin" data-options="prompt:'请输入用户名',iconWidth:'28'" style="width:100%;height:34px;padding:10px;">
				</div>
				<div style="margin-bottom:20px">
					<input class="easyui-passwordbox" name="password" value="123456" data-options="prompt:'请输入密码',iconWidth:'28'" style="width:100%;height:34px;padding:10px">
				</div>
				<div style="margin-bottom: 10px;">
						<input type="submit" value="登录" /><span>${ msg }</span>
				</div>
			</form>
		</div>
		<div id="viewer"></div>
	</div>
<script type="text/javascript">

	//登录
	$('#ff').form({
	    onSubmit : function() {
	        /* progressLoad();
	        var isValid = $(this).form('validate');
	        if(!isValid){
	            progressClose();
	        }
	        return isValid; */
	    },
	    success:function(result){
	        result = $.parseJSON(result); 
	        if (result.success) {
	            window.location.href = basePath + '/index';
	        }else{
	            // 刷新验证码
	            /* $("#captcha")[0].click();
	            showMsg(result.msg); */
	        }
	    }
	});
	


</script>
</body>
</html>
