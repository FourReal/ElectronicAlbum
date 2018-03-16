<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<head>
<%@	include file="/WEB-INF/jsp/public/commons.jspf"%>
<!-- 	<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<script type="text/javascript" src="js/bootstrap.js"></script> -->
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
</style>
</head>
<body>

	<%-- album====${id }<br/> --%>

	<!--<s:hidden name="id" value="%{id}"></s:hidden>  -->
	<div id="table">
		<div class="add">
			<s:form action="album_addBgp?id=%{id}" enctype="multipart/form-data"
				method="post">
				<input type="file" name="image" value="点击选择图片" />
				<input type="submit" value="上传" />
				<s:a action="album_make?id=%{id}"
					style="margin-left:20px;color:#008cd5">添加相册背景图</s:a>
				<s:a action="user_addalbum?id=%{id}"
					style="margin-left:20px;color:#008cd5">收藏该相册</s:a>
			</s:form>
		</div>
	</div>
	<div style="margin: 10px 5px 0;">
		<a href="javascript:history.go(-1);" style="color: #008cd5">返回</a>
	</div>
	<div class="shangchuan">
		<table cellspacing="0" cellpadding="0" class="TableStyle">
			<tbody id="TableData" class="dataContainer">
				<s:iterator value="#bgpList">
					<div class="TableDatail">
						<div style="float: right">
							<s:a action="album_deleteBgp?id=%{id}"
								onclick="return confirm('您确定要删除该背景图片吗？')"
								style="color: red;font-size:20px;">
								<img src="img/delete.jpg"
									style="height: 20px; width: 20px; margin-left: 3px;">
							</s:a>
						</div>

						<img src="${addr}" name="mvUrl" width="100px" height="80px"
							class="myimg" />

						<div>
							bgpid=====${ id }<br /> remark=====${remark}<br />
							albumId====${album.id}
						</div>

					</div>
				</s:iterator>
			</tbody>
		</table>
	</div>



</body>
</html>