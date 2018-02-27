<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<frameset rows="100,*,25" framespacing="0" border="1" frameborder="yes">
	<frame noresize name="TopMenu" scrolling="no" src="${pageContext.request.contextPath}/home_top.action">
	<frameset cols="180,*" id="resize">
		<frame noresize name="menu" scrolling="yes" src="${pageContext.request.contextPath}/home_left.action">
		<frame noresize name="right" scrolling="yes" src="${pageContext.request.contextPath}/home_right.action">
	</frameset>
	<frame noresize name="status_bar" scrolling="no" src="${pageContext.request.contextPath}/home_bottom.action">
</frameset>
<noframes>
<body>
</body>
</noframes>
</html>