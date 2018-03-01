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
	<style type="text/css">
		.login-page {
		  width: 360px;
		  padding: 8% 0 0;
		  margin: auto;
		}
		.form {
		  position: relative;
		  z-index: 1;
		  background: #FFFFFF;
		  max-width: 360px;
		  margin: 0 auto 100px;
		  padding: 45px;
		  text-align: center;
		  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
		}
		body {
		  background: #76b852; /* fallback for old browsers */
		  background: -webkit-linear-gradient(right, #76b852, #8DC26F);
		  background: -moz-linear-gradient(right, #76b852, #8DC26F);
		  background: -o-linear-gradient(right, #76b852, #8DC26F);
		  background: linear-gradient(to left, #76b852, #8DC26F);
		  font-family: "Roboto", sans-serif;
		  -webkit-font-smoothing: antialiased;
		  -moz-osx-font-smoothing: grayscale;      
		}
		.form input {
		  font-family: "Roboto", sans-serif;
		  outline: 0;
		  background: #BABABA;
		  width: 100%;
		  border: 0;
		  margin: 0 0 15px;
		  padding: 15px;
		  box-sizing: border-box;
		  font-size: 14px;
		}
		.form .button_1 {
		  font-family: "Microsoft YaHei","Roboto", sans-serif;
		  text-transform: uppercase;
		  outline: 0;
		  background: #4CAF50;
		  width: 100%;
		  border: 0;
		  padding: 15px;
		  color: #FFFFFF;
		  font-size: 14px;
		  -webkit-transition: all 0.3 ease;
		  transition: all 0.3 ease;
		  cursor: pointer;
		}
	</style>
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
	<h2 align="center">电子相册在线制作平台</h2>
	<div id="wrapper" class="login-page">
		<div id="login_form" class="form">
		<s:form action="user_login">
			<div>
			<font color="red">
				<s:fielderror/>
			</font>
			</div>
		
		
			
	        <s:textfield name="loginName" size="20" tabindex="1" id="loginNameInput"></s:textfield>
	        <input name="password" type="password">
	        <br>
	        <s:submit value="登录" class="button_1"></s:submit>
	    </s:form>
	    <s:a action="user_addUI"><input type="button"  value="注册"/></s:a>
	    </div> 
    </div>
</body>
</html>