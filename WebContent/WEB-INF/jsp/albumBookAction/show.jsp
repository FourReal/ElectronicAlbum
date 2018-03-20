<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<head>
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@	taglib prefix="s" uri="/struts-tags" %>
	<%pageContext.setAttribute("baseURL", request.getContextPath()); %>
	<meta charset="utf-8">
	
	<title>makealb</title>
	
	<link rel="stylesheet" type="text/css" href="${baseURL }/css/Huploadify.css"/>
	<link rel="stylesheet" type="text/css" href="css/default.css" />
	<link rel="stylesheet" type="text/css" href="css/bookblock.css" />
	<link rel="stylesheet" type="text/css" href="css/demo5.css" />
	<link href="http://how2j.cn/study/css/bootstrap/3.3.5/bootstrap.min.css" rel="stylesheet">
	
	<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
	<script type="text/javascript" src="${baseURL }/js/jquery.Huploadify.js"></script>
	<script src="${baseURL }/js/jquery-ui.min.js"></script>
	<script src="${baseURL }/js/modernizr.custom.js"></script>
	<script src="${baseURL }/js/interact.js"></script>
	<script src="http://how2j.cn/study/js/bootstrap/3.3.5/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/drag.js"></script>
<style type="text/css">
#table {
	width: 100%;
	font-size: 14px;
	border-radius: 5px;
	border: 1px solid #ccc;
	background: #ccc;
	margin-top: 15px;
}

.add {
	margin-left: 20px;
	height: 30px;
}

form {
	margin-top: 10px;
}

a {
	text-decoration: none;
}

.shangchuan {
	width: 100%;
	height: 800px;
	font-size: 14px;
	border-radius: 5px;
	border: 1px solid #ccc;
	background: #fff;
	margin-top: 10px;
}

.TableDatail {
	display: inline;
	float: left;
	margin-left: 20px;
	margin-right: 20px;
	margin-top: 20px;
}

.caozuo{
	height: 30px;
	padding-left: 100px;
}

</style>
<script type="text/javascript">
	$(function(){
		   $("#addorder").click(function(){
				 $.ajax({
                 type : "post",
                 url : 'order_add.action',
                 dataType : "json",//设置需要返回的数据类型
                 success : function(d) {
                 	alert("加入购物车成功！！！")					
                     
                 },
                 error : function(d) {
                 	alert("error");
                     alert(d.responseText);
                 }
             	});
		   });
		   
	});
</script>
</head>
<body>
	<div class="shangchuan">
		<div class="caozuos">
			<%-- albumbook==${ albumBook }<br>
			id==${ albumBook.id } --%>
			<button type="button" id="addorder">加入购物车</button>||
			<s:a action="order_add">下订单</s:a>
		</div>
		<table cellspacing="0" cellpadding="0" class="TableStyle">
			<tbody id="TableData" class="dataContainer">
				<s:iterator value="#photo_proList">
					<div class="TableDatail">
						<div>
						id===${id}<br>
						horizon==${horizon}<br>
						ordinate==${ ordinate}<br>
						size_x==${ size_x }<br>
						size_x==${ size_y }<br>
						page==${ page }<br>
						photoId==${ photo.id }
						</div>

					</div>
				</s:iterator>
				
			</tbody>
		</table>
	</div>



</body>
</html>