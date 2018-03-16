<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>

<style type="text/css">
	#table table {
		width: 100%;
		font-size: 14px;
		border: 1px solid #ccc;
		border-radius:5px;
	}
	
	#table {
		padding: 0 10px;
		border-radius:5px;
	}
	table thead{
	border-radius:5px;
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
	
	.add {
		border: 1px solid #eee;
		margin: 10px 0;
		padding: 15px;
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
	
	/* #mask {
		background: rgba(0, 0, 0, .5);
		width: 100%;
		height: 100%;
		position: fixed;
		z-index: 4;
		top: 0;
		left: 0;
	}
	
	.mask {
		width: 300px;
		height: 250px;
		background: rgba(255, 255, 255, 1);
		position: absolute;
		left: 0;
		top: 0;
		right: 0;
		bottom: 0;
		margin: auto;
		z-index: 47;
		border-radius: 5px;
	} */
	
	/* .title {
		padding: 10px;
		border-bottom: 1px solid #eee;
	}
	
	.title span {
		float: right;
		cursor: pointer;
	}
	
	.content {
		padding: 10px;
	}
	
	.content input {
		width: 270px;
		margin-bottom: 15px;
	} */
	a{
	text-decoration:none;
	}
	
	
</style>

</head>
<body>
<!-- 没添加样式的版本 -->
<%-- <div class="content">
	<div class="container" style="margin-top: 30px;">
	<s:a action="album_addUI"><h4 class="page-header">添加</h4></s:a>
	<div class="row-fluid">

	<table cellspacing="0" cellpadding="0" class="table table-striped table-bordered table-hover table-condensed">
		<thead>
			<tr text-align="center" valign="middle" id=TableTitle>
				<td width="100px">相册名</td>
				<td>描述</td>
				<td>相关操作</td>
			</tr>
		</thead>
		
		<tbody id="TableData" class="dataContainer">
		<s:iterator value="#albumList">
			<tr class="TableDatail template">
				<td><s:a action="album_show?id=%{id}">${albumName}</s:a>&nbsp;</td>
				<td>${description}&nbsp;</td>
				<td>
					<s:a action="album_delete?id=%{id}" onclick="return confirm('您确定要删除该用户吗？')">删除</s:a>
					<s:a action="album_editUI?id=%{id}" >修改</s:a>
				</td>
			</tr>
		</s:iterator>
		</tbody>
	</table>
	</div>
	</div>
	</div> --%>
<!-- 	添加样式的版本 -->
	<div id="table">
	<div class="add">
	<s:form action="album_add">
	<s:hidden name="id"></s:hidden>
		<font color="red">
			<s:fielderror/>
		</font>
		<s:textfield name="albumName" cssClass="InputStyle" placeholder="相册名" />
		<s:textfield name="description" cssClass="InputStyle" placeholder="描述" />
		<s:submit value="新增"></s:submit>
		</s:form>
		
	</div>
	<table cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<th>相册名</th>
				<th>描述</th>
				<th>操作</th>
				
			</tr>
		</thead>
		<tbody>
		<s:iterator value="#albumList">
			<tr>
				<td width="10%"><s:a action="album_show?id=%{id}" style="color:red">${albumName}</s:a>&nbsp;</td>
				<td>${description}&nbsp;</td>
				<td width="10%"><span><s:a action="album_delete?id=%{id}" onclick="return confirm('您确定要删除该用户吗？')" class="delete">删除</s:a></span>
				<span><s:a action="album_editUI?id=%{id}" class="edit">编辑</s:a></span>
				</td>
			</tr>
		</s:iterator>
		</tbody>
	</table>
	</div>

	
	
</body>
</html>