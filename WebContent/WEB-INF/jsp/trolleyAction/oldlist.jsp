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
	
	a{
	text-decoration:none;
	}
	
	
</style>

</head>
<body>
<!-- 	添加样式的版本 -->
	<div id="table">
	<span style="font-size:30px"><s:a action="trolley_list">购物车</s:a></span>||
	<span style="font-size:30px"><s:a action="trolley_oldlist">我的订单</s:a></span>
	<table cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<th>订单id</th>
				<th>订单数量</th>
				<th>实付价格</th>
				<th>状态</th>
				<th>下单时间</th>
				<th>操作</th>
				
			</tr>
		</thead>
		<tbody>
		<s:iterator value="#oldOrderList">
			<tr>
				<td width="10%">${id}&nbsp;</td>
				<td width="10%">${count}&nbsp;</td>
				<td>${ totalprice }</td>
				<td>${ sign }</td>
				<td>${remark}&nbsp;</td>
				
				<td width="10%"><span><s:a action="trolley_olddelete?id=%{id}" onclick="return confirm('您确定要删除该订单吗？')" class="delete">删除</s:a></span>
				<span><s:a action="trolley_editUI?id=%{id}" class="edit">编辑</s:a></span>
				</td>
			</tr>
		</s:iterator>
		</tbody>
	</table>
	</div>

	
	
</body>
</html>