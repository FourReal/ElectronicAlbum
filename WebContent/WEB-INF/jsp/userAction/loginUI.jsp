<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@	taglib prefix="s" uri="/struts-tags" %>
	<script src="jquery-3.2.1.min.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	
		$(function(){
			document.forms[0].loginName.focus();
		});
		
		//在被嵌套时就刷新上级窗口
		if(window.parent!=window){
			window.parent.location.reload(true);
		}
		
	</script>
</head>
<body>
	<s:form action="user_login">
		<div>
		<font color="red">
			<s:fielderror/>
		</font>
		</div>

        <s:textfield name="loginName" size="20" tabindex="1" id="loginNameInput"></s:textfield>
        <input name="password" type="password">
        <br>
        <s:submit value="登录"></s:submit>
    </s:form>
    
    <s:a action="user_addUI"><input type="button"  value="注册"/></s:a> 
</body>
</html>