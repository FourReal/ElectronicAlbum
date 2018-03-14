<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
		<link rel="stylesheet" href="https://terryz.github.io/lib/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">

	<link rel="stylesheet" href="css/b.page.bootstrap3.css" type="text/css">
</head>
<body>
<div class="content">
	<div class="container" style="margin-top: 30px;">
	<table cellspacing="0" cellpadding="0" class="table table-striped table-bordered table-hover table-condensed">
	<s:a action="user_addUI"><h4 class="page-header">添加</h4></s:a>
		<div class="row-fluid">
		<thead>
			<tr  valign="middle" id=TableTitle>
				<td width="100px">登录名</td>
				<td width="100px">姓名</td>
				<td width="100px">电话</td>
				<td width="100px">描述</td>
		
				<td>相关操作</td>
			</tr>
		</thead>
		
		<tbody id="TableData" class="dataContainer">
		<s:iterator value="#userList">
			<tr class="TableDatail template">
				<td>${loginName}&nbsp;</td>
				<td>${name}&nbsp;</td>
				<td>${phoneNumber}&nbsp;</td>
				<td>${description}&nbsp;</td>
				<td>
					<s:a action="user_delete?id=%{id}" onclick="return confirm('您确定要删除该用户吗？')">删除</s:a>
					<s:a action="user_AeditUI?id=%{id}" >修改</s:a>
					<s:a action="user_initPassword?id=%{id}" onclick="return window.confirm('您确定要初始化密码为1234吗？')">初始化密码</s:a>
				</td>
			</tr>
		</s:iterator>
		</tbody>
	</table>
</div>
</div>
</div>
	
</body>
</html>