<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@	taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>角色管理信息修改</title>
<style type="text/css">
	ul, li {
	margin:0; 
	padding:0; 
	list-style-type:none;
}
#infor{
	width:360px; 
	padding:0px; 
	background:#fefefe; 
	margin:0 auto;
	border:1px solid #c4cddb;
	border-top-color:#d3dbde;
	border-bottom-color:#bfc9dc;
	box-shadow:0 1px 1px #ccc;
	border-radius:5px;
	position:relative;
	margin-top:200px;
  
}

h2 {
	margin:0;
	padding:10px 0;
	font-size:20px; 
	text-align:center;
	background:#eff4f7;
	border-bottom:1px solid #dde0e7;
	box-shadow:0 -1px 0 #fff inset;
	border-radius:5px 5px 0 0; /* otherwise we get some uncut corners with container div */
	text-shadow:1px 1px 0 #fff;
}

form ul li {
	margin:10px 20px;
	
}
form ul li:last-child {
	text-align:center;
	margin:20px 0 25px 0;
}
input {
	padding:10px 10px;
	border:1px solid #ccc;
	border-radius:5px;
	box-shadow: 0 0 5px #e8e9eb inset;
	width:300px; /* 400 (parent) - 40 (li margins) -  10 (span paddings) - 20 (input paddings) - 2 (input borders) */
	font-size:1em;
	outline:0; /* remove webkit focus styles */
}
.button {
background: #E27575;
border: none;
padding: 10px 25px 10px 25px;
color: #FFF;
box-shadow: 1px 1px 5px #B6B6B6;
border-radius: 3px;
text-shadow: 1px 1px 1px #9E3F3F;
cursor: pointer;
}
 .button:hover {
background: #CF7A7A
}
</style>
</head>
<body>
<div id="infor">
	<s:form action="role_%{ id==null ? 'add' : 'edit'}">
	
		<s:hidden name="id"></s:hidden>
			<h2>角色管理</h2>
			<ul>
		<li>名称:
		<span><s:textfield name="name"></s:textfield></span></li>
		<li>描述<br >
		<span><s:textarea name="description" style="width:315px;margin-bottom:20px;"></s:textarea></span></li>
		<s:submit value="提交" class="button" style="width:320px;margin-left:20px;margin-bottom:40px;"></s:submit>
		</ul>
	</s:form>
	
	</div>
</body>
</html>