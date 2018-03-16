<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@	include file="/WEB-INF/jsp/public/commons.jspf" %>
</head>
<body>
	<s:form action="user_Aedit">
		<s:hidden name="id"></s:hidden>
		
		<div class="ItemBlock_Title1"><!-- 信息说明 --><div class="ItemBlock_Title">用户信息:</div>
		</div>
		
		<!-- 表单内容显示 -->
		<div class="ItemBlockBoder">
			<table cellspacing="0" cellpadding="0" class="mainForm">

				<tr><td>登录名</td>
					<td><s:textfield name="loginName" cssClass="InputStyle" /> *</td>
				</tr>
				<tr><td>姓名</td>
					<td><s:textfield name="name" cssClass="InputStyle" /></td>
				</tr>
				<tr><td>性别</td>
					<td>
						<s:radio name="gender" list="%{#{'男':'男','女':'女'} }"></s:radio>
					</td>
				</tr>
				<tr><td>联系电话</td>
					<td><s:textfield name="phoneNumber" cssClass="InputStyle" /></td>
				</tr>
				<tr><td>E-mail</td>
					<td><s:textfield name="email" cssClass="InputStyle" /></td>
				</tr>
				<tr><td>备注</td>
					<td><s:textarea name="description" cssClass="TextareaStyle" ></s:textarea></td>
				</tr>
					
			</table>
		</div>
			
		<div class="ItemBlock_Title1"><!-- 信息说明 --><div class="ItemBlock_Title">角色设置</div>
		</div>
		
		<!-- 表单内容显示 -->
		<div class="ItemBlockBorder">
			<table cellspacing="0" cellpadding="0" class="mainForm">
				<tr>
					<td width="100px">角色</td>
					<td>
						<s:select name="roleIds" cssClass="SelectStyle" 
						multiple="true" size="10" list="#roleList" 
						listKey="id" listValue="name"/>
						按住Ctrl键可以多选或者选择取消
					</td>
				</tr>	
			</table>
		</div>
			
		<s:submit value="提交"></s:submit>
	</s:form>
</body>
</html>