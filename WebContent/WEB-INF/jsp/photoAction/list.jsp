<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
</head>
<body>
	
	这是照片展示模块！！！！！！！！！！！！！！！
	<br>
	<s:a action="photo_add">上传照片</s:a>
	<br>
	<s:iterator value="#photoList">
		<s:property value="PName"/>
		<%-- <s:a action="role_delete?id=%{id}" onclick="return confirm('确定要删除吗?')">删除</s:a>
		<s:a action="role_editUI?id=%{id}" >修改</s:a> --%>
		<img src="/ElectronicAlbum/imgs/${PName}" name="mvUrl" width="100px" height="80px" class="myimg"/>
		<br/>
		<s:a action="photo_delete?id=%{Id}" onclick="return confirm('确定要删除吗?')">删除</s:a>
		<br>
		
	</s:iterator>
	
	
</body>
</html>