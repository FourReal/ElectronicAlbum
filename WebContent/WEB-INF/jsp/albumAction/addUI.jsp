<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@	include file="/WEB-INF/jsp/public/commons.jspf" %>
</head>
<body>
	<s:form action="album_add">
		<s:hidden name="id"></s:hidden>
		
		<div class=""><!-- 信息说明 --><div class="">相册信息:</div>
		</div>
		<div>
		<font color="red">
			<s:fielderror/>
		</font>
		</div>
		<!-- 表单内容显示 -->
		<div class="">
			<table cellspacing="0" cellpadding="0" class="mainForm">
				
				<tr><td>相册名</td>
					<td><s:textfield name="albumName" cssClass="InputStyle" /> </td>
				</tr>
				<tr><td>描述</td>
					<td><s:textfield name="description" cssClass="InputStyle" /></td>
				</tr>
					
			</table>
		</div>
			
		<s:submit value="提交"></s:submit>
	</s:form>
</body>
</html>