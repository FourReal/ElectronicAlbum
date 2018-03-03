<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
	<%@	taglib prefix="s" uri="/struts-tags" %>
	<%@	include file="/WEB-INF/jsp/public/commons.jspf" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
</head>
<body>



	
	 id:			${user.id}
	 <br>
	 loginName: 	${user.loginName}
	 <br>
	 password:		${user.password}
	 <br>
	 name:			${user.name}
	 <br>
	 gender:		${user.gender}
	 <br>
	 phoneNumber:	${user.phoneNumber}
	 <br>
	 email:			${user.email}
	 <br>
	 description:	${user.description}
	 <br>




	<s:form action ="user_edit.action">
		
		<div class="ItemBlock_Title1"><!-- 信息说明 --><div class="ItemBlock_Title">用户信息:</div>
		</div>
		<div>
		<font color="red">
			<s:fielderror/>
		</font>
		</div>
		<!-- 表单内容显示 -->
		<div class="ItemBlockBoder">
			<table cellspacing="0" cellpadding="0" class="mainForm">	
				
				
								
				<tr><td>姓名</td>
					<td><s:textfield name="name" cssClass="InputStyle" /> *</td>
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
			
		<s:submit value="提交"></s:submit>
	</s:form>
</body>
</html>