<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@	taglib prefix="s" uri="/struts-tags"%>
<title>管理员登录</title>
</head>
<body>

	<s:form action="user_adminlogin" class="login-form">
		<div>
			<font color="red"> <s:fielderror />
			</font>
		</div>
		<s:textfield name="loginName" size="20" tabindex="1"
			id="loginNameInput" placeholder="请输入用户名"></s:textfield>
		<input name="password" type="password" placeholder="请输入密码">
		<br>
	
	
		<s:submit value="登录" class="button" id="login"></s:submit>
	</s:form>

</body>
</html>