<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/jsp/public/commons.jspf"%>
<link rel="stylesheet" href="css/resetgowuche.css">
<link rel="stylesheet" href="css/carts.css">
<link
	href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<script src="js/jquery.min.js"></script>
<script src="js/carts.js"></script>

<script type="text/javascript">
	$(function() {
		$("#jiesuan").click(function() {
			var CheckName = document.getElementsByName("checkname");
			var total = document.getElementsByClassName("sum_price");

			console.log("点击成功！！！！");
			var $inputVal = $(this).next('input');
			$count = parseInt($inputVal.val()) - 1;

			var data = new Array();
			var j = 0;
			var orders = [];
			for (var i = 0; i < CheckName.length; i++) {

				if (CheckName[i].checked == true) {
					var order = {};
					order.id = CheckName[i].id;
					order.price = total[i].innerHTML;
					//console.log(total[i].innerHTML);
					orders.push(order);
				}
			}
			//data.push(orders);

			var jsonString = JSON.stringify(orders);
			console.log(jsonString);
			$.ajax({
				type : "post",
				url : 'trolley_done.action',//触发的action
				data : jsonString,//设置要传输的数据
				contentType : "application/json; charset=utf-8",
				success : function(d) {
					alert("订单完成");
					window.location.href = "zhifu.jsp";
				},
				error : function(d) {
					alert("error");
				}
			});

		});
	});
</script>


</head>
<body>
	<!-- 	添加样式的版本 -->
	<!-- <div id="table"> -->

	<div class="daohanglan">
		<h3 style="font-size: 30px;margin-top:10px;">
			<span class="fa fa-shopping-cart">我的购物车</span>
		</h3>

	</div>

	<section class="cartMain">
	<div class="cartMain_hd">
		<ul class="order_lists cartTop">
			<li class="list_chk">
				<!--所有商品全选--> <input type="checkbox" id="all" class="whole_check">
				<label for="all"></label> 全选
			</li>

			<li class="list_con">商品信息</li>
			<li class="list_price">单价</li>
			<li class="space"></li>
			<li class="list_amount">购买数量</li>
			<li class="list_sum">金额</li>
			<!-- <th>描述</th> -->
			<li class="list_op">操作</li>
		</ul>
	</div>
	<div class="cartBox">
		<div class="order_content">
			<s:iterator value="#onOrderList" status="L">
				<ul class="order_lists">
					<li class="list_chk"><input type="checkbox" name="checkname"
						id="${ id }" class="son_check"> <label for="${ id }"></label>
					</li>
					<li class="list_con">
						<div class="list_img">
							<s:a action="albumbook_output.action?albumId=%{albumBook.id}">
								<img src="${albumBook.album.coverAddr}">
							</s:a>
						</div>
						<div class="list_text">${ albumBook.description }</div>
					</li>
					<li class="list_price">
						<p class="price">￥${ totalprice }</p>
					</li>
					<li class="list_amount">
						<div class="amount_box">
							<a href="javascript:;" class="reduce reSty">-</a> <input
								type="text" value="1" class="sum">${count} <a
								href="javascript:;" class="plus">+</a>
						</div>

					</li>
					<%-- <td width="10%">${count}&nbsp;</td> --%>
					<li class="list_sum">
						<p class="sum_price">￥${ totalprice }</p>
					</li>
					<%-- <td>${remark}&nbsp;</td> --%>

					<li class="list_op"><p class="del">
							<s:a action="trolley_delete?id=%{id}"
								onclick="return confirm('您确定要删除该订单吗？')" class="delete">删除</s:a>
						</p> <%-- <s:a action="trolley_editUI?id=%{id}" class="edit">编辑</s:a> --%>
					</li>
				</ul>
			</s:iterator>
		</div>
		<div class="clear">
			<s:a action="trolley_clear" onclick="return confirm('您确定要清空购物车吗？')"><span class="fa fa-remove" style="color:red;font-size:14px;">清空购物车</span></s:a>
		</div>
	</div>
	<div class="bar-wrapper">
		<div class="bar-right">

			<div class="piece">
				已选商品<strong class="piece_num">0</strong>件
			</div>
			<div class="totalMoney" id="zongjia">
				共计: <strong class="total_text">0.00</strong>
			</div>
			<div class="calBtn">
				<a id="jiesuan">结算</a>
			</div>
		</div>
	</div>
	</section>
</body>
</html>