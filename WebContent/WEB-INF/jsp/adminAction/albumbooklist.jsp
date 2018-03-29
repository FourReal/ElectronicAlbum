<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>list</title>
<link rel="stylesheet" href="css/bootstrap.css" type="text/css">
<link rel="stylesheet" href="css/manage_photo.css" type="text/css">
<!-- 分页部分 -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/am-pagination.css">
<script type="text/javascript" src="js/zooming.js"></script>
<script type="text/javascript" src="js/jquery-1.3.2.js"></script>
<script type="text/javascript" src="js/jquery.galleriffic.js"></script>
<script type="text/javascript" src="js/jquery.opacityrollover.js"></script>
<script type="text/javascript">
	document.write('<style>.noscript { display: none; }</style>');
</script>
<%@ include file="/WEB-INF/jsp/public/commons.jspf"%>

<style type="text/css">
form {
	position: relative;
	width: 300px;
}

.d1 input {
	width: 95%;
	height: 42px;
	padding-left: 10px;
	border: 2px solid #cd9b9b;
	border-radius: 3px;
	outline: none;
	background: #FFFFFF;
	color: #9E9C9C;
}

.d1 button {
	position: absolute;
	top: 0;
	right: 0px;
	width: 50px;
	height: 42px;
	border: none;
	background: #cd9b9b;
	border-radius: 0 3px 3px 0;
	cursor: pointer;
	margin-right: 1px;
	color: #FFFFFF;
	font-size: 16px;
}
</style>

</head>
<body>

	<div class="main">
		<div class="main-inner body-width">
			<div class="search d1">
				<s:form action="albumbook_adminfindByUserid">
					<s:hidden name="id"></s:hidden>
					<s:textfield name="searchId" cssClass="InputStyle"
						placeholder="用户id" />
					<button type="submit">查找</button>
				</s:form>
			</div>


			<!--相册展示-->
			<div class="main-cont main-album">
				<table cellpadding="0" cellspacing="0" border="1">
					<thead>
						<tr>
							<th>用户id</th>
							<th>相册</th>
							<th>相册名</th>
							<th>相册描述</th>
							<th>操作</th>

						</tr>
					</thead>
					<tbody>
						<s:iterator value="#adminalbumbooks">
							<tr>
								<td>${ madeuser.id }</td>
								<td width="10%"><a href="#" class="pic"> <img
										src="${album.coverAddr}" name="mvUrl" data-action="zoom" /></a></td>
								<td>${name}&nbsp;</td>
								<td>${description}&nbsp;</td>
								<td width="10%"><span><s:a
											action="albumbook_admindelete?id=%{id}"
											onclick="return confirm('您确定要删除该用户的这个相册吗？')" class="delete">删除</s:a></span>
								</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>

			</div>
			<!--.main-cont/.main-album-->
		</div>
		<!--.main-inner/.body-width-->

	</div>

	</div>

	<script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js"></script>



</body>
</html>



