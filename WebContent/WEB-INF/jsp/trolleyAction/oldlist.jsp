<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
	<link rel="stylesheet" href="css/resetgowuche.css">
<link rel="stylesheet" href="css/cartorder.css">
<!-- <style type="text/css">
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
 -->
</head>
<body>
<!-- 	添加样式的版本 -->

	<span style="font-size:30px"><s:a action="trolley_list">购物车</s:a></span>||
	<span style="font-size:30px"><s:a action="trolley_oldlist">我的订单</s:a></span>
<section class="cartMain">
	<div class="cartMain_hd">
		<ul class="order_lists cartTop">
				<li class="list_con">订单id</li>
				<li class="list_amount">订单数量</li>
				<li class="list_sum">实付价格</li>
				<li class="list_status">状态</li>
				<li class="list_time">下单时间</li>
				<li class="list_op">操作</li>
			</ul>
	</div>	
	<div class="cartBox">
	<div class="order_content">
		<s:iterator value="#oldOrderList">
		<ul class="order_lists">
			<li class="list_con">
				${id}</li>
				<li class="list_amount">${count}</li>
				<li class="list_sum">${ totalprice }</li>
				<li class="list_status">${ sign }</li>
				<li class="list_time">${remark}&nbsp;</li>
				
				<li class="list_op"><s:a action="trolley_olddelete?id=%{id}" onclick="return confirm('您确定要删除该订单吗？')" class="delete">删除</s:a></li>
				<%-- <span><s:a action="trolley_editUI?id=%{id}" class="edit">编辑</s:a></span> --%>
				</ul>
			
		</s:iterator>
		</div>
		</div>
		</section>
		<script src="js/jquery.min.js"></script>
<script src="js/carts.js"></script>
	
</body>
</html>