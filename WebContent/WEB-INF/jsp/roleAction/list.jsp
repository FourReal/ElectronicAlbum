<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/public/commons.jspf"%>
<style type="text/css">
#table table {
	width: 100%;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

#table {
	padding: 0 10px;
	border-radius: 5px;
	margin-top: 25px;
}

table thead {
	border-radius: 5px;
	margin-top: 20px;
}

table thead th {
	background: #ccc;
	padding: 10px;
	text-align: left;
}

table tbody td {
	padding: 10px;
	text-align: left;
	border-bottom: 1px solid #ccc;
	border-right: 1px solid #ccc;
}

table tbody td span {
	margin: 0 10px;
	cursor: pointer;
}

.delete {
	color: red;
}

.edit {
	color: #008cd5;
}

.initial {
	color: #008cd5;
}

.add {
	border: 1px solid #eee;
	padding: 8px;
	background: #ccc;
	border-radius: 3px;
	width: 65px;
	margin-bottom: 10px;
	float: right;
	margin-top: 10px;
}

input {
	border: 1px solid #ccc;
	padding: 5px;
	border-radius: 3px;
	margin-right: 15px;
}

button {
	background: #008cd5;
	border: 0;
	padding: 4px 15px;
	border-radius: 3px;
	color: #fff;
}

a {
	text-decoration: none;
}
</style>

</head>
<body>
	<div id="table">

		<table cellspacing="0" cellpadding="0">
			<thead>
				<tr valign="middle" id=TableTitle>
					<th>角色id</th>
					<th>角色名称</th>
					<th>描述</th>
					<th>相关操作</th>
				</tr>
			</thead>

			<tbody id="TableData" class="dataContainer">
				<s:iterator value="#roleList">
					<tr class="TableDatail template">
						<td>${id}&nbsp;</td>
						<td>${name}&nbsp;</td>
						<td width="30%">${description}&nbsp;</td>
						<td><span><s:a action="role_delete?id=%{id}" onclick="return confirm('确定要删除吗?')" class="delete">删除</s:a></span>
							<span><s:a action="role_editUI?id=%{id}" class="edit">修改</s:a></span>
							<span><s:a action="role_setPrivilegeUI?id=%{id}">设置权限</s:a></span></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
		<div class="add">
			<s:hidden name="id"></s:hidden>
			<font color="red"> <s:fielderror />
			</font>
			<s:a action="role_addUI" style="color:#000">添加角色</s:a>
		</div>
	</div>

</body>
</html>