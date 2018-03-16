<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@	taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="keywords"
	content="Majestic Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
</script>
<script src="js/jquery-1.11.0.min.js"></script>
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<link href="css/style.css" rel='stylesheet' type='text/css' />
<link href="css/reset.css" rel="stylesheet" type="text/css">
<link href="css/topstyle.css" rel="stylesheet" type="text/css" />
<title>首页</title>
</head>
<body>
	<div class="header1">
		<div style="width: 1200px; margin: 0 auto;">
			<div class="befour">
				<ul class="header1-ul" style="float: right">
					<li><a href="#">联系我们</a></li>
					<li><a href="#">帮助</a></li>
					<%
						if (session.getAttribute("user") == null) {
					%>
					<li><a
						href="${pageContext.request.contextPath}/user_addUI.action"
						target="_parent">注册</a></li>
					<li><a
						href="${pageContext.request.contextPath}/user_loginUI.action"
						target="_parent">登陆</a></li>
					<%
						} else {
					%>
					<li><a
						href="${pageContext.request.contextPath}/user_logout.action"
						target="_parent">注销</a></li>
					<li><a href="${pageContext.request.contextPath}/user_index.action"  target="_parent" >${user.name}</a></li>
					<%
						}
					%>

				</ul>
			</div>
		</div>
	</div>
	<div class="wraper">
		<div class="th">
			<div class="logodiv">
				<img src="images/logo5.png" />
			</div>
			<div class="nav">
				<ul>
					<li class="nav-item">
					<a target="_parent" href="${pageContext.request.contextPath}/home_index.action">首页</a></li>
					<li class="nav-item"><a href= "fengjing.html" target="right">旅游照片书</a></li>
					<li class="nav-item"><a href="aiqing.html" target="right">爱情纪念册</a></li>
					<li class="nav-item"><a href="baobao.html" target="right">宝宝成长册</a></li>
					<li class="nav-item"><a href="biye.html" target="right">毕业纪念册</a></li>
					<li class="nav-item"><a href="geren.html" target="right">个人写真</a></li>

				</ul>
			</div>
		</div>
	</div>
</body>
</html>