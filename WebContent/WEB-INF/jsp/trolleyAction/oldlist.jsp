<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
	<link
	href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
 <style type="text/css">
#table table {
	width: 1200px;
    min-width: 1200px;
    max-width: 1200px;
	font-size: 14px;
	margin:10px auto;
	border-collapse: collapse;
	border-radius:2px;
	border:1px solid #eee;
}

#table {
	padding: 0 10px;
	border-radius: 5px;
}

table thead {
	border-radius: 2px;
	margin-top: 20px;

}


table thead th {
	background: #eee;
	padding: 10px;
	text-align: left;
	height:20px;
	text-align:center;
	border:1px solid #ccc; 	

}

table tbody td {
	padding: 10px;
	text-align: left;

	text-align:center;
	border:1px solid #ccc;
}


.delete {
	color: red;
}


.initial {
	color: #008cd5;
}


input {
	border: 1px solid #ccc;
	padding: 5px;
	border-radius: 3px;
	margin-right: 15px;
}


a {
	text-decoration: none;
}

.daohanglan{
	position:relative;
    width:1200px;
    margin: 0 auto;
    height:60px;
}

</style>
</head>
<body>
<!-- 	添加样式的版本 -->
<div class="daohanglan">
	<h3 style="font-size: 30px;font-weight:normal;">
			<span class="fa fa-reorder" >我的订单</span>
	</h3>
</div>
<div id="table">

		<table cellspacing="0" cellpadding="0" >
			<thead >
				<tr valign="middle" id=TableTitle>
				<th>订单id</th>
				<th>订单数量</th>
				<th>实付价格</th>
				<th>状态</th>
				<th>下单时间</th>
				<th>操作</th>
			</tr>
			</thead>
			

	<tbody id="TableData" class="dataContainer">
		<s:iterator value="#oldOrderList" var="var">
		<tr class="TableDatail template">
				<td>${id}</td>
				<td>${count}</td>
				<td>${ totalprice }</td>
				<s:if test='#var.sign=="1"'>
					<td>已完成支付</td>
				</s:if>
				<s:if test='#var.sign=="0"'>
					<td>未完成支付</td>
				</s:if>
				<td>${remark}&nbsp;</td>
				
				<td><s:a action="trolley_olddelete?id=%{id}" onclick="return confirm('您确定要删除该订单吗？')" class="delete">删除</s:a></td>
				<%-- <span><s:a action="trolley_editUI?id=%{id}" class="edit">编辑</s:a></span> --%>
				</tr>
			
		</s:iterator>
		</tbody>
		</table>
		</div>
		<script src="js/jquery.min.js"></script>
<script src="js/carts.js"></script>
	
</body>
</html>