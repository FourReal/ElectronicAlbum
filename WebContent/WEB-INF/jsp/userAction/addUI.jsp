<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@	include file="/WEB-INF/jsp/public/commons.jspf" %>
	
	<style type="text/css">
		.ItemBlockBoder {
		  width: 360px;
		  padding: 8% 0 0;
		  margin:0 auto;
		}
		.mainForm {
		  position: relative;
		  z-index: 1;
		  max-width: 600px;
		  margin: 0 auto;
		  text-align: center;
		
		}
		
		
		body {
		  background: #76b852; /* fallback for old browsers */
		  background: -webkit-linear-gradient(right, #F5F5F5, #F5F5F5);
		  background: -moz-linear-gradient(right, #F5F5F5, #F5F5F5);
		  background: -o-linear-gradient(right, #F5F5F5, #F5F5F5);
		  background: linear-gradient(to left, #F5F5F5, #F5F5F5);
		  font-family: "Roboto", sans-serif;
		  -webkit-font-smoothing: antialiased;
		  -moz-osx-font-smoothing: grayscale;      
		}
		.mainForm input {
		  font-family: "Roboto", sans-serif;
		  outline: 0;
		  background: #BABABA;
		  width: 360px;
		  border: 0;
		  margin: 0 0 20px;
		  padding: 15px;
		  box-sizing: border-box;
		  font-size: 14px;
		}
		.button_1 {
		  font-family: "Microsoft YaHei","Roboto", sans-serif;
		  text-transform: uppercase;
		  outline: 0;
		  background: #4CAF50;
		  width: 360px;
		  border: 0;
		  padding: 15px;
		  margin:0 auto;
		  color: #FFFFFF;
		  font-size: 14px;
		  -webkit-transition: all 0.3 ease;
		  transition: all 0.3 ease;
		  cursor: pointer;
		}
	</style>
</head>
<body>
	<s:form action="user_add">
	<H2 style="margin-left:890px;margin-top:100px">欢迎注册</h2>
		<s:hidden name="id"></s:hidden>
		<div>
		<font color="red">
			<s:fielderror/>
		</font>
		</div> 
		<!-- 表单内容显示 -->
		<div class="ItemBlockBoder">
	
			<table cellspacing="0" cellpadding="0" class="mainForm">
				
				<tr>
					<td><s:textfield name="loginName" cssClass="InputStyle" placeholder="请输入账号"/> </td>
				</tr>
				<tr>
					<td><s:textfield name="password" cssClass="InputStyle" placeholder="请输入密码"/></td>
				</tr>
				
				
				<tr>
					<td><s:textfield name="name" cssClass="InputStyle" placeholder="请输入姓名"/> </td>
				</tr>
				<%-- <tr><td>性别</td>
					<td>
						<s:radio name="gender" list="%{#{'男':'男','女':'女'} }"></s:radio>
					</td>
				</tr> --%>
				<tr>
					<td><s:textfield name="phoneNumber" cssClass="InputStyle" placeholder="请输入电话"/></td>
				</tr>
				<tr>
					<td><s:textfield name="email" cssClass="InputStyle" placeholder="请输入邮箱"/></td>
				</tr>
			<%-- 	<tr><td>备注</td>
					<td><s:textarea name="description" cssClass="TextareaStyle" ></s:textarea></td>
				</tr> --%>
					
			</table>
		</div>
			
		<s:submit value="立即注册" class="button_1"></s:submit>
	</s:form>
</body>
</html>