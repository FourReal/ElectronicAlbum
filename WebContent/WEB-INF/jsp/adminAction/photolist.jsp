<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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

<!-- We only want the thunbnails to display when javascript is disabled -->
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

table thead {
	border-radius: 3px;
	margin-top: 20px;
	border:1px solid #ccc;
	

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
.delete{
color:red;
}
.delete:hover{
text-decoration:none;
color:red;
}
</style>
</head>
<body>
	<div class="main">
		<div class="main-inner body-width">
			<div class="search d1">
				<s:form action="photo_adminfindByUserid">
					<s:hidden name="id"></s:hidden>
					<font color="red"> <s:fielderror />
					</font>
					<s:textfield name="searchId" cssClass="InputStyle"
						placeholder="用户id" />
					<button type="submit">查找</button>
				</s:form>
			</div>

			<!--照片展示-->
			<div class="main-cont main-album">
				<table cellpadding="0" cellspacing="0" border-collapse: collapse;>
					<thead>
						<tr>
							<th>用户id</th>
							<th>照片</th>
							<th>照片名</th>
							<th>操作</th>

						</tr>
					</thead>
					<tbody>
						<s:iterator value="#adminphotos">
							<tr>
								<td>${ OwnerId }</td>
								<td width="10%"><a href="#" class="pic" style="width:100px;height:100px;"> <img
										src="/ElectronicAlbum/imgs/${PName}" name="mvUrl"
										data-action="zoom" style="width:100%;height:100%;"/></a></td>
								<td>${PName}&nbsp;</td>
								<td width="10%"><span><s:a
											action="photo_admindelete?id=%{id}"
											onclick="return confirm('您确定要删除该用户的这张照片吗？')" class="delete">删除</s:a></span>
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


	<script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js"></script>



</body>
</html>













