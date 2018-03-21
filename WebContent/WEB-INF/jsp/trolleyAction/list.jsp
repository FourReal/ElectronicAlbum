<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
	<link rel="stylesheet" href="css/resetgowuche.css">
<link rel="stylesheet" href="css/carts.css">

</head>
<body>
<!-- 	添加样式的版本 -->
	<!-- <div id="table"> -->
	<span style="font-size:30px"><s:a action="trolley_list">购物车</s:a></span>||
	<span style="font-size:30px"><s:a action="trolley_oldlist">我的订单</s:a></span>
	
	<div class="daohanglan">
	<div class="logodis">
	<img src="images/logogowuche.png" />
	</div>
	<div class="search d1">
	<form>
	  <input type="text" placeholder="搜索从这里开始..." />
	  <button type="submit">搜索</button>
	  </form>
	</div>
	</div>

<section class="cartMain">
	<div class="cartMain_hd">
		<ul class="order_lists cartTop">
			<li class="list_chk">
				<!--所有商品全选-->
				<input type="checkbox" id="all" class="whole_check">
				<label for="all"></label>
				全选
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
				<li class="list_chk">
					<input type="checkbox" name="checkname" id="check_<s:property value="#L.index+1" />" class="son_check">
					<label for="check_<s:property value="#L.index+1" />"></label>
				</li>
				<li class="list_con">
				<div class="list_img">
				<s:a action="orderList?id=%{id}"><img src="${albumBook.album.coverAddr}"></s:a></div>
				<div class="list_text"><a href="#">古色古香个人写真模板</a></div>
				</li>
				<li class="list_price">
				<p class="price">￥${ totalprice }</p>
				</li>
				<li class="list_amount">
					<div class="amount_box">
						<a href="javascript:;" class="reduce reSty">-</a>
						<input type="text" value="1" class="sum">${count}
						<a href="javascript:;" class="plus">+</a>
					</div>
				
				</li>
				<%-- <td width="10%">${count}&nbsp;</td> --%>
				<li class="list_sum">
				<p class="sum_price">￥${ totalprice }</p>
				</li>
				<%-- <td>${remark}&nbsp;</td> --%>
				
			<li class="list_op"><p class="del"><s:a action="trolley_delete?id=%{id}" onclick="return confirm('您确定要删除该订单吗？')" class="delete">删除</s:a></p>
				<%-- <s:a action="trolley_editUI?id=%{id}" class="edit">编辑</s:a> --%>
				</li>
						</ul>
			</s:iterator>
		</div>
		<div class="clear"><s:a action="trolley_clear">清空购物车</s:a></div>
		</div>
	<div class="bar-wrapper">
		<div class="bar-right">
		
		<div class="piece">已选商品<strong class="piece_num">0</strong>件</div>
			<div class="totalMoney">共计: <strong class="total_text">0.00</strong></div>
		<div class="calBtn"><s:a action="trolley_done" onclick='getCheck()' class="btn">结算</s:a></div>
	</div>
	</div>
</section>
	<script src="js/jquery.min.js"></script>
<script src="js/carts.js"></script>
	<script type="text/javascript">
	 function getCheck()
	{ 
	   
	   var CheckName = document.getElementsById("check_"+<s:property value="id" />);  
	 
	    for(var i = 0; i < CheckName.length; i++) 
	    { 
	       if(CheckName[i].checked == true) 
	       { 
	    	  alert( CheckName[i].value+""); 
	    	  /*  $.ajax({
	                type : 'post',
	                url : 'trolley.action',
	                data : {
	                    id : id
	                },
	                success:function(response){ 
	                    //服务端返回的信息
	                    alert(response);
	                }
	            }); */
	        }
	       } 
	    } 
	   /*  var json= JSON.stringify(CheckName);
	    alert(json); */
	
	
	</script>
</body>
</html>