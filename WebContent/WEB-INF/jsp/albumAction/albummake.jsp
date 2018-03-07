<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
</head>
<body>
	<span>id=${ id }</span>
	<s:form action="album_addBgp?id=%{id}" enctype="multipart/form-data" method="post">
    	<span style="white-space:pre">  </span>上传文件：<input type="file" name="image"><br/>    
             <span style="white-space:pre"> </span><input type="submit" value="提交"/> 
	</s:form>
</body>
</html>